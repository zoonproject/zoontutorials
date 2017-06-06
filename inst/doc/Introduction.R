## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = F, out.width= '650px', fig.align = "center", fig.cap="*Figure 1. Species Distribution Modelling aims: ecological inference (a; figure from (@redfern17), photo from (@cetus)), predicting current species' distributions (b; figure from (@pigott14)), or mapping future distributions (c; figure from (@elith10), photo from (@fraser-smith)).*"----
knitr::include_graphics("../vignettes/Images/Figure_1_litSDM.png")

## ----echo = F, out.width= '650px', fig.align = "center", fig.cap="*Figure 2. Species Distribution Model Theory. Presence-background points plotted on geographic space and on environmental space (top panel; P = presence, B = background), and probability of occurrence predictions plotted on environmental and geographic space (bottom panel; colour scale represents probability of occurrence).*"----
knitr::include_graphics("../vignettes/Images/Figure_2_SDMtheory.png")

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

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                occurrence = SpOcc("Thryothorus ludovicianus",
                                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)))

## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----eval=TRUE, cache=TRUE-----------------------------------------------
Covariate(zoon_workflow)   # Before standardisation

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                process = Chain(StandardiseCov, Background(n = 1000)))

## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                model = LogisticRegression)


## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7, cache=TRUE----

zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                output = InteractiveMap)


## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
#  zoon_workflow <- ChangeWorkflow(zoon_workflow,
#                                  output = ResponsePlot())

## ----echo=FALSE, eval=TRUE, cache = TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
par(mfrow=c(2,3))
zoon_workflow <- ChangeWorkflow(zoon_workflow,
                                output = ResponsePlot())

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
Dual_Model_Workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                                process = Background(1000),
                                model = list(LogisticRegression, MaxEnt),
                                output = PrintMap(points = FALSE))

## ----eval = FALSE--------------------------------------------------------
#  save(Dual_Model_Workflow,
#       file = 'Dual_Model_Workflow.RData')

## ----eval = FALSE--------------------------------------------------------
#  load('Dual_Model_Workflow.RData')

