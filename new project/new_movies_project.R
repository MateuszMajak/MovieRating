##########################################
##### Project based on a new dataset #####
##########################################

# Libraries used
library(dplyr)
library(stargazer) # for descriptive statistics
library(mice)
library(corrplot)
library(caret)
library(bestNormalize)
library(car)
library(lmtest)
library(tseries)



# directory
setwd("~/Documents/GitHub/MovieRating/new project")

# Data reading
df1 <- readRDS("data/tmdb_data1.rds")
df2 <- readRDS("data/tmdb_data2.rds")

movies_new <- union_all(df1,df2)


glimpse(movies_new)

# Selecting variables
movies_new <- movies_new[c('original_language','adult','vote_average', 'vote_count', 'runtime', 'revenue', 'budget', 'popularity', 'release_date')]

# Data preperation
glimpse(movies_new)

movies_new$language_en <- as.factor(ifelse(movies_new$original_language == "en", 1, 0))
movies_new$adult <- as.factor(movies_new$adult)
movies_new$budget <- as.double(movies_new$budget) #we added NAs by this transformation
movies_new$popularity <- as.double(movies_new$popularity) #we added NAs by this transformation
movies_new$release_date <- as.Date(movies_new$release_date)
movies_new$years_old <- as.integer((as.Date("2021-06-09") - movies_new$release_date) / 365) # calculating age
movies_new$original_language <- NULL # deleting old variable
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

# We removed 6827 rows, which is 1% of the primary dataset. For now we have still
# a lot of NA values, but only within years_old and runtime columns.
# We will deal with it after checking the significance of these variables.



# Data division
set.seed(987654321)

movies_which_train <- createDataPartition(movies_new$vote_average,
                                        p = 0.7, 
                                        list = FALSE) 

movies_train <- movies_new[movies_which_train,]
movies_test <- movies_new[-movies_which_train,]

saveRDS(movies_train, 'new_movies_train.rda')
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

corrplot.mixed(
  movies_correlations,
  upper = "ellipse",
  lower = "number",
  tl.pos = "lt",
  insig = "label_sig",
  sig.level = c(.001, .01, .05),
  pch.cex = 0.8,
  tl.col = "black",
  number.digits = 3
) 


# Modeling
#estimation of the model with all variables
movies_lm1 <- lm(vote_average ~ ., 
                  data = movies_train)

summary(movies_lm1)
#R-squared 0.03246


# transformation of revenues with yeo-johnson

yeo <- yeojohnson(movies_train$revenue)

movies_train$revenue_yeo <- yeo$x.t

movies_test$revenue_yeo <- predict(yeo, newdata = movies_test$revenue) # applying on test data


#estimation with transformed variables
movies_lm2 <- lm(vote_average ~ language_en + adult + vote_count +
                   runtime + revenue_yeo +log1p(budget) + popularity + years_old, 
                 data = movies_train)

summary(movies_lm2)
#R-squared 0.04613


# Diagnostics


## Collinearity
vif(movies_lm2) # no collinearity

## RESET test
resettest(movies_lm2, power=2:3, type="fitted") # linear form is not true, estimators are biased and won't give true values

## Homoscedasticity
bptest(movies_lm2, studentize=TRUE)  # reject h0 -> heteroscedasticity

## distribution of error term
jarque.bera.test(movies_lm2$residuals) # reject h0 so not normal, but sample is huge this time




# Predictions
movies_lm2_pred <- predict(movies_lm2, movies_test)

regressionMetrics <- function(real, predicted) {
  MSE <- mean((real - predicted)^2, na.rm = T)
  RMSE <- sqrt(MSE)
  MAE <- mean(abs(real - predicted), na.rm = T)
  MedAE <- median(abs(real - predicted), na.rm = T)
  MSLE <- mean((log(1 + real) - log(1 + predicted))^2, na.rm = T)
  TSS <- sum((real - mean(real))^2, na.rm = T)
  RSS <- sum((predicted - real)^2, na.rm = T)
  R2 <- 1 - RSS/TSS
  
  result <- data.frame(MSE, RMSE, MAE, MedAE, MSLE, R2)
  return(result)
}

regressionMetrics(real = movies_test$vote_average,
                  predicted = movies_lm2_pred)

# Let's try to clean the data once again
ggplot(data = movies_train, aes(x = vote_average)) +
  geom_histogram(aes(y = ..density..)) +
  stat_function(fun = dnorm,
                color = 'red',
                size = 1,
                args = list(mean = mean(movies_train$vote_average), sd(movies_train$vote_average))) + theme_stata()

# It looks there are many 0 values. It is very likely they are movies without any
# votes. Let's remove the extreme values 0 and 10.
movies_trimmed <- movies_new %>% 
  dplyr::filter(movies_new$vote_average>0 & movies_new$vote_average<10)

# Data division
set.seed(987654321)

movies_which_train <- createDataPartition(movies_trimmed$vote_average,
                                          p = 0.7, 
                                          list = FALSE) 

movies_trimmed_train <- movies_trimmed[movies_which_train,]
movies_trimmed_test <- movies_trimmed[-movies_which_train,]

# saveRDS(movies_trimmed_train, 'new_movies_trimmed_train.rda')
summary(movies_trimmed$vote_average)
summary(movies_trimmed_train$vote_average)
summary(movies_trimmed_test$vote_average)

# Target variable distribution
ggplot(data = movies_trimmed_train, aes(x = vote_average)) +
  geom_histogram(aes(y = ..density..)) +
  stat_function(fun = dnorm,
                color = 'red',
                size = 1,
                args = list(mean = mean(movies_trimmed_train$vote_average), sd(movies_trimmed_train$vote_average))) + theme_stata()

# vote_average looks a lot better than before and fits the normal distribution better as well

# Correlations
movies_trimmed_correlations <- 
  cor(movies_trimmed_train[,movies_numeric_vars],
      use = "pairwise.complete.obs")

movies_numeric_vars_order <- 
  movies_trimmed_train[,"vote_average"] %>% 
  sort(decreasing = TRUE) %>%
  names()

corrplot.mixed(
  movies_trimmed_correlations,
  upper = "ellipse",
  lower = "number",
  tl.pos = "lt",
  insig = "label_sig",
  sig.level = c(.001, .01, .05),
  pch.cex = 0.8,
  tl.col = "black",
  number.digits = 3
) 

# We can see the strong correlation between budget and revenue, but also between
# vote_count and revenue and budget.

# Modeling
# Now we run the simple linear model again with all variables
movies_trimmed_lm1 <- lm(vote_average ~ ., 
                 data = movies_trimmed_train)

summary(movies_trimmed_lm1)
#R-squared 0.02459 - lower than before


# transformation of revenues with yeo-johnson
yeo_trimmed <- yeojohnson(movies_trimmed_train$revenue)

movies_trimmed_train$revenue_yeo <- yeo_trimmed$x.t

movies_trimmed_test$revenue_yeo <- predict(yeo_trimmed, newdata = movies_trimmed_test$revenue) # applying on test data


#estimation with transformed variables
movies_trimmed_lm2 <- lm(vote_average ~ language_en + adult + vote_count +
                   runtime + revenue_yeo +log1p(budget) + popularity + years_old, 
                 data = movies_trimmed_train)

summary(movies_trimmed_lm2)
#R-squared 0.02502 - slightly better than in the first model

# Diagnostics

## Collinearity
vif(movies_trimmed_lm2) # no collinearity

## RESET test
resettest(movies_trimmed_lm2, power=2:3, type="fitted") # linear form is not true, estimators are biased and won't give true values

## Homoscedasticity
bptest(movies_trimmed_lm2, studentize=TRUE)  # reject h0 -> heteroscedasticity

## distribution of error term
jarque.bera.test(movies_trimmed_lm2$residuals) # reject h0 so not normal, but sample is huge this time

# Predictions
movies_trimmed_lm2_pred <- predict(movies_trimmed_lm2, movies_trimmed_test)

regressionMetrics(real = movies_trimmed_test$vote_average,
                  predicted = movies_trimmed_lm2_pred)

# R^2 is higher (0.083) on the test set, but it is lower than before trimming the dataset
# (0.179)
# All error metrics are lower than before the trimming