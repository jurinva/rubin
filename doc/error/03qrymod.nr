.th QRYMOD ERROR "СУБД \*(RU. ДИАГНОСТИКА ОШИБОК"
.sh ИМЯ
Список диагностик модификатора запросов
.sh ФОРМАТ
Номера ошибок 3000 \- 3999.
.sh ОПИСАНИЕ
Сообщения об этих ошибках генерируются модификатором запросов.
Эти ошибки включают синтаксические и семантические неточности
при определении виртуального отношения, установке
ограничений по целостности и
определении защиты.
Ошибки времени выполнения \-
попытки изменять виртуальное отношение
или  нарушение защиты.
.sh ОШИБКИ
.lp +8 8
3310    %0 на виртуальном отношении %1: нельзя изменять домен
.s3
Вы попытались выполнить операцию
%0 на виртуальном отношении;
однако, это изменение не определено.
.s3
.lp +8 8
3320    %0 на виртуальном отношении %1: домен встречается в
квалификациях виртуального отношения
.s3
Невозможно изменять домен в квалификациях виртуального отношения,
однако, это будет причиной исчезновения кортежа из
виртуального отношения.
.s3
.lp +8 8
3330    %0 на виртуальном отношении %1: изменение будет
результатом более, чем одного запроса
.s3
Вы пытаетесь выполнить некоторые изменения
на виртуальном отношении,  которые будут затрагивать
два отношения, на которых оно базируется.
.s3
.lp +8 8
3340    %0 на виртуальном отношении %1: отношение не содержит TID
.s3
Вы пытаетесь использовать поле идентификатора кортежа
виртуального отношения, которое не определено.
.s3
.lp +8 8
3350    %0 на виртуальном отношении %1: нельзя изменить значение агрегата
.s3
Вы не можете изменять значение, которое указано в определении
виртуального отношения как агрегат.
.s3
.lp +8 8
3360    %0 на виртуальном отношении %1: такое изменение
может быть нефункциональным
.s3
Есть возможность того, что выполнение изменения будет нефункциональным,
т.е. могут возникнуть некоторые непредвиденные побочные эффекты.
\*(II придерживается мнения, что лучше это не пытаться изменять.
.s3
.lp +8 8
3490    INTEGRITY на %1: пока нельзя иметь дело с агрегатами
.s3
Вы не можете определить целостность
агрегата.
.s3
.lp +8 8
3491    INTEGRITY на %1: нельзя выполнять проверки со многими переменными
.s3
Вы не можете определить контроля целостности на
более, чем одной переменной.
.s3
.lp +8 8
3492    INTEGRITY на %1:  первоначальное владение
не устанавливается
.s3
Когда вы определяете целостность,
то те кортежи которые уже имеются в отношении
ей не удовлетворяют.
.s3
.lp +8 8
3493    INTEGRITY на %1: это виртуальное отношение
.s3
Вы не можете определить целостность
на виртуальном отношении.
.s3
.lp +8 8
3494    INTEGRITY на %1: Вы должны быть владельцем %1\*a
.s3
Вы должны быть владельцем того отношения
на котором вы объявляете целостность.
.s3
.lp +8 8
3500    %0 на отношении %1: нарушение защиты
.s3
Вы сделали попытку выполнить операцию,
которая вам не разрешена.
.s3
.lp +8 8
3590    PERMIT: неверный конечный идентификатор "%2"
.s3
В операторе
.it permit
поле конечного идентификатора было неподходящим.
.s3
.lp +8 8
3591    PERMIT:неверное имя пользователя "%2"
.s3
Вы попытались использовать имя пользователя, которого
нет в системе.
.s3
.lp +8 8
3592    PERMIT: Отношение \*a%1\*a вам не принадлежит
.s3
Вы должны быть владельцем отношением для
того, чтобы иметь право устанавливать защиту
отношения.
.s3
.lp +8 8
3593    PERMIT: Отношение \*a%1\*a должно быть настоящим отношением
(не виртуальным)
.s3
Вы не можете устанавливать разрешения на виртуальные отношения.
.s3
.lp +8 8
3594    PERMIT на %1: неверный день недели \*a%2\*a
.s3
Код дня недели был неверно указан.
.s3
.lp +8 8
3595    PERMIT на %1: только DBA может использовать команду PERMIT
.s3
Однако, только DBA может иметь разделяемые отношения,
только DBA может исполнять команду
.it permit.
.s3
.lp +8 8
3700    Переполнение буферов дерева при модификации запроса
.lp +8 8
3701    Переполнение стэка построения дерева при модификации запроса
.s3
Плохие новости.
Внутренний буфер переполнен.
Некоторые выражения слишком длинны.
Попытайтесь сделать ваши выражения короче.
