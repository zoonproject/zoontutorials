## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----Library, message = F, warning = F-----------------------------------
library(zoon)
library(lattice)

## ----Workflow, model, warning = FALSE, message=FALSE---------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = InteractiveOccurrenceMap)

## ----HTML_Output_1, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(Carolina_Wren_Workflow)

## ------------------------------------------------------------------------
occ.cov.df <- Process(Carolina_Wren_Workflow)$df
str(occ.cov.df)

## ------------------------------------------------------------------------
# once I have the process module that makes this binned, I will provide code examples. 

# also show the outliers module output. 

## ----Clean, eval=FALSE---------------------------------------------------
#  process = Clean(which = c(1,2,3))

## ----DataReport, eval=FALSE----------------------------------------------
#  output = GenerateCovariateReport(type = "DR")

## ----Transform_1, eval=FALSE---------------------------------------------
#  process = Transform(trans = function(x) {log(x)},
#                      which_cov = "VarA",
#                      replace = FALSE)

## ----Transform_2, eval=FALSE---------------------------------------------
#  process = Chain(Transform(trans = function(x) {x + 101},
#                            which_cov = c("VarA", "VarB"),
#                            replace = FALSE),
#                  Transform(trans = function(x) {(x*4) + log(x)},
#                            which_cov = c("VarC", "VarD"),
#                            replace = TRUE),
#                  Transform(trans = function(x) {x + 21 + x^x},
#                            which_cov = c("VarE"),
#                            replace = FALSE))

## ----StandardiseCov, eval=FALSE------------------------------------------
#  process = StandardiseCov(Gelman = FALSE, exclude = NULL) # default form
#  
#  process = StandardiseCov(Gelman = TRUE,
#                           exclude = c("VarB", "VarC"))

## ----Interaction_AllPairs, eval=FALSE------------------------------------
#  process = addInteraction(which.covs = 'pairs')

## ----Interaction_Pair, eval=FALSE----------------------------------------
#  process = addInteraction(which.covs = c("A","B"))   # adds an interaction between A & B

## ----Interaction_MultPairs, eval=FALSE-----------------------------------
#  process = addInteraction(which.covs = list(c("A","B"), c("A","C")))   # adds interactions between A & B and A & C, but not B & C

## ----Interaction_Three-way, eval=FALSE-----------------------------------
#  process = addInteraction(which.covs = c(A,B,C))   # adds all two-way (e.g. A & B) interactions and a three-way interaction between A, B & C

## ----Polynomial, eval=FALSE----------------------------------------------
#  process = addInteractions(which.covs = c(A,A))   # leads to a quadratic polynomial
#  
#  process = addInteractions(which.covs = c(A,A,A))   # leads to a cubic, polynomial

