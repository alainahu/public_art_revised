#### Preamble ####
# Purpose: Tests the simulated data and real data sets
# Author: Alaina Hu
# Date: 16 March 2024
# Contact: alaina.hu@utoronto.ca 
# License: MIT
# Pre-requisites: Have the simulation and analysis data 


#### Workspace setup ####
library(tidyverse)

analysis_data <- read_csv("outputs/data/analysis_data.csv")

ward_names <- c("Etobicoke North", "Etobicoke Centre", "Etobicoke-Lakeshore", 
                "Parkdale-High Park","York South-Weston", "York Centre", 
                "Humber River-Black Creek", "Eglinton-Lawrence",
                "Davenport", "Spadina-Fort York", "University-Rosedale",
                "Toronto-St. Paul's", "Toronto Centre", "Toronto-Danforth",
                "Don Valley West", "Don Valley East", "Don Valley North",
                "Willowdale", "Beaches-East York", "Scarborough Southwest",
                "Scarborough Centre", "Scarborough-Agincourt",
                "Scarborough North", "Scarborough-Guildwood",
                "Scarborough-Rouge Park")

#### Tests ####
#Making sure that the ward names are one of the 25 Toronto Ward names
analysis_data$ward_name |>
  unique() %in% ward_names
#Checking for the 25 wards
analysis_data$WARD |>
  unique() |>
  length() == 25
#Making sure that the number of art works is a positive number
analysis_data$n |>
  min() >= 0
#Checking the bounds for population, minority population, and income
analysis_data$population |>
  max() <= 500000 
analysis_data$population |>
  min() >= 1
analysis_data$minority_population |>
  max() <= 500000 
analysis_data$minority_population |>
  min() >= 1
analysis_data$income |>
  max() <= 500000 
analysis_data$income |>
  min() >= 1