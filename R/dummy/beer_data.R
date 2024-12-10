# Code generated with help of ChatGPT

# Load necessary libraries
library(tibble)

generate_beer_data <- function() {
  beer_data <- tibble(
    Year = rep(2010:2024, each = 4),
    Beer_Name = rep(c("Hopsplosion", "Fizzy Blonde", "Maltstorm", "Golden Ale"), times = 15),
    Popularity_Score = c(
      70, 55, 60, 80, # 2010
      75, 60, 65, 85, # 2011
      80, 65, 70, 90, # 2012
      82, 67, 72, 92, # 2013
      84, 70, 75, 95, # 2014
      85, 72, 78, 97, # 2015
      87, 75, 80, 98, # 2016
      89, 78, 82, 99, # 2017
      90, 80, 85, 100, # 2018
      92, 83, 87, 102, # 2019
      94, 85, 90, 104, # 2020
      95, 88, 92, 106, # 2021
      97, 90, 95, 108, # 2022
      98, 92, 97, 110, # 2023
      100, 95, 100, 112 # 2024
    )
  )

  return(beer_data)
}
