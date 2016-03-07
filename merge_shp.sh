#!/bin/bash

# This is adapted from here:
# http://www.northrivergeographic.com/ogr2ogr-merge-shapefiles
# https://eomwandho.wordpress.com/tag/create-shapefile/

for file in `find . -name "*.shp"`
do
    BASENAME=$(echo $file | sed 's/.shp//g')
    ogr2ogr -f GeoJSON -t_srs crs:84 $BASENAME.geojson $file
done

file="language_maps.shp"

for i in `find . -name "*.shp"`
do

    if [ -f "$file" ]
    then
	echo "creating merged shapefile"
	ogr2ogr --config SHAPE_ENCODING UTF-8 -f 'ESRI Shapefile' -update -append $file $i -nln language_maps
    else
	echo "merging……"
	ogr2ogr --config SHAPE_ENCODING UTF-8 -f 'ESRI Shapefile' $file $i
fi
done

ogr2ogr -f GeoJSON -t_srs crs:84 language_maps.geojson language_maps.shp
