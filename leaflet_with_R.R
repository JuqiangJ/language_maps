library(rgdal)
library(plyr)
library(dplyr)
library(maptools)
library(leaflet)

# The files in folder geojson are generated from shapefiles with script shp2geojson.sh
# Now there are all shapefiles, one should think about some smarter way to specify
# which languages are in INEL.

files <- list.files("../geojson/", full.names = T)

# This is quite bad idea here, instead one should probably specify somewhere else 
# whether language is part of INEL or not. Anyway, now it is good enough to
# remove all those vector elements we don't need

files <- files[c(-2, -4, -5, -9)]

# This reads each of the geojsons as spatialpolygonsdataframe

map <- llply(files, function(x) readOGR(x, "OGRGeoJSON"))

# We rbind those into one spdf

map <- do.call(rbind, c(map, makeUniqueIDs = T))

# Ideally this would work, but it seems the geojson is still somewhat too messy
# This certainly originates from some messiness in the shapefiles to start with
# readOGR("language_maps_inel.geojson", "OGRGeoJSON")

# Some information is stored in this CSV file

library(readr)

map@data <- left_join(map@data, read_csv("basic_info.csv"))

# This is a nice way to preview the color scheme, now it is hard-coded into file
# basic_info.csv, since which color each language gets is anyway quite specific 

# library(RColorBrewer)
# display.brewer.all()
# display.brewer.pal(n = 9, name = 'Set1')

# Arranging the data here mixed it up later somehow...

# map@data <- arrange(map@data, name)

# colors <- brewer.pal(n = 9, name = "Set1")
# palette <- colors


colors <- distinct(map@data, colors) %>% .$colors
palette <- colors

# It is bit annoying to always parse the whole thing when testing something,
# so I create here a new object from the map

ready_map <- map
ready_map@data <- left_join(map@data, cbind(map@data %>% distinct(lang) %>% select(lang), colors))

ready_map@data$label <- paste0(ready_map@data$name)
labels <- distinct(ready_map@data, label) %>% .$label

# It seems that one has to add legend later, although I guess one can somehow just 
# add it to the first part as well

ready_map@data$popup <- paste0("<h2>", ready_map@data$name, "</h2><p>", ready_map@data$name, ' is a language spoken here.</p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Nenets.jpg/732px-Nenets.jpg" style="width:304px;height:228px;"><audio controls><source src="http://larkpie.net/siberianlanguages/sites/siberianlanguages/files/audio_compressed/NENETS_01_09.mp3" type="audio/mpeg"></audio>')

m <- leaflet(ready_map) %>% setView(lng = 90, lat = 60, zoom = 3) %>% addTiles() %>% 
        addPolygons(weight = 2 , fillColor = ~colors, opacity = 0, fillOpacity = 1, popup = ~popup)

addLegend(map = m, position = "bottomleft", colors = ~palette, labels = ~labels, opacity = 1)

## The same with other tiles



m <- leaflet(ready_map) %>% setView(lng = 90, lat = 60, zoom = 3) %>% 
        addProviderTiles("CartoDB.Positron") %>% 
        addPolygons(weight = 2, fillColor = ~colors, opacity = 0, fillOpacity = 1, popup = ~popup)

addLegend(map = m, position = "bottomleft", colors = ~palette, labels = ~labels, opacity = 1)

## OpenTopoMap
 
m <- leaflet(ready_map) %>% setView(lng = 90, lat = 60, zoom = 3) %>% 
addProviderTiles("MapQuestOpen.Aerial") %>% 
        addPolygons(weight = 2, fillColor = ~colors, opacity = 0, fillOpacity = 0.8, popup = ~name)

addLegend(map = m, position = "bottomleft", colors = ~palette, labels = ~labels, opacity = 1)
