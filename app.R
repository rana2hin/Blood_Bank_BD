# -----------------------------------------------------------------
# SCRIPT 2: SHINY APPLICATION (Corrected Version)
# Filename: app.R
# -----------------------------------------------------------------

# Load necessary packages
library(shiny)
library(leaflet)

# --- 1. Load the Pre-generated Data ---
# Make sure 'blood_banks_bd.rds' is in the same folder as this app.R file.
if (file.exists("blood_banks_bd.rds")) {
  blood_banks_data <- readRDS("blood_banks_bd.rds")
} else {
  stop("Error: 'blood_banks_bd.rds' not found. Please run the data generation script first.")
}


# --- 2. Define the User Interface (UI) ---
ui <- fluidPage(
  titlePanel("Blood Bank Locations in Bangladesh"),
  
  # CHANGE 1: Set a robust height for the map output.
  # "95vh" means 95% of the browser's viewport height. This is more reliable than "100%".
  leafletOutput("bangladeshMap", width = "100%", height = "95vh")
)

# --- 3. Define the Server Logic (with Red Icons) ---
server <- function(input, output, session) {

  # Define a custom red icon
  redIcon <- makeIcon(
    iconUrl = "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
    iconWidth = 25, iconHeight = 41,
    iconAnchorX = 12, iconAnchorY = 41
  )

  # Create the Leaflet map
  output$bangladeshMap <- renderLeaflet({
    leaflet(data = blood_banks_data) %>%
      addTiles() %>%
      setView(lng = 90.3563, lat = 23.6850, zoom = 7) %>%
      addMarkers(
        lng = ~Longitude,
        lat = ~Latitude,
        icon = redIcon,  # <-- ADD THIS LINE
        popup = ~paste0(
          "<b>", Name, "</b><br>",
          "<b>Address:</b> ", Address, "<br>",
          "<b>Contact:</b> ", Contact
        ),
        clusterOptions = markerClusterOptions()
      )
  })
}

# --- 4. Run the Shiny App ---
shinyApp(ui, server)