#' Summarize Data by Groups
#'
#' This function computes the mean and standard deviation of a specified variable within groups defined by one or more grouping variables.
#'
#' @param data A data frame containing the data to be summarized.
#' @param varname A string specifying the name of the variable to summarize.
#' @param groupnames A character vector specifying the names of the grouping variables.
#'
#' @return A data frame with the means and standard deviations of the specified variable for each group.
#' @export
#'
#' @examples
#' data <- data.frame(
#'   group = rep(c("A", "B"), each = 5),
#'   value = c(1:5, 6:10)
#' )
#' data_summary(data, varname = "value", groupnames = "group")
#'
data_summary <- function(data, varname, groupnames){
    
  # require(plyr)
  summary_func <- function(x, col){
                                   c(mean = mean(x[[col]], na.rm=TRUE),
                                   sd = sd(x[[col]], na.rm=TRUE))
                                   }
  
  data_sum <- plyr::ddply(data, groupnames, .fun=summary_func, varname)
  # data_sum <- rename(data_sum, c("mean" = varname))
    
  return(data_sum)
    
}
