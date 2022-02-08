################################################################################
######################## fRasterCompatible R Function ##########################
################################################################################
# This script contains a function to convert a raster to a same projection, 
#   resolution, and extension of another reference raster. 
# As defined, rasterInput is converted to be compatible with rasterRef
# 
# How to use:
#   > source("fRasterCompatible.R")
#   > fRasterCompatible("raster1.tif", "rasterRef.tif", "rasterOut.tif", resampling_method = "average")
#   
#
# -r <resampling_method>
#   Resampling method to use. Available methods are:
#     near: nearest neighbour resampling.
#     bilinear: bilinear resampling (default).
#     cubic: cubic resampling.
#     cubicspline: cubic spline resampling.
#     lanczos: Lanczos windowed sinc resampling.
#     average: average of all non-NODATA contributing pixels.
#     mode: value which appears most often of all the sampled points.
#     max: maximum value from all non-NODATA contributing pixels.
#     min: minimum value from all non-NODATA contributing pixels.
#     med: median value of all non-NODATA contributing pixels.
#     q1: first quartile value of all non-NODATA contributing pixels.
#     q3: third quartile value of all non-NODATA contributing pixels.
# 
# Author: Arthur Hrast Essenfelder
# E-mail: arthur.essenfelder@cmcc.it
# 
# Version: 1.0
# Last update on: 04/09/2019
# Last modified by: Arthur Hrast Essenfelder
################################################################################
################################################################################

# Function to convert a raster to a same projection, resolution, and extension
fRasterCompatible = function(rasterInput, rasterRef, rasterOutput, dstnodata, resampling_method) {
  
  # rasterInput will be overwritten in case rasterOutput is not defined
  if (missing(rasterOutput)) { 
    message("Warning! ",rasterInput," will be overwritten."); 
    rasterOutput = rasterInput; 
  }
  if (missing(resampling_method)) { resampling_method = "average"; }
  resampling_methods = c("near","bilinear","cubic","cubicspline","lanczos",
                         "average","mode","max","min","med","q1","q3")
  if (!resampling_method %in% resampling_methods) {
    message("Wrong resampling_method. Available methods are:")
    message("  near: nearest neighbour resampling.")
    message("  bilinear: bilinear resampling.")
    message("  cubic: cubic resampling.")
    message("  cubicspline: cubic spline resampling.")
    message("  lanczos: Lanczos windowed sinc resampling.")
    message("  average: average of all non-NODATA contributing pixels.")
    message("  mode: value which appears most often of all the sampled points.")
    message("  max: maximum value from all non-NODATA contributing pixels.")
    message("  min: minimum value from all non-NODATA contributing pixels.")
    message("  med: median value of all non-NODATA contributing pixels.")
    message("  q1: first quartile value of all non-NODATA contributing pixels.")
    message("  q3: third quartile value of all non-NODATA contributing pixels.")
  }
  
  # Loading required libraries
  library(gdalUtils)
  library(raster); rasterOptions(chunksize=1e+07, maxmem=Inf, memfrac=.8)
  
  # Getting raster1 and rasterInput data
  rIn1 = raster(rasterRef)
  rIn2 = raster(rasterInput)
  sPrj = gsub(".tif", "_prj.tif", rasterInput);
  sRes = gsub(".tif", "_res.tif", rasterInput);
  
  # If dstnodata is missing, then dstnodata is defined as the same as rasterRef
  if (missing(dstnodata)) { dstnodata = rIn1@file@nodatavalue; }
  dstnodata = toString(dstnodata)
  if (is.infinite(as.numeric(dstnodata))) { 
    dst = sign(as.numeric(dstnodata)); 
    if (dst==-1) { dst = "-" } else { dst = "" }
    dstnodata = paste(dst,"3.40282e+38",sep=""); 
  }
  
  # Checking if rasterInput needs reprojection...
  if (projection(rIn1) != projection(rIn2)) {
    t_srs = projection(rIn1);
    gdalUtils::gdalwarp(rasterInput, sPrj, t_srs=t_srs, dstnodata=dstnodata, 
                        co=c("COMPRESS=DEFLATE","PREDICTOR=1","ZLEVEL=9","BIGTIFF=YES"), 
                        overwrite=TRUE, multi=TRUE, verbose=TRUE);
  } else { sPrj = rasterInput; }
  
  # Checking if rasterInput needs resampling...
  if (any(c(res(rIn1) != res(rIn2), rIn1@extent != rIn2@extent))) {
    tr = res(rIn1);
    te = c(bbox(extent(as.vector(rIn1@extent))));
    gdalUtils::gdalwarp(sPrj, sRes, tr=tr, r=resampling_method, te=te, dstnodata=dstnodata, 
                        co=c("COMPRESS=DEFLATE","PREDICTOR=1","ZLEVEL=9","BIGTIFF=YES"), 
                        overwrite=TRUE, multi=TRUE, verbose=TRUE); 
    if (file.exists(sPrj) && sPrj!=rasterInput) { file.remove(sPrj); }
  } else { sRes = sPrj; }
  
  # Checking if rasterInput is already compatible with rasterRef
  if (sRes==rasterInput) { 
    message("rasterInput is already compatible with rasterRef, nothing has been done."); 
  } else { 
    if (file.exists(rasterOutput)) { file.remove(rasterOutput); }
    file.rename(sRes, rasterOutput)
    message("rasterInput was made compatible with rasterRef, named: ", rasterOutput); 
  }
  
  # Cleaning-up
  gc()
  
}
