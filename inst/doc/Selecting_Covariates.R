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
#  process = addInteraction(which_covs = 'pairs')

## ----Interaction_Pair, eval=FALSE----------------------------------------
#  process = addInteraction(which_covs = c("A", "B"))   # adds an interaction between A & B

## ----Interaction_MultPairs, eval=FALSE-----------------------------------
#  process = addInteraction(which_covs = list(c("A","B"), c("A","C")))   # adds interactions between A & B and A & C, but not B & C

## ----Interaction_Three-way, eval=FALSE-----------------------------------
#  process = addInteraction(which_covs = c('A', 'B', 'C'))   # adds all two-way (e.g. A & B) interactions and a three-way interaction between A, B & C

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which_covs = c('A', 'A'))   # leads to a quadratic polynomial
#  
#  process = addInteraction(which_covs = c('A', 'A', 'A'))   # leads to a cubic, polynomial

## ----workflow, message = FALSE, warning = FALSE--------------------------
# ext <- c(-170, -20, 10, 80)
# SugarMaple_Workflow <- workflow(occurrence = SugarMaple,
#                                 covariate = Bioclim(extent = as.vector(ext)),
#                                 process = addInteraction(which_covs = c('Bio3', 'Bio3')),
#                                 model = NullModel,
#                                 output = ResponsePlot)

