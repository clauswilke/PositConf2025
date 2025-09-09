# Simple shiny example taken from: https://mastering-shiny.org/basic-app.html

# To test in regular R session:
# shiny::shinyAppDir("apps/src/shiny-example")
#
# To deploy:
# shinylive::export("apps/src/shiny-example", "apps/bin/shiny-example")

ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    # Use a reactive expression by calling it like a function
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}

shinyApp(ui, server)

