library(HistData)
library(knitr)
library(pander)
library(magrittr)
library(tidyverse)
options(digits = 3)
PolioTrials
str(PolioTrials)
plot(PolioTrials)
tapply(PolioTrials$Population, PolioTrials$Experiment, sum)
PolioTrials$Experiment %<>% 
  factor(levels = c("RandomizedControl", "ObservedControl"))
PolioTrials$Cases <- PolioTrials$Paralytic + PolioTrials$NonParalytic
PolioTrials$Rates <- PolioTrials$Cases / PolioTrials$Population * 100000
PolioTrials$Widths <- tapply(PolioTrials$Population, 
                             PolioTrials$Experiment,
                             FUN = function(x) x / sum(x)) %>%
  unlist %>%
  unname
levels(PolioTrials$Group) <- list(Vaccinated = "Vaccinated",
                                  Controls = c("Controls", "Placebo"), 
                                  NoConsent = c("NotInoculated", "Grade2NotInoculated"), 
                                  Incomplete = "IncompleteVaccinations")
PolioTrials[, c("Experiment", "Group", "Rates")]
Polio <- subset(PolioTrials, Group != "Incomplete", select = c(1:3, 7:9))
ggplot(data = Polio, 
       mapping = aes(x = Experiment, 
                     y = Rates, 
                     fill = Group)) +
  geom_bar(stat = "identity", 
           position = position_dodge2(), 
           color = "black") +
  scale_fill_brewer(type = "qual", palette = "Accent")
