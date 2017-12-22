## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE, 
               comment = '')

## ----echo = F, out.width= '400px', fig.align = "center", fig.cap="*Figure 1. Conceptual flowchart for process modules in covariates selection and reparation.*"----
knitr::include_graphics("../vignettes/Images/SelectCov_ConceptualDiagram.png")

## ----packages, message = FALSE, warning = FALSE, echo = FALSE------------
library(zoon)

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

## ----Interaction_AllPairs, eval=FALSE------------------------------------
#  # All pairwise interactions
#  
#  process = addInteraction(which_covs = 'pairs')

## ----Interaction_Pair, eval=FALSE----------------------------------------
#  # Adds an interaction between A & B
#  
#  process = addInteraction(which_covs = c("A", "B"))

## ----Interaction_MultPairs, eval=FALSE-----------------------------------
#  # Adds interactions between A & B and A & C, but not B & C
#  
#  process = addInteraction(which_covs = list(c("A","B"), c("A","C")))

## ----Interaction_Three-way, eval=FALSE-----------------------------------
#  # Adds all two-way (e.g. A & B) interactions and a three-way
#  # interaction between A, B & C
#  
#  process = addInteraction(which_covs = c('A', 'B', 'C'))

## ----eval=FALSE----------------------------------------------------------
#  # Adds a quadratic polynomial
#  
#  process = addInteraction(which_covs = c('A', 'A'))
#  
#  # Adds a cubic polynomial
#  
#  process = addInteraction(which_covs = c('A', 'A', 'A'))

