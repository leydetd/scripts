## NetCDF to csv conversion script
## Reference: https://help.marine.copernicus.eu/en/articles/6328012-how-to-convert-netcdf-to-csv-using-r
## Date: 20230326


## Required libraries

library(lubridate) ##dealing with dates/time
library(ncdf4) ##dealing with NetCDF files


setwd ("~/Desktop/University of Utah PhD /Research/r_code/")

## Load data
nc_fname <- "../data/spei/spei12.nc"
nc_ds <- nc_open(nc_fname)


## Extract coordinates

dim_lon <- ncvar_get(nc_ds, "lon")
dim_lat <- ncvar_get(nc_ds, "lat")

## Depth is optional if you have a depth dimension
dim_depth <- ncvar_get(nc_ds, "depth")

dim_time <- ncvar_get(nc_ds, "time")


## Time Conversion

t_units <- ncatt_get(nc_ds, "time", "units")
t_ustr <- strsplit(t_units$value, " ")
t_dstr <- strsplit(unlist(t_ustr)[3], "-")
date <- ymd(t_dstr) + dseconds(dim_time)
date

##My own conversion
##Convert days from 1900-01-01 to year date
date2 = as.Date(dim_time, origin = "1900-01-01")

## Coordinate Matrix
#coords <- as.matrix(expand.grid(dim_lon, dim_lat, dim_depth, date))

coords <- as.matrix(expand.grid(dim_lon, dim_lat, date2))

## Variable Extraction
## In the code below, please replace var1 and var2 with the actual names: 

var1 <- ncvar_get(nc_ds, "var1", collapse_degen=FALSE)
var2 <- ncvar_get(nc_ds, "var2", collapse_degen=FALSE)

## Check



## Export as a csv file

nc_df <- data.frame(cbind(coords, var1, var2))
names(nc_df) <- c("lon", "lat", "depth", "time", "var1", "var2")
head(na.omit(nc_df), 5)  # Display some non-NaN values for a visual check
csv_fname <- "netcdf_filename.csv"
write.table(nc_df, csv_fname, row.names=FALSE, sep=";")




