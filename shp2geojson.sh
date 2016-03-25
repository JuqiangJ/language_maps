#!/bin/bash

# This is adapted from here:
# http://www.northrivergeographic.com/ogr2ogr-merge-shapefiles
# https://eomwandho.wordpress.com/tag/create-shapefile/

# On Linux ogr2ogr does not want to overwrite files, so let's empty that directory always in the beginning
# This is a good practice in the sense that we want the geojson to be always generated from the shapefiles anyway.

rm ./geojson/*

# This merges kom-shapefile from different Komi varieties

rm ./langs/kom/*

ogr2ogr -f 'ESRI Shapefile' ./langs/kom/kom.shp ./langs/kpv/kpv.shp
ogr2ogr -f 'ESRI Shapefile' -update -append ./langs/kom/kom.shp ./langs/koi/koi.shp -nln kom
ogr2ogr -f 'ESRI Shapefile' -update -append ./langs/kom/kom.shp ./langs/koi-j/koi-j.shp -nln kom

# This creates the geojsons

for file in `find ./langs/ -name "*.shp"`
do
    BASENAME=$(echo $(basename $file) | sed 's/.shp//g')
    ogr2ogr -f GeoJSON -t_srs crs:84 ./geojson/$BASENAME.geojson $file
done

# I found this tool from here
# https://github.com/mapbox/geojson-merge

geojson-merge geojson/*.geojson > language_maps.geojson

## This has only INEL languages

geojson-merge ./geojson/dlg.geojson ./geojson/sel.geojson ./geojson/evn.geojson ./geojson/evn-all.geojson ./geojson/ket.geojson ./geojson/koi.geojson ./geojson/koi-j.geojson ./geojson/tat-sib.geojson ./geojson/xas.geojson ./geojson/yrk.geojson > language_maps_inel.geojson

## This creates the cut isogloss map for Komi

rm isoglosses/kom_isogloss_1_cut.shp
ogr2ogr -clipsrc langs/kom/kom.shp isoglosses/kom_isogloss_1_cut.shp isoglosses/kom_isogloss.shp

# file="language_maps.shp"

# for i in `find . -name "*.shp"`
# do

#    if [ -f "$file" ]
#    then
#	echo "creating merged shapefile"
#	ogr2ogr --config SHAPE_ENCODING UTF-8 -f 'ESRI Shapefile' -update -append $file $i -nln language_maps
#    else
#	echo "merging……"
#	ogr2ogr --config SHAPE_ENCODING UTF-8 -f 'ESRI Shapefile' $file $i
# fi
# done

# ogr2ogr -f GeoJSON -t_srs crs:84 language_maps.geojson language_maps.shp
