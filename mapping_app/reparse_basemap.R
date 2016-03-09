reparse_basemap <- function(folder = "../geojson") {
files <- list.files(folder, full.names = T)

selection <- data_frame(lang = gsub(".+//(.+).geojson", "\\1", files), geojson = files) %>% filter(lang %in% langs) %>% 
        .$geojson

# This reads each of the geojsons as spatialpolygonsdataframe

map <- llply(selection, function(x) readOGR(x, "OGRGeoJSON"))

# We rbind those into one spdf

map <- do.call(rbind, c(map, makeUniqueIDs = T))

# Some information is stored in this CSV file

library(readr)

meta <- read_csv("basic_info.csv") %>% filter(primary_polygon %in% langs)

map@data <- suppressWarnings(left_join(map@data, meta))

# This is a nice way to preview the color scheme, now it is hard-coded into file basic_info.csv, since which color each
# language gets is anyway quite specific

# library(RColorBrewer) display.brewer.all() display.brewer.pal(n = 9, name = 'Set1')

# colors <- brewer.pal(n = 9, name = 'Set1') palette <- colors

# It is bit annoying to always parse the whole thing when testing something, so I create here a new object from the map

map <- map
map@data <- suppressWarnings(left_join(map@data, cbind(map@data %>% distinct(lang) %>% select(lang), colors)))

saveRDS(map, "basemap.rds")
}
