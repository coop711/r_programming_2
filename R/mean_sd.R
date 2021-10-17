mean_sd <-
function(x) {
  mean <- mean(x, na.rm = TRUE)
  sd <- sd(x)
  c(mean = mean, sd = sd)
# list(mean = mean, sd = sd)
}
