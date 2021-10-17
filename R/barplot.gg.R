barplot.gg <-
function(x, 
                       position, 
                       base_family = "", 
                       ggtitle = "", 
                       xlab = "", 
                       ylab = "", 
                       fill.name = ""){
  switch(position,
         stack = barplot.gg.stack(x, 
                                  base_family = base_family, 
                                  ggtitle = ggtitle, 
                                  xlab = xlab, 
                                  ylab = ylab, 
                                  fill.name = fill.name),
         dodge = barplot.gg.dodge(x, 
                                  base_family = base_family, 
                                  ggtitle = ggtitle, 
                                  xlab = xlab, 
                                  ylab = ylab, 
                                  fill.name = fill.name),
         fill = barplot.gg.fill(x, 
                                base_family = base_family, 
                                ggtitle = ggtitle, 
                                xlab = xlab, 
                                ylab = ylab, 
                                fill.name = fill.name))
}
barplot.gg.stack <-
function(df, 
                             base_family = "", 
                             ggtitle = "", 
                             xlab = "", 
                             ylab = "", 
                             fill.name = ""){
n.fill <- length(levels(df[, 1]))
x <- df[, 2]
y <- unlist(tapply(df$Freq, 
                   x, 
                   function(x){x / 2 + c(0, cumsum(head(x, -1)))}))
y.breaks <- y
# delta <- (max(y.breaks) - min(y.breaks)) / 20
# y.breaks.sort <- sort(y.breaks)
# diff(y.breaks.sort) < delta 
# index <- which(diff(y.breaks.sort)  > delta)
# y.breaks <- c(0, y.breaks.sort[c(index, length(y.breaks.sort))])
y.label <- format(y.breaks, big.mark = ",")
b1 <- ggplot(df, 
             aes(x = x, 
                 y = Freq, 
                 fill = vote)) +
  geom_bar(stat = "identity", 
           position = position_stack(reverse = TRUE))
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme.kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y.breaks,
                     labels = y.label) +
  scale_fill_manual(name = fill.name, 
                    values = rainbow(n.fill)[n.fill:1], 
                    labels = df$vote, 
                    guide = guide_legend())
b3 <- b2 +
  geom_text(aes(y = y), 
            label = format(df$Freq, 
                           big.mark = ","), 
            position = "identity") +
  ggtitle(ggtitle)
return(b3)
}
barplot.gg.dodge <-
function(df, 
                             base_family = "", 
                             ggtitle = "", 
                             xlab = "", 
                             ylab = "", 
                             fill.name = ""){
n.fill <- length(levels(df[, 1]))
x <- df[, 2]
y.dodge <- df$Freq
b1 <- ggplot(df, 
             aes(x = x, 
                 y = Freq, 
                 fill = vote)) +
  geom_bar(stat = "identity", 
           position = "dodge")
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme.kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y.dodge,
                     labels = format(y.dodge, big.mark = ",")) +
  scale_fill_manual(name = fill.name, 
                    values = rainbow(n.fill)[n.fill:1], 
                    labels = df$vote)
#  N <- nrow(df)
#  index <- as.vector(matrix(1:N, nrow = 2)[2:1, ])
y.label <- unlist(tapply(df$Freq, 
                         df[, 2],
                         rev))
b3 <- b2 +
  geom_text(aes(y = y.dodge/2), 
#            label = format(df[index, "Freq"], big.mark = ","), 
            label = format(y.label, digits = 0, big.mark = ","),
            position = position_dodge(width = 0.9)) +
  ggtitle(ggtitle)
return(b3)
}
barplot.gg.fill <-
function(df, 
                            base_family = "", 
                            ggtitle = "", 
                            xlab = "", 
                            ylab = "", 
                            fill.name = ""){
n.fill <- length(levels(df[, 1]))
x <- df[, 2]
y.fill <- unlist(tapply(df$Freq, 
                   x, 
                   function(x){cumsum(x)/sum(x)}))
p.fill <- unlist(tapply(df$Freq, 
                        x, 
                        function(x){(x / 2 + c(0, cumsum(head(x, -1))))/sum(x)}))
b1 <- ggplot(df, 
             aes(x = x, 
                 y = Freq, 
                 fill = vote)) +
  geom_bar(stat = "identity", 
           position = position_fill(reverse = TRUE))
b2 <- b1 +
  theme_bw(base_family = base_family) +
#  theme.kr +
  scale_x_discrete(name = xlab) +
  scale_y_continuous(name = ylab, 
                     breaks = y.fill,
                     labels = format(y.fill * 100,
                                     digits = 2,
                                     nsmall = 1)) +
  scale_fill_manual(name = fill.name, 
                    values = rainbow(n.fill)[n.fill:1], 
                    labels = df$vote, 
                    guide = guide_legend())
b3 <- b2 +
  geom_text(aes(y = p.fill), 
            label = format(df$Freq, big.mark = ","), 
            position = "identity") +
  ggtitle(ggtitle)
return(b3)
}
