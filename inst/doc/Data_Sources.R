## ----echo=FALSE, message=FALSE, warning=FALSE----------------------------
library(zoon)

## ----eval=TRUE-----------------------------------------------------------
modules <- GetModuleList()
modules$occurrence            # subset for the sake of screen space
modules$covariate

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
Carolina_Wren_Workflow <- workflow(occurrence = CarolinaWrenPA,
                                   covariate = CarolinaWrenRasters,
                                   process = StandardiseCov,
                                   model = MaxEnt,
                                   output = InteractiveOccurrenceMap)

## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(Carolina_Wren_Workflow)

## ----eval=FALSE----------------------------------------------------------
#  occurrence = LocalOccurrenceData(filename = "myData.csv",         # File path to your data file
#                                   occurrenceType = "presence",     # The type of data you have
#                                   columns = c(long = "longitude",  # The names of the columns in
#                                               lat = "latitude",    #     your .csv that much the
#                                               value = "value"),    #     required columns
#                                   externalValidation =  FALSE)     # Only required if validation
#                                                                    #     data is set up externally

## ----eval=FALSE----------------------------------------------------------
#  covariate = LocalRaster(rasters = c("myRaster1",     # Filepath to a raster
#                                      "myRaster2"))    # Filepath to a second raster
#  
#  covariate = LocalRaster(rasters = "myRasterStack")   # A RasterStack object already loaded

## ----eval=FALSE----------------------------------------------------------
#  occurrence = SpOcc(species = "SpeciesName",   # Species scientific name
#                     extent = c(-1, 0, 51, 52), # Coordinates for the extent of the region
#                     databases = "gbif",        # List of data bases to use
#                     type = "presence",         # Type of data you want
#                     limit = 10000)             # A maximum limit of records to obtain

## ----eval=FALSE----------------------------------------------------------
#  covariate = Bioclim(extent = c(-180, 180, -90, 90), # Coordinates for the extent of the region
#                      resolution = 10,                # Required resolution
#                      layers = 1:5)                   # Variables we want (between 1-19)

## ----eval=FALSE----------------------------------------------------------
#  covariate = Bioclim_future(extent = c(-10, 10, 45, 65),  # Coordinates of the extent of the region
#                             resolution = 10,              # Resolution of the data
#                             layers = 1:19,                # Required Bioclim variables
#                             rcp = 45,                     # Representative Concentration Pathways
#                             model = "AC",                 # General Circulation Models
#                             year = 70)                    # Time period for the prediction

## ----eval=FALSE----------------------------------------------------------
#  covariate = NCEP(extent = c(-5, 5, 50, 60),     # Coordinates of the extent of the region
#                   variables = "hgt",             # Character cevtor of variables of interest
#                   status.bar = FALSE)            # Show a status bar of download progress?

## ----eval=TRUE, message=FALSE, warning=FALSE-----------------------------
CW_Online_Data <- workflow(occurrence = SpOcc(species = "Ursus arctos",
                                              extent = c(-175, -65, 20, 75),
                                              databases = "gbif",
                                              type = "presence"),
                           covariate = Bioclim(extent = c(-175, -65, 20, 75),
                                               resolution = 10,
                                               layers = 1:19),
                           process = Chain(StandardiseCov, Background(1000)),
                           model = MaxEnt,
                           output = InteractiveOccurrenceMap)

## ----echo=FALSE, fig.align='center', fig.height=7, fig.width=7-----------
# force the htmlwidget to render in the vignette
Output(CW_Online_Data)

