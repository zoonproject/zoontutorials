## ----message=FALSE, warning=FALSE----------------------------------------
library(zoon)

## ----message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPO,
                             covariate = CarolinaWrenRasters,
                             process = Background(100),
                             model = LogisticRegression,
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

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
#hidden_PO_workflow <- workflow(occurrence = CarolinaWrenPO,    ### just some basic workflows so there
#                             covariate = CarolinaWrenRasters,  ### is something to run accessor functions
#                             process = Background,          ### on as examples
#                             model = MaxEnt,
#                             output = NoOutput)

#hidden_PA_workflow <- workflow(occurrence = CarolinaWrenPA,
#                             covariate = CarolinaWrenRasters,
#                             process = NoProcess,
#                             model = LogisticRegression,
#                             output = NoOutput)

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
#head(Occurrence(hidden_PO_workflow))

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
#tail(Occurrence(hidden_PA_workflow))

## ----eval=FALSE----------------------------------------------------------
#  covariate = CarolinaWrenRasters

## ----eval=FALSE----------------------------------------------------------
#  covariate = NCEP(extent = c(-5,5,50,60), # default values for the NCEP module
#                    variables = "hgt")

## ----eval=FALSE----------------------------------------------------------
#  covariate = Bioclim(extent = c(-180,180,-90,90), # default values for the Bioclim module
#                       resolution = 10,
#                       layers = 1:5)

## ----eval=FALSE----------------------------------------------------------
#  covariate = Bioclim_future(extent = c(-10, 10, 45, 65),   # default values for the Bioclim_future module
#                              resolution = 10,
#                              layers = 1:19,
#                              rcp = 45,
#                              model = "AC",
#                              year = 70)

## ----eval=FALSE----------------------------------------------------------
#  covariate = LocalRaster(rasters = "MyRaster")

## ----eval=FALSE----------------------------------------------------------
#  #Covariate(Your_Workflow_Name_Here)

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
#Covariate(hidden_PO_workflow)

## ----eval=FALSE----------------------------------------------------------
#  process = Clean(which = c(1,2,3,4))   # default fit of the Clean module

## ----eval=FALSE----------------------------------------------------------
#  process = Transform(trans = function(x) {x},   # default form of the Transform module. Perform no transformations on any variable
#                      which_cov = NULL,
#                      replace = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  process = Transform(trans = function(x) {x^2},   # Add a new variable that is the squared transformation of the "cov1" variable
#                      which_cov = "cov1",
#                      replace = FALSE)

## ----eval=FALSE----------------------------------------------------------
#  process = Transform(trans = function(x) {log(x)}, # Replace the "cov1" variable with the log-transformed version of "cov1"
#                      which_cov = "cov1",
#                      replace = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  process = StandardiseCov(Gelman = FALSE, exclude = NULL)   # default form of the StandardiseCov module.

## ----eval=FALSE----------------------------------------------------------
#  process = Background(n = 100,   # generate 100 unbiased background points
#                       bias = NULL)

## ----eval=FALSE----------------------------------------------------------
#  process = OneHundredBackground

## ----eval=FALSE----------------------------------------------------------
#  process = OneThousandBackground

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

## ----eval=FALSE----------------------------------------------------------
#  process = Crossvalidate(k = 5)   # 5-fold cross-validation

## ----eval=FALSE----------------------------------------------------------
#  process = Bootstrap   # Bootstrap a number of points equal to the number of points in the dataset

## ----eval=FALSE----------------------------------------------------------
#  process = BackgroundAndCrossvalid(k = 5)   # generate up to 100 background points, and the split all data into 5 folds for cross validation

## ----eval=FALSE----------------------------------------------------------
#  process = NoProcess

## ----eval=FALSE----------------------------------------------------------
#  model = LogisticRegression

## ----eval=FALSE----------------------------------------------------------
#  model = mgcv(k = -1,   # default settings
#               bs = "tp")

## ----eval=FALSE----------------------------------------------------------
#  model = MaxEnt

## ----eval=FALSE----------------------------------------------------------
#  model = GBM(max.trees = 1000,   # default values
#              interaction.depth = 5,
#              shrinkage = 0.001)

## ----eval=FALSE----------------------------------------------------------
#  model = RandomForest

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
Logistic_Regression_Workflow <- workflow(occurrence = CarolinaWrenPO,
                       covariate = CarolinaWrenRasters,
                       process = Background(1000),
                       model = LogisticRegression,
                       output = PrintMap(points = FALSE))

