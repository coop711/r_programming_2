library(HistData)
SnowMap(xlim = c(3, 20), ylim = c(3, 20), 
        axis.labels = FALSE, main = "Snow's Cholera Map of London", 
        scale = TRUE, polygons = FALSE, density=FALSE,
        streets.args = list(col = "grey", lwd = 1), 
        deaths.args = list(col = "red", pch = 15, cex = 0.6), 
        pumps.args = list(col = "blue", pch = 17, cex = 1.5, cex.lab = 0.9), 
        scale.args = list(xs = 3.5, ys = 19.7), 
        polygons.args = list(col = NA, border = "brown", lwd = 2, lty = 1),
        density.args = list(bandwidth = c(0.5, 0.5), 
                            col1 = rgb(0, 1, 0, 0),
                            col2 = rgb(1, 0, 0, .8))
)

Splot(xlim = c(3, 20), ylim = c(3, 20), 
     xlab = "", ylab = "", 
     axis.labels = FALSE, 
     main = "Snow's Cholera Map of London")

Sdeaths(col = "red", pch = 15, cex = 0.6)

Spumps(col = "blue", pch = 17, cex = 1.5, cex.lab = 0.9)

Sstreets(col = "gray", lwd = 1)

Sscale(xs = 3.5, ys = 19.7)

Spolygons(col=NA, border="brown", lwd=2, lty=1)

Sdensity(bandwidth = c(0.5, 0.5), col1 = rgb(0, 1, 0, 0), col2 = rgb(1, 0, 0, 0.8))
