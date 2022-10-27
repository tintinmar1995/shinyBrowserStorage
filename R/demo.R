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

    observeEvent(input$set, {
      input$set
      # isolate({write.storage(input$type, input$key, input$value, session)})
      isolate({input2storage(input$type, input$key, "value", "value", session)})
    })

    observeEvent(input$rm, {
      input$set
      isolate({remove.storage(input$type, input$key, session)})
    })

    output$key <- renderText({
      input$show
      isolate({input$key})
    })

    output$value <- renderText({
      input$show
      isolate({read.storage(input$type, input$key, input, session)})
    })

  }

  shinyApp(ui = ui, server = server)
}
