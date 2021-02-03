#==============
# IICA Analysis
#==============

# Cleaning the R environment
rm(list = ls())

# Loading libraries
library(ncdf4)
library(fields)
library(maps)
library(lubridate)

#---------------------
# Reading the .nc data
#---------------------

path_data = "C:/Users/jninanya/OneDrive - CGIAR/Desktop/IICA - Ecuador/Chimborazo - Tungurahua/Mensuales/Prec/Hist/"
name_file = "pr_day_Ecuador_Ensamble_1981.nc"
nc.data = nc_open(paste0(path_data, name_file))

lon = ncvar_get(nc.data, "lon")
lat = ncvar_get(nc.data, "lat")
time = ncvar_get(nc.data, "time")
precip = ncvar_get(nc.data, "precip")

nc_close(nc.data)

t = 2
pp = precip[, length(lat):1, t]
image(pp)

