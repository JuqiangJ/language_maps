# Free language maps for different uses

This repository contains language maps in Shapefile and GeoJSON formats. Please notice that the actual files are always edited as Shapefiles, from which the GeoJSON is derived. This is a very nice workflow (in my opinion), as it allows editing just one file, and Shapefiles are easy to work with in programs like QGIS. Please notice that this model demands quite a bit of accuracy with each shapefile having the same structure, as we want to be able to parse and mix them in different ways without worrying about idiosynchronic decisions.

At the moment each Shapefile has just a few columns in data attribute tables: lang, dial, comment and desc. The **lang** basically contains the iso-code, although this is problematic as some languages don't have those. I was thinking to use **dial** to mark more specifically which dialect which polygon represents. **comment** is for random comments and I was thinking **desc** could be for some sort of description, but now when I think about it the descriptions should probably be language/dialect specific and be stored in their own files somewhere. Another possible field could of course be **source**, although this could also be in another file and specified for each modifications in Git commits when making changes to the files. 

It would probably be ideal if changes would be somehow discussed and coordinated in GitHub issues so that the decisions would be also publicly available later. The language boundaries are probably somewhat disputed topics, and what I like in these digital files is that it is always possible to go to the actual village level.

The easiest way to correct mistakes in this data would be to clone the repository, change the shapefiles and run again the script `shp2geojson.sh`. This demands few tools to be installed:

- [gdal](http://www.gdal.org/)
- [geojson-merge](https://github.com/mapbox/geojson-merge)

If you have some suggestions about better workflows, please let me know!

### Languages already almost in a good shape

- bua
- chm
- clw
- fin
- has
- kca
- lud
- mns
- mtm
- nio
- olo
- sah
- tyv
- udm
- ykg
- yug

I try to add these as soon as I get files bit harmonized and checked. If you have your own Shapefiles of any language, feel free to push them here!

One model I've had in mind is that new languages could be added just as very approximate polygon blobs, which would gradually be edited so that each change is recorded into Git log files.

## Things to consider

In many ways the maps currently here (first half of 2016) represent the areas on which these languages were spoken some hundred years ago. Some may even be anachronic in the sense that they mix different time levels, i.e. the earlier areas and results of later forced resettlements.

Ideally for each language there would be several maps with some indication about the historical period it attempts to represent. Of course here the use of some sources comes even more critical.

There are some languages, for example Evenki, for which I have currently included one Shapefile with individual villages marked with small dots, and another where there is a larger polygon which covers the whole area. These show so different things that it may be useful to have both Shapefiles available. I guess one just has to come up with some naming convention for different types. What makes it bit problematic is that with some more southern languages there is already such a population density that keeping drawing some polygon around the area is only sensible option.

Of course cases where we are having just individual villages those could be in form of point Shapefile. This should probably be connected somehow to the villages as they are marked in OpenStreetMaps.

## License

I haven't thought too much about this, I guess this kind of "common knowledge" should just be here with CC0, but as so many people advice against it, let the license be for now:

CC-BY Niko Partanen 2016

This license will naturally not be valid for all the data once there are more contributors, and then this has to be thought again.