## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----Decision_Tree_Image, echo = FALSE, fig.cap="*Figure 1. A single decision tree (upper panel), with a response Y, two predictor variables, X1 and X2 and split points t1 , t2 , etc. The bottom panel shows its prediction surface (after Hastie et al. 2001). Image sourced from @elith11", fig.align = "centre"----
knitr::include_graphics("../vignettes/Images/Decision_Tree_Elith.jpg")

