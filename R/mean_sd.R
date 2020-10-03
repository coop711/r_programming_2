mean_sd <-
function(x) {
  mean <- mean(x, na.rm = TRUE)
  sd <- sd(x)
  return(c(mean = mean, sd = sd))
# list(mean = mean, sd = sd)
}
