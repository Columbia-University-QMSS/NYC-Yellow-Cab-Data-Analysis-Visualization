## Shiny Heatmap Module

# UI function 
heatmapUI <- function(id) {
  ns <- NS(id)
  fluidPage(
    
    titlePanel("Pickup Hour Heatmap and Top 10 Hottest Pickup Spots"),
    fluidRow(
      column(2,
             selectInput(ns('hour'), 'Pickup hour', lookup_list, 
                         selected = '7')),
      column(10,
             leafletOutput(ns("interactive")),
             plotOutput(ns("barplot"))
             ))
    )
}

# Server function 
heatmap <- (function(input, output, session) {
  
  output$interactive <- renderLeaflet({
    df_hour <- filter(df, pickup_hour == input$hour)  
    
    leaflet(df_hour) %>% 
      addTiles('http://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png') %>%
      setView(-73.985131, 40.758895, zoom = 12) %>% 
      addWebGLHeatmap(lng=~pickup_longitude, lat=~pickup_latitude, size = 8, 
                      units = "px")
  })
  output$barplot <- renderPlot({
    by_nei <- na.omit(df) %>% filter(pickup_hour == input$hour) %>% 
      group_by(neighborhood) %>% 
      summarise(nei_trip_counts = n()) %>% 
      top_n(n = 10, wt = nei_trip_counts) %>% 
      arrange(desc(nei_trip_counts)) %>% 
      ungroup() 
    
    ggplot(by_nei, 
           aes(x = reorder(neighborhood,nei_trip_counts), 
               y = nei_trip_counts)) + 
      geom_bar(stat = "identity", fill = "#6495ED") + 
      coord_flip() + theme_tufte()+
      ylab("Number of Trips") + xlab("Neighborhood") + 
      ggtitle("Top 10 Hottest Pickup Spots at time")
    
  })
  
})
