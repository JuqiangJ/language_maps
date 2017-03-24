# INEL maps

This repository contains language maps in Shapefile and GeoJSON formats. Please notice that the actual files are always edited as Shapefiles, from which the GeoJSON is derived. This is a very nice workflow (in my opinion), as it allows editing just one file, and Shapefiles are easy to work with in programs like QGIS. Please notice that this model demands quite a bit of accuracy with each shapefile having the same structure, as we want to be able to parse and mix them in different ways without worrying about idiosynchronic decisions.

At the moment each Shapefile has just a few columns in data attribute tables: lang, dial, comment and desc. The **lang** basically contains the iso-code, although this is problematic as some languages don't have those. I was thinking to use **dial** to mark more specifically which dialect which polygon represents. **comment** is for random comments and I was thinking **desc** could be for some sort of description, but now when I think about it the descriptions should probably be language/dialect specific and be stored in their own files somewhere. Another possible field could of course be **source**, although this could also be in another file and specified for each modifications in Git commits when making changes to the files. 

The easiest way to correct mistakes in this data would be to clone the repository, change the shapefiles and run again the script `shp2geojson.sh`. This demands few tools to be installed:

- [gdal](http://www.gdal.org/)
- [geojson-merge](https://github.com/mapbox/geojson-merge)

### Example

There are lots of uses for this kind of data. One of the reasons why the Shapefiles are transformed also to GeoJSON is that it is possible to view them directly in GitHub file viewer. Try this by visiting geojson folder.

## License

This work is based on Niko Partanen's earlier personal work, but the work on these files during 2016-2017 was conducted entirely within INEL. There is another repository for Niko Partanen's other [language maps](https://github.com/nikopartanen/language_maps), but the most up to date INEL maps are naturally located in this inel_maps repository. The license for these maps is CC-BY INEL 2017. 