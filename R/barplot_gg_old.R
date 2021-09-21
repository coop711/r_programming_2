barplot_gg <-
function(x, 
                       position, 
                       base_family = "KoPubWorldDotum Medium", 
                       ggtitle = "", 
                       xlab = "", 
                       ylab = "", 
                       fill_name = ""){
  switch(position,
         stack = barplot_gg_stack(x, 
                                  base_family = base_family, 
                                  ggtitle = ggtitle, 
                                  xlab = xlab, 
                                  ylab = ylab, 
                                  fill_name = fill_name),
         dodge = barplot_gg_dodge(x, 
                                  base_family = base_family, 
                                  ggtitle = ggtitle, 
                                  xlab = xlab, 
                                  ylab = ylab, 
                                  fill_name = fill_name),
         fill = barplot_gg_fill(x, 
                                base_family = base_family, 
                                ggtitle = ggtitle, 
                                xlab = xlab, 
                                ylab = ylab, 
                                fill_name = fill_name))
}
barplot_gg_stack <-
function(df, 
                             base_family = "KoPubWorldDotum Medium", 
                             ggtitle = "", 
                             xlab = "", 
                             ylab = "", 
                             fill_name = ""){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y <- unlist(tapply(df[, 3], 
                   x, 
                   function(x){x / 2 + c(0, cumsum(head(x, -1)))}))
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
b1 <- ggplot(df, 
             aes(x = x, 
                 y = df[, 3], 
                 fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = position_stack(reverse = TRUE))
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme_kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y_breaks,
                     labels = y_label) +
  scale_fill_manual(name = fill_name, 
                    values = rainbow(n_fill)[n_fill:1], 
                    labels = df[, 1], 
                    guide = guide_legend())
b3 <- b2 +
  geom_text(aes(y = y), 
            label = format(ifelse(df[, 3] == 0, "", df[, 3]), 
                           big.mark = ","), 
            position = "identity") +
  ggtitle(ggtitle)
return(b3)
}
barplot_gg_dodge <-
function(df, 
                             base_family = "KoPubWorldDotum Medium", 
                             ggtitle = "", 
                             xlab = "", 
                             ylab = "", 
                             fill_name = ""){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y_dodge <- df[, 3]
b1 <- ggplot(df, 
             aes(x = x, 
                 y = df[, 3], 
                 fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = "dodge")
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme_kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y_dodge,
                     labels = format(y_dodge, big.mark = ",")) +
  scale_fill_manual(name = fill_name, 
                    values = rainbow(n_fill)[n_fill:1], 
                    labels = df[, 1])
#  N <- nrow(df)
#  index <- as.vector(matrix(1:N, nrow = 2)[2:1, ])
y_label <- unlist(tapply(df[, 3], 
                         df[, 2],
                         rev))
b3 <- b2 +
  geom_text(aes(y = y_dodge / 2), 
#            label = format(df[index, "Freq"], big.mark = ","), 
            label = ifelse(y_label == 0, "", y_label),
            position = position_dodge(width = 0.9)) +
  ggtitle(ggtitle)
return(b3)
}
barplot_gg_fill <-
function(df, 
                            base_family = "KoPubWorldDotum Medium", 
                            ggtitle = "", 
                            xlab = "", 
                            ylab = "", 
                            fill_name = ""){
n_fill <- length(levels(df[, 1]))
x <- df[, 2]
y_fill <- unlist(tapply(df[, 3], 
                   x, 
                   function(x){cumsum(x) / sum(x)}))
p_fill <- unlist(tapply(df[, 3], 
                        x, 
                        function(x){(cumsum(x) - x / 2) / sum(x)}))
#                         function(x){(x / 2 + c(0, cumsum(head(x, -1))))/sum(x)}))
b1 <- ggplot(df, 
             aes(x = x, 
                 y = df[, 3], 
                 fill = df[, 1])) +
  geom_bar(stat = "identity", 
           position = position_fill(reverse = TRUE))
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme_kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y_fill,
                     labels = format(y_fill * 100,
                                     digits = 2,
                                     nsmall = 1)) +
  scale_fill_manual(name = fill_name, 
                    values = rainbow(n_fill)[n_fill:1], 
                    labels = df[, 1], 
                    guide = guide_legend())
b3 <- b2 +
  geom_text(aes(y = p_fill), 
            label = format(ifelse(df[, 3] == 0, "", df[, 3]), 
                           big.mark = ","), 
            position = "identity") +
  ggtitle(ggtitle)
return(b3)
}
