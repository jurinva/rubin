












           000000   0     0  0000000  0     0  0     0
           0     0  0     0  0        0     0  0     0
           0     0  0     0  0        0   0 0  0     0
           000000    000000  000000   0  0  0  0000000
           0              0  0     0  0 0   0  0     0
           0              0  0     0  0     0  0     0
           0        000000   000000   0     0  0     0






         СС ИИ СС ТТ ЕЕ ММ АА   УУ ПП РР АА ВВ ЛЛ ЕЕ НН ИИ ЯЯ   ББ АА ЗЗ ОО ЙЙ
                     ДД АА НН НН ЫЫ ХХ   РР УУ ББ ИИ НН


                            ВЕРСИЯ 2
                  Инструкция по установке РУБИН
                с разделяемым доступом в ОС ДЕМОС

















                         ММоосскквваа 77//2244//8899












Как устанавливать устройство разделяемого доступа           Стр 1








В РУБИН полностью используется механизм управления  одновременным
доступом.  Система РУБИН устанавливает и снимает блокировки с по-
мощью записей на устройство, называемое  "/dev/lock".   Если  это
устройство не может быть открыто на запись, РУБИН запускается без
какой бы то ни было поддержки одновременного доступа.

Первоначально целесообразно запустить РУБИН без управления однов-
ременным  доступом.  Если планируемое использование РУБИН требует
одновременного доступа, то в вашей системе ДЕМОС должно быть  ус-
тановлено устройство "/dev/lock".

Этот документ описывает процедуру  установки  драйвера  для  уст-
ройства "/dev/lock" в системе ДЕМОС.


_1.  Вход в систему (под именем root).

_2.  Компиляция устройства разделяемого доступа.


    2.1.  Копирование исходных текстов и файлов.

        Устройство разделяемого доступа состоит из двух файлов: и
        .../source/support/ilock.h

        Переименуйте исходный файл в /usr/sys/dmr/ildr.c, а  файл
        /source/support/ilock.h в /usr/sys/dmr/ilock.h


                mv .../source/support/ildr.c /usr/sys/ildr.c
                mv .../source/support/ilock.h /usr/sys/ilock.h


    _2._2.

        Различные параметры, определяемые в ildr.h должны опреде-
        ляться пользователем.  Это включает:

                NLOCKS - число блокировок
                PLOCKS - блокировку страницы
                RLOCKS - блокировку отношения
                DLOCKS - блокировку базы данных

        NLOCKS - максимальное число разрешенных  блокировок.   Он
        определяет  размер  таблицы  блокировок.  PLOCKS - макси-
        мальное число заблокированных страниц,  отношений  и  баз
        данных.   RLOCKS - максимальное число блокированных отно-
        шений и баз данных.  DLOCKS - максимальное число блокиро-
        ванных  баз  данных.   Только DLOCKS могут использоваться
        одновременно.

        Следующие условия должны обеспечивать защиту  от  "блоки-
        ровки насмерть" при переполнении таблицы блокировок:




Как устанавливать устройство разделяемого доступа           Стр 2








                NLOCKS > PLOCKS > RLOCKS > DLOCKS + 6

        Такое число RLOCKS, удовлетворящих этому порядку  необхо-
        димо для запуска запросов с 6-ю переменными.  Мы рекомен-
        дуем сначала установить DLOCKS, а затем уже остальные па-
        раметры, как это указано ниже:

                RLOCKS = 2*DLOCKS + 6
                PLOCKS = RLOCKS + 3
                NLOCKS = PLOCKS + 1


        Например, чтобы уменьшить размер таблицы блокировок, надо
        установить DLOCKS = 2, RLOCKS = 10, PLOCKS = 13, NLOCKS =
        14.  В этом случае, одновременно с РУБИН смогут  работать
        только 2 пользователя.

        Другой пример, чтобы позволить одновременное  пользование
        РУБИН,  установим: DLOCKS = 20, RLOCKS = 46, PLOCKS = 49,
        NLOCKS = 50.  Такие значения параметров позволяют исполь-
        зовать РУБИН одновременно 20-и пользователям.

        Для драйвера устройствa "/dev/lock" трубуется 1008 байт в
        текстовом  сегменте и 36 + 18 * NLOCKS в сегментах DATA и
        BSS.


    _2._3.

        Перейдите в каталог, где хранятся драйверы устройств  ва-
        шей системы.

                chdir /usr/sys/dmr


    _2._4.

        Объектные коды ДЕМОС поделены  на  две  библиотеки,  lib1
        (коды системы) and lib2 (драйверы устройств).  Оттрансли-
        руйте ildr.c и поместите ее в lib2

                cc -c -O ildr.c
                ar rv ../lib2 ildr.o

    _2._5.

        Для установки устройства  в  систему,  файл  конфигурации
        должен быть изменен.

        2.5.1.  Редактирование /usr/sys/conf/conf.c ( или c.c )

            Отредактируйте  файл  конфигурации  и  добавьте  уст-
            ройство  блокировки  в список символов устройств.  На
            некоторых  системах  файл   конфигурации   называется



Как устанавливать устройство разделяемого доступа           Стр 3








            conf.c,  а  на некоторых c.c.  Найдите последнее уст-
            ройство в таблице "cdevsw[]" и добавьте строку:

                    &nulldev,  &nulldev,  &nulldev,  &ilwrite,  &nodev,

            Номер строки записи об устройстве становится  номером
            устройства.  _П_о_м_н_и_т_е, _ч_т_о _о_т_с_ч_е_т _в_е_д_е_т_с_я _с _н_у_л_я.

        _2._5._2.

            Оттранслируйте файл конфигурации.

                    chdir /usr/sys/conf
                    cc -c conf.c

        _2._5._3.


            2.5.3.1.  Редактирование /usr/sys/ken/sys1.c.

                Системный вызов exit должен быть изменен для  вы-
                зова  устройства разделяемого доступа.  Это необ-
                ходимо в случаях, когда  происходит  ненормальное
                завершение  процессов РУБИН, например, когда про-
                цесс убивают, или когда встречается  ошибка  сис-
                темы.    Должен  быть  добавлен  вызов  "ilrma(q-
                >p_pid)" в exit() в файле /usr/sys/ken/sys1.c пе-
                ред  меткой  "loop".   Тогда exit будет выглядеть
                так:

                exit()
                {
                        register int *q, a;
                        register struct proc *p;

                        p = u.u_procp;
                        p->p_flag =& ~STRC;
                        p->p_clktim = 0;
                        for(q = &u.u_signal[0]; q < &u.u_signal[NSIG];)
                                *q++ = 1;
                        for(q = &u.u_ofile[0]; q < &u.u_ofile[NOFILE]; q++)
                                if(a = *q) {
                                        *q = NULL;
                                        closef(a);
                                }
                        iput(u.u_cdir);
                        xfree();
                        a = malloc(swapmap, 1);
                        if(a == NULL)
                                panic("out of swap");
                        p = getblk(swapdev, a);
                        bcopy(&u, p->b_addr, 256);
                        bwrite(p);
                        q = u.u_procp;



Как устанавливать устройство разделяемого доступа           Стр 4








                        mfree(coremap, q->p_size, q->p_addr);
                        q->p_addr = a;
                        q->p_stat = SZOMB;
                        /*
                         * remove outstanding rubin locks for
                         * the dying process
                         */
                        ilrma(q->p_pid);

                loop:
                        for(p = &proc[0]; p < &proc[NPROC]; p++)
                        if(q->p_ppid == p->p_pid) {
                                wakeup(&proc[1]);
                                wakeup(p);
                                for(p = &proc[0]; p < &proc[NPROC]; p++)
                                if(q->p_pid == p->p_ppid) {
                                        p->p_ppid  = 1;
                                        if (p->p_stat == SSTOP)
                                                setrun(p);
                                }
                                swtch();
                                /* no return */
                        }
                        q->p_ppid = 1;
                        goto loop;
                }


            _2._5._3._2.

                Сейчас перетранслируем sys1.c и обновим lib1:

                        chdir /usr/sys/ken
                        cc -c -O sys1.c
                        ar rv ../lib1 sys1.o


            _2._5._3._3.


                2.5.3.3.1.  Перезагрузка системы.

                    Сейчас система готова к перезагрузке.  Следу-
                    ющая процедура для частичной установки.


                    Убедитесь, что следующие файлы:

                    low.o
                    m45.o ( или m40.o)
                    conf.o (или c.o)

                    имеются в наличии или что процедура  загрузки
                    их компилирует.



_К_а_к _у_с_т_а_н_а_в_л_и_в_а_т_ь _у_с_т_р_о_й_с_т_в_о _р_а_з_д_е_л_я_е_м_о_г_о _д_о_с_т_у_п_а           _С_т_р _5









                _2._5._3._3._2.

                    Вы пока не готовы  запускать  новую  систему.
                    Но  т.к. список имен изменился, вы должны пе-
                    рейти в однопользовательский режим перед  тем
                    как сделать это.

                _2._5._3._3._3.

                    Поместите новую систему ДЕМОС в  каталог,  из
                    которого происходит обычная перезагрузка:

                            mv /usr/sys/a.out /unix

                    Сейчас перезагрузите  систему  после  команды
                    sync,  и запустите процедуры, необходимые для
                    нормальной загрузки.


                _2._5._3._3._4.


                    2.5.3.3.4.1.  Создание узла.

                        Устройство  разделяемого  доступа  должно
                        быть  помещено  в  "/dev" после того, как
                        система  будет  перзагружена.   Выполните
                        команду:

                                /etc/mknod  /dev/lock  c  major  0

                        где "major" номер устройства.   Еще  раз:
                        номер устройства это позиция устройства в
                        таблице "cdevsw[]".  Вспомните,  что отс-
                        чет начинается с нуля.

                    _2._5._3._3._4._2.

                        Сейчас поменяйте моды устройства  на  за-
                        пись владельцу и установите владельца РУ-
                        БИН:

                                chown rubin /dev/lock
                                chmod 200 /dev/lock

                    _2._5._3._3._4._3.

                        Теперь  РУБИН  будет  использовать   уст-
                        ройство  /dev/lock для обеспечения однов-
                        ременного доступа  пользователей  к  базе
                        данных.   Простой  способ  проверить это,
                        это   попытаться   запустить   (например)
                        "purge"  на  какой-то  базе  данных, пока



Как устанавливать устройство разделяемого доступа           Стр 6








                        кто-то запускает "rubin" на этой же  базе
                        данных.























































Как устанавливать устройство разделяемого доступа           Стр 7


