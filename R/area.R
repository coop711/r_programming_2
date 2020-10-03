area_R <-
function(x, y) {
  sum(diff(x) * (head(y, -1) + tail(y, -1))/2)
  }
