filter_emission_data <- function(year, municipalities, provinces, emission_data) {
  # Filter the emission data for the selected year
  year_data <- emission_data %>% filter(Jaar == year)
  
  # Process municipalities and join with emission data
  municipalities_with_provinces <- municipalities %>%
    st_join(provinces %>% select(NAME_LATN), left = FALSE) %>%  # Spatial join with provinces
    left_join(year_data, by = c("LAU_NAME" = "Gebied")) %>%  # Join emission data by 'LAU_NAME' and 'Gebied'
    group_by(LAU_NAME, NAME_LATN) %>%
    summarise(
      total_emissie = sum(Emissie, na.rm = TRUE),  # Sum emission per municipality
      .groups = "drop"
    ) %>%
    mutate(
      # Combined label for both hover and popup
      combined_label = paste0(
        "Gemeente ", LAU_NAME, " (", NAME_LATN, "): ",
        "<br> Total Emissie: ", round(total_emissie, 2), " kg CO2 "
      ),
      # Hover label: more basic info for the hover tooltip
      combined_hover = paste0(
        "Gemeente ", LAU_NAME, " (", NAME_LATN, ")"
      )
    )
  
  return(municipalities_with_provinces)
}