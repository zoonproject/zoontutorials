## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----covariate, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
ext <- extent(Covariate(workflow))
ext

workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                     covariate = Bioclim(extent = ext),
                     process = Background(100),
                     model = MaxNet,
                     output = PrintMap)

## ----process, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                          covariate = Bioclim(extent = ext),
                          process = Chain(Clean, Background(100)),
                          model = MaxNet,
                          output = PrintMap)

## ----model, eval=TRUE, warning=FALSE, message=FALSE, fig.align='center', fig.height=4, fig.width=7, cache=TRUE----
workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                     covariate = Bioclim(extent = ext),
                     process = Chain(Clean, Background(100)),
                     model = LogisticRegression,
                     output = PrintMap)


## ----ourput_interactive_map, eval=TRUE, message=FALSE, warning=FALSE, fig.align='center', fig.height=7, fig.width=7, cache=TRUE----

workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
                          covariate = Bioclim(extent = ext),
                          process = Chain(Clean, Background(100)),
                          model = LogisticRegression,
                          output = InteractiveMap())


## ----output_response_plot_no_eval, echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5, fig.width=7, cache=TRUE----
#  workflow <- workflow(occurrence = SpOcc("Thryothorus ludovicianus", extent = ext),
#                       covariate = Bioclim(extent = ext),
#                       process = Chain(Clean, Background(100)),
#                       model = LogisticRegression,
#                       output = ResponsePlot)
#  

