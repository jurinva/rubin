.th SAVE QUEL "СУБД \*(RU. ОПЕРАТОРЫ QUEL"
.sh ИМЯ
save \- сохранять отношение до определенной даты
.sh ФОРМАТ
 \fBsave \fIrelname \fBuntil \fImonth day year\fR
.sh ОПИСАНИЕ
.bd Save
используется для того, чтобы сохранять отношения
свыше его семидневного жизненного цикла.
.s3
.it Month
может быть целым числом  от 1 до 12 или
названием месяца, сокращенным либо мнемоническим.
.s3
.it "day year"
- целые числа, обозначающие день месяца и год.\
.s3
Только владелец отношения может дать команду
.it save
для сохранения данного отношения.
Существует процесс \*(II, который специально удаляет
отношение сразу же после истечения срока,
помеченного указанной датой.
.s3
Фактически, программа, которая уничтожает отношения
называется чисткой ( purge ).
При удалении отношений принимается
локальное решение.
.s3
Системные отношения не имеют даты окончания хранения.
Отношения, которые создает администратор базы данных, также
получают бесконечный срок хранения.
.sh ПРИМЕР
.nf
/* Сохранить отношение emp до конца февраля 1987 */
   save emp until feb 28 1987
.fi
.sh "СМ.ТАКЖЕ"
create(quel),
retrieve(quel),
purge(unix)
