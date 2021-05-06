library(plyr)             #For Data transformation
library(tidyverse)        #For data cleaning
library(jsonlite)         #For manipulating JSON data
library(wordcloud)        #For generating Word Cloud
library(RColorBrewer)     #For further formatting
library(ggplot2)          #Extension of ggplot2
library(tm)               #For text mining
library(zoo)              #For handling irregular time series of numeric vectors/matrices and factors



movie = read_csv("C:/Users/mateu/Desktop/tmdb/film.csv",col_names = TRUE, na = "NA")
glimpse(movie)

diffGenre = movie %>% filter(nchar(genres) > 2) %>% mutate(js = lapply(genres,fromJSON)) %>% unnest(js) %>% select(id,title,genre = name)
productionCompanies = movie %>% filter(nchar(production_companies) > 2) %>% mutate(js = lapply(production_companies,fromJSON)) %>% unnest(js) %>% select(id,budget,revenue,production_companies = name)
productionCountries = movie %>% filter(nchar(production_countries) > 2) %>% mutate(js = lapply(production_countries,fromJSON)) %>% unnest(js) %>% select(production_countries = name)
SpokenLang = movie %>% filter(nchar(spoken_languages) > 2) %>% mutate(js = lapply(spoken_languages,fromJSON)) %>% unnest(js) %>% select(iso_639_1,spoken_languages = name)

#TEST---------------------
genredf=movie %>% filter(nchar(genres)>2) %>% mutate(js=lapply(genres,fromJSON)) %>% unnest(js) %>% select(title,genre=name)
slice(genredf)
print(genredf)
write.table(genredf, file = "genredf.csv",sep=",")
getwd()
#KONIEC TESTU-------------


movies <- subset(movie, select = -c(genres, keywords, production_companies, production_countries,spoken_languages))
glimpse(movies)
movies$homepage <- NULL
movies$id <- NULL
movies$status <- NULL
movies$tagline <- NULL
movies$original_title <- NULL
movies$overview <- NULL
write.csv(movies, "movies_neeeew.csv")
list(movies$vote_average)
typeof(movies$vote_average)


