# Display bar graph of top 5 municipalities by emission per year.

plotUI <- function(id) {
  ns <- NS(id)
  box(
    title = "Top 5 Emitting Municipalities", 
    width = 6, 
    status = "info", 
    solidHeader = TRUE, 
    plotOutput(ns("emission_plot"), height = 400)
  )
}

plotServer <- function(id, filtered_data) {
  moduleServer(id, function(input, output, session) {
    output$emission_plot <- renderPlot({
      # Extract municipality data from the filtered data
      data <- filtered_data()$municipalities_with_provinces
      
      # Select the top 5 municipalities by total emissions
      top_5_municipalities <- data %>%
        filter(!is.na(total_emissie)) %>%
        arrange(desc(total_emissie)) %>%
        slice_head(n = 5)  # Take the top 5
      
      # Generate the bar plot
      ggplot(top_5_municipalities, aes(x = reorder(LAU_NAME, total_emissie), y = total_emissie)) +
        geom_bar(stat = "identity", fill = "steelblue") +
        labs(
          title = "Total Emissions by Municipality",
          x = "Municipality",
          y = "Total Emissions (kg CO2)"
        ) +
        theme_minimal() +
        theme(
          axis.text.x = element_text(angle = 45, hjust = 1)
        )
    })
  })
}