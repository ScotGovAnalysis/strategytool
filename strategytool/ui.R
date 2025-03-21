library(shiny)
library(NZST)

shinyUI(
  fluidPage(
    tabsetPanel(
      tabPanel("User guide",
               includeMarkdown("www/Instructions.md")),
      tabPanel("App",
               tagList(tags$style(type="text/css", ".shiny-file-input-progress { display: none }")),
               column(6,
                      titlePanel("Strategy"),
                      fileInput("network_file", NULL),
                      actionButton("show_example", "Show example map")),
               column(6,
                      img(src='NZST_WhiteOnBlack.png', align = "right", width = 256, height = 102)),
               nzstOutput("map")
      )
    )
  )
)
