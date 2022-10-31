mosaic_gg <-
function(tbl){
  tbl_df <- tbl %>%
  as.data.frame
  N <- length(levels(tbl_df[, 1]))
#> data for mosaic coordinates
  tbl_p_df <- tbl %>%
    prop.table %>%
    as.data.frame
  tbl_p_m <- tbl_df %>%
    `[`(, 3) %>%
    tapply(tbl_df[, 2], sum) %>%
    prop.table
  tbl_p_df$width <- tbl_p_m[match(tbl_p_df[, 2], names(tbl_p_m))]
  tbl_p_df$height <- tbl %>%
    prop.table(margin = 2) %>%
    as.data.frame %>%
    `[`(, 3)
  tbl_p_df$label_height <- unlist(tapply(tbl_p_df$height, 
                                         tbl_p_df[, 2], 
                                         function(x) cumsum(x) - x / 2))
  tbl_p_df$y_breaks <- unlist(tapply(tbl_p_df$height, 
                                     tbl_p_df[, 2], 
                                     cumsum))
  x_center <- cumsum(tbl_p_m) - tbl_p_m / 2
  tbl_p_df$center <- x_center[match(tbl_p_df[, 2], names(x_center))]
#> 
#> breaks and labels
  x_breaks <- c(0, ifelse(cumsum(tbl_p_m) < 0.1, 0.0, cumsum(tbl_p_m)))
  x_label <- format(x_breaks * 100, 
                    digits = 3, 
                    nsmall = 1)
  y_breaks <- tbl_p_df$y_breaks
  delta <- (max(y_breaks) - min(y_breaks)) / 20
  y_breaks_sort <- sort(y_breaks)
  diff(y_breaks_sort) < delta 
  index <- which(diff(y_breaks_sort)  > delta)
  y_breaks <- c(0, y_breaks_sort[c(index, length(y_breaks_sort))])
  y_label <- format(y_breaks * 100,
                    digits = 2,
                    nsmall = 1)
#> 
  ggplot(tbl_p_df, 
         aes(x = center, 
             y = height, 
             width = width)) + 
    geom_bar(aes(fill = tbl_df[, 1]), 
             stat = "identity", 
             col = "white", 
             size = 1, 
             position = position_stack(reverse = TRUE)) +
    geom_text(aes(x = center, 
                  y = 1.05), 
              label = tbl_p_df[, 2]) +
    geom_text(aes(x = center, 
                  y = label_height), 
              label = format(ifelse(tbl_df[, 3] == 0, "", tbl_df[, 3]), 
                             big.mark = ","), 
              position = position_identity()) +
    scale_x_continuous(breaks = x_breaks, 
                       label = x_label) + 
    scale_y_continuous(breaks = y_breaks,
                       label = y_label) + 
    theme(plot.margin = unit(c(1, 2, 1, 1), "lines"))
}
