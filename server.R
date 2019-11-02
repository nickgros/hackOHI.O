library(shiny)
library(leaflet)
library(tidyverse)
library(plotly)
source("read_data.R")

diffData <- dataDaily %>%
  left_join((config %>% drop), by=c("MeterID", "Units")) %>% 
  filter(.$Units == "kWh") %>% 
  # arrange(-Time) %>%
  group_by(MeterID) %>%
  filter(CurrentValue > lag(CurrentValue)) %>% 
  filter(lead(CurrentValue) > CurrentValue) %>% 
  filter(CurrentValue > lag(CurrentValue)) %>% 
  filter(lead(CurrentValue) > CurrentValue) %>% 
  mutate(Diff = CurrentValue - lag(CurrentValue)) %>% 
  drop_na(Diff) %>% 
  filter(!(abs(Diff - median(Diff)) > 1.5*sd(Diff)))


shinyServer(function(input, output, session){
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=config$Longitude, lat=config$Latitude, popup=config$BuildingName, layerId = config$BuildingID)
  })
  
  output$building_graph_ui <- renderUI({
    if (is.null(input$map_marker_click$id )) {
      return()
    }
    print("Rendering new graph")
    data <- diffData %>% filter(BuildingID == input$map_marker_click$id)
    print(data)
    #p <- ggplot(data, aes(x = Time, y = Diff, color = Description.x)) + geom_point()
    plot(data.frame(x = c(1,2,3), y=c(1,2,3)))
    # return(plotOutput())
    # 
    #   ggplotly(p)
  })
})