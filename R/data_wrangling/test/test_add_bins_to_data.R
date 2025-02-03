source("R/functions/widgets/reactable_with_bins.R")

# Sample data
data <- data.frame(
    ID = 1:5,
    Score = c(88, 92, 76, 85, 90),
    Name = c("Alice", "Bob", "Carol", "David", "Eva"),
    Status = c("Pass", "Pass", "Fail", "Pass", "Pass")
)

# Alternative to this is to read from a text file
breakpoints <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

results <- add_bins_to_data(
    data = data,
    breakpoints = breakpoints,
    metric_to_bin = Score,
    bin_name = "Score_Bin"
)
