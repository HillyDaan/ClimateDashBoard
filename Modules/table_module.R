# Displays top companies by emission for selected year.

tableUI <- function(id) {
  ns <- NS(id)
  box(
    title = "Top Companies by Emissions", 
    width = 6, 
    solidHeader = TRUE,
    status = "info", 
    DTOutput(ns("top_companies_table"), height = 400)
  )
}

tableServer <- function(id, filtered_data) {
  moduleServer(id, function(input, output, session) {
    output$top_companies_table <- renderDT({
      # Extract the top companies' data from the filtered data
      data <- filtered_data()$top_5_companies_per_municipality
      
      # Render the data table
      datatable(
        data,
        options = list(
          pageLength = 5,  # Show 5 rows per page
          autoWidth = TRUE,
          dom = 't',       # Simplify table interface
          scrollX = TRUE   # Allow horizontal scrolling for wide tables
        ),
        rownames = FALSE
      )
    })
  })
}