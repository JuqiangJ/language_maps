library(rgdal)
mammals <- readOGR("../ext_data/", "TERRESTRIAL_MAMMALS")

library(maps)

library(dplyr)

mammals@data %>% distinct(order_name)

point <- data.frame(lon=70, lat=60)
point   <- SpatialPoints(point,proj4string=CRS(proj4string(mammals)))

nPolys <- sapply(mammals@polygons, function(x)length(x@Polygons))

eur <- mammals[which(nPolys==max(nPolys)),]

eur@data

plot(region)
