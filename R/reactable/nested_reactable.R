library(tidyverse)
library(reactable)
library(htmltools)
library(ggplot2)
library(plotly)
library(htmlwidgets)

# Load data
source("R/dummy/beer_data.R")
beer_data <- generate_beer_data()

# Define the breakpoints.
# TODO: replace this by reading from a config or data file.
# It should take in a list of numbers, and append 0 and Inf to either end.
breakpoints <- c(0, 50, 80, 100, Inf) # Add Inf for the last bin

# Generate labels dynamically
bin_labels <- paste0(head(breakpoints, -1), "-", tail(breakpoints, -1)) # Regular bins
bin_labels[length(bin_labels)] <- paste0(breakpoints[length(breakpoints) - 1], "+") # Override the last bin e.g 100+

# Add a new column for popularity bins.
# Mutate adds the new column.
# cut is a function for 'cutting' a range of values into bins https://www.statology.org/cut-function-in-r/
beer_data <- beer_data %>%
  mutate(
    Popularity_Bin = cut(
      Popularity_Score,
      breaks = breakpoints,
      labels = bin_labels,
      include.lowest = TRUE,
    )
  )

### 1st layer: plot
source("R/dummy/beer_plot.R")
beer_plot <- generate_beer_plot(beer_data)


### 2nd Layer: some beer metrics
filtered_beer_data <- beer_data %>%
  select(
    Beer_Name,
    Popularity_Score
  )

# Function to dynamically generate a reactable using the beer data, filtering by bin.
# 'details' is what reactable calls what is nested under an expandable row.
# 'div()' is a function from htmltools that creates a div.
generate_beer_name_and_plot_table <- function(bin) {
  filtered_with_bin <- beer_data %>%
    filter(
      Popularity_Bin == bin
    )

  beer_name_and_plot_table <- reactable(
    filtered_with_bin,
    outlined = TRUE,
    details = function(index) {
      return(
        div(
          style = list(display = "flex", justifyContent = "center"),
          ggplotly(beer_plot)
        )
      )
    }
  )

  return(beer_name_and_plot_table)
}


### 3rd Layer: Bins
unique_bins <- unique(beer_data$Popularity_Bin)
unique_bins_df <- data.frame(bin = unique_bins)

# Now create another reactable.
# This reactable will atually be shown, and uses the above function to nest
# more reactables underneath it.
reactable(
  unique_bins_df,
  details = function(index) {
    bin <- unique_bins_df$bin[index]
    return(
      div(
        style = "padding-left: 50px;",
        generate_beer_name_and_plot_table(bin)
      )
    )
  }
)
