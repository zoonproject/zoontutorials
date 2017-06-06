## ----message = F, warning = F--------------------------------------------
library(zoon)
library(lattice)

## ----model, warning = F--------------------------------------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = LogisticRegression,
                                   output = PrintMap)

## ------------------------------------------------------------------------
cov <- Process(Carolina_Wren_Workflow)$df
levels(cov) <- c('background', 'presence')
str(cov)

## ------------------------------------------------------------------------
table(cov$type)

## ------------------------------------------
par(mfrow = c(4, 1), mar = c(3, 4, 1, 1))
dotchart(cov$pcCon, main= "Percent Coniferous")
dotchart(cov$pcDec, main= "Percent Deciduous")
dotchart(cov$pcMix, main= "Percent Mixed Forest")
dotchart(cov$pcGr, main= "Percent Grassland")
dev.off()

## ------------------------------------------
# RELATIONSHIPS?
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

 pairs(cov[,c('pcCon', 'pcDec', 'pcMix', 'pcGr')], upper.panel = panel.cor)

## ------------------------------------------
# Covariate effects
par(mfrow = c(1, 1), mar = c(5, 5, 2, 2), cex.lab = 1.5)
boxplot(cov$pcCon ~ type,
        varwidth = TRUE,
        data = cov,
        xlab     = "Data Type",
        ylab     = "Percent Coniferous")
abline(h = mean(cov$pcCon, na.rm = TRUE),
       lty = 2)

