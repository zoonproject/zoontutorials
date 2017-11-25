## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE, 
               comment = '')

## ----clean workflow, eval = FALSE----------------------------------------
#  Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                     covariate = CarolinaWrenRasters,
#                                     process = Chain(Background(1000),
#                                                     Clean(which = c(1,2,3))),
#                                     model = NullModel,
#                                     output = NoOutput)

## ----StandardiseCov, warning=FALSE, message=FALSE------------------------
workflow_standardised <- workflow(CarolinaWrenPO,
                                  CarolinaWrenRasters,
                                  Chain(Background(1000),
                                        StandardiseCov),
                                  NullModel,
                                  NoOutput)

## ------------------------------------------------------------------------
summary(Covariate(workflow_standardised))

## ------------------------------------------------------------------------
summary(Process(workflow_standardised)$ras)

## ------------------------------------------------------------------------
summary(scale(Covariate(workflow_standardised)))

## ---- eval=FALSE---------------------------------------------------------
#  process = Transform(trans = function(x) {x^2},
#                      which_cov = "VarA",
#                      replace = FALSE)

## ---- eval=FALSE---------------------------------------------------------
#  process = Transform(trans = function(x) {log(x)},
#                      which_cov = c("VarA", "VarB", "VarC"),
#                      replace = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  process = Chain(Transform(trans = function(x) {x^2},
#                            which_cov = c("VarA", "VarB"),
#                            replace = FALSE),
#                  Transform(trans = function(x) {log(x)},
#                            which_cov = c("VarC", "VarD")))

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which_covs = c('A', 'A'))   # leads to a quadratic polynomial
#  
#  process = addInteraction(which_covs = c('A', 'A', 'A'))   # leads to a cubic, polynomial

