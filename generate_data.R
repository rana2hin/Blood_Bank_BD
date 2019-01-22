# -----------------------------------------------------------------
# SCRIPT 1: GENERATE AND SAVE SYNTHETIC BLOOD BANK DATA
# Filename: generate_data.R
# This version uses a local shapefile.
# -----------------------------------------------------------------

# Install required packages if they are not already installed
if (!require(sf)) install.packages("sf")
if (!require(dplyr)) install.packages("dplyr")

# Load libraries
library(sf)
library(dplyr)

# --- Step 1: Load Bangladesh's administrative boundary from local shapefile ---
# Make sure your .shp file and its associated files are in the same directory as this script.
shapefile_path <- "shp/bgd_admbnda_adm0_bbs_20201113.shp"

if (!file.exists(shapefile_path)) {
  stop("Error: Shapefile not found. Please ensure '", shapefile_path, "' is in the working directory.")
}

message("Loading shapefile...")
bangladesh_sf <- st_read(shapefile_path)
message("Shapefile loaded successfully.")

# --- Step 2: Generate random points strictly within the boundary ---
set.seed(42) # for reproducibility
num_blood_banks <- 60
# st_sample ensures all points are within the polygon(s) of the shapefile
points_sf <- st_sample(bangladesh_sf, size = num_blood_banks)

# --- Step 3: Get coordinates from the generated points ---
coords <- st_coordinates(points_sf)
coords_df <- as.data.frame(coords)
names(coords_df) <- c("Longitude", "Latitude")

# --- Step 4: Create realistic names and other details ---
# Using a sample of real blood bank names in Bangladesh for realism
real_names <- c(
  "Quantum Lab, Dhaka", "Badhan Blood Bank", "Red Crescent Blood Bank, Dhaka",
  "Police Blood Bank, Dhaka", "Thalassaemia Hospital Blood Bank",
  "Sandhani, DMCH", "Fatema Begum Red Crescent Blood Center", "Sir Salimullah Medical College Hospital Blood Bank",
  "Holy Family Red Crescent Medical College Hospital Blood Bank", "Combined Military Hospital (CMH) Blood Bank",
  "Bangladesh Red Crescent Society National Headquarters", "Blood Bank, BSMMU",
  "Quantum Blood Bank, Chittagong", "Sandhani, CMCH", "Lions Club Blood Bank, Chittagong",
  "Niramoy Clinic Blood Bank", "Islami Bank Hospital Blood Bank", "Medical Center Clinic Blood Bank",
  "Red Crescent Blood Bank, Sylhet", "Sandhani, MAG Osmani Medical College", "Ibn Sina Hospital Sylhet Blood Bank",
  "Al-Haramain Hospital Blood Bank", "North East Medical College Hospital Blood Bank",
  "Gonoshasthaya Kendra Blood Bank", "Sandhani, Rajshahi Medical College", "Red Crescent Blood Bank, Rajshahi",
  "Islami Bank Medical College Hospital Blood Bank", "Quantum Blood Bank, Khulna",
  "Sandhani, Khulna Medical College", "Gazi Medical College Hospital Blood Bank"
)

# Generate the final dataset
blood_banks_data <- coords_df %>%
  mutate(
    Name = sample(real_names, num_blood_banks, replace = TRUE),
    # For a placeholder address, we can just use "Bangladesh"
    Address = paste(
      sample(1:200, num_blood_banks, replace = TRUE),
      sample(c("Main Road", "Hospital Road", "College Avenue", "Kazi Nazrul Islam Ave"), num_blood_banks, replace = TRUE),
      "Bangladesh"
    ),
    Contact = paste("01", round(runif(num_blood_banks, 300000000, 999999999)), sep = "")
  ) %>%
  select(Name, Address, Contact, Latitude, Longitude) # Reorder columns

# --- Step 5: Save the dataset to an RDS file ---
saveRDS(blood_banks_data, "blood_banks_bd.rds")

message("Data generation complete. 'blood_banks_bd.rds' has been saved successfully.")

# You can preview the first few rows of the data
# print(head(blood_banks_data))