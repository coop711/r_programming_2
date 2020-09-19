barplot_gg <-
  function(x, position){
    switch(position,
           stack = barplot_gg_stack(x),
           dodge = barplot_gg_dodge(x),
           fill = barplot_gg_fill(x))
}
barplot_gg_stack <-
  function(df){
    Fill <- df[, 1]
    x <- df[, 2]
    Counts <- df[, 3]
    y <- unlist(tapply(df[, 3], 
                       INDEX = x, 
                       FUN = function(x){cumsum(x) - x / 2}))
    y_breaks <- unlist(tapply(df[, 3], 
                              INDEX = x, 
                              FUN = cumsum))
    y_label <- format(y_breaks, big.mark = ",")
##########
    delta <- (max(y_breaks) - min(y_breaks)) / 20
    y_breaks_sort <- sort(y_breaks)
    diff(y_breaks_sort) < delta 
    index <- which(diff(y_breaks_sort)  > delta)
    y_breaks <- c(0, y_breaks_sort[c(index, length(y_breaks_sort))])
    y_label <- format(y_breaks, big.mark = ",")
##########
    ggplot(df, aes(x = x, y = Counts, fill = Fill)) +
      geom_bar(stat = "identity", 
               position = position_stack(reverse = TRUE), 
               na.rm = TRUE) +
      scale_y_continuous(breaks = y_breaks, labels = y_label) +
      geom_text(aes(y = y), 
                label = format(ifelse(df[, 3] == 0, "", df[, 3]), big.mark = ","), 
                position = "identity",
                na.rm = TRUE)
}
barplot_gg_dodge <- 
  function(df){
    Fill <- df[, 1]
    x <- df[, 2]
    Counts <- df[, 3]
#    y_dodge <- df[, 3]
#    y_label <- unlist(tapply(df[, 3], df[, 2], rev))
#    y_label <- df[, 3]
    ggplot(df, aes(x = x, y = Counts, fill = Fill)) +
      geom_bar(stat = "identity", 
               position = "dodge", 
               na.rm = TRUE) +
      scale_y_continuous(breaks = Counts,
                         labels = format(Counts, big.mark = ",")) +
      geom_text(aes(y = Counts / 2), 
                label = ifelse(Counts == 0, "", Counts),
                position = position_dodge(width = 0.9),
                na.rm = TRUE)
}
barplot_gg_fill <-
  function(df){
    Fill <- df[, 1]
    x <- df[, 2]
    Counts <- df[, 3]
    y_fill <- unlist(tapply(df[, 3], 
                            INDEX = x, 
                            FUN = function(x){cumsum(x) / sum(x)}))
    p_fill <- unlist(tapply(df[, 3], 
                            INDEX = x, 
                            FUN = function(x){(cumsum(x) - x / 2) / sum(x)}))
    ggplot(df, aes(x = x, y = Counts, fill = Fill)) +
      geom_bar(stat = "identity", 
               position = position_fill(reverse = TRUE), 
               na.rm = TRUE) +
      scale_y_continuous(breaks = y_fill,
                         labels = format(y_fill * 100, digits = 2, nsmall = 1)) +
      geom_text(aes(y = p_fill), 
                label = format(ifelse(df[, 3] == 0, "", df[, 3]), big.mark = ","), 
                position = "identity",
                na.rm = TRUE) 
}
