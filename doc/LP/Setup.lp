


КАК УСТАНАВЛИВАТЬ РУБИН                                страница 1









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
            П О С Т А Н О В К А   С У Б Д   Р У Б И Н


















                         ММоосскквваа 77//2244//8899


















КАК УСТАНАВЛИВАТЬ РУБИН                                страница 2


1.  Введение

    Эти инструкции помогут вам прочитать РУБИН  версии 2.10  вер-
    сии  с  ленты  и установить его на вашей системе.  Если у вас
    работает какая-либо версия ДЕМОС, отличная  от  UTIX,  обяза-
    тельно  прочтите  этот  вводный документ прежде, чем что-либо
    делать.  Обратите особое внимание на раздел 5.3.

    *ДЕМОС это название версии  UNIX  адаптированной  на  русские
    буквы и отечественные типы ЭВМ.

2.  Установка РУБИН для начала работы с ним.

    Если вы уже имеете систему РУБИН, переходите к  чтению  части
    1.3.

    2.1.  Создание пользователей системы ДЕМОС, которые могут вы-
        зывать "rubin".

        Первое, что вы должны сделать, это  создать  пользователя
        "rubin"  в  вашей системе и войти в систему под этим име-
        нем.  Файлы, которые вы будете считывать с  ленты  должны
        будут  принадлежать "rubin" - настоящему пользователю ва-
        шей системы.  РУБИН размещает файлы в системе после прос-
        мотра  файла /etc/passwd и поиска в нем пользователя "ru-
        bin".  РУБИН НЕ БУДЕТ работать без  существования  такого
        пользователя.

    2.2.  Создание родительского каталога для РУБИН.

        Родителький каталог для РУБИН в версии UTIX  как  правило
        создается  под  именем "/usr/rubin".  Этот каталог должен
        быть домашним  (определенным  в  файле  /etc/passwd)  для
        пользователя  "rubin".   Для  целей этого документа роди-
        тельский каталог будем обозначать "...".

    2.3.  Извлечение РУБИН с ленты.

        Вы должны быть готовы считать ленту в вашей системе,  ис-
        пользуя  программу  tar.  Вы должны находиться в домашнем
        каталоге для РУБИН и быть пользователем РУБИН.  Печатайте
        команду:

                tar xvfp /dev/nrmt0

        В настоящий момент система извлечена с ленты, и лента мо-
        жет быть по желанию снята.

    2.4.  Программы, ориентированные на пользователя.

        В каталоге .../bin  находится  набор  команд.   Различные
        программы,  которые  являются  командами РУБИН могут быть
        связаны ссылками с /usr/bin.  Другие  программы  выполня-
        ются  только  другими программами РУБИН и должны быть ос-









КАК УСТАНАВЛИВАТЬ РУБИН                                страница 3


        тавлены в .../bin.  Самой правильной политикой будет  ос-
        тавление  всех  программ в ../bin и включение этого спра-
        вочника в "PATH" всех  пользователей  РУБИН.   Для  этого
        пользователи "sh" должны написать в своем стартовом файле
        ".profile" строку:

         PATH=$PATH:/usr/rubin/bin:

        пользователи "csh" добавляют в файл ".cshrc" строку:

          set path=($path ~rubin/bin)


        Очевидно, что каждая из программ должна иметь  правильные
        коды  доступа.   Пример  команды  "ls  -l" приведен ниже.
        Коды доступа ваших файлов должны быть такими  же,  как  в
        примере.

        -rwx--x--x 1 rubin     . . .   copydb
        -rws--x--x 1 rubin     . . .   creatdb
        -rwxr-xr-x 1 rubin     . . .   demodb
        -rws--x--x 1 rubin     . . .   destroydb
        -rwx--x--x 1 rubin     . . .   equel
        -rws--x--x 1 rubin     . . .   helpr
        -rws--x--x 1 rubin     . . .   rubin
        -rws--x--x 1 rubin     . . .   printr
        -rws--x--x 1 rubin     . . .   purge
        -rws--x--x 1 rubin     . . .   restore


    2.5.  Библиотека языка запросов EQUEL.

        Библиотека языка запросов EQUEL.  должна быть помещена  в
        "/lib/libq.a"  или  "/usr/lib/libq.a".  Библиотека требу-
        ется для компиляции программ пользователей на EQUEL.  Для
        компиляции самой системы РУБИН она не нужна.  Желательно,
        однако вовсе не обязательно, чтобы владельцем  библиотеки
        был  "rubin".   Для  перемещения библиотеки выполните ко-
        манду:

             cp .../bin/libq.a  /usr/lib/libq.a

        Об использовании EQUEL и библиотеки EQUEL см. "Справочное
        руководство  по  СУБД  РУБИН".  Примеры программ на EQUEL
        находятся в ".../doc/Examples/*.q".

    2.6.  Включение устройства-семафора в ядро.

        ДАННЫЙ РАЗДЕЛ ПРИ ПОСТАНОВКЕ РУБИН В ОС UTIX  МОЖНО  ПРО-
        ПУСТИТЬ, ТАК КАК В НЕЕ ДРАЙВЕР СЕМАФОРОВ РУБИН ВКЛЮЧЕН ПО
        УМОЛЧАНИЮ.

        Если вы хотите использовать базу данных для  работы  нес-
        кольких пользователей, вы должны установить РУБИН с вклю-









КАК УСТАНАВЛИВАТЬ РУБИН                                страница 4


        чением устройства-семафора в ядро системы.   Его  необхо-
        димо  добавить  как  драйвер устройства в каталог /dev, и
        изменить одну строку для  завершения  системного  вызова.
        Перед выполнением прочитайте документ "Инструкции по пос-
        тановке РУБИН с включением устройства-семафора в  системе
        ДЕМОС".

3.  Основная информация об РУБИН.

    3.1.  Некоторые комментарии по-поводу каталогов РУБИН

        Каталоги (в ...) необходимы для работы  системы  с  мини-
        мальными возможностями:

        bin          объектные программы, выполняемые
                     РУБИН
        files        файлы, используемые различными
                     частями РУБИН
        data/base/   базы данных, созданные
                     пользователями
        demo         используется командой "demodb"

        Создаются  также  и  различные  дополнительные  каталоги.
        Если недостаток свободного места является проблемой в ва-
        шей системе, вы можете захотеть удалить некоторые из всех
        этих  материалов.   Если  вы  действительно  нуждаетесь в
        этом, уничтожайте файлы, но будьте уверены в том, что ка-
        талоги будут сохранены.  Дополнительные каталоги это:

        doc      документация
        lib      библиотека объектных файлов
        source   исходные тексты системы
        В файле .../source/HISTORY собрана  история  изменений  в
        системе.

    3.2.  Поддержка разделяемых областей инструкций и данных.

        На PDP-11, вы ДОЛЖНЫ иметь разделяемые области  данных  и
        инструкций,  а также процессор плавающей точки, чтобы за-
        пусить в работу РУБИН/2.  РУБИН/2 НЕ  БУДЕТ  работать  на
        11/40 или на подобных машинах под седьмой версией ДЕМОС.

4.  Что надо иметь для начала работы с РУБИН.

    4.1.  Файлы пользовалей

        По порядку работы с РУБИН, пользователь должен быть  вве-
        ден в регистрационный файл "users".  Регистрационный файл
        содержит информацию относительно статуса и разрешений для
        каждого   пользователя.    Этот   файл   похож   на  файл
        /etc/passwd, и включает имя  пользователя,  идентификатор
        пользователя (используется внутри РУБИН для идентификации
        пользователя), идентификатор пользователя в ДЕМОС,  неко-
        торые биты статуса и некоторые другие поля.  Подробнее об









КАК УСТАНАВЛИВАТЬ РУБИН                                страница 5


        этом написано в  документе  о  регистрации  пользователей
        (файлы).

        Регистрационный файл инициализируется при  запуске  прог-
        раммы "usersetup".  Эта программа включает всех пользова-
        телей системы (из файла /etc/passwd), в пользователи  РУ-
        БИН.   Коды пользователей формируются последовательно на-
        чиная с "aa".  Поле статуса инициализируется  000000  для
        всех  обычных  пользоватлей и 177777 для пользоватля "ru-
        bin".

        Для установки регистрационного файла в /usr/rubin  выпол-
        ните:

                .../bin/usersetup

        Однажды установленный регистрационный файл может быть от-
        редактирован редактором, чтобы проделать следующее:

                - удалить тех пользователей, которым не разрешено
                использовать РУБИН.

                - оградить пользователей от использования другими
                пользователями их индивидуальной базы данных

                - установить остальные биты статуса, соответству-
                щие пользователю.

        Как только добавляется или удаляется пользователь  ДЕМОС,
        должен быть соответствующим образом изменен регистрацион-
        ный  файл.   Программа  "usersetup"  должна   выполняться
        только один раз.  При повторном запуске этой програмы вы-
        дается соответствующая диагностика.

    4.2.  Созданиее учебной базы данных.

        Команда "demodb" может  быть  использовани  для  создания
        учебной базы данных, которая приведена в качестве примера
        в       рукодстве       (которое       размещено        в
        ".../doc/LP/tutorial.lp").   Чтобы  выполнить эту команду
        вы должны быть включены в регистрационный  файл  и  иметь
        разрешение на создание базы данных.  Для создания учебной
        базы данных и с именем "demo" печатайте команду:

                demodb demo

        Чтобы использовать РУБИН с этой базой данных надо  просто
        напечатать:

                rubin demo

        и вы сможете повторить сеанс работы с базой данных,  опи-
        санный  в  "Введении  в  РУБИН",  или  формулировать свои
        собственные запросы.









КАК УСТАНАВЛИВАТЬ РУБИН                                страница 6


        Чтобы создать свою собственную копию образца базы данных,
        используйте какое-нибудь уникальное имя.

                demodb mydemo


    4.3.  Создание других баз данных.

        Без сомнения, вы захотите создать другие базы данных  для
        собственного  использования.   Для  этого  служит команда
        "creatdb".  Использовать ее вы можете только при условии,
        что вы зарегистрированы в файле пользователей РУБИН.

    4.4.  Управление одновременным доступом к базам данных.

        РУБИН может работать или полностью  поддерживая  одновре-
        менный  доступ  к  базам  данных,  или не поддерживая его
        вовсе.  РУБИН блокирует часть базы данных, используя осо-
        бый   специальный   файл   (устройство)   системы   ДЕМОС
        "/dev/lock" - устройство-семафор.  Сначала вы можете  ис-
        пользовать РУБИН без этого устройства.  Если же вы хотите
        включить управление одновременным доступом, (если с одной
        и  той же базой данных одновременно будут работать больше
        одного человека, вы ДОЛЖНЫ включить его), то распечатайте
        инструкцию по включению устройства-семафора в систему


5.  Советы и пожелания.


    5.1.  Проблемы защиты в Демос.

        Если вы неожиданно встретитесь с проблемами содания ката-
        логов или чтения файлов с ленты, проверьте статус доступа
        охватывающего родительского каталога, чтобы открыть  раз-
        решение на запись в каталог для создания новых файлов.

        Опишем моды, присущие, как правило каждому каталогу.  Все
        каталоги  принадлежат  РУБИН, иключая индивидуальные базы
        данных.  (Моды в скобках предсталяют  моды,  которые  ис-
        пользуются  тогда, когда вы хотите максимально ограничить
        доступ.)

        bin                            755
        data                           700
        data/base                      777
        demo                           755
        doc                            755
        files                          755
        lib                            755
        source и все его подкаталоги   755 (700)
        ост.базы данных                777
        (символически принадлежащие адм.базы данных)










КАК УСТАНАВЛИВАТЬ РУБИН                                страница 7


        Программы в  .../bin могут иметь следующие моды доступа:

        -rwsr----- 1 rubin     . . .   ksort
        -rwxr-x--x 1 rubin     . . .   monitor
        -rwsr----- 1 rubin     . . .   vaxrubin

        Вам может понадобиться стать  супер-пользователем,  чтобы
        добавить файл в "/usr/bin".

    5.2.  Создание некоторых программ со "Sticky".

        Программа сортировки отношений в РУБИН довольно часто вы-
        полнется  во  время его работы.  Ее выполнение может быть
        более эффективно с применением "sticky".  Если у вас есть
        достаточно  места  в области своппинга, полезно запустить
        программу с установленным "sticky".  Это может быть  сде-
        лано установкой следующей моды программы в 5700.

                chmod 5740 .../bin/ksort


    5.3.  Терминалы только с большими буквами

        Вспомните, когда вы использовали терминалы только с боль-
        шими  буквами, вы должны были использовать двойную обрат-
        ную черту "\\" во всех командах,  чтобы  интерпретировать
        ее  как  символ "\".  Например для терминала с большими и
        маленькми буквами, вы бы напечатали:

                help parts
                \g

        а для терминала только с большими буквами вы напечатате:

                HELP PARTS
                \\G


6.  Исходный текст и перегенерация системы:

    6.1.  Войдите, как пользователь "rubin".

        Когда  производятся  какие-либо  системные  работы,  надо
        всегда быть зарегистрированным как "rubin".

    6.2.  Перекомпиляция.

        Все исходные тексты системы располагаются в  ".../source"
        и его подкаталогах. Каждый подкаталог называется по имени
        функциональной компонент или подкомпоненты системы.   Все
        "Makefile"  для перегенерации различных часетй системы из
        исходных текстов размещаются в соответствующих им катало-
        гах.    Для  перегенерации  отдельных  модулей  (например
        parser) скажите:









КАК УСТАНАВЛИВАТЬ РУБИН                                страница 8


                chdir .../source/parser
                make

        Выполняемая система  перекомпилируется  и  размещается  в
        /usr/bin с использованием команды:

                chdir .../source/conf
                make allinstall sysinstall

        При перекомпиляции системы в первое время решительно  со-
        ветуем вам каким-либо способом сохранять вывод.

        Библиотеки объектных файлов размещены в  .../lib.

        Вы можете обнаружить, что ваш Си-компилятор не может отт-
        ранслировать  РУБИН.  Если так произрошло, вы должны уве-
        личить размер таблицы символов в cpp.

    6.3.  Трассировка работы РУБИН

        Для трассировки  РУБИН  используются  флаги  трассировка.
        Коды букв для этих флагов следующие:

             A       Методы доступа
             M       Терминальный монитор
             P       Синтаксический анаоизатор
             Q       Модификатор запросов
             D       Декомпозиция
             O       Процессор одной перменной в запросе
             Z       Утилиты базы данных
             E       Equel интерфейс языка запросов
             S       Сканнер
             T       Standalone Routines


7.  Документация.

    Все документы в сформатированном виде собраны в справочнике ".../doc/LP".
    Список документов приведен в файле ".../doc/READ_ME".





















