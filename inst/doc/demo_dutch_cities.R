## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# remotes::install_github("zonebuilders/zonebuilder")

## ----setup--------------------------------------------------------------------
# library(zonebuilder) # for the zoning system
# library(sf)          # for processing spatial data
# library(dplyr)       # for processing general data
# library(tmap)        # for visualizing spatial data

## -----------------------------------------------------------------------------
# NLD_cities = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/NLD_cities.Rds"))
# NLD_wijk_od = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/NLD_wijk_od.Rds"))
# NLD_wijk_centroids = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/NLD_wijk_centroids.Rds"))

## -----------------------------------------------------------------------------
# NLD_cities %>% arrange(desc(population))

## -----------------------------------------------------------------------------
# tmap_mode("view") # enable interactive mode in tmap
# qtm(NLD_cities, symbols.size = "population")

## -----------------------------------------------------------------------------
# zbs = do.call(rbind, lapply(1:nrow(NLD_cities), function(i) {
#   ci = NLD_cities[i, ]
# 
#   # Amsterdam 5, Eindhoven-Rotterdam 4, Roermond-Zeeland 2, others 3
#   nrings = ifelse(ci$population < 60000, 2,
#            ifelse(ci$population < 220000, 3,
#            ifelse(ci$population < 800000, 4, 5)))
# 
#   zb = zb_zone(x = ci, n_circles = nrings) %>%
#     mutate(name = ci$name,
#            labelplus = paste(ci$name, label, sep = "_"))
# 
#   zb
# }))

## -----------------------------------------------------------------------------
# tm_basemap("OpenStreetMap") +
# tm_shape(zbs) +
#   tm_polygons(col = "circle_id", id = "labelplus", style = "cat", palette = "YlOrBr", alpha = 0.7) +
#   tm_scale_bar()

