## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE, 
               comment = '')
<<<<<<< HEAD
=======

## ----echo = F, out.width= '400px', fig.align = "center", fig.cap="*Figure 1. Conceptual flowchart for data exploration*"----
knitr::include_graphics("../vignettes/Images/DataExp_ConceptualDiagram.png")

## ----packages, message = FALSE, warning = FALSE--------------------------
library(zoon)

## ----workflow, message = FALSE, warning = FALSE--------------------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PrintOccurrenceMap)

## ----relationships workflow, message = FALSE, warning = FALSE------------
#Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
#                                   covariate = CarolinaWrenRasters,
#                                   process = Background(1000),
#                                   model = NullModel,
#                                   output = Relationships)

## ------------------------------------------------------------------------
# summary(occ.cov.df$pcGr)
# max(occ.cov.df$pcGr)
# min(occ.cov.df$pcGr)

## ----pairplot workflow, message = FALSE, warning = FALSE-----------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                                   covariate = CarolinaWrenRasters,
                                   process = Background(1000),
                                   model = NullModel,
                                   output = PairPlot)

## ----DataReport, eval=FALSE----------------------------------------------
#  output = GenerateCovariateReport(type = "DR")
>>>>>>> 41ef0af

## ------------------------------------------------------------------------
# occ.cov.df <- Process(Carolina_Wren_Workflow)$df
# head(occ.cov.df)

## ------------------------------------------------------------------------
# str(occ.cov.df)
# class(occ.cov.df$pcMix)

