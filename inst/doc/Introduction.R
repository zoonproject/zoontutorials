## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = F, out.width= '650px', fig.align = "center", fig.cap="*Figure 1. Species Distribution Modelling aims: ecological inference (a; figure from @redfern17, photo from @cetus), predicting current species' distributions (b; figure from @pigott14), or mapping future distributions (c; figure from @elith10, photo from @fraser-smith).*"----
knitr::include_graphics("../vignettes/Images/Figure_1_litSDM.png")

## ----Figure_4, echo = FALSE, out.width= '650px', fig.align = "center", fig.cap="*Figure 2. Species Distribution Model Theory. Presence-background points plotted on geographic space and on environmental space (top panel; P = presence, B = background), and probability of occurrence predictions plotted on environmental and geographic space (bottom panel; colour scale represents probability of occurrence).*"----
knitr::include_graphics("../vignettes/Images/Figure_2_SDMtheory.png")

## ----Library, message=FALSE, warning=FALSE-------------------------------
library(zoon)

## ----Workflow, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7----
zoon_workflow <- workflow(occurrence = CarolinaWrenPO,
                          covariate = CarolinaWrenRasters,
                          process = Background(100),
                          model = MaxNet,
                          output = PrintMap)

## ----HTML_output_1, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----head_Occurrence, eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
head(Occurrence(zoon_workflow))

## ----Covariate, eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE------
Covariate(zoon_workflow)

## ----Workflow_Change_OccCov, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                occurrence = SpOcc("Thryothorus ludovicianus",
                                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)))

## ----HTML_output_2, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----Covariate_2, eval=TRUE----------------------------------------------
Covariate(zoon_workflow)   # Before standardisation

## ----Workflow_Change_Process, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                process = Chain(StandardiseCov, Background(n = 1000)))

## ----HTML_Output_3, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----Workflow_Change_Model, eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                model = LogisticRegression)


## ----HTML_Output_4, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----Workflow_Change_Output, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7, cache=TRUE----

zoon_workflow <- ChangeWorkflow(workflow = zoon_workflow,
                                output = InteractiveMap)


## ----HTML_Output_5, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(zoon_workflow)

## ----echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
#  zoon_workflow <- ChangeWorkflow(zoon_workflow,
#                                  output = ResponsePlot())

## ----Workflow_Change_Output_2, echo=FALSE, eval=TRUE, cache = TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
par(mfrow=c(2,3))
zoon_workflow <- ChangeWorkflow(zoon_workflow,
                                output = ResponsePlot())

## ----Dual_Model_Workflow, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
Dual_Model_Workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus",
                                                   extent = c(-138.71, -52.58, 18.15, 54.95)),
                                covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                                process = Background(1000),
                                model = list(LogisticRegression, MaxNet),
                                output = PrintMap(points = FALSE))

## ----Save, eval = FALSE--------------------------------------------------
#  save(Dual_Model_Workflow,
#       file = 'Dual_Model_Workflow.RData')

## ----Load, eval = FALSE--------------------------------------------------
#  load('Dual_Model_Workflow.RData')

