## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----Library, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE--------
library(zoon)
library(gridExtra)

## ----Logistic_Regression, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
Logistic <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                        extent = c(-138.71, -52.58, 18.15, 54.95)),
                     covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                     process = Chain(StandardiseCov,
                                     Background(1000)),
                     model = LogisticRegression,
                     output = PrintMap(points = FALSE))

## ----GAM, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
GAM <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                process = Chain(StandardiseCov,
                                Background(1000)),
                model = mgcv(k = -1,
                             bs = "tp"),
                output = PrintMap(points = FALSE))

## ----MaxNet, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
MaxNet <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                      extent = c(-138.71, -52.58, 18.15, 54.95)),
                   covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                   process = Chain(StandardiseCov,
                                   Background(1000)),
                   model = MaxNet,
                   output = PrintMap(points = FALSE))

## ----Decision_Tree_Image, echo = FALSE, fig.cap="*Figure 1. A single decision tree (upper panel), with a response Y, two predictor variables, X1 and X2 and split points t1 , t2 , etc. The bottom panel shows its prediction surface (after Hastie et al. 2001). Image sourced from @elith08", fig.align = "centre"----
knitr::include_graphics("../vignettes/Images/Decision_Tree_Elith.jpg")

## ----BRT, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
BRT <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                process = Chain(StandardiseCov, Background(1000)),
                model = GBM(max.trees = 1000,
                            interaction.depth = 5,
                            shrinkage = 0.001),
                output = PrintMap(points = FALSE))

## ----RandomForest, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
RandomForest <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                            extent = c(-138.71, -52.58, 18.15, 54.95)),
                         covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                         process = Chain(StandardiseCov, Background(1000)),
                         model = RandomForest,
                         output = PrintMap(points = FALSE))

## ----Colour_Palette, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE----
cls <- colorRampPalette(c('#e0f3db', '#a8ddb5', '#4eb3d3', '#08589e'))(10)  # PrintMap colour palette

## ----Comparison, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=10, fig.width=7----
grid.arrange(spplot(Output(Logistic), col.regions=cls,
                    cuts = length(cls)-1, main = "Logistic Regression"),
             spplot(Output(GAM), col.regions=cls,
                    cuts = length(cls)-1, main = "Generalised Additive Model"),
             spplot(Output(MaxNet), col.regions=cls,
                    cuts = length(cls)-1, main = "MaxNet"),
             spplot(Output(BRT), col.regions=cls,
                    cuts = length(cls)-1, main = "Boosted Regression Tree"),
             spplot(Output(RandomForest), col.regions=cls,
                    cuts = length(cls)-1, main = "Random Forest"))

