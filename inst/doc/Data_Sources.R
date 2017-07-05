## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE,
               comment = NA)

## ----Combination_A, eval=TRUE, message=FALSE, warning=FALSE--------------
CombinationA <- workflow(occurrence = list(CarolinaWrenPO,
                                           SpOcc("Thryothorus ludovicianus",
                                                 extent = c(-138.71, -52.58, 18.15, 54.95))),
                         covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                         process = Background(100),
                         model = LogisticRegression,
                         output = PrintMap)

