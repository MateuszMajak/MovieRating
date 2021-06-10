##########################################
##### Project based on a new dataset #####
##########################################

# Libraries used
library(dplyr)
library(stargazer) # for descriptive statistics
library(corrplot)

# directory
setwd("new project")

# Data reading
df1 <- readRDS("data/tmdb_data1.rds")
df2 <- readRDS("data/tmdb_data2.rds")

movies_new <- union_all(x1,x2)


glimpse(movies_new)

# Selecting variables
movies_new <- movies_new[c('original_language','adult','vote_average', 'vote_count', 'runtime', 'revenue', 'budget', 'popularity', 'release_date')]

# Data preperation
glimpse(movies_new)

movies_new$original_language <- as.factor(movies_new$original_language)
movies_new$adult <- as.factor(movies_new$adult)
movies_new$budget <- as.double(movies_new$budget) #we added NAs by this transformation
movies_new$popularity <- as.double(movies_new$popularity) #we added NAs by this transformation
movies_new$release_date <- as.Date(movies_new$release_date)
movies_new$years_old <- as.integer((as.Date("2021-06-09") - movies_new$release_date) / 365) # calculating age
movies_new$release_date <- NULL # deleting old variable

# EDA
glimpse(movies_new)

stargazer(
  movies_new, type = "text", 
  summary.stat = c("n", "mean", "sd", "min", "max")
)

colSums(is.na(movies_new)) %>% 
  sort()

movies_new %>% 
  md.pattern(rotate.names = TRUE)

# It looks like removing all rows containing NA value in release_date will deal 
# with most of the missings. However, we have to remove 1/6 of the whole dataset 
# to remove all NAs, so for now we remove only rows containing missing vote_average
# value, which is our target variable.
movies_new <- movies_new %>% 
  dplyr::filter(!is.na(movies_new$vote_average))

movies_new %>% 
  md.pattern(rotate.names = TRUE)

# We removed 6838 rows, which is 1% of the primary dataset. For now we have still
# a lot of NA values, but only within years_old and runtime columns.
# We will deal with it after checking the significance of these variables.

# Data division
set.seed(987654321)

movies_which_train <- createDataPartition(movies_new$vote_average,
                                        p = 0.7, 
                                        list = FALSE) 

movies_train <- movies_new[movies_which_train,]
movies_test <- movies_new[-movies_which_train,]

summary(movies_new$vote_average)
summary(movies_train$vote_average)
summary(movies_test$vote_average)

# The distributions of train and test datasets haven't significantly changed
# in comparison to the primary dataset.

# Correlations

movies_numeric_vars <- 
  sapply(movies_train, is.numeric) %>% 
  which() %>% 
  names()

movies_correlations <- 
  cor(movies_train[,movies_numeric_vars],
      use = "pairwise.complete.obs")

movies_numeric_vars_order <- 
  movies_train[,"vote_average"] %>% 
  sort(decreasing = TRUE) %>%
  names()

corrplot.mixed(movies_correlations,
               upper = "circle",
               lower = "pie",
               tl.col="black",
               tl.pos = "lt",
               tl.cex = 0.7)

# Modeling
#estimation of the model with all variables
movies_lm1 <- lm(vote_average ~ ., 
                  data = movies_train)

summary(movies_lm1)
#R-squared 0.04256

#estimation with transformed variables
movies_lm2 <- lm(vote_average ~ original_language + adult + vote_count +
                   runtime + log1p(revenue) +log1p(budget) + popularity + years_old, 
                 data = movies_train)

summary(movies_lm2)
#R-squared 0.05894


