
# Emissions Dashboard

This is a web-based dashboard application designed to analyze and visualize emissions data in the Netherlands. The project uses **Emissieregistratie Nederland** data to provide an interactive experience for exploring CO2 emissions across various municipalities and companies.

## Features

### Must-Have Features (Implemented ✅)
- **Interactive Map**: 
  - Displays a map of municipalities in the Netherlands with emission data.
  - Each municipality is color-coded based on emission levels.
  - Hover over a municipality to see details about emissions, including the top 5 CO2-emitting companies.
- **Top Companies by Emission**:
  - A table showing the top 5 companies contributing to CO2 emissions in selected municipalities.
  - Table is dynamically updated based on the selected year.
- **Yearly Data Selection**:
  - Users can select the year for which to view emission data, with historical data available for multiple years.
- **Bar Graph**:
  - Visual representation of emissions data by municipality or company in a bar chart format.

### Should-Have Features (Planned 🚧)
- **Future Scenarios**:
  - Integrating predictive models to visualize future emission scenarios based on trends.
  - Analyzing the potential impact of policy changes on emissions.
- **Additional Graph Types**:
  - Pie charts and line graphs for emissions data comparison over time.

### Could-Have Features (Future Ideas 💡)
- **Advanced Data Filtering**:
  - Users can filter data by different factors such as industry type or emission source.
- **Dynamic Reports**:
  - Export emission data in CSV or PDF format for further analysis.

## Development Details

- **Purpose**: This project serves to visualize emission data in an interactive and user-friendly way, focusing on insights and trends in CO2 emissions across municipalities and industries in the Netherlands. Mainly used as a learning project for R
- **Tech Stack**: The application is built using **Shiny** for the frontend and backend, **Leaflet** for mapping, and **dplyr** and **ggplot2** for data manipulation and visualization.
- **Progress**: All **Must-Have** features have been implemented, with further analysis features planned.

## Installation and Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/emissions-dashboard.git
   cd emissions-dashboard
   ```
2. Install the required dependencies:
   ```bash
   install.packages(c("shiny", "leaflet", "dplyr", "ggplot2", "DT", "giscoR", "shinydashboard", "ggplo2", "readxl", "sf"))
   ```
3. Run the application:
   ```bash
   shiny::runApp()
   ```


