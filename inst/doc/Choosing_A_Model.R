## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
library(zoon)
library(gridExtra)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
Logistic_Regression_workflow <- workflow(occurrence = CarolinaWrenPO,
                                         covariate = CarolinaWrenRasters,
                                         process = Chain(StandardiseCov, Background(1000)),
                                         model = LogisticRegression,
                                         output = PrintMap(points = FALSE))

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
GAM_workflow <- workflow(occurrence = CarolinaWrenPO,
                         covariate = CarolinaWrenRasters,
                         process = Chain(StandardiseCov, Background(1000)),
                         model = mgcv(k = -1, bs = "tp"),
                         output = PrintMap(points = FALSE))

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
MaxEnt_workflow <- workflow(occurrence = CarolinaWrenPO,
                         covariate = CarolinaWrenRasters,
                         process = Chain(StandardiseCov, Background(1000)),
                         model = MaxEnt,
                         output = PrintMap(points = FALSE))

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
BRT_workflow <- workflow(occurrence = CarolinaWrenPO,
                         covariate = CarolinaWrenRasters,
                         process = Chain(StandardiseCov, Background(1000)),
                         model = GBM(max.trees = 1000,
                                     interaction.depth = 5,
                                     shrinkage = 0.001),
                         output = PrintMap(points = FALSE))

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7----
RandomForest_workflow <- workflow(occurrence = CarolinaWrenPO,
                         covariate = CarolinaWrenRasters,
                         process = Chain(StandardiseCov, Background(1000)),
                         model = RandomForest,
                         output = PrintMap(points = FALSE))

## ----eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE-----------------
cls <- colorRampPalette(c('#e0f3db', '#a8ddb5', '#4eb3d3', '#08589e'))(10)  # PrintMap colour palette

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=10, fig.width=7----
grid.arrange(spplot(Output(Logistic_Regression_workflow), col.regions=cls, cuts = length(cls)-1, main = "Logistic Regression"),
             spplot(Output(GAM_workflow), col.regions=cls, cuts = length(cls)-1, main = "Generalised Additive Model"),
             spplot(Output(MaxEnt_workflow), col.regions=cls, cuts = length(cls)-1, main = "MaxEnt"),
             spplot(Output(BRT_workflow), col.regions=cls, cuts = length(cls)-1, main = "Boosted Regression Tree"),
             spplot(Output(RandomForest_workflow), col.regions=cls, cuts = length(cls)-1, main = "Random Forest"))

