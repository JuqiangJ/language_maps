library(plyr)
library(dplyr)
library(leaflet)

# The files in folder geojson are generated from shapefiles with script shp2geojson.sh Now there are all shapefiles, one
# should think about some smarter way to specify which languages one wants to map. Of course one could write a small function
# which takes the names of the files as an argument. This is maybe a good idea, as it could be even very easy to have that as
# a Shiny application...

create_leaflet <- function(langs = c("dlg-all", "evn-all", "ket", "koi-j", "koi", "sel", "tat-sib", "xas", "yrk"), empty = F) {
        
        m <- leaflet() %>% setView(lng = 90, lat = 60, zoom = 3) %>% 
                addTiles()
        map <- subset(map, lang %in% langs)
        a <- m %>% addPolygons(data = map, weight = 2, fillColor = ~colors, opacity = 0, fillOpacity = 0.8, popup = ~name)
        a

#        p <- a %>% addLegend(map = ep, position = "bottomleft", labels = ~labels, colors = ~palette, opacity = 1)
#        p
}


## The same with other tiles

# m <- leaflet(ready_map) %>% setView(lng = 90, lat = 60, zoom = 3) %>% addProviderTiles('CartoDB.Positron') %>%
# addPolygons(weight = 2, fillColor = ~colors, opacity = 0, fillOpacity = 1, popup = ~name) addLegend(map = m, position =
# 'bottomleft', colors = ~palette, labels = ~labels, opacity = 1) ## OpenTopoMap m <- leaflet(ready_map) %>% setView(lng = 90,
# lat = 60, zoom = 3) %>% addProviderTiles('MapQuestOpen.Aerial') %>% addPolygons(weight = 2, fillColor = ~colors, opacity =
# 0, fillOpacity = 0.8, popup = ~name) addLegend(map = m, position = 'bottomleft', colors = ~palette, labels = ~labels,
# opacity = 1) 
