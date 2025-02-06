# Load necessary libraries
library(plotly)
library(dplyr)
library(tidyr)

# Create example data WITHOUT 'beer'
data <- data.frame(
  id = 1:10,
  name = c(
    "Alice", "Bob", "Charlie", "Diana", "Ethan",
    "Fiona", "George", "Hannah", "Ian", "Julia"
  ),
  drink = sample(c("wine", "coffee", "water"), 10, replace = TRUE), # No 'beer' included
  status = sample(c("poured", "drinking", "finished", "other"), 10, replace = TRUE),
  stringsAsFactors = FALSE
)

# Define all possible drink categories
all_drinks <- c("beer", "wine", "coffee", "water")

# Summarize data: Count occurrences of each status for each drink
summary_data <- data %>%
  group_by(drink, status) %>%
  summarise(count = n(), .groups = "drop") %>%
  complete(drink = all_drinks, status = unique(data$status), fill = list(count = 0))

# Ensure 'drink' is a factor with all levels for consistent x-axis ordering
summary_data$drink <- factor(summary_data$drink, levels = all_drinks)

# Create stacked bar chart
fig <- plot_ly(
  data = summary_data,
  x = ~drink,
  y = ~count,
  color = ~status,
  type = "bar"
) %>% layout(
  barmode = "stack",
  title = "Drink Status Distribution (Including Missing Categories)",
  xaxis = list(title = "Drink"),
  yaxis = list(title = "Count")
)

# Display the plot
fig
