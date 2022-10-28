#' Run app demo
#'
#' @import shiny
#' @export
#'
runDemo <- function(){

  ui <- fluidPage(titlePanel("shinyBrowserStorage - Demo"),
                  sidebarLayout(
                    sidebarPanel(
                      withBrowserStorage(),
                      selectInput(inputId = "type", label = strong("Type"),
                                  choices = c("localStorage", "sessionStorage")),
                      textInput(inputId = "key", label = "Key"),
                      textInput(inputId = "value", label = "Value"),
                      actionButton("set", label = "Set"),
                      actionButton("rm", label = "Remove"),
                      actionButton("show", label = "Show")),

                    mainPanel(
                      h2(textOutput(outputId = "key")),
                      textOutput(outputId = "value"))))

  # Define server function
  server <- function(input, output, session) {

    storage = list(
      sessionStorage = SessionStorage$new(input, session),
      localStorage = LocalStorage$new(input, session)
    )

    observeEvent(input$set, {
      # write.storage(input$type, input$key, input$value, session)
      input2storage(input$type, input$key, "value", "value", session)
    })

    observeEvent(input$rm, {
      storage[[input$type]]$removeItem(input$key)
    })

    output$key <- renderText({
      input$show
      isolate({input$key})
    })

    output$value <- renderText({
      input$show
      selStorage = isolate({input$type})
      selKey = isolate({input$key})

      # getItem should not be isolated !
      storage[[selStorage]]$getItem(selKey)
    })

  }

  shinyApp(ui = ui, server = server)
}
