.th PURGE \*(DM "СУБД \*(RU. КОМАНДЫ \*(DM"
.sh ИМЯ
purge \- разрушает все устаревшие отношения и все временные отношения.
.sh ФОРМАТ
 purge [\-f] [\-p] [\-a] [\-s] [ база_данных ... ]
.sh ОПИСАНИЕ
.bd Purge
ищет и стирает в поименованных
базах данных системные временные отношения.
Когда используется ключ
.bd \-p,
осуществляется стирание устаревших отношений.
Ключ
.bd \-f
вызывает стирание нераспознаваемых файлов,
обычно
.bd purge
просто сообщает об этих файлах.
.s3
Только администратор базы данных (\fBDBA\fR)
может выполнять операцию удаления,
исключая суперпользователя \*(II,
который может чистить любую базу данных
при помощи ключа
.bd \-s.
.s3
Если база данных не указана, то очищаются все
базы данных для которых вы являетесь DBA.
Если суперпользователь \*(RU указал
ключ
.bd \-s,
очищаются все базы данных.
Ключ
.bd \-a
вызывает чистку в интерактивном перед каждой операцией над базой
запрашивается разрешение на эту операцию.
.s3
.bd Purge
будет блокировать базу данных на время ее обработки,
т.к. если во время выполнения чистки, база данных будет
использоваться, могут произойти ошибки.
Если база данных занята,
.bd purge
сообщит об этом и перейдет к другой, если
такая имеется.
Если стандартный ввод не
терминал,
.it purge
будет ждать, пока база данных не освободится.
.sh ПРИМЕРЫ
purge \-p +w tempdata
.br
purge \-a \-f
.sh "ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ"
save(quel),
restore(\*(dM)
