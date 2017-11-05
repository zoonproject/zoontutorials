
library(shiny)
library(miniUI)

zoonGadgetFunc <- function(inputValue1, inputValue2) {

  ui <- miniPage(
    gadgetTitleBar('SDM with zoon',
                   right = miniTitleBarButton('done', 'Done', primary = TRUE)
    ),
    miniTabstripPanel(
      id = 'tabs',
      miniTabPanel('Occurrence', icon = icon(NULL),
                   miniContentPanel(
                     selectInput(inputId = 'occ',
                                 label = 'Occurrence',
                                 choices = sort(GetModuleList('occurrence'))
                     )
                   ),
                   miniButtonBlock(
                     actionButton(inputId = 'gotocov', label = 'Next')
                   )
      ),
      miniTabPanel('Covariate', icon = icon(NULL),
                   miniContentPanel(
                     selectInput(inputId = 'cov',
                                 label = 'Covariate',
                                 choices = sort(GetModuleList('covariate'))
                     )
                   ),
                   miniButtonBlock(
                     actionButton(inputId = 'backtoocc', label = 'Back'),
                     actionButton(inputId = 'gotopro', label = 'Next')
                   )
      ),
      miniTabPanel('Process', icon = icon(NULL),
                   miniContentPanel(
                     selectInput(inputId = 'pro',
                                 label = 'Process',
                                 choices = sort(GetModuleList('process'))
                     )
                   ),
                   miniButtonBlock(
                     actionButton(inputId = 'backtocov', label = 'Back'),
                     actionButton(inputId = 'gotomod', label = 'Next')
                   )
      ),
      miniTabPanel('Model', icon = icon(NULL),
                   miniContentPanel(
                     selectInput(inputId = 'mod',
                                 label = 'Model',
                                 choices = sort(GetModuleList('model'))
                     )
                   ),
                   miniButtonBlock(
                     actionButton(inputId = 'backtopro', label = 'Back'),
                     actionButton(inputId = 'gotoout', label = 'Next')
                   )
      ),
      miniTabPanel('Output', icon = icon(NULL),
                   miniContentPanel(
                     selectInput(inputId = 'out',
                                 label = 'Output',
                                 choices = sort(GetModuleList('output'))
                     )
                   ),
                   miniButtonBlock(
                     actionButton(inputId = 'backtomod', label = 'Back'),
                     actionButton(inputId = 'makeoutput', label = 'Run')
                   )
      ),
      miniTabPanel('Display', icon = icon('map-o'),
                   miniContentPanel(padding = 0,
                                    plotOutput('zoon_output')
                                    )
                   )
    )
  )

  server <- function(input, output, session) {

    # library(log4r)
    # loggerDebug <- create.logger()
    # logfile(loggerDebug) <- 'data/debugData.log'
    # level(loggerDebug) <- 'INFO'
    #
    # loggerServer <- create.logger()
    # logfile(loggerServer) <- 'data/serverData.log'
    # level(loggerServer) <- 'INFO'

    # debug(logger, 'A Debugging Message')
    # info(logger, 'An Info Message')
    # warn(logger, 'A Warning Message')
    # error(logger, 'An Error Message')

    ### BACK buttons ###
    observeEvent(input$backtoocc, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Occurrence')
    })
    observeEvent(input$backtocov, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Covariate')
    })
    observeEvent(input$backtopro, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Process')
    })
    observeEvent(input$backtomod, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Model')
    })

    ### NEXT buttons ###
    observeEvent(input$gotocov, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Covariate')
    })
    observeEvent(input$gotopro, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Process')
    })
    observeEvent(input$gotomod, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Model')
    })
    observeEvent(input$gotoout, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Output')
    })
    observeEvent(input$makeoutput, {
      updateTabsetPanel(session = session, inputId = 'tabs', selected = 'Display')
    })

    occ <- reactive({ input$occ })
    cov <- reactive({ input$cov })
    pro <- reactive({ input$pro })
    mod <- reactive({ input$mod })
    out <- reactive({ input$out })

    ### DELAY making display until hit 'run' ###
    command <- eventReactive(input$makeoutput, {
      sprintf("workflow(%s,%s,%s,%s,%s)",
              occ(), cov(), pro(), mod(), out())
    })

    ### make display ###
    output$zoon_output <- renderPlot({
      eval(parse(text = command()))
    })

    # workflow <- renderText({
    #   str1 <- paste0('workflow(occurrence = ', occ(), ',')
    #   str2 <- paste0('covariate = ', cov(), ',')
    #   str3 <- paste0('process = ', pro(), ',')
    #   str4 <- paste0('model = ', mod(), ',')
    #   str5 <- paste0('output = ', out())
    #
    #   paste(str1, str2, str3, str4, str5, sep = '\n')
    # })

    ### DONE button ###
    observeEvent(input$done, {
      returnValue <-
      stopApp(returnValue)
    })

  }

  runGadget(ui, server, viewer = dialogViewer('zoonGadgetFunc'))

}

