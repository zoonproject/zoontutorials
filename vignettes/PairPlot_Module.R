

MyCovariates <- cov[,c('pcCon', 'pcDec', 'pcMix', 'pcGr')]

PairPlot <- function(MyCovariates){
  panel.cor <- function(x, y, digits = 2, cex.cor, ...)
  {
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    # correlation coefficient
    r <- cor(x, y)
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste("r= ", txt, sep = "")
    text(0.5, 0.6, txt)

    # p-value calculation
    p <- cor.test(x, y)$p.value
    txt2 <- format(c(p, 0.123456789), digits = digits)[1]
    txt2 <- paste("p= ", txt2, sep = "")
    if(p<0.01) txt2 <- paste("p= ", "<0.01", sep = "")
    text(0.5, 0.4, txt2)
  }
    return(pairs(x, upper.panel = panel.cor))
}


PairPlot(MyCovariates)






