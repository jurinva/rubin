#
foreach i ($*)
ex - $i << \%
/��������/i
���������
.
0a
.s3
.i0
.in +4
.ti -4
XXX
.
.,/^\.th/-d
s/\.th \(.*\) \(.*\) \(.*\)$/\1(\2) \\-/
+,/���/d
s/^/- /
s/^.*- //
-,.join
+,/������/c
.br
.
g/������/d
1,/��������/-w! >> ../toc.nr
q!
\%
end
