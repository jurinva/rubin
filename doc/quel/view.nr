.th VIEW QUEL "СУБД \*(RU. ОПЕРАТОРЫ QUEL"
.sh ИМЯ
view \- определить виртуальное отношение
.sh ФОРМАТ
 \fBdefine view \fIимя \fB(\fIсписок_объектов\fB)\fR[\fBwhere \fIусловие\fR]
.sh ОПИСАНИЕ
Синтаксис оператора
.bd view
почти идентичен оператору
.bd retrieve
.bd into;
однако, при этом данные
не выбираются. Вместо этого
запоминается определение.
Когда впоследствии используется
отношение
.it имя,
запрос преобразуется т.о.,
чтобы оперировать на отношениях,
указанных в
.it списке_объектов.
.s1
Осуществляется полная поддержка
всех видов поиска на виртуальном отношении,
однако поддерживается только ограниченный набор
обновлений, что связано с возможностью
повреждения исходных отношений, на которых задано виртуальное.
Нельзя производить изменения
виртуальных отношений,
заданных более,
чем на одном отношении.
Не поддерживаются обновления,
которые влияют на домены в определении виртуального
отношения или, которые влияют на домены
не переводимые в простой атрибут.
Для виртуальных отношений не определен псевдо-атрибут
.bd tid.
.s3
В основном,
обновление поддерживается в том и только в том
случае, когда можно гарантировать
(без просмотра фактических данных),
что результат обновления виртуального отношения
идентичен результату обновления соответствующего
реального отношения.
.s1
Пользователь, который определяет
виртуальное отношение,
должен быть владельцем всех отношений,
на которых строится виртуальное отношение.
.sh ПРИМЕР
range of e is employee
.br
range of d is dept
.br
define view empdpt (ename = e.name, e.sal, dname = d.name)
.br
	where e.mgr = d.mgr
.sh "ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ"
retrieve(quel), destroy(quel)
