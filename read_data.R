library(tidyverse)
library(sp)
library(rgdal)


dataHeaders <- c("MeterID", "CurrentValue", "ValueString", "Time", "BuildingName", "Units", "Status", "StatusCode")
# MeterID |              Meter identifier, will have a match in the config file
# CurrentValue |         Most precise measurement value
# ValueString |          Less precise measurement value
# Time |                 Time of measurement in UTC, format yyyy-mm-ddThh:mm:ssZ
# Status |               Sometimes meters malfunction, this indicates if this measurement is OK or UNRELIABLE
# StatusCode |           Numeric representation of status

configHeaders <- c("BuildingID", "MeterID", "Description", "Units", "Resource", "BuildingName", "GrossSquareFeet", "BuildDate", "Latitude", "Longitude", "Campus", "Organization", "LocationType", "SteamSourceID", "ChilledWaterSourceID", "HotWaterSourceID", "Time")
# MeterID |              Meter identifier, will have a match in the config file
# Description |          Description of what the meter is measuring
# Units |                Unit of measurement for this meter
# Resource |             Resource measured by this meter, can be Chilled Water, Heating Hot Water, Steam, or Electricity
# BuildingID |           ID for the building where this meter is located
# BuildingName |         Name of this building
# GrossSquareFeet |      Size of this building in square feet
# BuildDate |            Construction date of this building
# Latitude |             Latitude coordinate of this building
# Longitude |            Longitude coordinate of this building
# Campus |               Can be Main or Medical Center
# Organization |         Organization which manages this building
# LocationType |         Category of usage of this building
# SteamSourceID |        BuildingID representing the source of steam of this building (1)
# ChilledWaterSourceID | BuildingID representing the source of chilled water of this building (1)
# HotWaterSourceID |     BuildingID representing the source of hot water of this building (1)


config <- read_csv("data/HackathonConfig.csv",col_names = configHeaders)
dataDaily <- read_csv("data/HackathonDataDaily.csv", col_names = dataHeaders)
dataHourly1 <- read_csv("data/HackathonDataHourly1of2.csv", col_names = dataHeaders)
dataHourly2 <- read_csv("data/HackathonDataHourly1of2.csv", col_names = dataHeaders)
dataHourly <- rbind(dataHourly1, dataHourly2)
rm(dataHourly1)
rm(dataHourly2)
