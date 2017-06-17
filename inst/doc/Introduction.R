## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = F, out.width= '100%', fig.align = "center", fig.cap="*Figure 1. Species Distribution Modelling aims: ecological inference (a; figure from @redfern17, photo from @cetus), predicting current species' distributions (b; figure from @pigott14), or mapping future distributions (c; figure from @elith10, photo from @fraser-smith).*"----
knitr::include_graphics("../vignettes/Images/Figure_1_litSDM.png")

