.th HELPR \*(DM "СУБД \*(RU. КОМАНДЫ \*(DM"
.sh ИМЯ
helpr \- получить информацию о базе данных.
.sh ФОРМАТ
 \fBhelpr\fR [\fB\-u\fIимя\fR] [\fI+-\fBw\fR] \fIбаза_данных\fR [\fIрежим\fR] \fIотношение ...\fR
.sh ОПИСАНИЕ
.bd helpr
выдает информацию о поименованном отношении вне
указанной базы данных, точно так же,
как это делает команда
.br help.
.s3
Воспринимаемые ключи:
.bd \-u
и
.bd \+\-w.
Их значения идентичны значениям тех же
самых ключей в \*(II.
.s3
.it режим
- ключевое слово, которое уточняет формат выдачи. Это может быть
одно из следующих слов:

.bd short
\-  Предоставляет в компактной форме информацию обо всех отношениях,
которые существуют в текущей базе данных, кроме системных.

.bd my
\-  Предоставляет информацию обо всех личных
отношениях данного пользователя,
которые существуют в текущей базе данных.

.bd real
\-  Предоставляет информацию обо всех регулярных
(не VIEW или INDEX) отношениях,
которые существуют в текущей базе данных, кроме системных.

.sh "ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ""
\*(rN(\*(dM),
help(quel)
