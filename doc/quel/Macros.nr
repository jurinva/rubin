.th MACROS QUEL "СУБД \*(RU. ОПЕРАТОРЫ QUEL"
.sh ИМЯ
macros \- средства макрообработки, поддерживаемые терминальным монитором
.sh ОПИСАНИЕ
Средства макрообработки, поддерживаемые терминальным монитором,
предоставляют возможности расширять язык
запросов QUEL в соответствии со вкусами пользователей.
Макросредства позволяют удалять
строки текста из потока запросов
и заменять их другим текстом.
Кроме того, некоторые встроенные макрокоманды
изменяют рабочую среду на момент выполнения программы.
.s1
.bd "Основные понятия"
.s2
Все макрокоманды состоят из двух частей -
.it шаблонной
и
.it замещающей.
.it Шаблон
определяет когда должна быть вызвана
макрокоманда.
Например, шаблон
``\fIret\fR''
приводит к вызову соответствующей
макрокоманды, когда во входном потоке встречается слово
``\fIret\fR''.
Когда встречается такая макрокоманда,
то шаблонная часть удаляется и заменяется на
заменяющую часть
макрокоманды.
Например,
если замещающей частью макрокоманды
``\fIret\fR'' была ``\fIretrieve\fR'',
то все вхождения слова
``\fIret\fR'' во входной текст,
будут заменены словом
``\fIretrieve\fR'',
как, например, в операторе
.s3
	ret (p.all)
.s3
Макрокоманды могут иметь параметры,
помечаемые знаком доллара.
Например, шаблон
``\fIget $1\fR'' вызывает запуск макрокоманды по слову
``\fIget\fR'' за которым может следовать любое другое слово.
Слово, следующее за ``\fIget\fR''
запоминается для дальнейшего использования.
Например,
если замещающая часть макрокоманды
``\fIget\fR'' была:
.s3
	retrieve (p.all) where p.pnum = $1
.s3
то в этом случае, при печати ``\fIget 35\fR'',
должна выбираться вся информация о запасной части под номером 35.
(см. отношение parts)
.s1
.bd "Определение макрокоманд"
.s2
Макрокоманды определяются
специальной макрокомандой
``\fIdefine\fR''.
Макрокоманда ``\fIdefine\fR''
имеет (примерно) такой общий формат:
.s3
	\fB{define; \fI$t\fB; \fI$r\fB}\fR
.s3
где \fI$t\fR и \fI$r\fR - это соответственно шаблонная и замещающая
части.
.s3
Приведем несколько примеров.
Обсуждавшаяся ранее макрокоманда ``\fIret\fR'' определяется
следующим образом:
.s3
	{define; ret; retrieve}
.s3
После того, как эта последовательность считается,
макропроцессор удаляет все,
находящееся между \fB{}\fR,
и обновляет некоторые таблицы таким образом,
что ``\fIret\fR'' будет распознано и заменено
словом ``\fIretrieve\fR''.
Макрокоманда ``\fIdefine\fR'',
замещаемая пустой строкой,
будет воспринята как исчезнувшая.
.s3
Рассмотрим работу макропроцессора на примере полезной макрокоманды,
сокращающей указание переменной для отношения.
Она может быть определена так:
.s3
	{define; rg $v $r; range of $v is $r}
.s3
По этой макрокоманде слово ``\fIrg\fR'', за которым следуют
два слова, должно быть заменено
словами
``\fIrange of\fR'',
за которыми будет следовать слово, стоящее первым после
``\fIrg\fR'',
затем слово ``\fIis\fR'',
и, наконец, слово, стоящее вторым после
``\fIrg\fR''.
Т.е., входная строка
.s3
	rg p parts
.s3
будет преобразована
.s3
	range of p is parts
.s3
.s1
.bd "Процесс вычисления"
.s2
Точно так же, как и запросы накапливающиеся в буфере, но не
выполняющиеся до подачи команды монитору, так и оператор
``\fIdefine\fR'' не обрабатывается сразу после ввода.
До тех пор, пока не будет
вычислен буфер запросов никакой обработки макроопределений не производится.
Оператор define вычисляется после выполнения
команд монитора
\fB\ego\fR или
\fB\eeval\fR.
Буфер запросов вычисляется по командам
\fB\ego\fR,
\fB\elist\fR,
и \fB\eeval\fR;
\fB\ego\fR посылает результаты
в \*(II,
\fB\elist\fR печатает их на терминале,
а \fB\eeval\fR
возвращает результаты макроподстановки
в буфер запросов.
.s3
Макроопределения обязательно должны быть
вычислены, в противном случае они как бы вообще
отсутствуют.
Ниже приводится стандартный способ определения макрокоманды:
.s3
	{define . . . }
.br
	\eeval
.br
	\ereset
.s3
Если команда \fB\eeval\fR будет пропущена, макрокоманда не будет вычислена.
.s1
.bd "Экранирование"
.s2
Иногда строки символов должны пропускаться макропроцессором
без обработки. В таких случаях для
выделения необрабатываемого символьного текста, используются знаки
прямых и обратных кавычек
\fB\*g\fR и \fB\*a\fR.
Например,
для того, чтобы слово ``\fIret\fR'' не
преобразовывалсь в слово ``\fIretrieve\fR''
оно должно быть забрано в кавычки
.s3
	\*gret\*a
.s3
Кроме того, экранирование применяется для
образования параметров.
Если параметр состоит более, чем из одного слова,
а синтаксис допускает параметр, состоящий только из одного слова,
то образующую параметр цепочку, заключают в одинарные кавычки.
.s3
Символ обратной косой черты \fB\e\fR
экранирует только следующий за ним символ
(подобно заключению символа в одинарные кавычки).
В частности,
прямая одинарная кавычка может использоваться
в качестве обычного символа, если ей предшествует
обратная косая черта.
.s3
Поскольку макрокоманды должны состоять
только из одной строки,
символ \fB\e\fR используется в конце строки для маскирования символа
новой строки.
Например,
чтобы ввести длинную макрокоманду ``\fIget\fR''
следует напечатать:
.nf
	{define; get $n; retrieve (e.all ) \e
	where e.name = "$n"}
.fi
.s3
\fB\e\fR всегда экранирует следующий символ,
даже если этим символом является \fB\e\fR.
Поэтому, чтобы получить сам символ
\fB\e\fR введите его дважды.
.s1
.bd "Еще о параметрах"
.s2
Параметры могут и не ограничиваться
одним словом.
Например,
в шаблоне описания оператора
define:
.s3
	{define; $t; $r}
.s3
Параметр \fI$t\fR оканчивается первой точкой с запятой,
а параметр \fI$r\fR оканчивается первой правой фигурной скобкой.
Общее правило такое: если символ, следующий за обозначением
параметра в шаблоне макро, не является
символом пробела, табуляции,
новой строки
или конца шаблона (;), то этот символ является признаком конца параметра
при подстановке; иначе в качестве параметра подставляется очередное слово.
.s3
Так же, как и у всех хороших правил,
у этого правила есть исключения.
Т.к. системные макрокоманды всегда заключаются в фигурные скобки,
макропроцессор думает, что для них соблюдается правильная вложенность.
Так, в операторе
.s3
	{define; x; {sysfn}}
.s3
первая правая фигурная скобка будет закрывать ``\fIsysfn\fR''
а не ``\fIdefine\fR''.
А правильное макроопределение будет таким:
.s3
	{define; x; \*g{sysfn}\*a}
.s3
.s3
Слова определяются обычным образом,
как цепочки, состоящие из букв, цифр и
символов подчеркивания.
.s1
.bd "Встроенные макрокоманды"
.s2
В системе имеются
различные встроенные макрокоманды.
В следующем далее описании некоторые из параметров
помечаются двумя знаками доллара, а не одним.
Это об'ясняется в разделе о предварительном просмотре параметров.
.s3
\fB{define; \fI$$t;\fI $$r\fB}\fR
определяет макрокоманду описанным выше способом.
Проводится специальная обработка шаблонной части;
это будет обсуждаться в следующем разделе.
.s3
\fB{rawdefine; \fI$$t\fB; \fI$$r\fB}\fR
\- другая форма определения:
при таком определении специальная обработка уже не проводится.
.s3
\fB{remove; \fI$$n\fB}\fR
удаляет макрокоманду с именем
\fI$n\fR.
Так можно удалить больше одной макрокоманды,
т.к. этот макрооператор в действительности удаляет все макрокоманды, имена которых
при некоторых обстоятельствах
могут подпадать под определение аргумента
$n.
Например, ввод следующих макроопределений
.s3
	{define; get part $n; . . . }
.br
	{define; get emp $x; . . . }
.br
	{remove; get}
.s3
приведет к уничтожению обоих макроопределений.
А вызов
.s3
	{remove; get part}
.s3
удалит только первую макрокоманду.
.s3
\fB{type \fI$$s\fB}\fR
выводит \fI$s\fR на терминал.
.s3
\fB{read \fI$$s\fB}\fR
печатает \fI$s\fR и затем считывает строку с терминала.
Считанная с терминала строка замещает
макрокоманду.
Макрокоманда ``\fI{readcount}\fR'' определяется как
содержащий число считанных символов.
Если введен символ Control-D (конец файла), то значением макрокоманды становится \*-1,
если введен символ новой строки, то значением макрокоманды стaновится ноль,
и т.д.
.s3
\fB{readdefine; \fI$$n\fB; \fI$$s\fB}\fR
также печатает \fI$s\fR и считывает строку,
но помещает строку в
макрокоманду с именем \fI$n\fR.
Замещающий текст -
число
символов в строке.
\fB{readcount}\fR тем не менее остается определенным, т.е. сохраняет свое значение.
.s3
\fB{ifsame; \fI$$a\fB; \fI$$b\fB; \fI$t\fB; \fI$f\fB}\fR
сравнивает строки \fI$a\fR и \fI$b\fR.
Если они полностью совпадают,
то замещающим текстом становится
\fI$t\fR,
в противном случае \- \fI$f\fR.
.s3
\fB{ifeq; \fI$$a\fB; \fI$$b\fB; \fI$t\fB; \fI$f\fB}\fR
работает аналогично,
но производит численное сравнение.
.s3
\fB{ifgt; \fI$$a\fB; \fI$$b\fB; \fI$t\fB; \fI$f\fB}\fR
подобно \fBifeq\fR,
но проверяется, чтобы
\fI$a\fR было строго больше
чем \fI$b\fR.
.s3
\fB{substr; \fI$$f\fB; \fI$$t\fB; \fI$$s\fB}\fR
возвращает часть строки \fI$s\fR, расположенную
между символами в позициях \fI$f\fR и \fI$t\fR,
нумерующимися с единицы.
Если \fI$f\fR или \fI$t\fR находятся вне диапазона,
то они, по мере возможности, помещаются в диапазон.
.s3
\fB{dump; \fI$$n\fB}\fR
возвращает значение макрокоманды (или макрокоманд), соответствующих
\fI$n\fR, используя алгоритм работы макрокоманды remove.
Результатом вывода является
оператор \fBrawdefine\fR, для того, чтобы он мог быть
считан обратно.
\fB{dump}\fR без аргументов выгружает все макрокоманды.
.s1
.bd "Метасимволы"
.s2
Некоторые символы используются
макропроцессором специальным образом.
Как правило, вы их даже не будете видеть,
но они могут появиться в выводе команды dump,
и могут иногда быть использованы
для создания весьма причудливых макрокоманд.
.s3
\fB\e\*|\*v\fR соответствует любому числу пробелов,
знаков табулции или символов новой строки.
Он даже может представлять ноль пробелов,
\fB\e\*t\fR и
\fB\e\*n\fR,
но только между словами,
как в случае знаков препинания.
Например,
\fB\e\*|\*v\fR будет соответствовать месту
между последним символом слова и
следующей за ним запятой.
.s3
\fB\e^\fR соответствует точно одному пробелу,
знаку табуляции или символу новой строки.
.s3
\fB\e&\fR соответствует точно нолю пробелов,
знаков табуляции или символов новой строки,
но только между словами.
.s1
.bd "Процесс определения"
.s2
Когда вы определяете свою макрокоманду, используя
\fBdefine\fR, выполняются некоторые действия по обработке определения.
Отметим, что
\fBdefine\fR не
является функционально полной макрокомандой (т.е. она не позволяет определить
произвольный шаблон),
но все же отвечает большинству
требований. Если от макрокоманды при определении шаблона требуется
большая мощность, то пользуются макрокомандой
\fBrawdefine\fR; отличие \fBdefine\fR от \fBrawdefine\fR состоит в том,
что в \fBdefine\fR
определяется образец, который \fBПРЕОБРАЗУЕТСЯ К ШАБЛОНУ\fR, а \fBrawdefine\fR
явным образом \fBЗАДАЕТ ШАБЛОН\fR со всеми метасимволами.
Однако, пользоваться
\fBrawdefine\fR нужно достаточно аккуратно,
т.к. можно насажать ошибок в самых
неожиданных местах.
.s3
В шаблонной части макрокоманды \fBdefine\fR
все последовательности пробелов, символов табуляции и символов новой строки,
также как и все ``\fIнепробелы\fR''
между словами,
сворачиваются в символ
\fB\e\*|\*v\fR.
Если шаблон оканчивается параметром,
в конец добавляется символ \fB\e&\fR.
.s3
Если необходимо явно обозначить табуляцию или новую
строку, используйте символы
\fB\et\fR или \fB\en\fR соответственно.
Например,
макрокоманда, которая  читает всю вводимую строку
и интерпретирует ее, как имя служащего,
может быть определен так:
.s3
	{define; get $n\en; \e
.br
	    ret (e.all) where e.name = "$n"}
.s3
Этой макрокомандой можно пользоваться следующим образом:
напечатав
.s3
	get *Stan*
.s3
вы получите информацию о каждом служащем,
имя которого содержит ``\fIStan\fR''.
Попутно заметим,
что было бы полезно включить в определение макро ``\fIget\fR'' макро ``\fIret\fR''.
.s1
.bd "Предварительная обработка параметров"
.s2
Бывает необходимо провести макрообработку параметра, перед его
использованием в замещающей части.
Это особенно важно при использовании
некоторых встроенных макрокоманд.
.s3
Для выполнения предварительной макрообработки нужно соблюдать
два правила:
Первое:
параметр в шаблоне должен быть указан с
двумя \fIзнаками доллара\fR вместо одного;
и второе:
фактический параметр должен начинаться с символа "комерческий at"
``\fB@\fR'', который при обработке опускается.
.s3
Примеры предварительной макрообработки рассматриваются в разделе
``\fBСпециальные макрокоманды\fR''.
.s1
.bd "Специальные макрокоманды"
.s2
Некоторые специальные макрокоманды используются терминальным монитором
для управления средой и возврата результата пользователю.
.s3
\fB{begintrap}\fR
выполняется в начале выполнения запроса.
.s3
\fB{endtrap}\fR
выполняется после того, как тело запроса
передается \*(II.
.s3
\fB{continuetrap}\fR
выполняется после полного выполнения запроса.
Разница между ним и \fB{endtrap}\fR состоит в том,
что \fB{еndtrap}\fR выполняется после того,
как запрос был подготовлен к выполнению,
но перед его выполнением,
а \fB{continuetrap}\fR выполняется после выполнения запроса.
.s3
\fB{editor}\fR
его значение определяет полное имя
программы редактора, используемого в
команде \fB\eedit\fR.
.s3
\fB{shell}\fR
его значение определяет полное имя
интерпретатора shell для использования в команде
\fB\eshell\fR.
.s3
\fB{tuplecount}\fR
его значение
устанавливается после выполнения каждого запроса
(но перед тем как выполнится \fB{continuetrap}\fR)
и равно числу кортежей, которые удовлетворяют условию
запроса в команде retrieve
или числу измененных кортежей.
Эта макрокоманда не работает для обслуживающих
программ СУБД.
Если одновременно выполняются несколько запросов,
то его значение равняется числу кортежей, которые удовлетворяют
последнему выполненному запросу.
.s3
Например,
для печати числа рассматривавшихся в запросе кортежей
вы должны напечатать:
.nf
	{define; {begintrap}; {remove; {tuplecount}}}
	{define; {continuetrap}; \e
	   {ifsame; @{tuplecount}; {tuplecount};; \e
	     {type @{tuplecount} tuples touched}}}
.fi
.sh "ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ"
monitor(quel)
