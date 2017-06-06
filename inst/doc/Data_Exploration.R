## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----message = F, warning = F--------------------------------------------
library(zoon)
library(lattice)

## ----model, warning = F--------------------------------------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PrintMap)

## ------------------------------------------------------------------------
occ.cov.df <- Process(Carolina_Wren_Workflow)$df
str(cov)

## ------------------------------------------------------------------------
# once I have the process module that makes this binned, I will provide code examples. 

# also show the outliers module output. 

## ----eval=FALSE----------------------------------------------------------
#  process = Clean(which = c(1,2,3))

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

## ----eval=FALSE----------------------------------------------------------
#  process = StandardiseCov(Gelman = FALSE, exclude = NULL) # default form: standardise all covariates normally
#  
#  process = StandardiseCov() # short form of the default fit
#  
#  process = StandardiseCov(Gelman = TRUE,
#                           exclude = c("VarB", "VarC"))

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which.covs = 'pairs')

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which.covs = c("A","B"))   # adds an interaction between A & B

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which.covs = list(c("A","B"), c("A","C")))   # adds interactions between A & B and A & C, but not B & C

## ----eval=FALSE----------------------------------------------------------
#  process = addInteraction(which.covs = c(A,B,C))   # adds all two-way (e.g. A & B) interactions and a three-way interaction between A, B & C

## ----eval=FALSE----------------------------------------------------------
#  process = addInteractions(which.covs = c(A,A))   # leads to a quadratic polynomial
#  
#  process = addInteractions(which.covs = c(A,A,A))   # leads to a cubic, polynomial

