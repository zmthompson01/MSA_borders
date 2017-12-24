library(xlsx)
library(maptools)
library(rgdal)
library(ggplot2)
library(maps)
library(scales)
library(stringr)
library(plyr)
library(dplyr)

# Download the shape files at:
# https://catalog.data.gov/dataset/tiger-line-shapefile-2016-nation-u-s-current-county-and-equivalent-national-shapefile
# extract all and place into a folder called "data" in your working directory along with the msa and key files
path = ""

#Maps data for heat maps
county_map <- map_data("county")
state_map <- map_data("state")

#Spacial data to make the MSA outlines
spacial0 <- readOGR(paste(path,"data/tl_2016_us_county.shp",sep=""))
spacial1 <- spacial0[!grepl(
    paste(c("72", "02", "15", "60", "66", "69", "74", "78"), collapse="|"), spacial0$STATEFP),]
proj4string(spacial0) <- CRS("+proj=longlat +datum=NAD27")
spacial1 <- spChFIDs(spacial1, paste(spacial1$STATEFP, spacial1$COUNTYFP, sep = ""))
proj4string(spacial1) <- CRS(proj4string(spacial1))
spacial1$FIPS <- spacial1$GEOID

if (rgeosStatus()) {
    FIPS <- row.names(spacial1)
    str(FIPS)
    length(slot(spacial1, "polygons"))
}

key0 <- read.xlsx(paste(path,"data/key.xlsx",sep=""), sheetIndex=1)
key1 <- key0[!grepl(paste(c("72", "02", "15", "60", "66", "69", "74", "78"), collapse="|"), key0$stFIPS),]
key2 <- key1[which(!is.na(match(key1$stFIPS, spacial1$STATEFP))),]
key2$FIPS <- paste(key2$stFIPS, key2$ctFIPS, sep="")

msa0 <- read.xlsx(paste(path,"data/msa.xlsx",sep=""), sheetIndex=1)
msa1 <- msa0[!grepl(paste(c("02", "15", "60", "66", "69", "72", "74", "78"), collapse="|"), msa0$stFIPS),]
msa1$FIPS <- paste(msa1$stFIPS, msa1$ctFIPS, sep="")

if (rgeosStatus()) {
ct0 <- key2[key2$stFIPS == " ",]
ma0 <- msa1[msa1$stFIPS == " ", c(1,2)]
}

if (rgeosStatus()) {#COUNTY
    MA_FIPS <- key2$FIPS[match(FIPS, key2$FIPS)]
    MA <- ct0$FIPS[match(MA_FIPS, ct0$FIPS)]
    MA_df <- data.frame(MA_FIPS = MA_FIPS, MA = MA, row.names = FIPS)
    ncscva_MA <- unionSpatialPolygons(spacial1, spacial1$GEOID)
}#County
if (rgeosStatus()) {#COUNTY
    np <- sapply(slot(ncscva_MA, "polygons"), function(x) length(slot(x,"Polygons")))
    table(np)
    MA_fips <- row.names(ncscva_MA)
    MA_name <- ct0$FIPS[match(MA_fips, ct0$CSA.Code)]
    #data.frame(MA_fips, MA_name)[np > 1, ]
}#County

if (rgeosStatus()) {#MSA
    MSA_Codes <- msa1$msaCode[match(FIPS, msa1$FIPS)]
    MSA <- ma0$msaCode[match(MSA_Codes, ma0$msaCode)]
    MSA_df <- data.frame(MSA_Codes = MSA_Codes, MSA = MSA, row.names=FIPS)
    spacial3 <- spCbind(spacial1, MSA_df) 
    ncscva_MSA <- unionSpatialPolygons(spacial3, spacial3$MSA_Codes)
}#MSA
if (rgeosStatus()) {#MSA
    np_msa <- sapply(slot(ncscva_MSA, "polygons"), function(x) length(slot(x,"Polygons")))
    table(np_msa)
    MSA_fips <- row.names(ncscva_MSA)
    MSA_name <- ma0$msaTitle[match(MSA_fips, ma0$msaCode)]
    #data.frame(MSA_fips, MSA_name)[np > 1, ]
}#MSA

theme_clean <- function(base_size = 12) {
    require(grid)
    theme_grey(base_size) %+replace%
        theme(
            axis.title = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            panel.background = element_blank(),
            panel.grid = element_blank(),
            axis.ticks.length = unit(0,"cm"),
            panel.spacing = unit(0,"lines"),
            plot.margin = unit(c(0,0,0,0),"lines"),
            legend.position = "none",
            complete = TRUE
        )
    
}#Theme
mapping <- map('county', fill = TRUE, col = 'grey90')
mapping0 <- ggplot(mapping, aes(x = long, y = lat, group=group)) +
    geom_polygon(fill='grey60') +
    coord_map("polyconic") +
    theme_clean() +
    geom_path(data = ncscva_MSA, color = "orange")
mapping0
