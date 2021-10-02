## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = NA, fig.path = "images/", collapse = TRUE)

## ----eval = FALSE--------------------------------------------------------
## use_vignette("model_details")

## ----echo = FALSE--------------------------------------------------------
markdown_format <- data.frame(Code = c("`**text**`",
                                       "`*text*`",
                                       "`[text](www.google.com)`", 
                                       "`# text`", 
                                       "`## text`"),
                              Rendering = c("**text**",
                                            "*text*",
                                            "[text](www.google.com)",
                                            "",
                                            ""),
                              Explanation = c("boldface",
                                              "italicized",
                                              "hyperlink",
                                              "first-level header",
                                              "second-level header"))
knitr::kable(markdown_format)

## ----echo = FALSE--------------------------------------------------------
chunk_opts <- data.frame(Option = c("`echo`",
                                    "`eval`",
                                    "`messages`",
                                    "`warnings`",
                                    "`include`"),
                         Action = c("Print out the R code?",
                                    "Run the R code?",
                                    "Print out messages?",
                                    "Print out warnings?",
                                    "If FALSE, run code, but don't print code or results"))
knitr::kable(chunk_opts)

## ----echo = FALSE--------------------------------------------------------
chunk_opts2 <- data.frame(Option = c("`results`",
                                     "`fig.width`",
                                     "`fig.height`"),
                          Action = c("How to print results (e.g., `hide` runs the code, but doesn't print the results)",
                                     "Width to print your figure, in inches (e.g., `fig.width = 4`)",
                                     "Height to print your figure"))
knitr::kable(chunk_opts2)
## pander::pander(chunk_opts2, split.cells = Inf, justify = c("center", "left"), style = "rmarkdown")

## ---- eval=FALSE---------------------------------------------------------
## #' Production and farm value of maple products in Canada
## #'
## #' @source Statistics Canada. Table 001-0008 - Production and farm value of
## #'  maple products, annual. \url{http://www5.statcan.gc.ca/cansim/}
## #' @format A data frame with columns:
## #' \describe{
## #'  \item{Year}{A value between 1924 and 2015.}
## #'  \item{Syrup}{Maple products expressed as syrup, total in thousands of gallons.}
## #'  \item{CAD}{Gross value of maple products in thousands of Canadian dollars.}
## #'  \item{Region}{Postal code abbreviation for territory or province.}
## #' }
## #' @examples
## #' \dontrun{
## #'  maple
## #' }
## "maple"

## ---- eval=FALSE---------------------------------------------------------
## #' Postal Abbreviations for Mexico
## #'
## #' @examples
## #' \dontrun{
## #'  mexico_abb
## #' }
## "mexico_abb"

## ------------------------------------------------------------------------
library(testthat)
expect_that(sqrt(3) * sqrt(3), equals(3))

## ------------------------------------------------------------------------
test_that("model fitting", {
        data(airquality)
        fit <- lm(Ozone ~ Wind, data = airquality)
        expect_that(fit, is_a("lm"))
        expect_that(1 + 1, equals(2))
})

## ---- error=TRUE---------------------------------------------------------
multiply_by <- function(n, multiplier = c("two", "three", "four")){
  multiplier <- match.arg(multiplier)
  if(multiplier == "two"){
    n * 2
  } else if(multiplier == "three"){
    n * 3
  } else {
    n * 4
  }
}

multiply_by(5, "two")
multiply_by(5, "six")

## ------------------------------------------------------------------------
apropos("mean")
apropos("my_new_function")

## ------------------------------------------------------------------------
file.path("~", "Desktop", "data.txt")

## ------------------------------------------------------------------------
Sys.info()['sysname']

## ------------------------------------------------------------------------
path.expand("~")
path.expand(file.path("~", "Desktop"))

## ---- eval=FALSE---------------------------------------------------------
## normalizePath(file.path("~", "R"))

## ---- eval=FALSE---------------------------------------------------------
## normalizePath(".")

## ---- eval=FALSE---------------------------------------------------------
## normalizePath("..")

## ---- warning=FALSE------------------------------------------------------
data_file <- normalizePath(file.path("~", "data.txt"))
data_file
dirname(data_file)
dirname(dirname(data_file))
basename(data_file)

## ---- eval=FALSE---------------------------------------------------------
## #' A function for doing something
## #'
## #' This function takes some action. It also attempts to create a file on your
## #' desktop called \code{data.txt}. If \code{data.txt} cannot be created a
## #' warning is raised.
## #'
## #' @param force If set to \code{TRUE}, \code{data.txt} will be created on the
## #' user's Desktop if their Desktop exists. If this function is used in an
## #' interactive session the user will be asked whether or not \code{data.txt}
## #' should be created. The default value is \code{FALSE}.
## #'
## #' @export
## some_function <- function(force = FALSE){
## 
##   #
##   # ... some code that does something useful ...
##   #
## 
##   if(!dir.exists(file.path("~", "Desktop"))){
##     warning("No Desktop found.")
##   } else {
##     if(!force && interactive()){
##       result <- select.list(c("Yes", "No"),
##                   title = "May this program create data.txt on your desktop?")
##       if(result == "Yes"){
##         file.create(file.path("~", "Desktop", "data.txt"))
##       }
##     } else if(force){
##       file.create(file.path("~", "Desktop", "data.txt"))
##     } else {
##       warning("data.txt was not created on the Desktop.")
##     }
##   }
## }

## ------------------------------------------------------------------------
library(rappdirs)
site_data_dir(appname = "ggplyr2")
user_data_dir(appname = "ggplyr2")

## ------------------------------------------------------------------------
user_data_dir(appname = "ggplyr2", os = "win")

## ------------------------------------------------------------------------
.Platform$OS.type

## ------------------------------------------------------------------------
.Machine$double.xmax
.Machine$double.xmax + 100 == .Machine$double.xmax
.Machine$double.xmin

## ------------------------------------------------------------------------
1 + .Machine$double.eps != 1
1 + .Machine$double.xmin != 1

