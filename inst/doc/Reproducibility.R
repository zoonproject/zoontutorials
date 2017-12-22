## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = TRUE, echo = FALSE, message = FALSE, warning = FALSE---------
library(zoon)

## ----example, eval = TRUE, echo = TRUE, message = FALSE, warning = FALSE, fig.show='hide'----
example <- workflow(occurrence = SpOcc(species = "Ursus arctos",
                                       extent = c(-175, -65, 20, 75),
                                       databases = "gbif",
                                       type = "presence"),
                    covariate = Bioclim(extent = c(-175, -65, 20, 75),
                                        resolution = 10,
                                        layers = 1:19),
                    process = Chain(Clean,
                                    Background(1000),            
                                    StandardiseCov,              
                                    Crossvalidate(k = 5)),       
                    model = list(LogisticRegression,             
                                 MaxNet,
                                 RandomForest),
                    output = Chain(PrintMap,
                                   PerformanceMeasures),
                    forceReproducible = TRUE)

## ----eval = TRUE, echo = FALSE, message = FALSE, warning = FALSE---------
plot(example)

## ----eval = TRUE, echo = TRUE--------------------------------------------
example$call

## ----eval = TRUE, echo = TRUE--------------------------------------------
example$session.info

## ----eval = TRUE, echo = TRUE--------------------------------------------
example$module.versions

## ----save, eval = FALSE--------------------------------------------------
#  save(example, file = 'workflow.RData')

## ----load, eval = FALSE--------------------------------------------------
#  load('workflow.RData')

## ----eval = FALSE, echo = TRUE, message=FALSE, warning=FALSE-------------
#  RerunWorkflow(example)

## ----eval = FALSE--------------------------------------------------------
#  ZoonFigshare(zoonWorkflow = example,
#               title = "Example",
#               description = "Our example workflow",
#               authors = "Zoon Team",
#               categories = "ecology",
#               tags = c("ecology", "zoon", "species distribution model"))

