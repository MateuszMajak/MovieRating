/*statystyki opisowe zmiennych - informacje na temat zbioru danych*/
summarize vote_average vote_count  runtime revenue years_old popularity budget
/*macierz korelacji zmiennych*/
corr vote_average vote_count  runtime revenue years_old popularity budget
/*histogramy zmiennych*/
hist vote_average, normal
hist vote_average, name (w1)
hist vote_count, name (w2)
hist runtime, name (w3)
hist years_old, name (w4)
hist popularity, name (w5)
hist revenue, name (w6)
hist budget, name (w7)
graph combine w1 w2 w3 w4 w5 w6 w7
/*tworzymy logarytmy*/
generate lnvotec=ln(vote_count)
generate lnbudget=ln(budget)
generate lnrevenue=ln(revenue)
generate lntime=ln(runtime)	
/*histogramy z logarytmami*/
hist vote_average, name (g1)
hist lnvotec, name (g2)
hist lntime, name (c3)
hist years_old, name (g4)
hist popularity, name (g5)
hist lnrevenue, name (g6)
hist lnbudget, name (g7)
graph combine g1 g2 c3 g4 g5 g6 g7
/*Pierwsza estymacja*/
regress vote_average lnbudget years_old lnrevenue runtime vote_count popularity
/*Druga estymacja*/
regress vote_average lnbudget years_old lnrevenue runtime lnvotec popularity
/*trzecia estymacja*/
regress vote_average lnbudget years_old lnrevenue lntime lnvotec popularity
/*regresja czwarta*/
regress vote_average lnbudget years_old lnrevenue lntime lnvotec popularity
/*Regresja piata*/
generate yearsquared=years_old*years_old
drop if years_old >= 25
drop if vote_count <= 85
regress vote_average lnbudget years_old yearsquare lnrevenue lntime lnvotec popularity
/*test RESET*/
ovtest
/*testy na normalnosc skladnika losowego*/
predict reszty, resid
  kdensity reszty, normal
  pnorm reszty
