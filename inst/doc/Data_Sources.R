## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE,
               comment = NA)

## ----Library, echo=FALSE, message=FALSE, warning=FALSE-------------------
library(zoon)

## ----Module_List, eval=TRUE----------------------------------------------
modules <- GetModuleList()
modules$occurrence
modules$covariate

## ----Workflow, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
Carolina_Wren <- workflow(occurrence = CarolinaWrenPO,
                          covariate = CarolinaWrenRasters,
                          process = Background(100),
                          model = NullModel,
                          output = InteractiveOccurrenceMap)

## ----HTML_Output_1, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(Carolina_Wren)

## ----LocalOccurrence, eval=FALSE-----------------------------------------
#  occurrence = LocalOccurrenceData(filename = "myData.csv",         # File path to your data file
#                                   occurrenceType = "presence",     # The type of data you have
#                                   columns = c(long = "longitude",  # The names of the columns in
#                                               lat = "latitude",    #     your .csv that much the
#                                               value = "value"),    #     required columns
#                                   externalValidation =  FALSE)     # Only required if validation
#                                                                    #     data is set up externally

## ----LocalRaster, eval=FALSE---------------------------------------------
#  covariate = LocalRaster(rasters = c("myRaster1",     # Filepath to a raster
#                                      "myRaster2"))    # Filepath to a second raster
#  
#  covariate = LocalRaster(rasters = "myRasterStack")   # A RasterStack object already loaded

## ----eval=TRUE, echo=TRUE, warning=FALSE, message=FALSE------------------
filename <- paste(system.file(package = "dismo"), '/ex/bradypus.csv', sep='') # filepath to .csv
Bradypus <- read.csv(filename, header = TRUE) # read in .csv file
Bradypus <- Bradypus[,2:3] # remove column of species name
Bradypus <- cbind(Bradypus, rep(1, nrow(Bradypus))) # all records are presences, so add column of 1s
colnames(Bradypus) <- c("longitude", "latitude", "value") # set necessary column names
write.csv(Bradypus, "Bradypus.csv") # create a .csv file of the required format

## ----eval=TRUE, echo=TRUE, warning=FALSE, message=FALSE------------------
files <- list.files(path = paste(system.file(package="dismo"),'/ex', sep=''),
                    pattern='grd', full.names=TRUE ) # list all .grd files in `dismo`
predictors <- stack(files) # create a raster-stack from these layers
predictors <- dropLayer(x=predictors,i=9) # drop unwanted raster layer

## ----eval=TRUE, echo=TRUE, warning=FALSE, message=FALSE------------------
Our_Data <- workflow(occurrence = LocalOccurrenceData(filename = "Bradypus.csv",
                                                      occurrenceType = "presence",
                                                      columns = c(long = "longitude",
                                                                  lat = "latitude",
                                                                  value = "value")),
                     covariate = LocalRaster(predictors),
                     process = Background(100),
                     model = NullModel,
                     output = InteractiveOccurrenceMap)

## ----HTML_Output_2, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(Our_Data)

## ----SpOcc, eval=FALSE---------------------------------------------------
#  occurrence = SpOcc(species = "SpeciesName",   # Species scientific name
#                     extent = c(-1, 0, 51, 52), # Coordinates for the extent of the region
#                     databases = "gbif",        # List of data bases to use
#                     type = "presence",         # Type of data you want
#                     limit = 10000)             # A maximum limit of records to obtain

## ----Bioclim, eval=FALSE-------------------------------------------------
#  covariate = Bioclim(extent = c(-180, 180, -90, 90), # Coordinates for the extent of the region
#                      resolution = 10,                # Required resolution
#                      layers = 1:5)                   # Variables we want (between 1-19)

## ----Bioclim_future, eval=FALSE------------------------------------------
#  covariate = Bioclim_future(extent = c(-10, 10, 45, 65),  # Coordinates of the extent of the region
#                             resolution = 10,              # Resolution of the data
#                             layers = 1:19,                # Required Bioclim variables
#                             rcp = 45,                     # Representative Concentration Pathways
#                             model = "AC",                 # General Circulation Models
#                             year = 70)                    # Time period for the prediction

## ----NCEP, eval=FALSE----------------------------------------------------
#  covariate = NCEP(extent = c(-5, 5, 50, 60),     # Coordinates of the extent of the region
#                   variables = "hgt",             # Character vector of variables of interest
#                   status.bar = FALSE)            # Show a status bar of download progress?

## ----Online, eval=TRUE, message=FALSE, warning=FALSE---------------------
Online <- workflow(occurrence = SpOcc(species = "Ursus arctos",
                                      extent = c(-175, -65, 20, 75),
                                      databases = "gbif",
                                      type = "presence"),
                   covariate = Bioclim(extent = c(-175, -65, 20, 75),
                                       resolution = 10,
                                       layers = 1:19),
                   process = Background(1000),
                   model = NullModel,
                   output = InteractiveOccurrenceMap)

## ----HTML_Output_3, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(Online)

## ----Combination_A, eval=TRUE, message=FALSE, warning=FALSE--------------
CombinationA <- workflow(occurrence = list(CarolinaWrenPO,
                                           SpOcc("Thryothorus ludovicianus",
                                                 extent = c(-138.71, -52.58, 18.15, 54.95))),
                         covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                         process = Background(100),
                         model = LogisticRegression,
                         output = PrintMap)

