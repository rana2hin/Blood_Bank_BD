# Blood Bank Locator - Bangladesh

An interactive R Shiny application to visualize the locations of blood banks across Bangladesh on a Leaflet map. This project uses a synthetically generated dataset, with the flexibility to easily integrate real-world data.



## About The Project

This application was built to provide a simple yet powerful tool for locating blood banks. It serves as a template that can be expanded with real data for public use. The map is interactive, allowing users to pan, zoom, and click on locations to get more information.

### Features

*   **Interactive Map:** Utilizes Leaflet for a smooth, user-friendly map interface.
*   **Custom Icons:** Uses custom blood drop icons for clear and thematic location marking.
*   **Informative Popups:** Clicking on a blood bank reveals its name, address, and contact number.
*   **Marker Clustering:** Automatically groups nearby markers at higher zoom levels for better visibility.
*   **Scalable Design:** The data generation process is separate from the Shiny app, allowing for easy replacement with a real dataset.
*   **Reproducible Environment:** The scripts are designed to work on any machine with the required R packages installed.

## Technology Stack

This project is built entirely in the R programming language and relies on the following core packages:

*   **[R](https://www.r-project.org/)**: The programming language.
*   **[Shiny](https://shiny.rstudio.com/)**: The web application framework for R.
*   **[Leaflet](https://rstudio.github.io/leaflet/)**: The mapping and visualization library.
*   **[sf (Simple Features)](https://r-spatial.github.io/sf/)**: Used for spatial data handling to ensure locations are within Bangladesh's borders.
*   **[dplyr](https://dplyr.tidyverse.org/)**: Used for data manipulation.

## Project Structure

The project is organized into a few key files and folders:

```
blood-bank-app/
│
├── www/
│   └── blood_drop.png        # Folder for web assets like images
│
├── generate_data.R           # R script to create the synthetic dataset
├── blood_banks_bd.rds        # The output dataset used by the app
│
├── bgd_admbnda_adm0_bbs_20201113.shp  # Shapefile for Bangladesh's boundary
├── bgd_admbnda_adm0_bbs_20201113.shx  # (and other associated shapefile parts)
│
└── app.R                     # The main R Shiny application script
```

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

You need to have R and RStudio installed on your computer.
*   [Download R](https://cran.r-project.org/)
*   [Download RStudio Desktop (Free)](https://rstudio.com/download/rstudio-desktop/)

### Installation and Setup

1.  **Download the Project:**
    Download or clone this project's files to a new folder on your computer.

2.  **Organize Files:**
    Place all the project files in the root of your new folder as shown in the `Project Structure` section above.
    *   Crucially, ensure your shapefile (`.shp`, `.shx`, `.dbf`, `.prj`, etc.) is in the main directory.
    *   Create a folder named `www` and place the `blood_drop.png` icon inside it.

3.  **Install R Packages:**
    Open RStudio and run the following command in the console to install all the necessary packages:
    ```R
    install.packages(c("shiny", "leaflet", "sf", "dplyr"))
    ```

4.  **Generate the Dataset:**
    *   Open the `generate_data.R` script in RStudio.
    *   Set your working directory to the project folder by going to `Session > Set Working Directory > To Source File Location`.
    *   Run the entire script. This will read your shapefile and create the `blood_banks_bd.rds` file which is required by the app. You only need to do this once.

### How to Run the App

1.  Open the `app.R` file in RStudio.
2.  Click the **"Run App"** button that appears at the top of the script editor.
3.  The application will launch in a new window or in the RStudio viewer pane.

---

## Future Improvements

This application provides a strong foundation that can be extended with more features:

*   **Use Real Data:** Replace the synthetic `.rds` file with an actual, verified dataset of blood banks.
*   **Add Filtering:** Implement dropdowns or checkboxes to filter blood banks by division, district, or city.
*   **Search Functionality:** Add a search bar to find the nearest blood bank to a specific address or location.
*   **Data Table View:** Display the blood bank information in a searchable, sortable table alongside the map.
*   **Deployment:** Deploy the application to a service like [shinyapps.io](https://www.shinyapps.io/) to make it publicly accessible.