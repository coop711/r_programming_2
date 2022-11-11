library(magrittr)
sample(1:365, size = 23, replace = TRUE) %>%
  duplicated %>%
  any 
N <- 100
replicate(N, sample(1:365, size = 23, replace = TRUE) %>% 
            duplicated %>% 
            any) %>%
  sum
prob <- vector(mode = "numeric", length = 100)
prob[1] <- 0
for (i in 2:100){
  prob[i] <- 
    replicate(N, 
              sample(1:365, size = i, replace = TRUE) %>% 
                duplicated %>% 
                any) %>%
    sum %>%
    "/"(N)
}
prob
birthday <- 
  function(N = 1000, x){
    replicate(N, 
              sample(1:365, size = x, replace = TRUE) %>% 
                duplicated %>% 
                any) %>%
      sum %>%
      "/"(N)
  }
birthday(x = 23)
probs <- 
  sapply(2:100, FUN = function(x) birthday(N = 10000, x))
opar <- par(no.readonly = TRUE)
par(mai = c(1.02, 1.02, 0.82, 0.42))
plot(2:100, probs, type = "p", pch = ".", cex = 3, axes = FALSE, xlab = "Number of People", ylab = "")
axis(side = 1, at = c(0, 23, 40, 60, 80, 100), labels = c(0, 23, 40, 60, 80, 100))
axis(side = 2, at = c(0, 0.25, probs[22], 0.75, 1), labels = format(c(0, 0.25, probs[22], 0.75, 1), digits = 4), las = 1)
text(x = 23, y = probs[22], labels = "x")
arrows(x0 = 23, y0 = 0, x1 = 23, y1 = probs[22], code = 1, length = 0.15)
arrows(x0 = 0, y0 = probs[22], x1 = 23, y1 = probs[22], code = 1, length = 0.15)
title(ylab = "Probability", line = 4)
title(main = "Birthday Problem")