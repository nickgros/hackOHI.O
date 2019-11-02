### Spatial Data in R
library(raster)
library(sp)
library(rgdal)
library(tidyverse)
library(leaflet)

# Read in data and create a coordinate df ---------------------------------
configHeaders <- c("BuildingID", "MeterID", "Description", "Units", "Resource", "BuildingName", "GrossSquareFeet", "BuildDate", "Latitude", "Longitude", "Campus", "Organization", "LocationType", "SteamSourceID", "ChilledWaterSourceID", "HotWaterSourceID", "Time")

building_dat <- read_csv("data/HackathonConfig.csv", col_names = configHeaders)

building_dat$BuildingID <- as.factor(building_dat$BuildingID)
building_dat$HotWaterSourceID <- as.factor(building_dat$HotWaterSourceID)
building_dat$ChilledWaterSourceID <- as.factor(building_dat$ChilledWaterSourceID)
building_dat$SteamSourceID <- as.factor(building_dat$SteamSourceID)

building_dat <- building_dat[!is.na(building_dat$Longitude) & building_dat$Longitude != 0,]

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=building_dat$Longitude, lat=building_dat$Latitude, popup=building_dat$BuildingName)
