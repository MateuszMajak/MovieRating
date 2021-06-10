
# R version: 4.0.2
# RStudio version: 1.3.1093


# This analysis is intended to reproduce to the biggest possible extent 
# the results presented in the old report


# Libraries used

#install.packages('dplyr')
library(dplyr)

#install.packages('stargazer')
library(stargazer) # for despcriptive statistics

#install.packages('stargazer')
library(mice) #checking missings


# directory

setwd('reproduced old project/data')


# Data reading

movies_old <- read.csv('tmdb_5000_movies_2019.csv', header = T)


# Selecting variables

movies_old <- movies_old[c('vote_average', 'runtime', 'popularity', 'revenue', 'budget', 'release_date', 'vote_count')]


# Creating new variable - years_old

movies_old$release_date <- as.Date((movies_old$release_date), format = "%Y-%m-%d") # changing format to date

movies_old$years_old <- as.integer((as.Date("2019-01-10") - movies_old$release_date) / 365) # calculating age

movies_old$release_date <- NULL # deleting old variable


# reordering columns to order in report

movies_old <- movies_old[c(1:3,7,4:6)]


# dealing with missing values

movies_old %>%
  is.na() %>%
  colSums() %>%
  sort()

movies_old %>% 
  md.pattern(rotate.names = TRUE)

movies_old <- na.omit(movies_old) # omitting NAs


# Variables statistics

stargazer(
  movies_old, type = "text", 
  summary.stat = c("n", "mean", "sd", "min", "max")
)



# Removing variables with values outside of ranges presented in raport

## Vote_average

summary(movies_old$vote_average)

sum(ifelse(movies_old$vote_average < 2.3 | movies_old$vote_average > 8.5, 1, 0))

movies_old[movies_old$vote_average < 2.3 | movies_old$vote_average > 8.5,]$vote_average <- NA

sum(is.na(movies_old$vote_average))


## runtime

summary(movies_old$runtime)

sum(ifelse(movies_old$runtime < 63 | movies_old$runtime > 338, 1, 0))

movies_old[movies_old$runtime < 63 | movies_old$runtime > 338,]$runtime <- NA 

sum(is.na(movies_old$runtime))


## popularity

summary(movies_old$popularity)

sum(ifelse(movies_old$popularity < 0.179 | movies_old$popularity > 875.6, 1, 0))

movies_old[movies_old$popularity < 0.179 | movies_old$popularity > 875.6,]$popularity <- NA 

sum(is.na(movies_old$popularity))


## years_old

summary(movies_old$years_old)

sum(ifelse(movies_old$years_old < 3 | movies_old$years_old > 103, 1, 0))

movies_old[movies_old$years_old < 3 | movies_old$years_old > 103,]$years_old <- NA 

sum(is.na(movies_old$years_old))


## revenue

summary(movies_old$revenue)

sum(ifelse(movies_old$revenue < 6399 | movies_old$revenue > 2.788e+09, 1, 0))

movies_old[movies_old$revenue < 6399 | movies_old$revenue > 2.788e+09,]$revenue <- NA 

sum(is.na(movies_old$revenue))


## budget

summary(movies_old$budget)

sum(ifelse(movies_old$budget < 7000 | movies_old$budget > 3.800e+08, 1, 0))

movies_old[movies_old$budget < 7000 | movies_old$budget > 3.800e+08,]$budget <- NA 

sum(is.na(movies_old$budget))


## vote_count

summary(movies_old$vote_count)

sum(ifelse(movies_old$vote_count < 20 | movies_old$vote_count > 13752, 1, 0))

movies_old[movies_old$vote_count < 20 | movies_old$vote_count > 13752,]$vote_count <- NA 

sum(is.na(movies_old$vote_count))


## removing

movies_old %>%
  is.na() %>%
  colSums() %>%
  sort()

movies_old %>% 
  md.pattern(rotate.names = TRUE)

movies_old <- na.omit(movies_old)


# descriptive statistics

stargazer(
  movies_old, type = "text", 
  summary.stat = c("n", "mean", "sd", "min", "max")
) # Still a little bit different than in report


# saving cleaned data

save(movies_old, file = "movies_old_cleaned.rda")




