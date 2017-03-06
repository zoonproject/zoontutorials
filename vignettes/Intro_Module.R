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

## ----eval=FALSE, message=FALSE, warning=FALSE----------------------------
#  Occurrence(Your_Workflow_Name_Here)

