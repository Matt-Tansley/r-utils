library(dplyr)

#' General function for adding bins to data.
#'
#' @param data The data.frame we want to add bins to.
#' @param breakpoints A list of numbers used to create bins.
#' @param metric_to_bin The metric which is used to determine the bin for a row.
#' @param bin_name The name of the newly created bin column. Default is 'bin'
#'
add_bins_to_data <- function(
    data,
    breakpoints,
    metric_to_bin,
    bin_name = "bin") {
    # Ensure breakpoints are ordered
    ordered_breakpoints <- sort(breakpoints)

    # Generate the labels for each bin
    bin_labels <-
        # Create regular bins.
        paste0(head(ordered_breakpoints, -1), " - ", tail(ordered_breakpoints, -1)) %>%
        # Add in first bin e.g Less than minimum
        append(paste0("Less than ", ordered_breakpoints[1]), after = 0) %>%
        # Add in last bin e.g > Greater than maximum
        append(paste0("Greater than ", ordered_breakpoints[length(ordered_breakpoints)]))

    # Now, add 0 and Inf to the breakpoints for use in the cut function.
    # Note: this means we assume the lowest value in the data will be 0.
    ordered_breakpoints <- ordered_breakpoints %>%
        append(0, after = 0) %>%
        append(Inf)

    # Apply the bins based on metric_to_bin.
    # If the Group is missing in Main, then the bin will be NA.
    binned_data <- data %>%
        mutate(
            {{ bin_name }} := cut(
                {{ metric_to_bin }}, # {{ }} curly-curly operator to select column from data.frame
                breaks = ordered_breakpoints,
                labels = bin_labels
            )
        ) %>%
        # Change NAs to 'no bin'.
        # If not NA, then just use the current value.
        mutate({{ bin_name }} := case_when(
            is.na({{ bin_name }}) ~ "no bin",
            .default = {{ bin_name }}
        ))

    return(binned_data)
}
