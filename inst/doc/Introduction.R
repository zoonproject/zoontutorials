## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = FALSE, out.width= 700, fig.cap="*Figure 1. Species Distribution Model Theory. Presence-background points plotted on geographic space, on environmental space, and probability of occurrence predictions plotted on environmental and geographic space.*", fig.align = "left"----
knitr::include_graphics("../vignettes/Images/SDM_theory.png")

## ----message=FALSE, warning=FALSE, cache=TRUE----------------------------
library(zoon)

## ----message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
zoon_workflow <- workflow(occurrence = CarolinaWrenPO,
                          covariate = CarolinaWrenRasters,
                          process = Background(100),
                          model = MaxEnt,
                          output = InteractiveMap)

## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE-----------------
head(Occurrence(zoon_workflow))

## ----eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE-----------------
Covariate(zoon_workflow)

