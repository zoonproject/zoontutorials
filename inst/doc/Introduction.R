## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)


## ----echo = F, out.width= 700--------------------------------------------
#knitr::include_graphics("../vignettes/Intro_Module_files/SDM_theory.png")

## ----message=FALSE, warning=FALSE, cache=TRUE----------------------------
library(zoon)

## ----message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
zoon_workflow <- workflow(occurrence = SpOcc("Yucca brevifolia", extent = c(-119, -113, 34, 39)),
                          covariate = Bioclim(extent = c(-120, -112, 33, 40)),
                          process = Background(100),
                          model = RandomForest,
                          output = PrintMap)

## ----eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE-----------------
head(Occurrence(zoon_workflow))

## ----eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE-----------------
Covariate(zoon_workflow)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                occurrence = CarolinaWrenPO,
                                covariate = CarolinaWrenRasters)

## ----eval=TRUE, cache=TRUE-----------------------------------------------
Covariate(zoon_workflow)   # Before standardisation

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                process = Chain(Background(n=100), StandardiseCov))


## ----eval=TRUE, cache=TRUE-----------------------------------------------
Covariate(zoon_workflow)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                process = Chain(StandardiseCov, Background(n = 100)))

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                model = LogisticRegression)


## ------------------------------------------------------------------------

zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                output = InteractiveMap)


## ----hidden chunk to embed interative map in html------------------------



## ------------------------------------------------------------------------
zoon_workflow <- ChangeWorkflow(zoon_workflow,
                                output = ResponseCurveViz(1:4))

## ------------------------------------------------------------------------
zoon_workflow <- ChangeWorkflow(zoon_workflow,
                                output = ROCcurve)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
Dual_Model_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                covariate = CarolinaWrenRasters,
                                process = Background(1000),
                                model = list(LogisticRegression, MaxEnt),
                                output = PrintMap(points = FALSE))

