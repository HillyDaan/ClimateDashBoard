## interactive map functions
mapUI <- function(id) {
  ns <- NS(id)
  box(
    title = "Map of Emissions",
    width = 12,
    status = "primary",
    solidHeader = TRUE,
    leafletOutput(ns("map"), height = 600)
  )
}

##
mapServer <- function(id, filtered_data, provinces) {
  moduleServer(id, function(input, output, session) {
    output$map <- renderLeaflet({
      data <- filtered_data()$municipalities_with_provinces  # Get the filtered municipalities data
      
      leaflet(data) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(
          data = provinces,
          color = "black",
          weight = 1.5,
          fillColor = ~colorFactor("Set3", provinces$NAME_LATN)(NAME_LATN),
          fillOpacity = 0.7
        ) %>%
        addPolygons(
          color = "darkgray",
          weight = 0.5,
          fillColor = ~ifelse(top_5 == "Top 5", "red", "lightblue"),
          fillOpacity = 0.4,
          highlight = highlightOptions(
            weight = 2, color = "black", bringToFront = TRUE
          ),
          label = ~combined_hover,
          popup = ~combined_label
        ) %>%
        addLegend(
          position = "bottomright",
          colors = c("lightblue", "red"),
          labels = c("Other Municipalities", "Top 5 Municipalities"),
          title = "Top 5 Municipalities by Emission",
          opacity = 0.7
        )
    })
  })
}