### Spatial Data in R
library(raster)
library(sp)
library(rgdal)
library(tidyverse)

# Read in data and create a coordinate df ---------------------------------
configHeaders <- c("BuildingID", "MeterID", "Description", "Units", "Resource", "BuildingName", "GrossSquareFeet", "BuildDate", "Latitude", "Longitude", "Campus", "Organization", "LocationType", "SteamSourceID", "ChilledWaterSourceID", "HotWaterSourceID", "Time")

building_dat <- read_csv("data/HackathonConfig.csv", col_names = configHeaders)

building_dat$BuildingID <- as.factor(building_dat$BuildingID)
building_dat$HotWaterSourceID <- as.factor(building_dat$HotWaterSourceID)
building_dat$ChilledWaterSourceID <- as.factor(building_dat$ChilledWaterSourceID)
building_dat$SteamSourceID <- as.factor(building_dat$SteamSourceID)

building_dat <- building_dat[!is.na(building_dat$Longitude),]


coords <- data.frame(X  = building_dat$Longitude,
                     Y = building_dat$Latitude)
coords <- coords[coords$X != 0,]

cpoints <- SpatialPoints(coords) #Spatial points object with no other definitions than just coordinates



