library(magrittr)
mtcars %>%
  str
car_data <- 
  mtcars %>%
  subset(hp > 100) %>%
  aggregate(. ~ cyl, data = ., FUN = . %>% mean %>% round(2)) %>%
  transform(kpl = mpg %>% multiply_by(0.4251)) %>%
  print
car_data <- 
  transform(aggregate(. ~ cyl, 
                      data = subset(mtcars, hp > 100), 
                      FUN = function(x) round(mean(x, 2))), 
            kpl = mpg*0.4251)
car_data %>%
  (function(x) {
    if (nrow(x) > 2) 
      rbind(head(x, 1), tail(x, 1))
    else x
  })
s <- function(x) {
  if (nrow(x) > 2) 
    rbind(head(x, 1), tail(x, 1))
  else x
}
s(car_data)

car_data %>%
  {
    if (nrow(.) > 2) 
      rbind(head(., 1), tail(., 1))
    else .
  }
1:10 %>% (substitute(f(), list(f = sum)))
rnorm(200) %>%
  matrix(ncol = 2) %T>%
  plot %>% # plot usually does not return anything. 
  colSums
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)
data.frame(z = rnorm(100)) %$% 
  ts.plot(z)
iris$Sepal.Length %<>% 
  sqrt
rnorm(1000)    %>%
  multiply_by(5) %>%
  add(5)         %>%
  { 
    cat("Mean:", mean(.), 
        "Variance:", var(.), "\n")
    head(.)
  }