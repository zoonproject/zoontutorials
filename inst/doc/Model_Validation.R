## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----Library, message=FALSE, warning=FALSE-------------------------------
library(zoon)

## ----Workflow, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
zoon_workflow <- workflow(occurrence = CarolinaWrenPA,
                          covariate = CarolinaWrenRasters,
                          process = NoProcess,
                          model = LogisticRegression,
                          output = InteractiveMap)

