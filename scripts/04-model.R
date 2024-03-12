#### Preamble ####
# Purpose: Models the relationship between population and public art
# Author: Alaina Hu
# Date: 09 March 2024
# Contact: alaina.hu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have access to the analysis data 
# Any other information needed? NA


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
#### Read data ####
analysis_data <- read_csv("outputs/data/analysis_data.csv")

analysis_data <- analysis_data |>
  mutate(
    population = population / 1000,
    minority_population = minority_population / 1000,
    income = income / 1000
  )




### Model data ####
set.seed(853)


first_model <-
  stan_glm(
    formula = n ~ population,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

second_model <-
  stan_glm(
    formula = n ~ population + minority_population + income,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = -160, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

poisson <-
  stan_glm(
    n ~ population + minority_population + income,
    data = analysis_data,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

neg_binomial <-
  stan_glm(
    n ~ population + minority_population + income,
    data = analysis_data,
    family = neg_binomial_2(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

prior_summary(first_model)
prior_summary(second_model)


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)

saveRDS(
  poisson,
  file = "models/poisson.rds"
)

saveRDS(
  neg_binomial,
  file = "models/neg_bin.rds"
)