## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = F, out.width= '400px', fig.align = "center", fig.cap="*Figure 1. Conceptual flowchart for data exploration steps.*"----
knitr::include_graphics("../vignettes/Images/DataExp_ConceptualDiagram.png")

## ----packages, message = FALSE, warning = FALSE--------------------------
library(zoon)

## ----workflow, message = FALSE, warning = FALSE--------------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PrintMap)

## ------------------------------------------------------------------------
occ.cov.df <- Process(Carolina_Wren_Workflow)$df
head(occ.cov.df)

## ------------------------------------------------------------------------
str(occ.cov.df)
class(occ.cov.df$pcMix)

## ----relationships workflow, message = FALSE, warning = FALSE------------
#Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                   covariate = CarolinaWrenRasters,
#                                   process = Background(1000),
#                                   model = NullModel,
#                                   output = Relationships)

## ----Clean, eval=FALSE---------------------------------------------------
#  process = Clean(which = c(1,2,3))

## ------------------------------------------------------------------------
summary(occ.cov.df$pcGr)
max(occ.cov.df$pcGr)
min(occ.cov.df$pcGr)

## ----outliers workflow, message = FALSE, warning = FALSE-----------------
#Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                   covariate = CarolinaWrenRasters,
#                                   process = Background(1000),
#                                   model = NullModel,
#                                   output = Outliers)

## ----pairplot workflow, message = FALSE, warning = FALSE-----------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PairPlot)

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

## ----DataReport, eval=FALSE----------------------------------------------
#  output = GenerateCovariateReport(type = "DR")

