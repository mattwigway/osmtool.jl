# OSMTool.jl

This is Julia tool to manipulate OSM data. Its main functionality is to convert OSM data to [ArchGDAL](https://github.com/yeesian/ArchGDAL.jl) supported formats, optionally splitting ways at intersections to create a routable GIS file.

usage: osmtool [--filter-ways FILTER-WAYS]
               [--filter-nodes FILTER-NODES]
               [--no-relations NO-RELATIONS]
               [--write-gdal-ways WRITE-GDAL-WAYS]
               [--write-gdal-nodes WRITE-GDAL-NODES]
               [--gdal-driver GDAL-DRIVER] [--gdal-tags GDAL-TAGS]
               [--split-ways-at-intersections]
               [--speed-table SPEED-TABLE] [-h] [input_file]

positional arguments:
  input_file            Input file, OSM PBF format

optional arguments:
  --filter-ways FILTER-WAYS
                        Filter ways based on tags
  --filter-nodes FILTER-NODES
                        Filter nodes based on tags
  --no-relations NO-RELATIONS
                        Don't parse relations
  --write-gdal-ways WRITE-GDAL-WAYS
                        Write ways to a GDAL file
  --write-gdal-nodes WRITE-GDAL-NODES
                        Write nodes to a GDAL file
  --gdal-driver GDAL-DRIVER
                        GDAL driver to use (default 'ESRI Shapefile')
                        (default: "ESRI Shapefile")
  --gdal-tags GDAL-TAGS
                        Tags to retain in GDAL output, comma-separated
                        (default: "highway,name")
  --split-ways-at-intersections
                        Break ways at intersection nodes (i.e. create
                        noded network)
  --speed-table SPEED-TABLE
                        CSV with highway and speed columns specifying
                        assumed max speeds when not specified
  -h, --help            show this help message and exit