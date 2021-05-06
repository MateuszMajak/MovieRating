do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
rate totalthingstodo rank couples business
regress rate totalthingstodo rank couples business
test solo friends
regress  rate reviewcount totalthingstodo interactive rank families couples solo business friends
test solo friends
regress  rate reviewcount totalthingstodo interactive rank families couples business
regress  rate reviewcount totalthingstodo interactive rank couples business
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
hist t
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
regress  rate reviewcount totalthingstodo interactive rank families couples business
test  families interactive
regress  rate reviewcount totalthingstodo rank couples business
test  couples reviewcount
regress  rate  totalthingstodo rank business
drop totalthingstodo if <=100
drop totalthingstodo if => 100
drop if totalthingstodo <= 100
regress  rate  totalthingstodo rank business
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
regress totalthingstodo rank business
test  totalthingstodo rank business
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
tabulate  interactive
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
graph save Graph "C:\Users\Dominika\Desktop\model\histogram_graph.gph"
asdoc summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends, save(modelword)
help asdoc
save "C:\Users\Dominika\Desktop\model_muzea.dta"
ssc install asdoc, replace
asdoc summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends, save(wordmodel)
summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
outreg2 using modelword.doc, replace
ssc install outreg2
outreg2 using modelword.doc, replace
shellout using `"modelword.doc"'
eststo: summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
ssc install eststo
ssc install esttab
help esttab
ssc install estout
eststo: summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
esttab using "C:\Users\Dominika\Pulpit\model\Testword.rtf", cells(b(star fmt(4) label
esttab using "C:\Users\Dominika\Pulpit\model\Testword.rtf", cells(b(star fmt(4) label))
esttab using "C:\Users\Dominika\Pulpit\model\Testword.rtf"
esttab using testword.rtf
eststo clear
eststo: summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
esttab
estpost summarize rate reviewcount totalthingstodo interactive rank families couples so
estpost summarize rate reviewcount totalthingstodo interactive rank families couples solo business friends
esttab
esttab, cells ("rate reviewcount totalthingstodo interactive rank families couples solo business friends")
esttab, cells ("rate reviewcount totalthingstodo interactive rank families couples solo business friends") nomtitle nonumber
esttab clear
eststo clear
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
outreg2 using ds.doc, replace sum(detail) keep(roa roe sdlt ldtl) eqkeep(N sum mean sd kurtosis skewness)
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N sum mean sd kurtosis skewness)
shellout using `"ds.doc"'
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N mean sd Min Max)
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N mean sd Min Max)
shellout using `"ds.doc"'
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N mean min max)
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N mean sd Min Max)
shellout using `"ds.doc"'
outreg2 clear
clear
outreg2 using ds.doc, replace sum(detail) keep(rate reviewcount totalthingstodo interactive rank families couples solo business friends) eqkeep(N mean min max)
shellout using `"ds.doc"'
outreg2 using ds.doc, replace sum(log)
outreg2 using ds1.doc, replace sum(log)
shellout using `"ds1.doc"'
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
estpost correlate rate reviewcount totalthingstodo interactive rank families couples solo business friends, matrix listwise
est store c1
esttab*using correlation.rtf, unstack not noobs compress
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
outreg using reg1.rtf
outreg2 using reg1.rtf
shellout using `"reg1.rtf"'
shellout using `"reg1.rtf"'
shellout using `"reg1.rtf"'
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
test  reviewcount interactive families couples solo  friends
test  reviewcount interactive families couples solo friends
test  interactive families couples solo business friends
regress  rate reviewcount totalthingstodo interactive rank families couples business
regress rate  totalthingstodo interactive rank families couples business business friends
test  reviewcount interactive families couples solo business friends
regress  rate  reviewcount totalthingstodo interactive rank families couples solo business friends
test reviewcount interactive families couples solo business friends
test reviewcount interactive families couples solo friends
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
clear all
do "C:\Users\Dominika\AppData\Local\Temp\STD01000000.tmp"
help
tsset t
dwstat
save "C:\Users\Dominika\Desktop\stata.dta"
