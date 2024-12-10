# Code generated with help of ChatGPT

library(ggplot2)

generate_beer_plot <- function(beer_data) {
  beer_plot <- ggplot(beer_data, aes(x = Year, y = Popularity_Score, color = Beer_Name, group = Beer_Name)) +
    geom_line() +
    geom_point() +
    labs(
      title = "Popularity of Fictional Beers Over Time",
      x = "Year",
      y = "Popularity Score"
    ) +
    theme_minimal()

  return(beer_plot)
}
