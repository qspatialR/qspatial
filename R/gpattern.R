
gpattern = function(shapefile, longitude = longitude, latitude = latitude, nsim = 99){

  # Creating the ppp object
  pattern = spatstat::ppp(longitude, latitude, window = as.owin2(shapefile))
  pattern = spatstat::as.ppp(pattern) # removing the events outside the specified window
  pattern = spatstat::unique.ppp(pattern) # removing duplicates

  # CSR envelope for the G function

  genv = spatstat::envelope(pattern, Gest, nsim = nsim)
  ggplot2::ggplot(data.frame(genv), aes(x = r)) +
    ggplot2::ggtitle("G function") +
    ggplot2::geom_line(aes(y = lo), col='grey') +
    ggplot2::geom_line(aes(y = hi), col='grey') +
    ggplot2::geom_ribbon(aes(ymin = lo - 0.01, ymax = hi + 0.01), alpha = 0.75, fill = 'grey') +
    ggplot2::geom_line(aes(y = theo), col = 'red') +
    ggplot2::geom_line(aes(y = obs)) +
    ggplot2::ylab("G(r)") + ggplot2::xlab("r") +
    theme_qspatial()
}

