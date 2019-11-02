library(shiny)

shinyUI(fluidPage(
  titlePanel("ENGIE Data App HACK OHIO 2k19"),
  tabsetPanel(
    type = "tabs",
    tabPanel(
      "Mapz",
      sidebarLayout(
        sidebarPanel(
          hr()
        ),
        mainPanel(
          leafletOutput("map"),
          plotOutput("building_graph_ui")
        )
      )
      
    )
  )
))