library(dplyr)
library(naniar)

data <- read.csv('tmdb_5000_movies_2019.csv', header = T)


data2 <- data[c('vote_average', 'vote_count', 'runtime', 'revenue', 'budget', 'popularity', 'release_date')]


data2$release_date <- as.Date((data2$release_date), format = "%Y-%m-%d")

data2$years_old <- as.integer((as.Date("2019-01-10") - data2$release_date) / 365)


data2$release_date <- NULL

data2 %>%
  is.na() %>%
  colSums() %>%
  sort()

data2 <- na.omit(data2)

data2 %>% summary()



summary(data2$vote_average)

sum(ifelse(data2$vote_average < 2.3 | data2$vote_average > 8.5, 1, 0))

data2[data2$vote_average < 2.3 | data2$vote_average > 8.5,]$vote_average <- NA

sum(is.na(data2$vote_average))


summary(data2$runtime)

sum(ifelse(data2$runtime < 63 | data2$runtime > 338, 1, 0))

data2[data2$runtime < 63 | data2$runtime > 338,]$runtime <- NA 

sum(is.na(data2$runtime))


summary(data2$popularity)

sum(ifelse(data2$popularity < 0.179 | data2$popularity > 875.6, 1, 0))

data2[data2$popularity < 0.179 | data2$popularity > 875.6,]$popularity <- NA 

sum(is.na(data2$popularity))


summary(data2$years_old)

sum(ifelse(data2$years_old < 3 | data2$years_old > 103, 1, 0))

data2[data2$years_old < 3 | data2$years_old > 103,]$years_old <- NA 

sum(is.na(data2$years_old))


summary(data2$revenue)

sum(ifelse(data2$revenue < 6399 | data2$revenue > 2.788e+09, 1, 0))

data2[data2$revenue < 6399 | data2$revenue > 2.788e+09,]$revenue <- NA 

sum(is.na(data2$revenue))


summary(data2$budget)

sum(ifelse(data2$budget < 7000 | data2$budget > 3.800e+08, 1, 0))

data2[data2$budget < 7000 | data2$budget > 3.800e+08,]$budget <- NA 

sum(is.na(data2$budget))


summary(data2$vote_count)

sum(ifelse(data2$vote_count < 20 | data2$vote_count > 13752, 1, 0))

data2[data2$vote_count < 20 | data2$vote_count > 13752,]$vote_count <- NA 

sum(is.na(data2$vote_count))


data2 %>%
  is.na() %>%
  colSums() %>%
  sort()

data2 <- na.omit(data2)

data2 %>% summary()
