## ---- include=FALSE------------------------------------------------------
knitr::opts_chunk$set(comment = NA, collapse = TRUE, fig.path = "images/")
set.seed(2016-09-27)

## ------------------------------------------------------------------------
## Generate a uniform random number
x <- runif(1, 0, 10)  
if(x > 3) {
        y <- 10
} else {
        y <- 0
}

## ------------------------------------------------------------------------
numbers <- rnorm(10)
for(i in 1:10) {
        print(numbers[i])
}

## ------------------------------------------------------------------------
x <- c("a", "b", "c", "d")

for(i in 1:4) {
        ## Print out each element of 'x'
        print(x[i])  
}

## ------------------------------------------------------------------------
## Generate a sequence based on length of 'x'
for(i in seq_along(x)) {   
        print(x[i])
}

## ------------------------------------------------------------------------
for(letter in x) {
        print(letter)
}

## ------------------------------------------------------------------------
for(i in 1:4) print(x[i])

## ----eval=FALSE----------------------------------------------------------
## for(i in 1:100) {
##         if(i <= 20) {
##                 ## Skip the first 20 iterations
##                 next
##         }
##         ## Do something here
## }

## ----eval=FALSE----------------------------------------------------------
## for(i in 1:100) {
##       print(i)
## 
##       if(i > 20) {
##               ## Stop loop after 20 iterations
##               break
##       }		
## }

## ----message=FALSE-------------------------------------------------------
library(readr)
library(dplyr)

## Download data from RStudio (if we haven't already)
if(!file.exists("data/2016-07-20.csv.gz")) {
        download.file("http://cran-logs.rstudio.com/2016/2016-07-20.csv.gz", 
                      "data/2016-07-20.csv.gz")
}
cran <- read_csv("data/2016-07-20.csv.gz", col_types = "ccicccccci")
cran %>% filter(package == "filehash") %>% nrow

## ---- message=FALSE------------------------------------------------------
library(dplyr)
library(readr)

## pkgname: package name (character)
## date: YYYY-MM-DD format (character)
num_download <- function(pkgname, date) {
        ## Construct web URL
        year <- substr(date, 1, 4)
        src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                       year, date)
        
        ## Construct path for storing local file
        dest <- file.path("data", basename(src))
        
        ## Don't download if the file is already there!
        if(!file.exists(dest))
                download.file(src, dest, quiet = TRUE)
        
        cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
        cran %>% filter(package == pkgname) %>% nrow
}

## ------------------------------------------------------------------------
num_download("filehash", "2016-07-20")

## ------------------------------------------------------------------------
num_download("Rcpp", "2016-07-19")

## ------------------------------------------------------------------------
num_download <- function(pkgname, date = "2016-07-20") {
        year <- substr(date, 1, 4)
        src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                       year, date)
        dest <- file.path("data", basename(src))
        if(!file.exists(dest))
                download.file(src, dest, quiet = TRUE)
        cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
        cran %>% filter(package == pkgname) %>% nrow
}

## ------------------------------------------------------------------------
num_download("Rcpp")

## ------------------------------------------------------------------------
check_for_logfile <- function(date) {
        year <- substr(date, 1, 4)
        src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                       year, date)
        dest <- file.path("data", basename(src))
        if(!file.exists(dest)) {
                val <- download.file(src, dest, quiet = TRUE)
                if(!val)
                        stop("unable to download file ", src)
        }
        dest
}

## ------------------------------------------------------------------------
num_download <- function(pkgname, date = "2016-07-20") {
        dest <- check_for_logfile(date)
        cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
        cran %>% filter(package == pkgname) %>% nrow
}    

## ------------------------------------------------------------------------
check_pkg_deps <- function() {
        if(!require(readr)) {
                message("installing the 'readr' package")
                install.packages("readr")
        }
        if(!require(dplyr))
                stop("the 'dplyr' package needs to be installed first")
}

## ------------------------------------------------------------------------
num_download <- function(pkgname, date = "2016-07-20") {
        check_pkg_deps()
        dest <- check_for_logfile(date)
        cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
        cran %>% filter(package == pkgname) %>% nrow
}

## ------------------------------------------------------------------------
## 'pkgname' can now be a character vector of names
num_download <- function(pkgname, date = "2016-07-20") {
        check_pkg_deps()
        dest <- check_for_logfile(date)
        cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
        cran %>% filter(package %in% pkgname) %>% 
                group_by(package) %>%
                summarize(n = n())
}    


## ------------------------------------------------------------------------
num_download(c("filehash", "weathermetrics"))

## ------------------------------------------------------------------------
num_download <- function(pkgname, date = "2016-07-20") {
        check_pkg_deps()
        
        ## Check arguments
        if(!is.character(pkgname))
                stop("'pkgname' should be character")
        if(!is.character(date))
                stop("'date' should be character")
        if(length(date) != 1)
                stop("'date' should be length 1")
        
        dest <- check_for_logfile(date)
        cran <- read_csv(dest, col_types = "ccicccccci", 
                         progress = FALSE)
        cran %>% filter(package %in% pkgname) %>% 
                group_by(package) %>%
                summarize(n = n())
}    

## ---- error=TRUE---------------------------------------------------------
num_download("filehash", c("2016-07-20", "2016-0-21"))

## ------------------------------------------------------------------------
adder_maker <- function(n){
  function(x){
    n + x
  }
}

add2 <- adder_maker(2)
add3 <- adder_maker(3)

add2(5)
add3(5)

## ----message = FALSE-----------------------------------------------------
library(purrr)

map_chr(c(5, 4, 3, 2, 1), function(x){
  c("one", "two", "three", "four", "five")[x]
})

map_lgl(c(1, 2, 3, 4, 5), function(x){
  x > 3
})

## ------------------------------------------------------------------------
map_if(1:5, function(x){
              x %% 2 == 0
            },
            function(y){
              y^2
            }) %>% unlist()

## ------------------------------------------------------------------------
map_at(seq(100, 500, 100), c(1, 3, 5), function(x){
  x - 10
}) %>% unlist()

## ------------------------------------------------------------------------
map2_chr(letters, 1:26, paste)

## ------------------------------------------------------------------------
pmap_chr(list(
  list(1, 2, 3),
  list("one", "two", "three"),
  list("uno", "dos", "tres")
), paste)

## ------------------------------------------------------------------------
reduce(c(1, 3, 5, 7), function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  x + y
})

## ------------------------------------------------------------------------
reduce(letters[1:4], function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  paste0(x, y)
})

## ------------------------------------------------------------------------
reduce_right(letters[1:4], function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  paste0(x, y)
})

## ------------------------------------------------------------------------
contains(letters, "a")
contains(letters, "A")

## ------------------------------------------------------------------------
detect(20:40, function(x){
  x > 22 && x %% 2 == 0
})

## ------------------------------------------------------------------------
detect_index(20:40, function(x){
  x > 22 && x %% 2 == 0
})

## ------------------------------------------------------------------------
keep(1:20, function(x){
  x %% 2 == 0
})

## ------------------------------------------------------------------------
discard(1:20, function(x){
  x %% 2 == 0
})

## ------------------------------------------------------------------------
n_unique <- compose(length, unique)
# The composition above is the same as:
# n_unique <- function(x){
#   length(unique(x))
# }

rep(1:5, 1:5)

n_unique(rep(1:5, 1:5))

## ------------------------------------------------------------------------
library(purrr)

mult_three_n <- function(x, y, z){
  x * y * z
}

mult_by_15 <- partial(mult_three_n, x = 3, y = 5)

mult_by_15(z = 4)

## ------------------------------------------------------------------------
library(purrr)

walk(c("Friends, Romans, countrymen,",
       "lend me your ears;",
       "I come to bury Caesar,", 
       "not to praise him."), message)

## ------------------------------------------------------------------------
vector_sum_loop <- function(v){
  result <- 0
  for(i in v){
    result <- result + i
  }
  result
}

vector_sum_loop(c(5, 40, 91))

## ------------------------------------------------------------------------
vector_sum_rec <- function(v){
  if(length(v) == 1){
    v
  } else {
    v[1] + vector_sum_rec(v[-1])
  }
}

vector_sum_rec(c(5, 40, 91))

## ------------------------------------------------------------------------
fib <- function(n){
  stopifnot(n > 0)
  if(n == 1){
    0
  } else if(n == 2){
    1
  } else {
    fib(n - 1) + fib(n - 2)
  }
}

fib(1)
fib(2)
fib(3)
fib(4)
fib(5)
fib(6)
fib(7)

map_dbl(1:12, fib)

## ---- echo=FALSE, fig.cap="Memoization of fib() function"----------------
knitr::include_graphics("images/memoization.png", dpi = 60)

## ------------------------------------------------------------------------
fib_tbl <- c(0, 1, rep(NA, 23))

fib_mem <- function(n){
  stopifnot(n > 0)
  
  if(!is.na(fib_tbl[n])){
    fib_tbl[n]
  } else {
    fib_tbl[n - 1] <<- fib_mem(n - 1)
    fib_tbl[n - 2] <<- fib_mem(n - 2)
    fib_tbl[n - 1] + fib_tbl[n - 2]
  }
}

map_dbl(1:12, fib_mem)

## ---- message=FALSE, fig.cap="Speed comparison of memoization"-----------
library(purrr)
library(microbenchmark)
library(tidyr)
library(magrittr)
library(dplyr)

fib_data <- map(1:10, function(x){microbenchmark(fib(x), times = 100)$time})
names(fib_data) <- paste0(letters[1:10], 1:10)
fib_data <- as.data.frame(fib_data)

fib_data %<>%
  gather(num, time) %>%
  group_by(num) %>%
  summarise(med_time = median(time))

memo_data <- map(1:10, function(x){microbenchmark(fib_mem(x))$time})
names(memo_data) <- paste0(letters[1:10], 1:10)
memo_data <- as.data.frame(memo_data)

memo_data %<>%
  gather(num, time) %>%
  group_by(num) %>%
  summarise(med_time = median(time))

plot(1:10, fib_data$med_time, xlab = "Fibonacci Number", ylab = "Median Time (Nanoseconds)",
     pch = 18, bty = "n", xaxt = "n", yaxt = "n")
axis(1, at = 1:10)
axis(2, at = seq(0, 350000, by = 50000))
points(1:10 + .1, memo_data$med_time, col = "blue", pch = 18)
legend(1, 300000, c("Not Memoized", "Memoized"), pch = 18, 
       col = c("black", "blue"), bty = "n", cex = 1, y.intersp = 1.5)

## ------------------------------------------------------------------------
two_plus_two <- quote(2 + 2)
two_plus_two

## ------------------------------------------------------------------------
eval(two_plus_two)

## ------------------------------------------------------------------------
tpt_string <- "2 + 2"

tpt_expression <- parse(text = tpt_string)

eval(tpt_expression)

## ------------------------------------------------------------------------
deparse(two_plus_two)

## ------------------------------------------------------------------------
sum_expr <- quote(sum(1, 5))
eval(sum_expr)
sum_expr[[1]]
sum_expr[[2]]
sum_expr[[3]]
sum_expr[[1]] <- quote(paste0)
sum_expr[[2]] <- quote(4)
sum_expr[[3]] <- quote(6)
eval(sum_expr)

## ------------------------------------------------------------------------
sum_40_50_expr <- call("sum", 40, 50)
sum_40_50_expr
eval(sum_40_50_expr)

## ------------------------------------------------------------------------
return_expression <- function(...){
  match.call()
}

return_expression(2, col = "blue", FALSE)

## ------------------------------------------------------------------------
first_arg <- function(...){
  expr <- match.call()
  first_arg_expr <- expr[[2]]
  first_arg <- eval(first_arg_expr)
  if(is.numeric(first_arg)){
    paste("The first argument is", first_arg)
  } else {
    "The first argument is not numeric."
  }
}

first_arg(2, 4, "seven", FALSE)

first_arg("two", 4, "seven", FALSE)

## ------------------------------------------------------------------------
my_new_env <- new.env()
my_new_env$x <- 4
my_new_env$x

assign("y", 9, envir = my_new_env)
get("y", envir = my_new_env)
my_new_env$y

## ------------------------------------------------------------------------
ls(my_new_env)
rm(y, envir = my_new_env)
exists("y", envir = my_new_env)
exists("x", envir = my_new_env)
my_new_env$x
my_new_env$y

## ------------------------------------------------------------------------
search()

## ------------------------------------------------------------------------
library(ggplot2)
search()

## ---- eval=FALSE---------------------------------------------------------
## x <- 10
## 
## my_func <- function(){
##   x <- 5
##   return(x)
## }
## 
## my_func()

## ------------------------------------------------------------------------
x <- 10

my_func <- function(){
  x <- 5
  return(x)
}

my_func()

## ------------------------------------------------------------------------
x <- 10

another_func <- function(){
  return(x)
}

another_func()

## ------------------------------------------------------------------------
x <- 10
x

assign1 <- function(){
  x <<- "Wow!"
}

assign1()
x

## ---- error=TRUE---------------------------------------------------------
a_variable_name
exists("a_variable_name")

assign2 <- function(){
  a_variable_name <<- "Magic!"
}

assign2()
exists("a_variable_name")
a_variable_name

## ---- error=TRUE---------------------------------------------------------
"hello" + "world"

## ---- warning=TRUE-------------------------------------------------------
as.numeric(c("5", "6", "seven"))

## ---- message=TRUE-------------------------------------------------------
f <- function(){
  message("This is a message.")
}

f()

## ---- eval=FALSE---------------------------------------------------------
## stop("Something erroneous has occurred!")

## ---- eval=FALSE---------------------------------------------------------
## Error: Something erroneous has occurred!

## ---- error=TRUE---------------------------------------------------------
name_of_function <- function(){
  stop("Something bad happened.")
}

name_of_function()

## ---- error=TRUE---------------------------------------------------------
error_if_n_is_greater_than_zero <- function(n){
  stopifnot(n <= 0)
  n
}

error_if_n_is_greater_than_zero(5)

## ---- warning=TRUE-------------------------------------------------------
warning("Consider yourself warned!")

## ---- warning=TRUE-------------------------------------------------------
make_NA <- function(x){
  warning("Generating an NA.")
  NA
}

make_NA("Sodium")

## ------------------------------------------------------------------------
message("In a bottle.")

## ------------------------------------------------------------------------
beera <- function(expr){
  tryCatch(expr,
         error = function(e){
           message("An error occurred:\n", e)
         },
         warning = function(w){
           message("A warning occured:\n", w)
         },
         finally = {
           message("Finally done!")
         })
}

## ------------------------------------------------------------------------
beera({
  2 + 2
})

beera({
  "two" + 2
})

beera({
  as.numeric(c(1, "two", 3))
})

## ---- error=TRUE---------------------------------------------------------
is_even <- function(n){
  n %% 2 == 0
}

is_even(768)

is_even("two")

## ------------------------------------------------------------------------
is_even_error <- function(n){
  tryCatch(n %% 2 == 0,
           error = function(e){
             FALSE
           })
}

is_even_error(714)

is_even_error("eight")

## ------------------------------------------------------------------------
is_even_check <- function(n){
  is.numeric(n) && n %% 2 == 0
}

is_even_check(1876)

is_even_check("twelve")

## ---- eval=FALSE---------------------------------------------------------
## library(microbenchmark)
## microbenchmark(sapply(letters, is_even_check))

## ---- eval=FALSE---------------------------------------------------------
## microbenchmark(sapply(letters, is_even_error))

## ---- error=TRUE---------------------------------------------------------
check_n_value <- function(n) {
        if(n > 0) {
                stop("n should be <= 0")
        }
}
error_if_n_is_greater_than_zero <- function(n){
        check_n_value(n)
        n
}
error_if_n_is_greater_than_zero(5)

## ------------------------------------------------------------------------
check_n_value <- function(n) {
        if(n > 0) {
                browser()  ## Error occurs around here
                stop("n should be <= 0")
        }
}

## ----include=FALSE-------------------------------------------------------
check_n_value <- function(n) {
        if(n > 0) {
                stop("n should be <= 0")
        }
}

## ------------------------------------------------------------------------
trace("check_n_value")

## ----error=TRUE----------------------------------------------------------
error_if_n_is_greater_than_zero(5)

## ------------------------------------------------------------------------
as.list(body(check_n_value))

## ------------------------------------------------------------------------
as.list(body(check_n_value)[[2]])

## ------------------------------------------------------------------------
trace("check_n_value", browser, at = list(c(2, 3)))

## ------------------------------------------------------------------------
check_n_value

## ------------------------------------------------------------------------
body(check_n_value)

## ------------------------------------------------------------------------
trace("check_n_value", quote({
        if(n == 5) {
                message("invoking the browser")
                browser()
        }
}), at = 2)

## ------------------------------------------------------------------------
body(check_n_value)

## ------------------------------------------------------------------------
trace("glm", browser, at = 4, where = asNamespace("stats"))

## ------------------------------------------------------------------------
body(stats::glm)[1:5]

## ----eval=FALSE----------------------------------------------------------
## ## Turn on debugging state for 'lm' function
## debug(lm)

## ----eval=FALSE----------------------------------------------------------
## options(error = recover)

## ------------------------------------------------------------------------
library(microbenchmark)
microbenchmark(a <- rnorm(1000), 
               b <- mean(rnorm(1000)))

## ------------------------------------------------------------------------
# Function that uses a loop 
find_records_1 <- function(datafr, threshold){
  highest_temp <- c()
  record_temp <- c()
  for(i in 1:nrow(datafr)){
    highest_temp <- max(highest_temp, datafr$temp[i])
    record_temp[i] <- datafr$temp[i] >= threshold & 
      datafr$temp[i] >= highest_temp
  }
  datafr <- cbind(datafr, record_temp)
  return(datafr)
}

# Function that uses tidyverse functions
find_records_2 <- function(datafr, threshold){
  datafr <- datafr %>%
    mutate_(over_threshold = ~ temp >= threshold,
            cummax_temp = ~ temp == cummax(temp),
            record_temp = ~ over_threshold & cummax_temp) %>%
    select_(.dots = c("-over_threshold", "-cummax_temp"))
  return(as.data.frame(datafr))
}

## ------------------------------------------------------------------------
example_data <- data_frame(date = c("2015-07-01", "2015-07-02",
                                    "2015-07-03", "2015-07-04",
                                    "2015-07-05", "2015-07-06",
                                    "2015-07-07", "2015-07-08"),
                           temp = c(26.5, 27.2, 28.0, 26.9, 
                                    27.5, 25.9, 28.0, 28.2))

(test_1 <- find_records_1(example_data, 27))

(test_2 <- find_records_2(example_data, 27))

all.equal(test_1, test_2)

## ------------------------------------------------------------------------
record_temp_perf <- microbenchmark(find_records_1(example_data, 27), 
                                   find_records_2(example_data, 27))
record_temp_perf

## ----message = FALSE-----------------------------------------------------
library(dlnm)
data("chicagoNMMAPS")

record_temp_perf_2 <- microbenchmark(find_records_1(chicagoNMMAPS, 27), 
                                     find_records_2(chicagoNMMAPS, 27))
record_temp_perf_2

## ---- fig.cap="Timing comparison of find records functions"--------------
library(ggplot2)
# For small example data
autoplot(record_temp_perf)
# For larger data set
autoplot(record_temp_perf_2)

## ----eval = FALSE--------------------------------------------------------
## library(profvis)
## datafr <- chicagoNMMAPS
## threshold <- 27
## 
## profvis({
##   highest_temp <- c()
##   record_temp <- c()
##   for(i in 1:nrow(datafr)){
##     highest_temp <- max(highest_temp, datafr$temp[i])
##     record_temp[i] <- datafr$temp[i] >= threshold &
##       datafr$temp[i] >= highest_temp
##   }
##   datafr <- cbind(datafr, record_temp)
## })

## ----echo = FALSE--------------------------------------------------------
nse_examples <- data.frame(x = c("`filter(fips %in% counties)`",
                                 "`mutate(max_rain = max(tot_precip)`",
                                 "`summarize(tot_precip = sum(precip))`",
                                 "`group_by(storm_id, fips)`",
                                 "`aes(x = long, y = lat)`",
                                 "`select(-start_date, -end_date)`",
                                 "`select(-start_date, -end_date)`",
                                 "`spread(key, mean)`",
                                 "`gather(key, mean)`"),
                           y = c("`filter_(~ fips %in% counties)`",
                                 "`mutate_(max_rain = ~ max(tot_precip)`",
                                 "`summarize_(tot_precip = ~ sum(precip))`",
                                 "`group_by_(~ storm_id, ~ fips)`",
                                 "`aes_(x = ~ long, y = ~ lat)`",
                                 "`select_(.dots = c('start_date', 'end_date'))`",
                                 "`select_(.dots = c('-start_date', '-end_date'))`",
                                 "`spread_(key_col = 'key', value_col = 'mean')`",
                                 "`gather_(key_col = 'key', value_col = 'mean')`"))
knitr::kable(nse_examples, col.names = c("Non-standard evaluation version",
                                         "Standard evaluation version"))

## ------------------------------------------------------------------------
class(2)
class("is in session.")
class(class)

## ------------------------------------------------------------------------
special_num_1 <- structure(1, class = "special_number")
class(special_num_1)

special_num_2 <- 2
class(special_num_2)
class(special_num_2) <- "special_number"
class(special_num_2)

## ------------------------------------------------------------------------
shape_s3 <- function(side_lengths){
  structure(list(side_lengths = side_lengths), class = "shape_S3")
}

square_4 <- shape_s3(c(4, 4, 4, 4))
class(square_4)

triangle_3 <- shape_s3(c(3, 3, 3))
class(triangle_3)

## ------------------------------------------------------------------------
mean(c(2, 3, 7))
mean(c(as.Date("2016-09-01"), as.Date("2016-09-03")))

## ------------------------------------------------------------------------
is_square <- function(x) UseMethod("is_square")

## ------------------------------------------------------------------------
is_square.shape_S3 <- function(x){
  length(x$side_lengths) == 4 &&
    x$side_lengths[1] == x$side_lengths[2] &&
    x$side_lengths[2] == x$side_lengths[3] &&
    x$side_lengths[3] == x$side_lengths[4]
}

is_square(square_4)
is_square(triangle_3)

## ------------------------------------------------------------------------
is_square.default <- function(x){
  NA
}

is_square("square")
is_square(c(1, 1, 1, 1))

## ------------------------------------------------------------------------
print(square_4)

## ------------------------------------------------------------------------
print.shape_S3 <- function(x){
  if(length(x$side_lengths) == 3){
    paste("A triangle with side lengths of", x$side_lengths[1], 
          x$side_lengths[2], "and", x$side_lengths[3])
  } else if(length(x$side_lengths) == 4) {
    if(is_square(x)){
      paste("A square with four sides of length", x$side_lengths[1])
    } else {
      paste("A quadrilateral with side lengths of", x$side_lengths[1],
            x$side_lengths[2], x$side_lengths[3], "and", x$side_lengths[4])
    }
  } else {
    paste("A shape with", length(x$side_lengths), "slides.")
  }
}

print(square_4)
print(triangle_3)
print(shape_s3(c(10, 10, 20, 20, 15)))
print(shape_s3(c(2, 3, 4, 5)))

## ------------------------------------------------------------------------
head(methods(print), 10)

## ------------------------------------------------------------------------
class(square_4)
class(square_4) <- c("shape_S3", "square")
class(square_4)

## ------------------------------------------------------------------------
inherits(square_4, "square")

## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = NA)

## ------------------------------------------------------------------------
## Constructor function for polygon objects
## x a numeric vector of x coordinates
## y a numeric vector of y coordinates
make_poly <- function(x, y) {
        if(length(x) != length(y))
                stop("'x' and 'y' should be the same length")
        
        ## Create the "polygon" object 
        object <- list(xcoord = x, ycoord = y)
        
        ## Set the class name
        class(object) <- "polygon"
        object
}

## ------------------------------------------------------------------------
## Print method for polygon objects
## x an object of class "polygon"
print.polygon <- function(x, ...) {
        cat("a polygon with", length(x$xcoord), 
            "vertices\n")
        invisible(x)
}

## ------------------------------------------------------------------------
## Summary method for polygon objects
## object an object of class "polygon"

summary.polygon <- function(object, ...) {
        object <- list(rng.x = range(object$xcoord),
                       rng.y = range(object$ycoord))
        class(object) <- "summary_polygon"
        object
}

## ------------------------------------------------------------------------
## Print method for summary.polygon objects
## x an object of class "summary_polygon"
print.summary_polygon <- function(x, ...) {
        cat("x:", x$rng.x[1], "-->", x$rng.x[2], "\n")
        cat("y:", x$rng.y[1], "-->", x$rng.y[2], "\n")
        invisible(x)
}

## ------------------------------------------------------------------------
## Construct a new "polygon" object
x <- make_poly(1:4, c(1, 5, 2, 1))

## ------------------------------------------------------------------------
print(x)

## ------------------------------------------------------------------------
out <- summary(x)
class(out)
print(out)

## ------------------------------------------------------------------------
summary(x)

## ---- echo=FALSE---------------------------------------------------------
library(methods)

## ------------------------------------------------------------------------
setClass("bus_S4",
         slots = list(n_seats = "numeric", 
                      top_speed = "numeric",
                      current_speed = "numeric",
                      brand = "character"))
setClass("party_bus_S4",
         slots = list(n_subwoofers = "numeric",
                      smoke_machine_on = "logical"),
         contains = "bus_S4")

## ------------------------------------------------------------------------
my_bus <- new("bus_S4", n_seats = 20, top_speed = 80, 
              current_speed = 0, brand = "Volvo")
my_bus
my_party_bus <- new("party_bus_S4", n_seats = 10, top_speed = 100,
                    current_speed = 0, brand = "Mercedes-Benz", 
                    n_subwoofers = 2, smoke_machine_on = FALSE)
my_party_bus

## ------------------------------------------------------------------------
my_bus@n_seats
my_party_bus@top_speed

## ------------------------------------------------------------------------
setGeneric("is_bus_moving", function(x){
  standardGeneric("is_bus_moving")
})

## ------------------------------------------------------------------------
setMethod("is_bus_moving",
          c(x = "bus_S4"),
          function(x){
            x@current_speed > 0
          })

is_bus_moving(my_bus)
my_bus@current_speed <- 1
is_bus_moving(my_bus)

## ------------------------------------------------------------------------
setGeneric("print")

setMethod("print",
          c(x = "bus_S4"),
          function(x){
            paste("This", x@brand, "bus is traveling at a speed of", x@current_speed)
          })

print(my_bus)
print(my_party_bus)

## ------------------------------------------------------------------------
Student <- setRefClass("Student",
                      fields = list(name = "character",
                                    grad_year = "numeric",
                                    credits = "numeric",
                                    id = "character",
                                    courses = "list"),
                      methods = list(
                        hello = function(){
                          paste("Hi! My name is", name)
                        },
                        add_credits = function(n){
                          credits <<- credits + n
                        },
                        get_email = function(){
                          paste0(id, "@jhu.edu")
                        }
                      ))

## ------------------------------------------------------------------------
brooke <- Student$new(name = "Brooke", grad_year = 2019, credits = 40,
                    id = "ba123", courses = list("Ecology", "Calculus III"))
roger <- Student$new(name = "Roger", grad_year = 2020, credits = 10,
                    id = "rp456", courses = list("Puppetry", "Elementary Algebra"))

## ------------------------------------------------------------------------
brooke$credits
roger$hello()
roger$get_email()

## ------------------------------------------------------------------------
brooke$credits
brooke$add_credits(4)
brooke$credits

## ------------------------------------------------------------------------
Grad_Student <- setRefClass("Grad_Student",
                            contains = "Student",
                            fields = list(thesis_topic = "character"),
                            methods = list(
                              defend = function(){
                                paste0(thesis_topic, ". QED.")
                              }
                            ))

jeff <- Grad_Student$new(name = "Jeff", grad_year = 2021, credits = 8,
                    id = "jl55", courses = list("Fitbit Repair", 
                                                "Advanced Base Graphics"),
                    thesis_topic = "Batch Effects")

jeff$defend()

