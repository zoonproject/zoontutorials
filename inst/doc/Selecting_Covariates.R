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

## ----packages, message = FALSE, warning = FALSE--------------------------
library(zoon)

## ----workflow, message = FALSE, warning = FALSE--------------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PrintOccurrenceMap)

## ----Clean, eval=FALSE---------------------------------------------------
#  process = Clean(which = c(1,2,3))

## ----StandardiseCov, eval=FALSE------------------------------------------
#  process = StandardiseCov() # default form
#  
#  process = StandardiseCov(Gelman = TRUE,
#                           exclude = c("VarB", "VarC"))

## ----eval=FALSE----------------------------------------------------------
#  process = Transform(trans = function(x) {x^2},
#                      which_cov = "VarA",
#                      replace = FALSE)

## ----eval=FALSE----------------------------------------------------------
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
#  process = addInteraction(which.covs = 'pairs')

## ----Interaction_Pair, eval=FALSE----------------------------------------
#  process = addInteraction(which.covs = c("A","B"))   # adds an interaction between A & B

## ----Interaction_MultPairs, eval=FALSE-----------------------------------
#  process = addInteraction(which.covs = list(c("A","B"), c("A","C")))   # adds interactions between A & B and A & C, but not B & C

## ----Interaction_Three-way, eval=FALSE-----------------------------------
#  process = addInteraction(which.covs = c(A,B,C))   # adds all two-way (e.g. A & B) interactions and a three-way interaction between A, B & C

## ----eval=FALSE----------------------------------------------------------
#  process = addInteractions(which.covs = c(A,A))   # leads to a quadratic polynomial
#  
#  process = addInteractions(which.covs = c(A,A,A))   # leads to a cubic, polynomial

