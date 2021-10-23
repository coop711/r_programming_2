load("./R/Elec.RData")
ls()
Electricity$Rates
Electricity
Electricity$R2 <- factor(Electricity$R2, 
                         levels = c("수도권", "가야", "백제", "신라", "영산강"))
by(Electricity[3:4], factor(Electricity$R2), 
   function(x) round(sum(x[1]) / sum(x[2]) * 100, digits = 1))
aggregate(Electricity[, 3:4], list(factor(Electricity$R2)), 
          function(x) round(sum(x[1]) / sum(x[2]) * 100, digits = 1))
library(dplyr)
ddply(Electricity, .(R2), 
      function(x) round(sum(x[, 3]) / sum(x[, 4]) * 100, digits = 1))
