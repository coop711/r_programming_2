## The  importance of Tidy Data
VADeaths
library(tidyr)
library(dplyr)
str(VADeaths)

VADeaths %>%
  tbl_df() %>%
  mutate(age = row.names(VADeaths)) %>%
  gather(key, death_rate, -age) %>%
  separate(key, c("urban", "gender"), sep = " ") %>%
  mutate(age = factor(age), urban = factor(urban), gender = factor(gender))

## The "Tidyverse"
install.packages("tidyverse", repos = "https://cran.rstudio.com")
library(tidyverse)

# Reading Tabular Data with the `readr` package
