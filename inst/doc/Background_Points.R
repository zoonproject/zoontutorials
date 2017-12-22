## ----echo=FALSE----------------------------------------------------------
library(zoon)

## ------------------------------------------------------------------------
ext <- extent(c(-138.71, -52.58, 18.15, 54.95))

Background <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                          extent = ext),
                       covariate = Bioclim(extent = ext),
                       process = Background(1000,
                                            seed = 1234),
                       model = NullModel,
                       output = PrintOccurrenceMap)

## ------------------------------------------------------------------------
ext <- extent(c(-138.71, -52.58, 18.15, 54.95))

BiasLayer <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                         extent = ext),
                      covariate = Bioclim(extent = ext),
                      process = Background(1000,
                                           bias = raster("../Bias.tif"),
                                           seed = 1234),
                      model = NullModel,
                      output = PrintOccurrenceMap)

## ------------------------------------------------------------------------
ext <- extent(c(-138.71, -52.58, 18.15, 54.95))

Buffer <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                      extent = ext),
                   covariate = Bioclim(extent = ext),
                   process = Background(1000,
                                        bias = 50,
                                        seed = 1234),
                   model = NullModel,
                   output = PrintOccurrenceMap)

## ------------------------------------------------------------------------
TargettedBG <- workflow(occurrence = SpOcc(species = "Thryothorus ludovicianus",
                                           extent = ext,
                                           databases = "gbif",
                                           type = "presence",
                                           limit = 500),
                        covariate = CarolinaWrenRasters,
                        process = TargetGroupBackground(OccurrenceCall = Chain(
                          SpOcc(species = "Empidonax virescens",
                                databases = "gbif",
                                extent = ext,
                                type = "background",
                                limit = 300),
                          SpOcc(species = "Peucaea aestivalis",
                                databases = "gbif",
                                extent = ext,
                                type = "background",
                                limit = 300),
                          SpOcc(species = "Strix varia",
                                databases = "gbif",
                                extent = ext,
                                type = "background",
                                limit = 300),
                          SpOcc(species = "Cyanocitta cristata",
                                databases = "gbif",
                                extent = ext,
                                type = "background",
                                limit = 300))),
                        model = NullModel,
                        output = PrintOccurrenceMap)


