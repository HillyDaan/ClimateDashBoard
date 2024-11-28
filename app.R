source("global.R")
source("modules/map_module.R")
source("modules/plot_module.R")
source("modules/table_module.R")
source("utils.R")

#Set up UI

ui <- dashboardPage(
  dashboardHeader(title = "Emissions Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      selectInput("year_input", "Select Year:", 
                  choices = unique(emission_data$Jaar), selected = 2020)
    )
  ),
  dashboardBody(
    fluidRow(mapUI("map")),
    fluidRow(
      plotUI("emission_plot"),
      tableUI("top_companies_table")
    )
  )
)

#Set up server
server <- function(input, output, session) {
  
  # Reactive expression to filter data by the selected year
  filtered_data <- reactive({
    # Process the filtered data
    municipalities_with_provinces <- filter_emission_data(input$year_input, municipalities, provinces, emission_data)
    
    # Create the top 5 municipalities
    top_5_municipalities <- municipalities_with_provinces %>%
      arrange(desc(total_emissie)) %>%
      slice_head(n = 5)
    
    municipalities_with_provinces <- municipalities_with_provinces %>%
      mutate(top_5 = ifelse(LAU_NAME %in% top_5_municipalities$LAU_NAME, "Top 5", "Other"))
    
    #Create company records
    year_data <- emission_data %>%
      filter(Jaar == input$year_input)
    # Aggregate emission data by both municipality and company
    company_emissions <- year_data %>%
      group_by(Gebied, Bedrijf) %>%
      summarise(
        company_emissie = sum(Emissie, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      arrange(desc(company_emissie))  # Sort companies by total emissions
    
    # For each municipality, get the top 5 companies by emissions
    top_5_companies_per_municipality <- company_emissions %>%
      group_by(Gebied) %>%
      slice_head(n = 5) %>%  # Get the top 5 companies by emissions
      ungroup()
    
    # Create a label for the top 5 companies
    top_5_companies_label <- top_5_companies_per_municipality %>%
      group_by(Gebied) %>%
      summarise(
        top_companies = paste0(
          Bedrijf, ": ", round(company_emissie, 2), " ",
          collapse = "<br>"
        ),
        .groups = "drop"
      )
    
    # Merge the top companies information back into the municipalities data
    municipalities_with_provinces <- municipalities_with_provinces %>%
      left_join(top_5_companies_label, by = c("LAU_NAME" = "Gebied")) %>%
      mutate(
        combined_label = paste0(
          combined_label, 
          "<br><b>Top 5 Companies:</b><br>", 
          ifelse(is.na(top_companies), "No data available", top_companies)  # Add top companies to label
        )
      )
    
    
    # Return the required data for the map and other modules
    return(list(
      municipalities_with_provinces = municipalities_with_provinces,
      top_5_companies_per_municipality = top_5_companies_per_municipality
    ))
  })
  

  # Call the map module and pass filtered data and provinces
  mapServer("map", filtered_data = filtered_data, provinces = provinces)
  
  # Call the table module and pass filtered data
  tableServer("top_companies_table", filtered_data = filtered_data)
  
  # Call the plot module and pass filtered data
  plotServer("emission_plot", filtered_data = filtered_data)
}


#Run shiny application
shinyApp(ui = ui, server = server)