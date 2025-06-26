#' Summarize Data by Groups
#'
#' Computes the mean and standard deviation of a specified variable within groups.
#'
#' @param data A data frame.
#' @param varname Name of the numeric variable to summarize (unquoted or string).
#' @param groupnames Vector of grouping variable names (unquoted or string).
#'
#' @return A data frame with mean and SD for each group.
#' @export
#'
#' @examples
#' data <- data.frame(group = rep(c("A", "B"), each = 5), value = 1:10)
#' data_summary(data, varname = "value", groupnames = "group")
data_summary <- function(data, varname, groupnames) {
  varname <- rlang::ensym(varname)
  group_syms <- rlang::syms(groupnames)

  data %>%
    dplyr::group_by(!!!group_syms) %>%
    dplyr::summarise(
      mean = mean(!!varname, na.rm = TRUE),
      sd = sd(!!varname, na.rm = TRUE),
      .groups = "drop"
    )
}
