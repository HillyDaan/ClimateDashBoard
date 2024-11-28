library(shiny)
library(giscoR)
library(sf)
library(leaflet)
library(dplyr)
library(readxl)
library(ggplot2)
library(DT)
library(shinydashboard)

# Load municipalities data / fetch if already exist
if (!file.exists("data/municipalities.rds")) {
  municipalities <- gisco_get_lau(year = 2021, country = "NL")
  saveRDS(municipalities, "data/municipalities.rds")
} else {
  municipalities <- readRDS("data/municipalities.rds")
}

# Fetch provinces (NUTS level 2 )
provinces <- gisco_get_nuts(country = "NL", nuts_level = 2, resolution = 3, year = "2021")

# Load emission data
file_path <- "data/ER_Data.xlsx"
emission_data <- read_excel(file_path, sheet = 2)

