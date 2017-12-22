## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE, 
               comment = '')

## ----echo = F, out.width= '400px', fig.align = "center", fig.cap="*Figure 1. Data exploration considerations for occurence and covariate data*"----
knitr::include_graphics("../vignettes/Images/DataExp_ConceptualDiagram.png")

## ----packages, message = FALSE, warning = FALSE--------------------------
library(zoon)

## ----data summary workflow, message = FALSE, warning = FALSE-------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = DataSummary)

## ----relationships workflow, message = FALSE, warning = FALSE------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = CovHistograms)

## ----clean workflow, eval = FALSE----------------------------------------
#  Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                     covariate = CarolinaWrenRasters,
#                                     process = Chain(Background(1000),
#                                                     Clean(which = c(1,2,3))),
#                                     model = NullModel,
#                                     output = NoOutput)

## ----pairplot workflow, message = FALSE, warning = FALSE-----------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PairPlot)

## ----DataReport, eval=FALSE----------------------------------------------
#  Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                     covariate = CarolinaWrenRasters,
#                                     process = Background(1000),
#                                     model = NullModel,
#                                     output = GenerateCovariateReport(type = "DR"))

## ------------------------------------------------------------------------
occ.cov.df <- Process(Carolina_Wren_Workflow)$df

head(occ.cov.df)

## ------------------------------------------------------------------------
str(occ.cov.df)

## ------------------------------------------------------------------------
class(occ.cov.df$pcMix)

