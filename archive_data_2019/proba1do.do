/*statystyki opisowe zmiennych - informacje na temat zbioru danych*/
summarize vote_average vote_count  runtime revenue years_old popularity budget

/*macierz korelacji zmiennych*/
corr vote_average vote_count  runtime revenue years_old popularity budget

/*histogramy zmiennych*/
histogram vote_average, normal
hist vote_count
hist budget
hist revenue
hist runtime
hist years_old
	/*tworzymy logarytmy dla lepszego rozkladu*/
	generate lnvotec=ln(vote_count)
	generate lnbudget=ln(budget)
	generate lnrevenue=ln(revenue)
	generate lntime=ln(runtime)
	generate lnyear=ln(years_old)
histogram lnvotec, normal
histogram lnrevenue, normal
histogram popularity, normal
histogram lnbudget, normal
histogram lnyear, normal
hist vote_average
hist lnvotec
hist runtime
hist revenue
hist years_old
hist popularity
hist budget

/*Pierwsza estymacja*/
regress vote_average lnbudget years_old lnrevenue runtime vote_count popularity
/*Druga estymacja*/
regress vote_average lnbudget years_old lnrevenue runtime lnvotec popularity
/*trzecia estymacja*/
regress vote_average lnbudget years_old lnrevenue lntime lnvotec popularity
/*regresja czwarta*/
regress vote_average lnbudget years_old lnrevenue lntime lnvotec popularity
/*Regresja piata*/
generate yearsquare=years_old*years_old
drop if years_old >= 25
drop if vote_count <= 85
regress vote_average lnbudget years_old yearsquare lnrevenue lntime lnvotec popularity
/*wychodzi lepiej test RESET, ale wciaz reszta slabo*/
generate=  

/*Test RESET*/
ovtest

/*cos*/









