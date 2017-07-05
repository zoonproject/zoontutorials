## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----echo = F, out.width= '650px', fig.align = "center", fig.cap="*Figure 1. Species distribution modelling aims: ecological inference (a; figure from @redfern17, photo from @cetus), predicting current species distributions (b; figure from @pigott14), or future distributions (c; figure from @elith10, photo from @fraser-smith).*"----
knitr::include_graphics("../vignettes/Images/Figure_1_litSDM.png")

## ----Figure_4, echo = FALSE, out.width= '650px', fig.align = "center", fig.cap="*Figure 2. Species distribution modelling process. Presence-background points in geographic (a) and environmental space (b; P = presence, B = background), and predicted probability of occurrence in environmental (c) and geographic space (d; colour scale represents probability of occurrence).*"----
knitr::include_graphics("../vignettes/Images/Figure_2_SDMtheory.png")

## ----basic_workflow, message = FALSE, warning = FALSE, fig.align = 'center', fig.height = 4, fig.width = 7, cache = TRUE----
workflow <- workflow(occurrence = CarolinaWrenPO,
                     covariate = CarolinaWrenRasters,
                     process = Background(100),
                     model = MaxNet,
                     output = PrintMap)

## ----head_occurrence, eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
head(Occurrence(workflow))

## ----covariate_accessor, eval=TRUE, message=FALSE, warning=FALSE, cache=TRUE----
Covariate(workflow)

## ----covariate, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
ext <- extent(Covariate(workflow))
ext

workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                     covariate = Bioclim(extent = as.vector(ext)),
                     process = Background(100),
                     model = MaxNet,
                     output = PrintMap)

## ----process, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                          covariate = Bioclim(extent = as.vector(ext)),
                          process = Chain(Clean, Background(100)),
                          model = MaxNet,
                          output = PrintMap)

## ----model, eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                     covariate = Bioclim(extent = as.vector(ext)),
                     process = Chain(Clean, Background(100)),
                     model = LogisticRegression,
                     output = PrintMap)


## ----ourput_interactive_map, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7, cache=TRUE----

workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                          covariate = Bioclim(extent = as.vector(ext)),
                          process = Chain(Clean, Background(100)),
                          model = LogisticRegression,
                          output = InteractiveMap())


## ----HTML_Output_5, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(workflow)

## ----output_response_plot_no_eval, echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
#  workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
#                       covariate = Bioclim(extent = as.vector(ext)),
#                       process = Chain(Clean, Background(100)),
#                       model = LogisticRegression,
#                       output = ResponsePlot)
#  

## ----output_response_plot_eval_for_render, echo=FALSE, eval=TRUE, cache = TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----

par(mfrow=c(2,3))
workflow <- ChangeWorkflow(workflow,
                           output = ResponsePlot)

## ----save, eval = FALSE--------------------------------------------------
#  save(workflow, file = 'workflow.RData')

## ----load, eval = FALSE--------------------------------------------------
#  load('workflow.RData')

