## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = NA, fig.path = "images/", collapse = TRUE)

## ------------------------------------------------------------------------
# install.packages("titanic") # If you don't have the package installed
library(titanic)
data("titanic_train", package = "titanic")
titanic <- titanic_train

## ------------------------------------------------------------------------
# install.packages("faraway") # If you don't have the package installed
library(faraway)
data("worldcup")

## ------------------------------------------------------------------------
# install.packages("ggplot2")  ## Uncomment and run if you don't have `ggplot2` installed
library(ggplot2)

## ---- eval = FALSE-------------------------------------------------------
## ## Generic code
## object <- ggplot(dataframe, aes(x = column_1, y = column_2))
## ## or, if you don't need to save the object
## ggplot(dataframe, aes(x = column_1, y = column_2))

## ----aesmapex, echo = FALSE, warning = FALSE, fig.width = 6, fig.height = 4, message = FALSE, fig.cap = "Example of how different properties of a plot can show different elements to the data. Here, color indicates gender, position along the x-axis shows height, and position along the y-axis shows weight. This example is a subset of data from the `nepali` dataset in the `faraway` package."----
library(dplyr)
data("nepali") 
nepali %>%
  tbl_df() %>% 
  distinct(id, .keep_all = TRUE) %>%
  mutate(sex = factor(sex, levels = c(1, 2), labels = c("Male", "Female"))) %>%
  ggplot(aes(x = ht, y = wt, color = sex)) + 
  geom_point() + 
  xlab("Height (cm)") + ylab("Weight (kg)")

## ----echo = FALSE--------------------------------------------------------
aes_vals <- data.frame(aes = c("`x`", "`y`", "`shape`",
                               "`color`", "`fill`", "`size`",
                               "`alpha`", "`linetype`"),
                       desc = c("Position on x-axis", 
                                "Position on y-axis", 
                                "Shape",
                                "Color of border of elements", 
                                "Color of inside of elements",
                                "Size", 
                                "Transparency (1: opaque; 0: transparent)",
                                "Type of line (e.g., solid, dashed)"))
knitr::kable(aes_vals, col.names = c("Code", "Description"))

## ----message = FALSE, warning = FALSE, fig.cap="Titanic data"------------
ggplot(data = titanic, aes(x = Fare)) + 
  geom_histogram()

## ----eval = FALSE, fig.cap="A basic ggplot plot"-------------------------
## ggplot(data = titanic) +
##   geom_histogram(aes(x = Fare))

## ----eval = FALSE--------------------------------------------------------
## ggplot() +
##   geom_histogram(data = titanic, aes(x = Fare))

## ----eval = FALSE--------------------------------------------------------
## titanic %>%
##   ggplot() +
##   geom_histogram(aes(x = Fare))
## # or
## titanic %>%
##   ggplot(aes(x = Fare)) +
##   geom_histogram()

## ----eval = FALSE--------------------------------------------------------
## ggplot(titanic, aes(x = Fare)) +
##   geom_histogram(bins = 15)

## ----fig.width = 6, fig.height = 5, fig.cap="Scatterplot of Time and Passes from `worldcup` data"----
ggplot(worldcup, aes(x = Time, y = Passes)) + 
  geom_point()

## ----error = TRUE, eval = FALSE------------------------------------------
## ggplot(worldcup, aes(x = Time)) +
##   geom_point()

## ---- fig.cap="Using color and size to show Position and Shots"----------
ggplot(worldcup, aes(x = Time, y = Passes,
                     color = Position, size = Shots)) + 
  geom_point()

## ----geomtable, echo = FALSE---------------------------------------------
funcs <- c("`geom_point()`", "`geom_line()`", "`geom_segment()`",
           "`geom_path()`", "`geom_polygon()`", "`geom_histogram()`",
           "`geom_abline()`", "`geom_hline()`", "`geom_vline()`",
           "`geom_smooth()`", "`geom_text()`")
aesthetics <- c("`x`, `y`", "`x`, `y`", "`x`, `y`, `xend`, `yend`",
                "`x`, `y`", "`x`, `y`", "`x`",
                "`intercept`, `slope`", "`yintercept`", "`xintercept`",
                "`x`, `y`", "`x`, `y`, `label`")
arguments <- c("", "`arrow`, `na.rm`", "`arrow`, `na.rm`",
               "`na.rm`", "", "`bins`, `binwidth`", 
               "", "", "",
                "`method`, `se`, `span`",
               "`parse`, `nudge_x`, `nudge_y`")

knitr::kable(data.frame("function" = funcs,
                        "aesthetics" = aesthetics,
                        "arguments" = arguments),
             col.names = c("Function", "Common aesthetics", 
                           "Common arguments"),
             caption = "MVPs of geom functions", booktabs = TRUE)

## ----message = FALSE, warning = FALSE, fig.cap="Adding label points to a scatterplot"----
library(dplyr)
noteworthy_players <- worldcup %>% filter(Shots == max(Shots) | 
                                            Passes == max(Passes)) %>%
  mutate(point_label = paste(Team, Position, sep = ", "))

ggplot(worldcup, aes(x = Passes, y = Shots)) + 
  geom_point() + 
  geom_text(data = noteworthy_players, aes(label = point_label), 
            vjust = "inward", hjust = "inward") 

## ----fig.cap="Histogram with reference lines"----------------------------
ggplot(worldcup, aes(x = Time)) + 
        geom_histogram(binwidth = 10) + 
        geom_vline(xintercept = 90 * 0:6,
                   color = "blue", alpha = 0.5)

## ---- fig.cap="Using a constant color aesthetic"-------------------------
ggplot(worldcup, aes(x = Time, y = Passes)) + 
  geom_point(color = "darkgreen")

## ----shapeexamples, echo = FALSE, fig.width = 5, fig.height = 3, fig.cap = "Examples of the shapes corresponding to different numeric choices for the `shape` aesthetic. For all examples, `color` is set to black and `fill` to red."----
x <- rep(1:5, 5)
y <- rep(1:5, each = 5)
shape <- 1:25
to_plot <- data_frame(x = x, y = y, shape = shape)
ggplot(to_plot, aes(x = x, y = y)) + 
  geom_point(shape = shape, size = 4, color = "black", fill = "red") + 
  geom_text(label = shape, nudge_x = -0.25) +
  xlim(c(0.5, 5.5)) + 
  theme_void() + 
  scale_y_reverse()

## ----colorexamples, echo = FALSE, fig.width = 5, fig.height = 3, fig.cap = "Example of a few available shades of blue in R."----
x <- rep(0, 6)
y <- 1:6
color <- c("blue", "blue4", "darkorchid", "deepskyblue2", 
           "steelblue1", "dodgerblue3")
to_plot <- data_frame(x = x, y = y, color = color)
ggplot(to_plot, aes(x = x, y = y)) + 
  geom_point(color = color, size = 2) + 
  geom_text(label = color, hjust = 0, nudge_x = 0.05) + 
  theme_void() + 
  xlim(c(-1, 1.5)) +
  scale_y_reverse()

## ----echo = FALSE--------------------------------------------------------
plot_adds <- data.frame(add = c("`ggtitle`",
                                "`xlab`, `ylab`",
                                "`xlim`, `ylim`"),
                        descrip = c("Plot title",
                                    "x- and y-axis labels",
                                    "Limits of x- and y-axis"))
knitr::kable(plot_adds, col.names = c("Element", "Description"))

## ------------------------------------------------------------------------
# install.packages("faraway") ## Uncomment if you do not have the faraway package installed
library(faraway)
data(nepali)

## ----message = FALSE, fig.cap="Nepali data"------------------------------
nepali <- nepali %>%
  select(id, sex, wt, ht, age) %>%
  mutate(id = factor(id),
         sex = factor(sex, levels = c(1, 2),
                      labels = c("Male", "Female"))) %>%
  distinct(id, .keep_all = TRUE)

## ------------------------------------------------------------------------
head(nepali)

## ---- nepalihist1, fig.width = 4, fig.height = 3, message = FALSE, warning = FALSE, fig.cap = "Basic example of plotting a histogram with `ggplot2`. This histogram shows the distribution of heights for the first recorded measurements of each child in the `nepali` dataset."----
ggplot(nepali, aes(x = ht)) + 
  geom_histogram()

## ----nepalihist2, fig.width = 4, fig.height = 3, message = FALSE, warning = FALSE, fig.cap = "Example of adding ggplot elements to customize a histogram."----
ggplot(nepali, aes(x = ht)) + 
  geom_histogram(fill = "lightblue", color = "black") + 
  ggtitle("Height of children") + 
  xlab("Height (cm)") + xlim(c(0, 120))

## ----nepaliscatter1, fig.width = 5, fig.height = 4, warning = FALSE, fig.cap = "Example of creating a scatterplot. This scatterplot shows the relationship between children's heights and weights within the nepali dataset."----
ggplot(nepali, aes(x = ht, y = wt)) + 
  geom_point()

## ----nepaliscatter2, fig.width = 5, fig.height = 4, message = FALSE, warning = FALSE, fig.cap = "Example of adding ggplot elements to customize a scatterplot."----
ggplot(nepali, aes(x = ht, y = wt)) + 
  geom_point(color = "blue", size = 0.5) + 
  ggtitle("Weight versus Height") + 
  xlab("Height (cm)") + ylab("Weight (kg)")

## ----nepaliscatter3, fig.width = 5, fig.height = 4, message = FALSE, warning = FALSE, fig.cap = "Example of mapping color to an element of the data in a scatterplot."----
ggplot(nepali, aes(x = ht, y = wt, color = sex)) + 
  geom_point(size = 0.5) + 
  ggtitle("Weight versus Height") + 
  xlab("Height (cm)") + ylab("Weight (kg)")

## ----nepaliboxplot1, fig.height = 4, fig.width = 4, warning = FALSE, fig.cap = "Example of creating a boxplot. The example shows the distribution of height data for children in the nepali dataset."----
ggplot(nepali, aes(x = 1, y = ht)) + 
  geom_boxplot() + 
  xlab("")+ ylab("Height (cm)")

## ----nepaliboxplot2, fig.height = 4, fig.width = 5, warning = FALSE, fig.cap = "Example of creating separate boxplots, divided by a categorical grouping variable in the data."----
ggplot(nepali, aes(x = sex, y = ht)) + 
  geom_boxplot() + 
  xlab("Sex")+ ylab("Height (cm)") 

## ----ggallyexample, message = FALSE, warning = FALSE, fig.cap = "Example of using ggpairs from the GGally package for exploratory data analysis."----
library(GGally)
ggpairs(nepali %>% select(sex, wt, ht, age))

## ----message = FALSE-----------------------------------------------------
library(dplyr)
library(ggplot2)
library(gridExtra)
library(ggthemes)

## ----message = FALSE-----------------------------------------------------
# install.packages("faraway")  ## Uncomment and run if you do not have the `faraway` package installed
library(faraway)
data(nepali)
data(worldcup)

# install.packages("dlnm")     ## Uncomment and run if you do not have the `dlnm` package installed
library(dlnm)
data(chicagoNMMAPS)
chic <- chicagoNMMAPS
chic_july <- chic %>%
  filter(month == 7 & year == 1995)

## ----datainkratio1, echo = FALSE, fig.height = 3, fig.width = 8, fig.cap = "Example of plots with lower (left) and higher (right) data-to-ink ratios. Each plot shows the number of players in each position in the worldcup dataset from the faraway package."----
a <- ggplot(worldcup, aes(Position)) + 
        geom_bar() + coord_flip() + 
        ylab("Number of players") + 
        ggtitle("1. Lower data density")

ex <- group_by(worldcup, Position) %>%
        summarise(n = n())
b <- ggplot(ex, aes(x = n, y = Position)) + 
        geom_point() +  
        xlab("Number of players") +  ylab("") + 
        theme_few() + 
        xlim(0, 250) + 
        ggtitle("2. Higher data density")
grid.arrange(a, b, ncol = 2)

## ----datainkratio2, echo = FALSE, fig.height = 3, fig.width = 8, fig.cap = "Example of plots with lower (left) and higher (right) data-to-ink ratios. Each plot shows daily mortality in Chicago, IL, in July 1995 using the chicagoNMMAPS data from the dlnm package."----
a <- ggplot(chic_july, aes(x = date, y = death)) + 
        geom_area(fill = "black") + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_excel() + 
        ggtitle("1. Lower data density")

b <- ggplot(chic_july, aes(x = date,
                           y = death)) + 
        geom_line() + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_tufte() + 
        ggtitle("2. Higher data density")

grid.arrange(a, b, ncol = 2)

## ----fig.width = 5, fig.height = 3, fig.cap="Minimal theme"--------------
ggplot(worldcup, aes(x = Time, y = Shots)) + 
  geom_point() + 
  theme_classic()

## ----fig.width = 5, fig.height = 3, fig.cap="Tufte theme"----------------
library(ggthemes)
ggplot(worldcup, aes(x = Time, y = Shots)) + 
  geom_point() + 
  theme_tufte()

## ----themeexamples, echo = FALSE, fig.height = 9, fig.width = 8, fig.cap = "Daily mortality in Chicago, IL, in July 1995. This figure gives an example of the plot using different themes."----
chic_plot <- ggplot(chic_july, aes(x = date, y = death))  +
        geom_point(color = "red")
a <- chic_plot + ggtitle("Default theme")
b <- chic_plot + theme_bw() + ggtitle("`theme_bw`")
c <- chic_plot + theme_few() + ggtitle("`theme_few`")
d <- chic_plot + theme_tufte() + ggtitle("`theme_tufte`")
e <- chic_plot + theme_fivethirtyeight() +
  ggtitle("`theme_fivethirtyeight`")
f <- chic_plot + theme_solarized() + 
  ggtitle("`theme_solarized`")

grid.arrange(a, b, c, d, e, f, ncol = 2)

## ----eval = FALSE--------------------------------------------------------
## chicago_plot <- ggplot(chic_july, aes(x = date, y = death)) +
##   xlab("Day in July 1995") +
##   ylab("All-cause deaths") +
##   ylim(0, 450)
## 
## chicago_plot +
##   geom_area(fill = "black") +
##   theme_excel()
## 
## chicago_plot +
##   geom_line() +
##   theme_tufte()

## ----labelsexample, echo = FALSE, fig.height = 3, fig.width = 8, fig.cap = "The number of players in each position in the worldcup data from the faraway package. Both graphs show the same information, but the left graph has murkier labels, while the right graph has labels that are easier to read and interpret."----
ex <- worldcup
ex$Position <- factor(ex$Position, 
                      levels = c("Defender",
                                 "Forward",
                                 "Goalkeeper",
                                 "Midfielder"),
                      labels = c("DF", "FW",
                                 "GK", "MF"))
a <- ggplot(ex, aes(Position)) + 
        geom_bar() + 
        xlab("Pos") +
        ggtitle("1. Murkier labels") + 
        theme(axis.text.x = 
                      element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust=1))

b <- ggplot(worldcup, aes(Position)) + 
        geom_bar(fill = "lightgray") + coord_flip() + 
        ylab("Number of players") + xlab("") + 
        theme_tufte() + 
        ggtitle("2. Clearer labels")

grid.arrange(a, b, ncol = 2)

## ----eval = FALSE--------------------------------------------------------
## library(forcats)
## # Create a messier example version of the data
## wc_example_data <- worldcup %>%
##   dplyr::rename(Pos = Position) %>%
##   mutate(Pos = fct_recode(Pos,
##                           "DC" = "Defender",
##                           "FW" = "Forward",
##                           "GK" = "Goalkeeper",
##                           "MF" = "Midfielder"))
## 
## wc_example_data %>%
##   ggplot(aes(x = Pos)) +
##   geom_bar()
## 
## wc_example_data %>%
##   mutate(Pos = fct_recode(Pos,
##                           "Defender" = "DC",
##                           "Forward" = "FW",
##                           "Goalkeeper" = "GK",
##                           "Midfielder" = "MF")) %>%
##   ggplot(aes(x = Pos)) +
##   geom_bar(fill = "lightgray") +
##   xlab("") +
##   ylab("Number of players") +
##   coord_flip() +
##   theme_tufte()

## ----referenceexample1, echo = FALSE, fig.height = 3, fig.width = 8, fig.cap = "Daily mortality during July 1995 in Chicago, IL. In the graph on the right, we have added a shaded region showing the range of daily mortality counts for neighboring years, to show how unusual this event was."----
chic_july <- subset(chic, month == 7 & year == 1995)
chic_july_ref <- filter(chic, month == 7 & 
                        year %in% c(1990:1994,
                                    1996:2000)) %>%
        summarise(mean = mean(death),
                  min = min(death),
                  max = max(death))
ref_points <- data.frame(date = c(-2, 33, 33, -2),
        death = c(rep(chic_july_ref$max, 2),
                  rep(chic_july_ref$min, 2)))
        
a <- ggplot(chic_july, aes(x = as.POSIXlt(date)$mday,
                           y = death)) + 
        geom_line() + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_tufte() + 
        ggtitle("1. No reference")

b <- ggplot(chic_july, aes(x = as.POSIXlt(date)$mday,
                           y = death)) + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_tufte() + 
        geom_polygon(aes(x = date, y = death), 
                     data = ref_points,
                     color = "lightgray", 
                     alpha = 0.1) + 
        geom_line() + 
        ggtitle("2. Reference")

grid.arrange(a, b, ncol = 2)

## ----referenceexample2, echo = FALSE, message = FALSE, fig.width = 8, fig.height = 4, fig.cap = "Relationship between passes and shots taken among Forwards in the worldcup dataset from the faraway package. The plot on the right has a smooth function added to help show the relationship between these two variables."----
ex <- filter(worldcup, Position == "Forward")
a <- ggplot(ex, aes(x = Passes, y = Shots)) + 
        geom_point(size = 1.5) + 
        theme_few()  + 
        ggtitle("1. No reference")

b <- ggplot(ex, aes(x = Passes, y = Shots)) + 
        geom_point(size = 1.5) + 
        theme_few()  + 
        geom_smooth() + 
        ggtitle("2. Reference")

grid.arrange(a, b, ncol = 2)

## ----referenceexample3, message = FALSE, fig.width = 4, fig.height = 4, fig.cap = "Relationship between passes and shots taken among Forwards in the worldcup dataset from the faraway package. The plot has a smooth function added to help show the relationship between these two variables."----
ggplot(filter(worldcup, Position == "Forward"), aes(x = Passes, y = Shots)) + 
        geom_point(size = 1.5) + 
        theme_few()  + 
        geom_smooth()

## ----highlightexample1, echo = FALSE, fig.height = 3, fig.width = 8, fig.cap = "Mortality in Chicago, July 1995. In the plot on the right, a thick red line has been added to show the dates of a heat wave."----
chic_july <- subset(chic, month == 7 & year == 1995)
chic_july_ref <- filter(chic, month == 7 & 
                        year %in% c(1990:1994,
                                    1996:2000)) %>%
        summarise(mean = mean(death),
                  min = min(death),
                  max = max(death))
ref_points <- data.frame(date = c(-2, 33, 33, -2),
        death = c(rep(chic_july_ref$max, 2),
                  rep(chic_july_ref$min, 2)))
hw <- data.frame(date = c(12, 16, 16, 12),
                 death = c(425, 425, 0, 0))
        
a <- ggplot(chic_july, aes(x = as.POSIXlt(date)$mday,
                           y = death)) + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_tufte() + 
        geom_polygon(aes(x = date, y = death), 
                     data = ref_points,
                     color = "lightgray", 
                     alpha = 0.1) + 
        geom_line() + 
        ggtitle("1. No highlighting")

b <- ggplot(chic_july, aes(x = as.POSIXlt(date)$mday,
                           y = death)) + 
        xlab("Day in July 1995") + 
        ylab("All-cause deaths") + 
        ylim(0, 450) + 
        theme_tufte() + 
        geom_polygon(aes(x = date, y = death), 
                     data = ref_points,
                     color = "lightgray", 
                     alpha = 0.1) + 
        geom_line(aes(x = date, y = death),
                  data = hw[1:2, ],
                     color = "red",
                  size = 2) +
        geom_line() + 
        ggtitle("2. With highlighting")

grid.arrange(a, b, ncol = 2)

## ----highlightpoints, echo = FALSE, message = FALSE, fig.width = 8, fig.height = 4, fig.cap = "Passes versus shots for World Cup 2010 players. In the plot on the right, notable players have been highlighted."----
ex <- subset(worldcup, Position == "Forward")
a <- ggplot(ex, aes(x = Passes, y = Shots)) + 
        geom_point(size = 1.5, alpha = 0.5) + 
        theme_few()  + 
        ggtitle("1. No highlighting")

most_shots <- ex[which.max(ex$Shots), ]
most_passes <- ex[which.max(ex$Passes), ]
b <- ggplot(ex, aes(x = Passes, y = Shots)) + 
        geom_point(size = 1.5, alpha = 0.5) + 
        theme_few()  + 
        ggtitle("2. Highlighting") + 
        geom_text(data = most_shots,
           label = paste0(rownames(most_shots), ", ",
                                most_shots$Team, " "),
                  colour = "blue", size = 3,
                  hjust = 1, vjust = 0.4) + 
        geom_text(data = most_passes,
           label = paste(rownames(most_passes), ",",
                                most_passes$Team, " "),
                  colour = "blue", size = 3,
                  hjust = 1, vjust = 0.4) 

grid.arrange(a, b, ncol = 2)

## ------------------------------------------------------------------------
noteworthy_players <- worldcup %>%
  filter(Shots == max(Shots) | Passes == max(Passes)) %>%
  mutate(point_label = paste0(Team, Position, sep = ", "))
noteworthy_players

## ----fig.width = 4, fig.height = 4---------------------------------------
ggplot(worldcup, aes(x = Passes, y = Shots)) + 
  geom_point(alpha = 0.5) + 
  geom_text(data = noteworthy_players, aes(label = point_label),
            vjust = "inward", hjust = "inward", color = "blue") +
  theme_few()

## ----fig.height = 3, fig.width = 5, fig.cap="Shots vs. Time by Position"----
data(worldcup)
worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Position)) + 
  geom_point() 

## ----fig.height = 3, fig.width = 8, fig.cap="Small multiples with facet_grid"----
worldcup %>%
  ggplot(aes(x = Time, y = Shots)) + 
  geom_point() +
  facet_grid(. ~ Position) 

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## facet_grid([factor for rows] ~ [factor for columns])

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## facet_wrap(~ [formula with factor(s) for faceting],
##            ncol = [number of columns])

## ---- fig.cap="Faceting by Position and Team"----------------------------
worldcup %>%
  filter(Team %in% c("Spain", "Netherlands")) %>%
  ggplot(aes(x = Time, y = Shots)) + 
  geom_point() +
  facet_grid(Team ~ Position) 

## ----fig.height = 8, fig.width = 8, fig.cap="Using facet_wrap"-----------
worldcup %>%
  ggplot(aes(x = Time, y = Shots)) + 
  geom_point(alpha = 0.25) +
  facet_wrap(~ Team, ncol = 6) 

## ------------------------------------------------------------------------
nepali <- nepali %>%
  mutate(sex = factor(sex, levels = c(1, 2), 
                      labels = c("Male", "Female")))

## ----warning = FALSE, fig.width = 8, fig.height = 3, fig.cap="Facets with labeled factor"----
ggplot(nepali, aes(ht, wt)) + 
        geom_point() + 
        facet_grid(. ~ sex)

## ------------------------------------------------------------------------
nepali <- nepali %>%
  mutate(sex = factor(sex, levels = c("Female", "Male")))

## ----warning = FALSE, fig.width = 8, fig.height = 3, fig.cap="Facets with re-labeled factor"----
ggplot(nepali, aes(ht, wt)) + 
        geom_point() + 
        facet_grid(. ~ sex)

## ----plotorder, echo = FALSE, fig.width = 8, fig.height = 5, fig.cap = "Mean time per player in World Cup 2010 by team. The plot on the right has reordered teams to show patterns more clearly."----
ex <- group_by(worldcup, Team) %>%
        summarise(mean_time = mean(Time))

a <- ggplot(ex, aes(x = mean_time, y = Team)) + 
        geom_point() + 
        theme_few() + 
        xlab("Mean time per player (minutes)") + ylab("") + 
        ggtitle("1. Alphabetical order")

ex2 <- arrange(ex, mean_time) %>%
        mutate(Team = factor(Team, levels = Team))
b <- ggplot(ex2, aes(x = mean_time, y = Team)) + 
        geom_point() + 
        theme_few() + 
        xlab("Mean time per player (minutes)") +  ylab("") + 
        ggtitle("2. Meaningful order")

grid.arrange(a, b, ncol = 2)

## ----eval = FALSE--------------------------------------------------------
## ## Left plot
## worldcup %>%
##   group_by(Team) %>%
##   summarize(mean_time = mean(Time)) %>%
##   ggplot(aes(x = mean_time, y = Team)) +
##   geom_point() +
##   theme_few() +
##   xlab("Mean time per player (minutes)") + ylab("")
## 
## ## Right plot
## worldcup %>%
##   group_by(Team) %>%
##   summarize(mean_time = mean(Time)) %>%
##   arrange(mean_time) %>%                         # re-order and re-set
##   mutate(Team = factor(Team, levels = Team)) %>% # factor levels before plotting
##   ggplot(aes(x = mean_time, y = Team)) +
##   geom_point() +
##   theme_few() +
##   xlab("Mean time per player (minutes)") + ylab("")

## ----fig.height = 3, fig.width = 8, fig.cap="More customization in faceting"----
worldcup %>%
  select(Position, Time, Shots) %>%
  group_by(Position) %>%
  mutate(ave_shots = mean(Shots),
         most_shots = Shots == max(Shots)) %>%
  ungroup() %>%
  arrange(ave_shots) %>%
  mutate(Position = factor(Position, levels = unique(Position))) %>%
  ggplot(aes(x = Time, y = Shots, color = most_shots)) + 
  geom_point(alpha = 0.5) + 
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     guide = FALSE) + 
  facet_grid(. ~ Position) + 
  theme_few()

## ----fig.height = 10, fig.cap=""-----------------------------------------
worldcup %>%
  dplyr::select(Team, Time) %>%
  dplyr::group_by(Team) %>%
  dplyr::mutate(ave_time = mean(Time),
                min_time = min(Time),
                max_time = max(Time)) %>%
  dplyr::arrange(ave_time) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(Team = factor(Team, levels = unique(Team))) %>%
  ggplot(aes(x = Time, y = Team)) + 
  geom_segment(aes(x = min_time, xend = max_time, yend = Team),
               alpha = 0.5, color = "gray") + 
  geom_point(alpha = 0.5) + 
  geom_point(aes(x = ave_time), size = 2, color = "red", alpha = 0.5) + 
  theme_minimal() + 
  ylab("")

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## scale_[aesthetic]_[vector type]

## ----fig.width = 7, fig.height = 4, fig.cap=""---------------------------
ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) + 
  geom_point(alpha = 0.5)

## ----fig.width = 7, fig.height = 4, fig.cap=""---------------------------
ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) + 
  geom_point(alpha = 0.5) + 
  scale_x_continuous(name = "Time played (minutes)", 
                     breaks = 90 * c(2, 4, 6),
                     minor_breaks = 90 * c(1, 3, 5))

## ----fig.width = 7, fig.height = 4---------------------------------------
ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) + 
  geom_point(alpha = 0.5) + 
  scale_x_continuous(name = "Time played (minutes)", 
                     breaks = 90 * c(2, 4, 6),
                     minor_breaks = 90 * c(1, 3, 5)) + 
  scale_size_continuous(name = "Shots on goal",
                        breaks = c(0, 10, 20))

## ----echo = FALSE--------------------------------------------------------
scale_params <- data.frame(param = c("name",
                                     "breaks",
                                     "minor_breaks",
                                     "labels",
                                     "limits"),
                           desc = c("Label or legend name",
                                    "Vector of break points",
                                    "Vector of minor break points",
                                    "Labels to use for each break",
                                    "Limits to the range of the axis"))
knitr::kable(scale_params, col.names = c("Parameter", "Description"))

## ----fig.width = 5, fig.height = 2, fig.cap="Mortality in Chicago for July 1995"----
ggplot(chic_july, aes(x = date, y = death)) + 
  geom_line() 

## ----fig.width = 5, fig.height = 2, fig.cap="Mortality in Chicago for July 1995"----
ggplot(chic_july, aes(x = date, y = death)) + 
  geom_line() + 
  scale_x_date(name = "Date in July 1995",
               date_labels = "%m-%d")

## ----fig.width = 5, fig.height = 2, fig.cap="Transforming the y axis"----
ggplot(chic_july, aes(x = date, y = death)) + 
  geom_line() +
  scale_y_log10(breaks = c(1:4 * 100))

## ---- fig.show='hold', fig.height = 3, fig.width = 4, fig.cap="ColorBrewer palettes"----
library(RColorBrewer)
display.brewer.pal(name = "Set1", n = 8)
display.brewer.pal(name = "PRGn", n = 8)
display.brewer.pal(name = "PuBuGn", n = 8)

## ----fig.width = 10, fig.height = 7, fig.cap="Using ColorBrewer palettes"----
wc_example <- ggplot(worldcup, aes(x = Time, y = Passes,
                     color = Position, size = Shots)) + 
  geom_point(alpha = 0.5) 

a <- wc_example + 
  scale_color_brewer(palette = "Set1") + 
  ggtitle("Set1")
b <- wc_example + 
  scale_color_brewer(palette = "Dark2") + 
  ggtitle("Dark2")
c <- wc_example + 
  scale_color_brewer(palette = "Pastel2") + 
  ggtitle("Pastel2") + 
  theme_dark()
d <- wc_example + 
  scale_color_brewer(palette = "Accent") + 
  ggtitle("Accent")
grid.arrange(a, b, c, d, ncol = 2)

## ----fig.width = 7, fig.height = 4, fig.cap="Setting colors manually"----
ggplot(worldcup, aes(x = Time, y = Passes,
                     color = Position, size = Shots)) + 
  geom_point(alpha = 0.5) + 
  scale_color_manual(values = c("blue", "red", 
                                "darkgreen", "darkgray"))

## ---- fig.cap="Viridis color map"----------------------------------------
library(viridis)
worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Passes)) + 
  geom_point(size = 0.9) + 
  facet_wrap(~ Position) + 
  scale_color_viridis()

## ----fig.width = 8, fig.height = 4, fig.cap="Viridis discrete color map"----
worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Position)) + 
  geom_point(alpha = 0.7) + 
  scale_color_viridis(discrete = TRUE)

## ----fig.cap="Color maps included in viridis package"--------------------
library(gridExtra)

worldcup_ex <- worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Passes)) + 
  geom_point(size = 0.9) 

magma_plot <- worldcup_ex + 
  scale_color_viridis(option = "A") + 
  ggtitle("magma")
inferno_plot <- worldcup_ex + 
  scale_color_viridis(option = "B") + 
  ggtitle("inferno")
plasma_plot <- worldcup_ex + 
  scale_color_viridis(option = "C") + 
  ggtitle("plasma")
viridis_plot <- worldcup_ex + 
  scale_color_viridis(option = "D") + 
  ggtitle("viridis")

grid.arrange(magma_plot, inferno_plot, plasma_plot, viridis_plot, ncol = 2)

## ----cau, warning = FALSE, message = FALSE-------------------------------
library(ggplot2)
us_map <- map_data("state")
head(us_map, 3)

## ----cav, fig.width = 3.5, fig.height = 2.25, fig.cap="Map of Carolinas"----
us_map %>% 
  filter(region %in% c("north carolina", "south carolina")) %>%
  ggplot(aes(x = long, y = lat)) +
  geom_point()

## ----caw, fig.width = 3.5, fig.height = 2.25, fig.cap="Map of Carolinas"----
us_map %>% 
  filter(region %in% c("north carolina", "south carolina")) %>%
  ggplot(aes(x = long, y = lat)) +
  geom_path()

## ----cax, fig.width = 3.5, fig.height = 2.25, fig.cap="Map of Carolinas with grouping"----
us_map %>% 
  filter(region %in% c("north carolina", "south carolina")) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_path()

## ----caz, fig.width = 3.5, fig.height = 2.25, fig.cap="Set interior state colors"----
us_map %>% 
  filter(region %in% c("north carolina", "south carolina")) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "lightblue", color = "black")

## ----fig.width = 3.5, fig.height = 2.25, fig.cap="Remove background grid"----
us_map %>% 
  filter(region %in% c("north carolina", "south carolina")) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "lightblue", color = "black") + 
  theme_void()

## ----cbb, fig.width = 6.5, fig.height = 3.5, fig.cap="Map of entire U.S."----
us_map %>% 
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "lightblue", color = "black") + 
  theme_void()

## ------------------------------------------------------------------------
data(votes.repub)
head(votes.repub)

## ----fig.width = 6.75, fig.height = 3.5, message = FALSE, fig.cap="Choropleth of voting percentages"----
library(dplyr)
library(viridis)

votes.repub %>%
  tbl_df() %>%
  mutate(state = rownames(votes.repub),
         state = tolower(state)) %>%
  right_join(us_map, by = c("state" = "region")) %>%
  ggplot(aes(x = long, y = lat, group = group, fill = `1976`)) +
  geom_polygon(color = "black") + 
  theme_void() + 
  scale_fill_viridis(name = "Republican\nvotes (%)")

## ----cbc, message = FALSE------------------------------------------------
library(readr)
serial <- read_csv(paste0("https://raw.githubusercontent.com/",
                          "dgrtwo/serial-ggvis/master/input_data/",
                          "serial_podcast_data/serial_map_data.csv"))
head(serial, 3)

## ----cbd, message = FALSE, warning = FALSE-------------------------------
serial <- serial %>%
    mutate(long = -76.8854 + 0.00017022 * x,
           lat  = 39.23822 + 1.371014e-04 * y,
           tower = Type == "cell-site")
serial %>%
  slice(c(1:3, (n() - 3):(n())))

## ----cbf-----------------------------------------------------------------
maryland <- map_data('county', region = 'maryland')
head(maryland)

## ----cbg-----------------------------------------------------------------
baltimore <- maryland %>%
  filter(subregion %in% c("baltimore city", "baltimore"))
head(baltimore, 3)

## ----fig.width = 3.5, fig.height = 4, fig.cap="'Serial' data"------------
ggplot(baltimore, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "lightblue", color = "black") + 
  theme_void()

## ----fig.width = 4.2, fig.height = 4, fig.cap="'Serial' data"------------
ggplot(baltimore, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "lightblue", color = "black") + 
  geom_point(data = serial, aes(group = NULL, color = tower)) + 
  theme_void() + 
  scale_color_manual(name = "Cell tower", values = c("black", "red"))

## ----message = FALSE, warning = FALSE------------------------------------
## install.packages("ggmap")
library(ggmap)
beijing <- get_map("Beijing", zoom = 12)

## ----cby, message = FALSE, warning = FALSE, fig.width = 3.5, fig.height = 3.5,fig.cap="Map of Beijing"----
ggmap(beijing)

## ----message = FALSE, warning = FALSE, fig.width = 3.5, fig.cap="Map of Beijing", fig.height = 3.5----
ggmap(beijing) + 
  theme_void() + 
  ggtitle("Beijing, China")

## ----cca, message = FALSE, warning = FALSE, fig.cap="Arranging maps with gridExtra package", fig.width = 7, fig.height = 3----
map_1 <- get_map("Estes Park", zoom = 12,
                 source = "google", maptype = "terrain") %>%
  ggmap(extent = "device")

map_2 <- get_map("Estes Park", zoom = 12,
                 source = "stamen", maptype = "watercolor") %>%
  ggmap(extent = "device")

map_3 <- get_map("Estes Park", zoom = 12,
                 source = "google", maptype = "hybrid") %>%
  ggmap(extent = "device")

library(gridExtra)
grid.arrange(map_1, map_2, map_3, nrow = 1) 

## ----message = FALSE, fig.cap="Map based on latitude and longitude"------
get_map(c(2.35, 48.86), zoom = 10) %>%
  ggmap(extent = "device")

## ----message = FALSE, fig.cap="Adding ggplot elements to a map"----------
get_map("Baltimore County", zoom = 10, 
        source = "stamen", maptype = "toner") %>%
  ggmap() + 
  geom_polygon(data = baltimore, aes(x = long, y = lat, group = group),
               color = "navy", fill = "lightblue", alpha = 0.2) + 
  geom_point(data = serial, aes(x = long, y = lat, color = tower)) + 
  theme_void() + 
  scale_color_manual(name = "Cell tower", values = c("black", "red"))

## ----cch, message = FALSE, warning = FALSE-------------------------------
geocode("Supreme Court of the United States")

## ----cci, message = FALSE, warning = FALSE-------------------------------
geocode("1 First St NE, Washington, DC")

## ----ccj, message = FALSE, warning = FALSE-------------------------------
mapdist("Baltimore, MD",
        "1 First St NE, Washington, DC") %>%
  select(from, to, miles)

## ----message = FALSE-----------------------------------------------------
library(choroplethr)
library(choroplethrMaps)
data(df_pop_county)
df_pop_county %>% slice(1:3)

## ----message = FALSE, warning = FALSE, fig.cap="Population choropleth map of U.S."----
county_choropleth(df_pop_county)

## ----message = FALSE, warning = FALSE, fig.cap="Subset some U.S. states"----
county_choropleth(df_pop_county, state_zoom = c("colorado", "wyoming"))

## ----warning = FALSE, message = FALSE, fig.cap="Using a reference map"----
county_choropleth(df_pop_county, state_zoom = c("north carolina"),
                  reference_map = TRUE)

## ----message = FALSE-----------------------------------------------------
library(readr)
floyd_events <- read_csv("data/floyd_events.csv") 
floyd_events %>% slice(1:3)

## ----message = FALSE, warning = FALSE, fig.cap="Hurricane Floyd data"----
floyd_events %>% 
  group_by(fips) %>%
  dplyr::summarize(n_events = n()) %>%
  mutate(fips = as.numeric(fips)) %>%
  dplyr::rename(region = fips, 
         value = n_events) %>%
  county_choropleth(state_zoom = c("north carolina", "virginia"),
                    reference_map = TRUE)

## ----message = FALSE, warning = FALSE, fig.cap="Hurricane Floyd data with hurricane track"----
floyd_track <- read_csv("data/floyd_track.csv")

floyd_events %>% 
  dplyr::group_by(fips) %>%
  dplyr::summarize(flood = sum(grepl("Flood", type))) %>%
  dplyr::mutate(fips = as.numeric(fips)) %>%
  dplyr::rename(region = fips, 
                value = flood) %>%
  county_choropleth(state_zoom = c("north carolina", "maryland", 
                                   "delaware", "new jersey",
                                   "virginia", "south carolina",
                                   "pennsylvania", "new york",
                                   "connecticut", "massachusetts",
                                   "new hampshire", "vermont",
                                   "maine", "rhode island"),
                    reference_map = TRUE) + 
  geom_path(data = floyd_track, aes(x = -longitude, y = latitude,
                                    group = NA),
            color = "red")

## ----warning = FALSE-----------------------------------------------------
floyd_floods <- floyd_events %>% 
  filter(grepl("Flood", type)) %>%
  mutate(fips = as.numeric(fips)) %>%
  group_by(fips) %>%
  dplyr::summarize(value = 1) %>%
  ungroup() %>%
  dplyr::rename(region = fips) 

floyd_map <- CountyChoropleth$new(floyd_floods)

## ------------------------------------------------------------------------
floyd_map$set_zoom(c("north carolina", "maryland", 
                     "delaware", "new jersey",
                     "virginia", "south carolina",
                     "pennsylvania", "new york",
                     "connecticut", "massachusetts",
                     "new hampshire", "vermont",
                     "maine", "rhode island"))

## ----message = FALSE, warning = FALSE, fig.cap="Hurricane Floyd flooding"----
floyd_map$render()

## ------------------------------------------------------------------------
names(floyd_map)

## ----warning = FALSE, message = FALSE, fig.cap="Customizing county choropleth"----
floyd_map$add_state_outline <- TRUE
floyd_map$ggplot_scale <- scale_fill_manual(values = c("yellow"),
                                            guide = FALSE)
floyd_xlim <- floyd_map$get_bounding_box()[c(1, 3)]
floyd_ylim <- floyd_map$get_bounding_box()[c(2, 4)]

a <- floyd_map$render() + 
  geom_path(data = floyd_track, aes(x = -longitude, y = latitude,
                                    group = NA),
            color = "red", size = 2, alpha = 0.6) + 
            xlim(floyd_map$get_bounding_box()[c(1, 3)]) + 
            ylim(floyd_map$get_bounding_box()[c(2, 4)])
            
b <- floyd_map$render_with_reference_map() + 
  geom_path(data = floyd_track, aes(x = -longitude, y = latitude,
                                    group = NA),
            color = "red", size = 2, alpha = 0.6) + 
            xlim(floyd_xlim) + 
            ylim(floyd_ylim)
            
library(gridExtra)
grid.arrange(a, b, ncol = 2)

## ----message = FALSE, warning = FALSE------------------------------------
library(tigris)
library(sp)
denver_tracts <- tracts(state = "CO", county = 31, cb = TRUE)

## ------------------------------------------------------------------------
class(denver_tracts)

## ----fig.cap="Plot of Denver Census tracts", fig.width = 7, fig.height = 4----
plot(denver_tracts)

## ------------------------------------------------------------------------
bbox(denver_tracts)

## ------------------------------------------------------------------------
is.projected(denver_tracts)
proj4string(denver_tracts)

## ------------------------------------------------------------------------
head(denver_tracts@data)

## ----message = FALSE, warning = FALSE, fig.cap="Denver tracts with roads", fig.width = 7, fig.height = 4----
roads <- primary_roads()

plot(denver_tracts, col = "lightblue")
plot(roads, add = TRUE, col = "darkred")

## ----message = FALSE, warning = FALSE------------------------------------
denver_tracts_df <- fortify(denver_tracts)
denver_tracts_df %>%
  dplyr::select(1:4) %>% dplyr::slice(1:5)

## ----message = FALSE, warning = FALSE, fig.cap="Creating a map with ggplot2 functions"----
denver_tracts_df %>%
  ggplot(aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "lightblue", color = "black") + 
  theme_void()

## ------------------------------------------------------------------------
proj4string(denver_tracts)

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## proj4string(my_spatial_object) <- "+proj=longlat +datum=NAD83"

## ------------------------------------------------------------------------
library(sp)
CRS("+proj=longlat +datum=NAD27")
CRS("+init=epsg:28992")

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## my_spatial_object <- spTransform(my_spatial_object,
##                                  CRS = CRS("+init=epsg:4267"))

## ----eval = FALSE--------------------------------------------------------
## ## Generic code
## my_spatial_object <- spTransform(my_spatial_object,
##                                  CRS = proj4string(another_sp_object))

## ----fig.width = 8, fig.height = 9, fig.cap="Maps with different projections"----
usamap <- map_data("state") %>%
  ggplot(aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

map_1 <- usamap + coord_map() + ggtitle("default") 
map_2 <- usamap + coord_map("gilbert") + ggtitle("+ coord_map('gilbert')")
map_3 <- usamap + coord_map("conic", lat0 = 30) + 
  ggtitle("+ coord_map('conic', lat0 = 30)")

grid.arrange(map_1, map_2, map_3, ncol = 1)

## ------------------------------------------------------------------------
load("data/fars_colorado.RData")
driver_data %>% 
  dplyr::select(1:5) %>% dplyr::slice(1:5)

## ----message = FALSE, warning = FALSE, fig.cap="FARS data for Colorado"----
map_data("county", region = "Colorado") %>%
  ggplot(aes(x = long, y = lat, group = subregion)) + 
  geom_polygon(color = "gray", fill = NA) + 
  theme_void() + 
  geom_point(data = driver_data,
             aes(x = longitud, y = latitude, group = NULL),
             alpha = 0.5, size = 0.7) 

## ------------------------------------------------------------------------
library(stringr)
county_accidents <- driver_data %>%
  dplyr::mutate(county = str_pad(county, width = 3,
                          side = "left", pad = "0")) %>%
  tidyr::unite(region, state, county, sep = "") %>%
  dplyr::group_by(region) %>%
  dplyr::summarize(value = n()) %>%
  dplyr::mutate(region = as.numeric(region))
county_accidents %>% slice(1:4)

## ----warning = FALSE, message = FALSE, fig.width = 10, fig.height = 8, fig.cap="Choropleth of Colorado FARS data"----
county_choropleth(county_accidents, state_zoom = "colorado")

## ------------------------------------------------------------------------
denver_fars <- driver_data %>% 
  filter(county == 31)

## ------------------------------------------------------------------------
library(sp)
denver_fars_sp <- denver_fars 
coordinates(denver_fars_sp) <- c("longitud", "latitude")
proj4string(denver_fars_sp) <- CRS("+init=epsg:4326")

## ------------------------------------------------------------------------
class(denver_fars_sp)

## ------------------------------------------------------------------------
denver_tracts_proj <- spTransform(denver_tracts, 
                                  CRS("+init=epsg:26954"))
denver_fars_proj <- spTransform(denver_fars_sp, 
                                CRS(proj4string(denver_tracts_proj)))

## ----fig.cap="", fig.width = 10, fig.height = 8--------------------------
plot(denver_tracts_proj)
plot(denver_fars_proj, add = TRUE, col = "red", pch = 1)

## ----message = FALSE, warning = FALSE------------------------------------
library(GISTools)
tract_counts <- poly.counts(denver_fars_proj, denver_tracts_proj)
head(tract_counts)

## ----fig.width = 10, fig.height = 8, fig.cap="Choropleth of accident counts"----
choropleth(denver_tracts, tract_counts)

## ----message = FALSE, warning = FALSE------------------------------------
head(poly.areas(denver_tracts_proj))

## ----warning = FALSE, message = FALSE, fig.cap="Denver accidents adjusted for tract area", fig.width = 10, fig.height = 8----
choropleth(denver_tracts, 
           tract_counts / poly.areas(denver_tracts_proj))

## ----message = FALSE, fig.width = 10, fig.height = 8---------------------
library(raster)
bbox(denver_fars_sp)
denver_raster <- raster(xmn = -105.09, ymn = 39.60,
                        xmx = -104.71, ymx = 39.86,
                        res = 0.02)
den_acc_raster <- rasterize(geometry(denver_fars_sp),
                            denver_raster,
                            fun = "count")

## ---- fig.cap="Raster data"----------------------------------------------
image(den_acc_raster, col = terrain.colors(5))

## ----fig.width = 10, fig.height = 8, fig.cap="Overlaying raster data"----
plot(denver_tracts)
plot(den_acc_raster, add = TRUE, alpha = 0.5)

## ----fig.width = 6, fig.height = 4, fig.cap="Plotly plot", message = FALSE, warning = FALSE----
library(faraway) 
data(worldcup)
library(plotly)

plot_ly(worldcup, type = "scatter",
        x = ~ Time, y = ~ Shots, color = ~ Position)

## ----message = FALSE, warning = FALSE, fig.cap="Plotly scatterplot with fixed color"----
plot_ly(worldcup, type = "scatter",
        x = ~ Time, y = ~ Shots, color = I("blue"))

## ---- fig.cap="Scatterplot with point markers"---------------------------
worldcup %>%
  mutate(Name = rownames(worldcup)) %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
  add_markers(text = ~ Name, hoverinfo = "text")

## ---- fig.cap="Customized text labels"-----------------------------------
worldcup %>%
  mutate(Name = rownames(worldcup)) %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
  add_markers(text = ~ paste("<b>Name:</b> ", Name, "<br />", 
                             "<b>Team:</b> ", Team),
              hoverinfo = "text")

## ----eval = FALSE--------------------------------------------------------
## worldcup %>%
##   plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
##   add_markers()

## ----message = FALSE, fig.cap="Max wind over time for Hurricane Floyd"----
read_csv("data/floyd_track.csv") %>%
  plot_ly(x = ~ datetime, y = ~ max_wind) %>% 
  add_lines() %>%
  rangeslider()

## ---- fig.cap="3-D scatterplot"------------------------------------------
worldcup %>%
  plot_ly(x = ~ Time, y = ~ Shots, z = ~ Passes,
          color = ~ Position, size = I(3)) %>%
  add_markers()

## ------------------------------------------------------------------------
class(volcano)
volcano[1:4, 1:4]

## ---- fig.cap="3-D surface plot"-----------------------------------------
plot_ly(z = ~ volcano, type = "surface")

## ----fig.cap="Using ggplotly"--------------------------------------------
worldcup_scatter <- worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Position)) + 
  geom_point() 
ggplotly(worldcup_scatter)

## ----message = FALSE-----------------------------------------------------
library(tigris)
denver_tracts <- tracts(state = "CO", county = 31, cb = TRUE)
load("data/fars_colorado.RData")
denver_fars <- driver_data %>% 
  filter(county == 31 & longitud < -104.5)

## ----fig.width = 7, fig.height = 3, fig.cap="Blank Leaflet plot"---------
library(leaflet)
leaflet()

## ---- fig.cap="Leaflet global map"---------------------------------------
leaflet() %>%
  addTiles()

## ---- fig.cap="Denver FARS data in Leaflet"------------------------------
leaflet() %>%
  addTiles() %>%
  addMarkers(data = denver_fars, lng = ~ longitud, lat = ~ latitude)

## ---- fig.cap="Customizing markers in Leaflet"---------------------------
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = denver_fars, radius = 2,
                   lng = ~ longitud, lat = ~ latitude)

## ----fig.cap="Clustering markers"----------------------------------------
leaflet() %>%
  addTiles() %>%
  addMarkers(data = denver_fars, 
                   lng = ~ longitud, lat = ~ latitude,
                   clusterOptions = markerClusterOptions())

## ---- fig.cap="Alternate background map tiles"---------------------------
leaflet() %>%
  addProviderTiles("Stamen.Watercolor") %>%
  addCircleMarkers(data = denver_fars, radius = 2,
                   lng = ~ longitud, lat = ~ latitude)

## ---- fig.cap="Thunderforest TransportDark tiles"------------------------
leaflet() %>%
  addProviderTiles("Thunderforest.TransportDark") %>%
  addCircleMarkers(data = denver_fars, radius = 2, color = I("red"),
                   lng = ~ longitud, lat = ~ latitude)

## ---- fig.cap="Adding interactive pop-ups"-------------------------------
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = denver_fars, radius = 2, 
                   lng = ~ longitud, lat = ~ latitude,
                   popup = ~ paste(age))

## ---- fig.cap="Adding HTML to pop-ups"-----------------------------------
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data = denver_fars, radius = 2, 
                   lng = ~ longitud, lat = ~ latitude,
                   popup = ~ paste("<b>Driver age:</b>", age))

## ---- fig.cap="Storing pop-up data in data frame"------------------------
denver_fars <- denver_fars %>%
  mutate(popup_info = paste("<b>Driver age:</b>", age, "<br />",
                            "<b>Date:</b>", format(date, "%Y-%m-%d"), "<br />",
                            "<b>Time:</b>", format(date, "%H:%M"), "<br />"),
         popup_info = ifelse(!is.na(alc_res),
                             paste(popup_info,
                                   "<b>Blood alcohol</b>", alc_res, "<br />"),
                             popup_info)) 

denver_fars %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = 2, lng = ~ longitud, lat = ~ latitude,
                   popup = ~ popup_info)

## ---- fig.cap="Custom colors with colorFactor"---------------------------
library(viridis)
pal <- colorFactor(viridis(5), denver_fars$drunk_dr)
leaflet() %>%
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
  addCircleMarkers(data = denver_fars, radius = 2,
                   lng = ~ longitud, lat = ~ latitude,
                   popup = ~ popup_info,
                   color = ~ pal(drunk_dr)) 

## ----fig.cap="Adding a color legend"-------------------------------------
library(viridis)
pal <- colorFactor(viridis(5), denver_fars$drunk_dr)
leaflet() %>%
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
  addCircleMarkers(data = denver_fars, radius = 2,
                   lng = ~ longitud, lat = ~ latitude,
                   popup = ~ popup_info,
                   color = ~ pal(drunk_dr)) %>%
  addLegend(pal = pal, values = denver_fars$drunk_dr)

## ---- fig.cap="Adding polygons to a map"---------------------------------
leaflet() %>%
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
  addPolygons(data = denver_tracts)

## ----fig.cap="Pop-up data for polygons"----------------------------------
leaflet() %>%
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
  addPolygons(data = denver_tracts, 
              popup = paste0("Tract ID:  ", denver_tracts@data$NAME))

## ---- fig.cap="Overlaying multiple elements"-----------------------------
leaflet() %>%
  addProviderTiles("Thunderforest.Transport") %>%
  addPolygons(data = denver_tracts,
              popup = paste0("Tract ID:  ", denver_tracts@data$NAME),
              color = "#000000", fillColor = "969696", 
              weight = 2) %>%
  addCircleMarkers(data = denver_fars, lat = ~ latitude, 
                   lng = ~ longitud, radius = 2,
                   popup = ~ popup_info, opacity = 0.9,
                   color = ~ pal(drunk_dr)) %>%
  addLegend(pal = pal, values = denver_fars$drunk_dr, opacity = 0.9)

## ---- fig.cap="Adding layer options"-------------------------------------
leaflet() %>%
  addProviderTiles("Thunderforest.Transport") %>%
  addPolygons(data = denver_tracts,
              popup = paste0("Tract ID:  ", denver_tracts@data$NAME),
              color = "#000000", fillColor = "969696", 
              weight = 2, group = "tracts") %>%
  addCircleMarkers(data = denver_fars, lat = ~ latitude, 
                   lng = ~ longitud, radius = 2,
                   popup = ~ popup_info, opacity = 0.9,
                   color = ~ pal(drunk_dr),
                   group = "accidents") %>%
  addLegend(pal = pal, values = denver_fars$drunk_dr, opacity = 0.9) %>%
  addLayersControl(baseGroups = c("base map"), 
                   overlayGroups = c("tracts", "accidents"))

## ------------------------------------------------------------------------
library(grid)
my_circle <- circleGrob(x = 0.5, y = 0.5, r = 0.5,
                        gp = gpar(col = "gray", lty = 3))

## ----fig.height = 3, width = 5, fig.cap = "Grid circle"------------------
grid.draw(my_circle)

## ----fig.height = 3, width = 5, fig.cap="Grid objects"-------------------
my_circle <- circleGrob(name = "my_circle",
                        x = 0.5, y = 0.5, r = 0.5,
                        gp = gpar(col = "gray", lty = 3))
grid.draw(my_circle)

my_rect <- rectGrob(x = 0.5, y = 0.5, width = 0.8, height = 0.3)
grid.draw(my_rect)

grid.edit("my_circle", gp = gpar(col = "red", lty = 1))

## ----fig.height = 3, width = 4, fig.cap="Grid scatterplot"---------------
wc_plot <- ggplot(worldcup, aes(x = Time, y = Passes)) + 
  geom_point()
grid.draw(wc_plot)

## ----fig.height = 3, width = 4, fig.cap="Adding ggplot objects to grid plots"----
grid.draw(wc_plot)
grid.draw(my_circle)

## ----eval = FALSE, fig.cap=""--------------------------------------------
## wc_plot
## grid.force()
## grid.ls()

## ----eval = FALSE--------------------------------------------------------
## grid.edit("geom_point.points.1400", gp = gpar(col = "red"))
## grid.edit("GRID.text.1419", gp = gpar(fontface = "bold"))

## ----fig.height = 3, width = 5, fig.cap="Adding a lollipop"--------------
candy <- circleGrob(r = 0.1, x = 0.5, y = 0.6)
stick <- segmentsGrob(x0 = 0.5, x1 = 0.5, y0 = 0, y1 = 0.5)
lollipop <- gTree(children = gList(candy, stick))
grid.draw(lollipop)

## ------------------------------------------------------------------------
grid.ls(lollipop)

## ----fig.height = 3, width = 5, fig.cap="Using viewports in grid"--------
grid.draw(rectGrob())
sample_vp <- viewport(x = 0.5, y = 0.5, 
                      width = 0.5, height = 0.5,
                      just = c("left", "bottom"))
pushViewport(sample_vp)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

## ----fig.height = 3, width = 5, fig.cap=""-------------------------------
grid.draw(rectGrob())
sample_vp <- viewport(x = 0.5, y = 0.5, 
                      width = 0.5, height = 0.5,
                      just = c("center", "center"))
pushViewport(sample_vp)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

## ----fig.height = 3, width = 5, fig.cap=""-------------------------------
grid.draw(rectGrob())
sample_vp <- viewport(x = 0.75, y = 0.75, 
                      width = 0.25, height = 0.25,
                      just = c("left", "bottom"))
pushViewport(sample_vp)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

## ----fig.height = 3, width = 5, fig.cap="Multiple viewports"-------------
grid.draw(rectGrob())

sample_vp_1 <- viewport(x = 0.75, y = 0.75, 
                      width = 0.25, height = 0.25,
                      just = c("left", "bottom"))
pushViewport(sample_vp_1)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

sample_vp_2 <- viewport(x = 0, y = 0, 
                      width = 0.5, height = 0.5,
                      just = c("left", "bottom"))
pushViewport(sample_vp_2)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

## ----fig.height = 3, width = 5, fig.cap="Nested viewports"---------------
grid.draw(rectGrob())

sample_vp_1 <- viewport(x = 0.5, y = 0.5, 
                      width = 0.5, height = 0.5,
                      just = c("left", "bottom"))
sample_vp_2 <- viewport(x = 0.1, y = 0.1, 
                      width = 0.4, height = 0.4,
                      just = c("left", "bottom"))

pushViewport(sample_vp_1)
grid.draw(roundrectGrob(gp = gpar(col = "red")))
pushViewport(sample_vp_2)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport(2)

## ----fig.height = 3, width = 5, fig.cap=""-------------------------------
grid.draw(rectGrob())

sample_vp_1 <- viewport(x = 0.5, y = 0.5, 
                      width = 0.5, height = 0.5,
                      just = c("left", "bottom"))
pushViewport(sample_vp_1)
grid.draw(roundrectGrob())
grid.draw(lollipop)
popViewport()

grid.ls()

## ---- fig.cap=""---------------------------------------------------------
worldcup %>%
  ggplot(aes(x = Time, y = Passes)) + 
  geom_point()
grid.force()
grid.ls()

## ----message = FALSE, fig.cap="Adding an inset map"----------------------
balt_counties <- map_data("county", region = "maryland") %>%
  mutate(our_counties = subregion %in% c("baltimore", "baltimore city"))
balt_map <- get_map("Baltimore County", zoom = 10) %>%
  ggmap(extent = "device") + 
  geom_polygon(data = filter(balt_counties, our_counties == TRUE),
               aes(x = long, y = lat, group = group),
               fill = "red", color = "darkred", alpha = 0.2)
maryland_map <- balt_counties %>%
  ggplot(aes(x = long, y = lat, group = group, fill = our_counties)) + 
  geom_polygon(color = "black") + 
  scale_fill_manual(values = c("white", "darkred"), guide = FALSE) + 
  theme_void() + 
  coord_map()

grid.draw(ggplotGrob(balt_map))
md_inset <- viewport(x = 0, y = 0, 
                     just = c("left", "bottom"),
                     width = 0.35, height = 0.35)
pushViewport(md_inset)
grid.draw(rectGrob(gp = gpar(alpha = 0.5, col = "white")))
grid.draw(rectGrob(gp = gpar(fill = NA, col = "black")))
grid.draw(ggplotGrob(maryland_map))
popViewport()

## ----fig.height = 3, width = 5, fig.cap="Specifying coordinate systems"----
ex_vp <- viewport(x = 0.5, y = 0.5, 
                  just = c("center", "center"),
                  height = 0.8, width = 0.8,
                  xscale = c(0, 100), yscale = c(0, 10))
pushViewport(ex_vp)
grid.draw(rectGrob())
grid.draw(circleGrob(x = unit(20, "native"), y = unit(5, "native"),
                     r = 0.1, gp = gpar(fill = "lightblue")))
grid.draw(circleGrob(x = unit(85, "native"), y = unit(8, "native"),
                     r = 0.1, gp = gpar(fill = "darkred")))
popViewport()

## ----fig.height = 3, width = 5, fig.cap="Using grid.arrange()"-----------
library(gridExtra)
grid.arrange(lollipop, circleGrob(),
             rectGrob(), lollipop, 
             ncol = 2)

## ----fig.width = 7, fig.height = 3, fig.cap="Using grid.arrange()"-------
time_vs_shots <- ggplot(worldcup, aes(x = Time, y = Shots)) + 
  geom_point()
player_positions <- ggplot(worldcup, aes(x = Position)) + 
  geom_bar()

grid.arrange(time_vs_shots, player_positions, ncol = 2)

## ----fig.width = 7, fig.height = 3, fig.cap="Arranging multiple plots in a matrix"----
grid.arrange(time_vs_shots, player_positions,
             layout_matrix = matrix(c(1, 2, 2), ncol = 3))

## ---- fig.cap="Adding blank space to a matrix of plots"------------------
grid.arrange(time_vs_shots, player_positions,
             layout_matrix = matrix(c(1, NA, NA, NA, 2, 2), 
                                    byrow = TRUE, ncol = 3))

## ------------------------------------------------------------------------
worldcup_table <- worldcup %>%
  filter(Team %in% c("Germany", "Spain", "Netherlands", "Uruguay")) %>%
  group_by(Team) %>%
  dplyr::summarize(`Average time` = round(mean(Time), 1),
                   `Average shots` = round(mean(Shots), 1)) %>%
  tableGrob()

grid.draw(ggplotGrob(time_vs_shots))
wc_table_vp <- viewport(x = 0.22, y = 0.85, 
                        just = c("left", "top"),
                        height = 0.1, width = 0.2)
pushViewport(wc_table_vp)
grid.draw(worldcup_table)
popViewport()

## ---- fig.cap="Classic theme"--------------------------------------------
library(ggplot2)
ggplot(data = mtcars, aes(x = disp, y = mpg)) + 
        geom_point() + 
        theme_classic()

## ------------------------------------------------------------------------
x <- theme_get()
class(x)

## ------------------------------------------------------------------------
new_theme <- theme_minimal()
theme_set(new_theme)

## ---- fig.cap="Using new default theme"----------------------------------
ggplot(data = mtcars, aes(disp, mpg)) + 
        geom_point() + 
        facet_grid( . ~ gear)

## ----eval=FALSE----------------------------------------------------------
## setHook(packageEvent("ggplot2", "onLoad"),
##         function(...) ggplot2::theme_set(ggplot2::theme_minimal()))

## ------------------------------------------------------------------------
newtheme <- theme_bw() + theme(plot.title = element_text(color = "darkred"))

## ------------------------------------------------------------------------
newtheme$panel.border

## ------------------------------------------------------------------------
newtheme <- newtheme + 
        theme(panel.border = element_rect(color = "steelblue", size = 2))

## ---- fig.cap="Revised theme"--------------------------------------------
library(faraway)
ggplot(data = worldcup, aes(Time, Shots)) + 
        geom_point() + 
        ggtitle("World Cup Data") + 
        newtheme

## ---- fig.cap="Faceting with revised theme"------------------------------
ggplot(data = worldcup, aes(Time, Shots)) + 
        geom_point() + 
        facet_wrap(facets = ~ Position, ncol = 2) + 
        ggtitle("World Cup Data") + 
        newtheme

## ------------------------------------------------------------------------
library(grid)
GeomMyPoint <- ggproto("GeomMyPoint", Geom,
        required_aes = c("x", "y"),
        default_aes = aes(shape = 1),
        draw_key = draw_key_point,
        draw_panel = function(data, panel_scales, coord) {
                ## Transform the data first
                coords <- coord$transform(data, panel_scales)
                
                ## Let's print out the structure of the 'coords' object
                str(coords)
                
                ## Construct a grid grob
                pointsGrob(
                        x = coords$x,
                        y = coords$y,
                        pch = coords$shape
                )
        })

## ------------------------------------------------------------------------
geom_mypoint <- function(mapping = NULL, data = NULL, stat = "identity",
                         position = "identity", na.rm = FALSE, 
                         show.legend = NA, inherit.aes = TRUE, ...) {
        ggplot2::layer(
                geom = GeomMyPoint, mapping = mapping,  
                data = data, stat = stat, position = position, 
                show.legend = show.legend, inherit.aes = inherit.aes,
                params = list(na.rm = na.rm, ...)
        )
}

## ---- fig.cap="Using a custom geom"--------------------------------------
ggplot(data = worldcup, aes(Time, Shots)) + geom_mypoint()

## ------------------------------------------------------------------------
GeomAutoTransparent <- ggproto("GeomAutoTransparent", Geom,
        required_aes = c("x", "y"),
        default_aes = aes(shape = 19),
        draw_key = draw_key_point,
        draw_panel = function(data, panel_scales, coord) {
                ## Transform the data first
                coords <- coord$transform(data, panel_scales)
                
                ## Compute the alpha transparency factor based on the
                ## number of data points being plotted
                n <- nrow(data)
                if(n > 100 && n <= 200)
                        coords$alpha <- 0.3
                else if(n > 200)
                        coords$alpha <- 0.15
                else
                        coords$alpha <- 1
                ## Construct a grid grob
                grid::pointsGrob(
                        x = coords$x,
                        y = coords$y,
                        pch = coords$shape,
                        gp = grid::gpar(alpha = coords$alpha)
                )
        })

## ------------------------------------------------------------------------
geom_transparent <- function(mapping = NULL, data = NULL, stat = "identity",
                         position = "identity", na.rm = FALSE, 
                         show.legend = NA, inherit.aes = TRUE, ...) {
        ggplot2::layer(
                geom = GeomAutoTransparent, mapping = mapping,  
                data = data, stat = stat, position = position, 
                show.legend = show.legend, inherit.aes = inherit.aes,
                params = list(na.rm = na.rm, ...)
        )
}

## ----include=FALSE-------------------------------------------------------
set.seed(100)

## ---- fig.cap="Scatterplot with auto transparency geom"------------------
ggplot(data = worldcup, aes(Time, Shots)) + geom_transparent()

## ---- fig.cap="Scatterplot with auto transparency geom"------------------
library(dplyr)
ggplot(data = sample_n(worldcup, 150), aes(Time, Shots)) +
        geom_transparent()

## ---- fig.cap="Scatterplot with auto transparency geom"------------------
ggplot(data = sample_n(worldcup, 50), aes(Time, Shots)) + 
        geom_transparent()

## ---- fig.cap="Faceted plot with auto transparency geom"-----------------
ggplot(data = worldcup, aes(Time, Shots)) + 
        geom_transparent() + 
        facet_wrap(~ Position, ncol = 2) + 
        newtheme

