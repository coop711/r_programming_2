## ----echo=FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = NA, collapse = TRUE, fig.path="images/")

## ------------------------------------------------------------------------
x <- 1
print(x)
x
msg <- "hello"

## ------------------------------------------------------------------------
x <- 5  ## nothing printed
x       ## auto-printing occurs
print(x)  ## explicit printing

## ----echo=FALSE----------------------------------------------------------
old <- options(width = 40)

## ------------------------------------------------------------------------
x <- 11:30
x

## ----echo=FALSE----------------------------------------------------------
options(old)

## ------------------------------------------------------------------------
x <- c(0.5, 0.6)       ## numeric
x <- c(TRUE, FALSE)    ## logical
x <- c(T, F)           ## logical
x <- c("a", "b", "c")  ## character
x <- 9:29              ## integer
x <- c(1+0i, 2+4i)     ## complex

## ------------------------------------------------------------------------
x <- vector("numeric", length = 10) 
x

## ------------------------------------------------------------------------
y <- c(1.7, "a")   ## character
y <- c(TRUE, 2)    ## numeric
y <- c("a", TRUE)  ## character

## ------------------------------------------------------------------------
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

## ------------------------------------------------------------------------
x <- c("a", "b", "c")
as.numeric(x)
as.logical(x)
as.complex(x)

## ------------------------------------------------------------------------
m <- matrix(nrow = 2, ncol = 3) 
m
dim(m)
attributes(m)

## ------------------------------------------------------------------------
m <- matrix(1:6, nrow = 2, ncol = 3) 
m

## ------------------------------------------------------------------------
m <- 1:10 
m
dim(m) <- c(2, 5)
m

## ------------------------------------------------------------------------
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y) 

## ------------------------------------------------------------------------
x <- list(1, "a", TRUE, 1 + 4i) 
x

## ------------------------------------------------------------------------
x <- vector("list", length = 5)
x

## ------------------------------------------------------------------------
x <- factor(c("yes", "yes", "no", "yes", "no")) 
x
table(x) 
## See the underlying representation of factor
unclass(x)  

## ------------------------------------------------------------------------
x <- factor(c("yes", "yes", "no", "yes", "no"))
x  ## Levels are put in alphabetical order
x <- factor(c("yes", "yes", "no", "yes", "no"),
            levels = c("yes", "no"))
x

## ------------------------------------------------------------------------
## Create a vector with NAs in it
x <- c(1, 2, NA, 10, 3)  
## Return a logical vector indicating which elements are NA
is.na(x)    
## Return a logical vector indicating which elements are NaN
is.nan(x)   

## ------------------------------------------------------------------------
## Now create a vector with both NA and NaN values
x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

## ------------------------------------------------------------------------
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x
nrow(x)
ncol(x)

## ------------------------------------------------------------------------
x <- 1:3
names(x)
names(x) <- c("New York", "Seattle", "Los Angeles") 
x
names(x)

## ------------------------------------------------------------------------
x <- list("Los Angeles" = 1, Boston = 2, London = 3) 
x
names(x)

## ------------------------------------------------------------------------
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 
m

## ------------------------------------------------------------------------
colnames(m) <- c("h", "f")
rownames(m) <- c("x", "z")
m

## ----echo=FALSE----------------------------------------------------------
library(datasets)
VADeaths

## ---- message=FALSE------------------------------------------------------
library(tidyr)
library(dplyr)

VADeaths %>%
  tbl_df() %>%
  mutate(age = row.names(VADeaths)) %>%
  gather(key, death_rate, -age) %>%
  separate(key, c("urban", "gender"), sep = " ") %>%
  mutate(age = factor(age), urban = factor(urban), gender = factor(gender))

## ----eval = FALSE--------------------------------------------------------
## library(dplyr)
## library(tidyr)
## library(readr)
## library(ggplot2)

## ----eval = FALSE--------------------------------------------------------
## library(tidyverse)

## ------------------------------------------------------------------------
library(readr)
teams <- read_csv("data/team_standings.csv")
teams

## ------------------------------------------------------------------------
teams <- read_csv("data/team_standings.csv", col_types = "cc")

## ------------------------------------------------------------------------
logs <- read_csv("data/2016-07-19.csv.gz", n_max = 10)
logs

## ------------------------------------------------------------------------
logs <- read_csv("data/2016-07-20.csv.gz", col_types = "ccicccccci", n_max = 10)
logs

## ------------------------------------------------------------------------
logdates <- read_csv("data/2016-07-20.csv.gz", 
                     col_types = cols_only(date = col_date()),
                     n_max = 10)
logdates

## ----echo = FALSE--------------------------------------------------------
readr_functions <- data.frame(func = c("`read_csv`",
                                       "`read_csv2`",
                                       "`read_tsv`",
                                       "`read_delim`",
                                       "`read_fwf`",
                                       "`read_log`"),
                              file_type = c("Reads comma-separated file",
                                            "Reads semicolon-separated file",
                                            "Reads tab-separated file",
                                            "General function for reading delimited files",
                                            "Reads fixed width files",
                                            "Reads log files"))
knitr::kable(readr_functions, col.names = c("`readr` function", "Use"))

## ------------------------------------------------------------------------
ext_tracks_file <- paste0("http://rammb.cira.colostate.edu/research/",
                          "tropical_cyclones/tc_extended_best_track_dataset/",
                          "data/ebtrk_atlc_1988_2015.txt")

## ----message = FALSE-----------------------------------------------------
library(readr)

# Create a vector of the width of each column
ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)
length(ext_tracks_widths)

# Create a vector of column names, based on the online documentation for this data
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                          "hour", "year", "latitude", "longitude",
                          "max_wind", "min_pressure", "rad_max_wind",
                          "eye_diameter", "pressure_1", "pressure_2",
                          paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                          "storm_type", "distance_to_land", "final")
length(ext_tracks_colnames)

# Read the file in from its url
ext_tracks <- read_fwf(ext_tracks_file, 
                       fwf_widths(ext_tracks_widths, ext_tracks_colnames),
                       na = "-99")
ext_tracks[1:3, 1:9]
ext_tracks[1:3, 10:18]
ext_tracks[1:3, 19:29]

## ----message = FALSE-----------------------------------------------------
library(dplyr)

ext_tracks %>%
  filter(storm_name == "KATRINA") %>%
  select(month, day, hour, max_wind, min_pressure, rad_max_wind) %>%
  sample_n(4)

## ----message = FALSE-----------------------------------------------------
zika_file <- paste0("https://raw.githubusercontent.com/cdcepi/zika/master/",
                    "Brazil/COES_Microcephaly/data/COES_Microcephaly-2016-06-25.csv")
zika_brazil <- read_csv(zika_file)

zika_brazil %>%
  select(location, value, unit)

## ------------------------------------------------------------------------
library(httr)
meso_url <- "https://mesonet.agron.iastate.edu/cgi-bin/request/asos.py/"
denver <- GET(url = meso_url,
                    query = list(station = "DEN",
                                 data = "sped",
                                 year1 = "2016",
                                 month1 = "6",
                                 day1 = "1",
                                 year2 = "2016",
                                 month2 = "6",
                                 day2 = "30",
                                 tz = "America/Denver",
                                 format = "comma")) %>%
  content() %>% 
  read_csv(skip = 5, na = "M") 

denver %>% slice(1:3)

## ----message = FALSE-----------------------------------------------------
ext_tracks_file <- "data/ebtrk_atlc_1988_2015.txt"
ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                          "hour", "year", "latitude", "longitude",
                          "max_wind", "min_pressure", "rad_max_wind",
                          "eye_diameter", "pressure_1", "pressure_2",
                          paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                          "storm_type", "distance_to_land", "final")
ext_tracks <- read_fwf(ext_tracks_file, 
                       fwf_widths(ext_tracks_widths, ext_tracks_colnames),
                       na = "-99")

## ----eval = FALSE--------------------------------------------------------
## # Without piping
## function(dataframe, argument_2, argument_3)
## 
## # With piping
## dataframe %>%
##   function(argument_2, argument_3)

## ------------------------------------------------------------------------
katrina <- filter(ext_tracks, storm_name == "KATRINA")
katrina_reduced <- select(katrina, month, day, hour, max_wind)
head(katrina_reduced, 3)

## ------------------------------------------------------------------------
head(select(filter(ext_tracks, storm_name == "KATRINA"),
            month, day, hour, max_wind), 3)

## ------------------------------------------------------------------------
ext_tracks %>%
  filter(storm_name == "KATRINA") %>%
  select(month, day, hour, max_wind) %>%
  head(3)

## ------------------------------------------------------------------------
ext_tracks %>%
  summarize(n_obs = n(),
            worst_wind = max(max_wind),
            worst_pressure = min(min_pressure))

## ------------------------------------------------------------------------
knots_to_mph <- function(knots){
  mph <- 1.152 * knots
}

ext_tracks %>%
  summarize(n_obs = n(),
            worst_wind = knots_to_mph(max(max_wind)),
            worst_pressure = min(min_pressure))

## ------------------------------------------------------------------------
ext_tracks %>%
  group_by(storm_name, year) %>%
  head()

## ------------------------------------------------------------------------
ext_tracks %>%
  group_by(storm_name, year) %>%
  summarize(n_obs = n(),
            worst_wind = max(max_wind),
            worst_pressure = min(min_pressure))

## ----windhistogram, message = FALSE, warning = FALSE, fig.cap = "Histogram of the maximum wind speed observed during a storm for all Atlantic basin tropical storms, 1988--2015."----
library(ggplot2)
ext_tracks %>%
  group_by(storm_name) %>%
  summarize(worst_wind = max(max_wind)) %>%
  ggplot(aes(x = worst_wind)) + geom_histogram() 

## ------------------------------------------------------------------------
ext_tracks %>%
  select(storm_name, month, day, hour, year, latitude, longitude, max_wind)

## ------------------------------------------------------------------------
ext_tracks %>%
  select(storm_name, latitude, longitude, starts_with("radius_34"))

## ------------------------------------------------------------------------
head(ext_tracks$hour)
head(ext_tracks$hour == "00")

## ------------------------------------------------------------------------
ext_tracks %>% 
  select(storm_name, hour, max_wind) %>%
  head(9)

ext_tracks %>%
  select(storm_name, hour, max_wind) %>%
  filter(hour == "00") %>%
  head(3)

## ------------------------------------------------------------------------
ext_tracks %>%
  group_by(storm_name, year) %>%
  summarize(worst_wind = max(max_wind)) %>%
  filter(worst_wind >= 160)

## ------------------------------------------------------------------------
ext_tracks %>%
  select(storm_name, month, day, hour, latitude, longitude, max_wind) %>%
  filter(storm_name == "ANDREW" & max_wind >= 137) 

## ------------------------------------------------------------------------
library(faraway)
data(worldcup)

## ------------------------------------------------------------------------
worldcup <- worldcup %>%
  mutate(player_name = rownames(worldcup))

worldcup %>% slice(1:3)

## ------------------------------------------------------------------------
worldcup <- worldcup %>% 
  group_by(Position) %>%
  mutate(ave_shots = mean(Shots)) %>%
  ungroup()

worldcup %>% slice(1:3)

## ------------------------------------------------------------------------
worldcup %>% 
  rename(Name = player_name) %>%
  slice(1:3)

## ------------------------------------------------------------------------
data("VADeaths")
head(VADeaths)

## ------------------------------------------------------------------------
data("VADeaths")
library(tidyr)

# Move age from row names into a column
VADeaths  <- VADeaths %>%
  tbl_df() %>%
  mutate(age = row.names(VADeaths)) 
VADeaths

# Gather everything but age to tidy data
VADeaths %>%
  gather(key = key, value = death_rate, -age)

## ----facetworldcup, message = FALSE, fig.cap = "Example of a faceted plot created by taking advantage of the `gather` function to pull together data."----
library(tidyr)
library(ggplot2)
worldcup %>%
  select(Position, Time, Shots, Tackles, Saves) %>% 
  gather(Type, Number, -Position, -Time) %>%
  ggplot(aes(x = Time, y = Number)) + 
  geom_point() + 
  facet_grid(Type ~ Position)

## ------------------------------------------------------------------------
library(knitr)

# Summarize the data to create the summary statistics you want
wc_table <- worldcup %>% 
  filter(Team %in% c("Spain", "Netherlands", "Uruguay", "Germany")) %>%
  select(Team, Position, Passes) %>%
  group_by(Team, Position) %>%
  summarize(ave_passes = mean(Passes),
            min_passes = min(Passes),
            max_passes = max(Passes),
            pass_summary = paste0(round(ave_passes), " (", 
                                  min_passes, ", ",
                                  max_passes, ")")) %>%
  select(Team, Position, pass_summary)
# What the data looks like before using `spread`
wc_table

# Use spread to create a prettier format for a table
wc_table %>%
  spread(Position, pass_summary) %>%
  kable()

## ----message = FALSE-----------------------------------------------------
team_standings <- read_csv("data/team_standings.csv")
team_standings %>% slice(1:3)

## ----echo = FALSE--------------------------------------------------------
join_funcs <- data.frame(func = c("`left_join`",
                                  "`right_join`",
                                  "`inner_join`",
                                  "`full_join`"),
                         does = c("Includes all observations in the left data frame, whether or not there is a match in the right data frame",
                                  "Includes all observations in the right data frame, whether or not there is a match in the left data frame",
                                  "Includes only observations that are in both data frames",
                                  "Includes all observations from both data frames"))
knitr::kable(join_funcs, col.names = c("Function", "What it includes in merged data frame"))

## ----eval = FALSE--------------------------------------------------------
## left_join(world_cup, team_standings, by = "Team")

## ----message = FALSE-----------------------------------------------------
data(worldcup)
worldcup %>% 
  mutate(Name = rownames(worldcup),
         Team = as.character(Team)) %>%
  select(Name, Position, Shots, Team) %>%
  arrange(desc(Shots)) %>%
  slice(1:5) %>%
  left_join(team_standings, by = "Team") %>% # Merge in team standings
  rename("Team Standing" = Standing) %>%
  kable()

## ----message = FALSE-----------------------------------------------------
ext_tracks_file <- "data/ebtrk_atlc_1988_2015.txt"
ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                          "hour", "year", "latitude", "longitude",
                          "max_wind", "min_pressure", "rad_max_wind",
                          "eye_diameter", "pressure_1", "pressure_2",
                          paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                          paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                          "storm_type", "distance_to_land", "final")
ext_tracks <- read_fwf(ext_tracks_file, 
                       fwf_widths(ext_tracks_widths, ext_tracks_colnames),
                       na = "-99")

## ----message = FALSE-----------------------------------------------------
library(lubridate)

ymd("2006-03-12")
ymd("'06 March 12")
ymd_hm("06/3/12 6:30 pm")

## ----message = FALSE-----------------------------------------------------
library(dplyr)
library(tidyr)

andrew_tracks <- ext_tracks %>%
  filter(storm_name == "ANDREW" & year == "1992") %>%
  select(year, month, day, hour, max_wind, min_pressure) %>%
  unite(datetime, year, month, day, hour) %>%
  mutate(datetime = ymd_h(datetime))

head(andrew_tracks, 3)
class(andrew_tracks$datetime)

## ----andrewwind, fig.cap = "Example of how variables in a date-time class can be parsed for sensible axis labels."----
andrew_tracks %>%
  gather(measure, value, -datetime) %>%
  ggplot(aes(x = datetime, y = value)) + 
  geom_point() + geom_line() + 
  facet_wrap(~ measure, ncol = 1, scales = "free_y")

## ------------------------------------------------------------------------
andrew_tracks %>%
  select(datetime) %>%
  mutate(year = year(datetime),
         month = months(datetime),
         weekday = weekdays(datetime),
         yday = yday(datetime),
         hour = hour(datetime)) %>%
  slice(1:3)

## ----stormbytimegroups, message = FALSE, fig.cap = "Example of using `lubridate` functions to explore data with a date variable by different time groupings"----
check_tracks <- ext_tracks %>%
  select(month, day, hour, year, max_wind) %>%
  unite(datetime, year, month, day, hour) %>%
  mutate(datetime = ymd_h(datetime),
         weekday = weekdays(datetime),
         weekday = factor(weekday, levels = c("Sunday", "Monday",
                                              "Tuesday", "Wednesday",
                                              "Thursday", "Friday",
                                              "Saturday")),
         month = months(datetime),
         month = factor(month, levels = c("April", "May", "June",
                                          "July", "August", "September",
                                          "October", "November", 
                                          "December", "January")))

check_weekdays <- check_tracks %>%
  group_by(weekday) %>%
  summarize(ave_max_wind = mean(max_wind)) %>%
  rename(grouping = weekday)
check_months <- check_tracks %>%
  group_by(month) %>%
  summarize(ave_max_wind = mean(max_wind)) %>%
  rename(grouping = month)
  
a <- ggplot(check_weekdays, aes(x = grouping, y = ave_max_wind)) + 
  geom_bar(stat = "identity") + xlab("")
b <- a %+% check_months

library(gridExtra)
grid.arrange(a, b, ncol = 1)

## ----andrewutc, message = FALSE, fig.cap = "Hurricane Andrew tracks by date, based on UTC date times."----
andrew_tracks <- ext_tracks %>%
  filter(storm_name == "ANDREW") %>% 
  slice(23:47) %>%
  select(year, month, day, hour, latitude, longitude) %>%
  unite(datetime, year, month, day, hour) %>%
  mutate(datetime = ymd_h(datetime),
         date = format(datetime, "%b %d")) 
  
library(ggmap)
miami <- get_map("miami", zoom = 5)
ggmap(miami) + 
  geom_path(data = andrew_tracks, aes(x = -longitude, y = latitude),
            color = "gray", size = 1.1) + 
  geom_point(data = andrew_tracks,
             aes(x = -longitude, y = latitude, color = date),
             size = 2)

## ----andrewlocal, message = FALSE, fig.cap = "Hurricane Andrew tracks by date, based on Miami, FL, local time."----
andrew_tracks <- andrew_tracks %>%
  mutate(datetime = with_tz(datetime, tzone = "America/New_York"),
         date = format(datetime, "%b %d")) 
  
ggmap(miami) + 
  geom_path(data = andrew_tracks, aes(x = -longitude, y = latitude),
            color = "gray", size = 1.1) + 
  geom_point(data = andrew_tracks,
             aes(x = -longitude, y = latitude, color = date),
             size = 2)

## ------------------------------------------------------------------------
paste("Square", "Circle", "Triangle")

## ------------------------------------------------------------------------
paste("Square", "Circle", "Triangle", sep = "+")

## ------------------------------------------------------------------------
paste0("Square", "Circle", "Triangle")

## ------------------------------------------------------------------------
shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

## ------------------------------------------------------------------------
paste(shapes, collapse = " ")

## ------------------------------------------------------------------------
nchar("Supercalifragilisticexpialidocious")

## ------------------------------------------------------------------------
cases <- c("CAPS", "low", "Title")
tolower(cases)
toupper(cases)

## ------------------------------------------------------------------------
regular_expression <- "a"
string_to_search <- "Maryland"

grepl(regular_expression, string_to_search)

## ------------------------------------------------------------------------
regular_expression <- "u"
string_to_search <- "Maryland"

grepl(regular_expression, string_to_search)

## ------------------------------------------------------------------------
grepl("land", "Maryland")
grepl("ryla", "Maryland")
grepl("Marly", "Maryland")
grepl("dany", "Maryland")

## ------------------------------------------------------------------------
head(state.name)

## ------------------------------------------------------------------------
grepl(".", "Maryland")
grepl(".", "*&2[0+,%<@#~|}")
grepl(".", "")

## ------------------------------------------------------------------------
grepl("a.b", c("aaa", "aab", "abb", "acadb"))

## ------------------------------------------------------------------------
# Does "Maryland" contain one or more of "a" ?
grepl("a+", "Maryland")

# Does "Maryland" contain one or more of "x" ?
grepl("x+", "Maryland")

# Does "Maryland" contain zero or more of "x" ?
grepl("x*", "Maryland")

## ------------------------------------------------------------------------
# Does "Mississippi" contain exactly 2 adjacent "s" ?
grepl("s{2}", "Mississippi")

# This is equivalent to the expression above:
grepl("ss", "Mississippi")

# Does "Mississippi" contain between 1 and 3 adjacent "s" ?
grepl("s{2,3}", "Mississippi")

# Does "Mississippi" contain between 2 and 3 adjacent "i" ?
grepl("i{2,3}", "Mississippi")

# Does "Mississippi" contain between 2 adjacent "iss" ?
grepl("(iss){2}", "Mississippi")

# Does "Mississippi" contain between 2 adjacent "ss" ?
grepl("(ss){2}", "Mississippi")

# Does "Mississippi" contain the pattern of an "i" followed by 
# 2 of any character, with that pattern repeated three times adjacently?
grepl("(i.{2}){3}", "Mississippi")

## ------------------------------------------------------------------------
grepl("\\w", "abcdefghijklmnopqrstuvwxyz0123456789")

grepl("\\d", "0123456789")

# "\n" is the metacharacter for a new line
# "\t" is the metacharacter for a tab
grepl("\\s", "\n\t   ")

grepl("\\d", "abcdefghijklmnopqrstuvwxyz")

grepl("\\D", "abcdefghijklmnopqrstuvwxyz")

grepl("\\w", "\n\t   ")

## ------------------------------------------------------------------------
grepl("[aeiou]", "rhythms")

grepl("[^aeiou]", "rhythms")

grepl("[a-m]", "xyz")

grepl("[a-m]", "ABC")

grepl("[a-mA-M]", "ABC")

## ------------------------------------------------------------------------
grepl("\\+", "tragedy + time = humor")

grepl("\\.", "http://www.jhsph.edu/")

## ------------------------------------------------------------------------
grepl("^a", c("bab", "aab"))

grepl("b$", c("bab", "aab"))

grepl("^[ab]+$", c("bab", "aab", "abc"))

## ------------------------------------------------------------------------
grepl("a|b", c("abc", "bcd", "cde"))

grepl("North|South", c("South Dakota", "North Carolina", "West Virginia"))

## ------------------------------------------------------------------------
start_end_vowel <- "^[AEIOU]{1}.+[aeiou]{1}$"
vowel_state_lgl <- grepl(start_end_vowel, state.name)
head(vowel_state_lgl)

state.name[vowel_state_lgl]

## ---- echo=FALSE---------------------------------------------------------
library(knitr)

mc_tibl <- data.frame(Metacharacter =
                        c(".", "\\\\w", "\\\\W", "\\\\d", "\\\\D",
                          "\\\\s", "\\\\S", "[xyz]", "[^xyz]", "[a-z]",
                          "^", "$", "\\\\n", "+", "*", "?", "|", "{5}", "{2, 5}",
                          "{2, }"),
           Meaning =
             c("Any Character", "A Word", "Not a Word", "A Digit", "Not a Digit",
               "Whitespace", "Not Whitespace", "A Set of Characters", 
               "Negation of Set", "A Range of Characters",
               "Beginning of String", "End of String", "Newline", 
               "One or More of Previous", "Zero or More of Previous",
               "Zero or One of Previous", "Either the Previous or the Following",
               "Exactly 5 of Previous", "Between 2 and 5 or Previous",
               "More than 2 of Previous"),
           stringsAsFactors = FALSE)
kable(mc_tibl, align = "c")

## ------------------------------------------------------------------------
grepl("[Ii]", c("Hawaii", "Illinois", "Kentucky"))

## ------------------------------------------------------------------------
grep("[Ii]", c("Hawaii", "Illinois", "Kentucky"))

## ------------------------------------------------------------------------
sub("[Ii]", "1", c("Hawaii", "Illinois", "Kentucky"))

## ------------------------------------------------------------------------
gsub("[Ii]", "1", c("Hawaii", "Illinois", "Kentucky"))

## ------------------------------------------------------------------------
two_s <- state.name[grep("ss", state.name)]
two_s
strsplit(two_s, "ss")

## ------------------------------------------------------------------------
library(stringr)
state_tbl <- paste(state.name, state.area, state.abb)
head(state_tbl)
str_extract(state_tbl, "[0-9]+")

## ------------------------------------------------------------------------
head(state.name)
str_order(state.name)

head(state.abb)
str_order(state.abb)

## ------------------------------------------------------------------------
str_pad("Thai", width = 8, side = "left", pad = "-")
str_pad("Thai", width = 8, side = "right", pad = "-")
str_pad("Thai", width = 8, side = "both", pad = "-")

## ------------------------------------------------------------------------
cases <- c("CAPS", "low", "Title")
str_to_title(cases)

## ------------------------------------------------------------------------
to_trim <- c("   space", "the    ", "    final frontier  ")
str_trim(to_trim)

## ------------------------------------------------------------------------
pasted_states <- paste(state.name[1:20], collapse = " ")

cat(str_wrap(pasted_states, width = 80))
cat(str_wrap(pasted_states, width = 30))

## ------------------------------------------------------------------------
a_tale <- "It was the best of times it was the worst of times it was the age of wisdom it was the age of foolishness"

word(a_tale, 2)

word(a_tale, end = 3)

word(a_tale, start = 11, end = 15)

## ------------------------------------------------------------------------
library(pryr)
mem_used()

## ------------------------------------------------------------------------
ls()  ## Show objects in workspace
object_size(worldcup)

## ----warning=FALSE,message=FALSE-----------------------------------------
library(magrittr)
sapply(ls(), function(x) object.size(get(x))) %>% sort %>% tail(5)

## ------------------------------------------------------------------------
mem_used()
rm(ext_tracks, miami)
mem_used()

## ------------------------------------------------------------------------
mem_change(rm(check_tracks, denver, b))

## ------------------------------------------------------------------------
object_size(integer(0))

## ------------------------------------------------------------------------
object_size(integer(1000))  ## 4 bytes per integer
object_size(numeric(1000))  ## 8 bytes per numeric

## ------------------------------------------------------------------------
str(.Machine)

## ------------------------------------------------------------------------
gc()

## ----message = FALSE, warning = FALSE------------------------------------
library(data.table)
brazil_zika <- fread("data/COES_Microcephaly-2016-06-25.csv")
head(brazil_zika, 2)
class(brazil_zika)

## ------------------------------------------------------------------------
fread("data/COES_Microcephaly-2016-06-25.csv",
      select = c("location", "value", "unit")) %>%
  dplyr::slice(1:3)

## ----rdbi, echo = FALSE, fig.cap = "Structure of interface between code in an R script and data stored in a database management system using DBI-compliant packages"----
knitr::include_graphics("images/RDatabaseInterface.png")

## ----echo = FALSE--------------------------------------------------------
dbi_workflow <- data.frame(task = c("Create a new driver object for an instance of a database", 
                                    "Connect to database instance",
                                    "Find available tables in a connected database instance",
                                    "Find available fields within a table",
                                    "Query a connected database instance",
                                    "Pull a data frame into R from a query result",
                                    "Jointly query and pull data from a database instance",
                                    "Close result set from a query",
                                    "Write a new table in a database instance",
                                    "Remove a table from a database instance",
                                    "Disconnect from a database instance"), 
                           dbi_func = c("`dbDriver`",
                                        "`dbConnect`",
                                        "`dbListTables`",
                                        "`dbListFields`",
                                        "`dbSendQuery`",
                                        "`dbFetch`",
                                        "`dbGetQuery`",
                                        "`dbClearResult`",
                                        "`dbWriteTable`",
                                        "`dbRemoveTable`",
                                        "`dbDisconnect`"))
knitr::kable(dbi_workflow, col.names = c("Task", "DBI Function"))

## ----echo = FALSE--------------------------------------------------------
db_packages <- data.frame("dbms" = c("Oracle", #1
                                     "MySQL", #2
                                     "Microsoft SQL Server", #3
                                     "PostgreSQL", #5
                                     "SQLite"),
                          "package" = c("`ROracle`", #1 
                                        "`RMySQL`", #2
                                        "`RSQLServer`", #3
                                        "`RPostgres`", #5
                                        "`RSQLite`")) #9
knitr::kable(db_packages, col.names = c("Database Management System", "R packages"))

