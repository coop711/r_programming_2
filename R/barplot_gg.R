barplot_gg <-
function(x, 
                       position){
  switch(position,
         stack = barplot_gg_stack(x),
         dodge = barplot_gg_dodge(x),
         fill = barplot_gg_fill(x))
}
barplot_gg_stack <-
function(df){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y <- unlist(tapply(df[, 3], 
                   x, 
                   function(x){cumsum(x) - x / 2}))
y_breaks <- unlist(tapply(df[, 3], 
                          x, 
                          cumsum))
y_label <- format(y_breaks, big.mark = ",")
delta <- (max(y_breaks) - min(y_breaks)) / 20
y_breaks_sort <- sort(y_breaks)
diff(y_breaks_sort) < delta 
index <- which(diff(y_breaks_sort)  > delta)
y_breaks <- c(0, y_breaks_sort[c(index, length(y_breaks_sort))])
y_label <- format(y_breaks, big.mark = ",")
ggplot(df, 
       aes(x = x, 
           y = df[, 3], 
           fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = position_stack(reverse = TRUE)) +
  scale_y_continuous(breaks = y_breaks,
                     labels = y_label) +
  geom_text(aes(y = y), 
            label = format(ifelse(df[, 3] == 0, "", df[, 3]), 
                           big.mark = ","), 
            position = "identity")
}
barplot_gg_dodge <-
function(df){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y_dodge <- df[, 3] / 2
y_label < df[, 3]
ggplot(df, aes(x = x, 
               y = df[, 3], 
               fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = "dodge") +
  scale_y_continuous(breaks = y_label,
                     labels = format(y_label, big.mark = ",")) +
#  N <- nrow(df)
#  index <- as.vector(matrix(1:N, nrow = 2)[2:1, ])
# y_label <- unlist(tapply(df[, 3], 
#                          df[, 2],
#                          rev))
  geom_text(aes(y = y_dodge), 
#            label = format(df[index, "Freq"], big.mark = ","), 
            label = ifelse(y_label == 0, "", y_label),
            position = position_dodge(width = 0.9))
}
barplot_gg_fill <-
function(df){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y_fill <- unlist(tapply(df[, 3], 
                        x, 
                        function(x){cumsum(x) / sum(x)}))
p_fill <- unlist(tapply(df[, 3], 
                        x, 
                        function(x){(cumsum(x) - x / 2) / sum(x)}))
ggplot(df, aes(x = x, 
               y = df[, 3], 
               fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = position_fill(reverse = TRUE)) +
  scale_y_continuous(breaks = y_fill,
                     labels = format(y_fill * 100,
                                     digits = 2,
                                     nsmall = 1)) +
  geom_text(aes(y = p_fill), 
            label = format(ifelse(df[, 3] == 0, "", df[, 3]), 
                           big.mark = ","), 
            position = "identity")
}
