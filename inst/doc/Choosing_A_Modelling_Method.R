## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----Data, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Distribution of presence (red) and background (black) data for the Carolina wren in North America"----
ext <- extent(c(-138.71, -52.58, 18.15, 54.95)) # define extent of study area

data <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                    extent = ext),
                 covariate = Bioclim(extent = ext),
                 process = Background(1000),
                 model = NullModel,
                 output = PrintOccurrenceMap)

## ----Logistic_Regression, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Predicted Carolina wren distribution map from the logistic regression SDM."----
logistic <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                        extent = ext),
                     covariate = Bioclim(extent = ext),
                     process = Background(1000),
                     model = LogisticRegression,
                     output = PrintMap)

## ----GAM, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Predicted Carolina wren distribution map for the generalised additive model SDM"----
GAM <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                   extent = ext),
                covariate = Bioclim(extent = ext),
                process = Background(1000),
                model = mgcv(k = -1,
                             bs = "tp"),
                output = PrintMap)

## ----MaxNet, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Predicted Carolina wren distribution map for the MaxNet SDM"----
MaxNet <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                      extent = ext),
                   covariate = Bioclim(extent = ext),
                   process = Background(1000),
                   model = MaxNet,
                   output = PrintMap)

## ----Decision_Tree_Image, echo = FALSE, fig.cap="A single decision tree (upper panel), with a response Y, two predictor variables, X1 and X2 and split points t1 , t2 , etc. The bottom panel shows its prediction surface (after Hastie et al. 2001). Image sourced from @elith08", fig.align = "centre"----
knitr::include_graphics("../vignettes/Images/Decision_Tree_Elith.jpg")

## ----RandomForest, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Predicted Carolina wren distribution map for the random forest model."----
RandomForest <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                            extent = ext),
                         covariate = Bioclim(extent = ext),
                         process = Background(1000),
                         model = RandomForest,
                         output = PrintMap)

## ----BRT, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, fig.cap="Predicted Carolina wren distribution map for the boosted regresion tree SDM"----
BRT <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                   extent = ext),
                covariate = Bioclim(extent = ext),
                process = Background(1000),
                model = GBM(max.trees = 1000,
                            interaction.depth = 5,
                            shrinkage = 0.001),
                output = PrintMap)

