## ----message=FALSE, warning=FALSE----------------------------------------
library(zoon)

## ----message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=3----
example_workflow <- workflow(occurrence = UKAnophelesPlumbeus,
                             covariate = UKAir,
                             process = OneHundredBackground,
                             model = RandomForest,
                             output = PrintMap)

## ----eval=FALSE----------------------------------------------------------
#  occurrence = CarolinaWrenPO

## ----eval=FALSE----------------------------------------------------------
#  occurrence = SpOcc(species = “Ailuropoda melanoleuca”, extent = “ ”, database = “GBIF”)

## ----eval=FALSE----------------------------------------------------------
#  occurrence = LocalOccurrenceData(filename = "myData.csv",
#                                   occurrenceType = 'presence')

## ----eval=FALSE----------------------------------------------------------
#  occurrence = LocalOccurrenceData(filename = "myData.csv",
#                                   occurrenceType = 'presence/absence')

## ----eval=FALSE----------------------------------------------------------
#  process = addInteractions(which.covs = 'pairs')

## ----eval=FALSE----------------------------------------------------------
#  process = addInteractions(which.covs = c(A,B))   # adds an interacton between A & B
#  
#  process = addInteractions(which.covs = list(c(A,B), c(A,C)))   # adds interactions between A & B and A & C, but not B & C
#  
#  process = addInteractions(which.covs = c(A,B,C))   # adds all two-way (e.g. A & B) interactions and a three-way interaction between A, B & C

## ----eval=FALSE----------------------------------------------------------
#  process = addInteractions(which.covs = c(A,A))   # leads to a quadratic polynomial
#  
#  process = addInteractions(which.covs = c(A,A,A))   # leads to a cubic, polynomial

