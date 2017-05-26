## ----eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE-----------------
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
Dual_Model_Workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", 
                                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                                process = Background(1000),
                                model = list(LogisticRegression, MaxEnt),
                                output = PrintMap(points = FALSE))

## ----eval = FALSE--------------------------------------------------------
#  save(Dual_Model_Workflow,
#       file = 'Dual_Model_Workflow.RData')

## ----eval = FALSE--------------------------------------------------------
#  load('Dual_Model_Workflow.RData')

