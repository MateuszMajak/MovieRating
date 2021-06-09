

# libraries used

#install.packages('dplyr')
library(dplyr)

#install.packages('stargazer')
library(stargazer) # for despcriptive statistics

#install.packages('corrplot')
library(corrplot) # correlation matrix

#install.packages('ggplot2')
library(ggplot2) # histograms

#install.packages('Rmisc)
library(Rmisc) # multiple plots

#install.packages("lmtest")
library("lmtest") # reset test

#install.packages("car")
library(car) # vif test

#install.packages("gglm")
library(gglm)


# directory

getwd()
setwd('reproduced old project/data')


# load data

load(file = "movies_old_cleaned.rda") 


# descriptive statistics provided in raport: count, mean, sd, min, max

stargazer(
  movies_old, type = "text", 
  summary.stat = c("n", "mean", "sd", "min", "max")
)


# correlation matrix

movies_old <- movies_old[c(1,7,2,4,3,5,6)] # reordering

p_matrix <- cor.mtest(movies_old, conf.level = .95)

correlations <- cor(movies_old, use = "pairwise.complete.obs")

corrplot.mixed(
  correlations,
  upper = "ellipse",
  lower = "number",
  tl.pos = "lt",
  p.mat = p_matrix$p,
  insig = "label_sig",
  sig.level = c(.001, .01, .05),
  pch.cex = 0.8,
  tl.col = "black",
  number.digits = 3
) 


# histograms

ggplot(data = movies_old, aes(x = vote_average)) +
  geom_histogram(aes(y = ..density..)) +
  stat_function(fun = dnorm,
                color = 'red',
                size = 1,
                args = list(mean = mean(movies_old$vote_average), sd(movies_old$vote_average)))

p1 <- ggplot(data = movies_old, aes(x = vote_count)) +
  geom_histogram(aes(y = ..density..))

p2 <- ggplot(data = movies_old, aes(x = runtime)) +
  geom_histogram(aes(y = ..density..))

p3 <- ggplot(data = movies_old, aes(x = years_old)) +
  geom_histogram(aes(y = ..density..))

p4 <- ggplot(data = movies_old, aes(x = popularity)) +
  geom_histogram(aes(y = ..density..))

p5 <- ggplot(data = movies_old, aes(x = revenue)) +
  geom_histogram(aes(y = ..density..))

p6 <- ggplot(data = movies_old, aes(x = budget)) +
  geom_histogram(aes(y = ..density..))

design <- matrix(c(1, 2, 3, 4, 5, 6), # order of plots
                 2, # number of rows
                 3, # number of columns
                 byrow = TRUE
)

multiplot(p1, p2, p3, p4, p5, p6, layout = design)


# creating log

movies_old$vote_count_ln <- log(movies_old$vote_count)

movies_old$runtime_ln <- log(movies_old$runtime)

movies_old$revenue_ln <- log(movies_old$revenue)

movies_old$budget_ln <- log(movies_old$budget)


# histograms with logs

p1_ln <- ggplot(data = movies_old, aes(x = vote_count_ln)) +
  geom_histogram(aes(y = ..density..))

p2_ln <- ggplot(data = movies_old, aes(x = runtime_ln)) +
  geom_histogram(aes(y = ..density..))

p5_ln <- ggplot(data = movies_old, aes(x = revenue_ln)) +
  geom_histogram(aes(y = ..density..))

p6_ln <- ggplot(data = movies_old, aes(x = budget_ln)) +
  geom_histogram(aes(y = ..density..))


multiplot(p1_ln, p2_ln, p3, p4, p5_ln, p6_ln, layout = design)



# regression


formula1 <- vote_average ~ budget_ln + years_old + revenue_ln + runtime + vote_count + popularity

linear1 <- lm(formula1, movies_old)

summary(linear1) # popularity is insignificant, Adj. R2 = 0.39

resettest(linear1, power=2:3, type="fitted") # reject h0 so form is not linear


# 2nd regression

formula2 <- vote_average ~ budget_ln + years_old + revenue_ln + runtime_ln + vote_count_ln + popularity

linear2 <- lm(formula2, movies_old)

summary(linear2) # all variables significant, Adj. R2 = 0.446

resettest(linear2, power=2:3, type="fitted") # reject h0 so form is not linear


# analyzing data - vote_average vs years_old

ggplot(movies_old, aes(x = vote_average, y = years_old, size = budget)) +
  geom_point() +
  theme_bw() 


# changing data

movies_old2 <- movies_old[ which( movies_old$years_old <= 25 & movies_old$vote_count >= 85) , ] # eliminated not 775 but 703 records

movies_old2$years_old_squared <- movies_old2$years_old^2


# 3rd regression

formula3 <- vote_average ~ budget_ln + years_old + years_old_squared + revenue_ln + runtime_ln + vote_count_ln + popularity

linear3 <- lm(formula3, movies_old2)

summary(linear3) # all variables significant, Adj. R2 = 0.446

resettest(linear3, power=2:3, type="fitted") # reject h0 so the specification is still wrong



# 4th regression


## data modification

movies_old$years_binary <- ifelse(movies_old$years_old <= 10, "0-10",
                                  ifelse(movies_old$years_old <= 25, "11-25", "26 and more")) %>% as.factor()


## options for proper one-hot encoding

options(contrasts = c("contr.treatment",  # for non-ordinal factors
                      "contr.treatment")) # for ordinal factors


## model

formula4 <- vote_average ~ budget_ln + revenue_ln + runtime_ln + vote_count_ln + popularity + years_binary

linear4 <- lm(formula4, movies_old)

summary(linear4) # all variables significant, Adj. R2 = 0.449

resettest(linear4, power=2:3, type="fitted") # reject h0 so the specification is still wrong



# diagnostics


## collinearity

vif(linear3)

gglm(linear3)

