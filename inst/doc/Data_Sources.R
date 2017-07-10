## ----knitr_options, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE----
# set up knitr options
knitr::opts_chunk$set(message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE,
               comment = NA)

## ----TargettedBackground, eval=TRUE, message=FALSE, warning=FALSE, out.width=350, fig.show = "hold"----
TargettedBG <- workflow(occurrence = Chain(SpOcc("Thryothorus ludovicianus",
                                                 extent = c(-138.71, -52.58, 18.15, 54.95),
                                                 type = "presence"),
                                           SpOcc("Cistothorus platensis",
                                                 extent = c(-138.71, -52.58, 18.15, 54.95),
                                                 type = "background"),
                                           SpOcc("Troglodytes hiemalis",
                                                 extent = c(-138.71, -52.58, 18.15, 54.95),
                                                 type = "background")),
                        covariate = Bioclim(extent = c(-138.71, -52.58, 18.15, 54.95)),
                        process = NoProcess,
                        model = NullModel,
                        output = InteractiveOccurrenceMap)

## ----HTML_Output_4, echo=FALSE, fig.align='center', fig.height=7, fig.width=7----
# force the htmlwidget to render in the vignette
Output(TargettedBG)

