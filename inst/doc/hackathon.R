## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# remotes::install_github("zonebuilders/zonebuilder")
# remotes::install_github("itsleeds/pct")

## ----setup--------------------------------------------------------------------
# library(zonebuilder)
# library(dplyr)
# library(tmap)
# tmap_mode("view")

## ----eval=FALSE---------------------------------------------------------------
# zones_west_yorkshire = pct::get_pct_zones("west-yorkshire")
# zones_leeds_official = zones_west_yorkshire %>% filter(lad_name == "Leeds")

## ----eval=FALSE---------------------------------------------------------------
# leeds_centroid = tmaptools::geocode_OSM(q = "Leeds", as.sf = TRUE)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# saveRDS(zones_leeds_official, "zones_leeds_official.Rds")
# piggyback::pb_upload("zones_leeds_official.Rds")
# piggyback::pb_download_url("zones_leeds_official.Rds")
# saveRDS(zones_leeds_zb, "zones_leeds_zb.Rds")
# piggyback::pb_upload("zones_leeds_zb.Rds")

## -----------------------------------------------------------------------------
# leeds_centroid = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/leeds_centroid.Rds"))
# zones_leeds_official = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/zones_leeds_official.Rds"))
# zone_outline = zones_leeds_official %>%
#   sf::st_buffer(dist = 0.0001) %>%
#   sf::st_union()
# zones_leeds_zb = zb_zone(x = zone_outline, point = leeds_centroid)
# tm_shape(zones_leeds_zb) + tm_borders() +
#   tm_text("label")

## -----------------------------------------------------------------------------
# city_name = "Erbil"
# city_centre = tmaptools::geocode_OSM(city_name, as.sf = TRUE)
# zones_erbil = zb_zone(point = city_centre, n_circles = 5)
# tm_shape(zones_erbil) + tm_borders() +
#   tm_text("label") +
#   tm_basemap(server = leaflet::providers$OpenStreetMap)
# # zb_view(zones_erbil)

## -----------------------------------------------------------------------------
# city_name = "Dhaka"
# city_centre = tmaptools::geocode_OSM(city_name, as.sf = TRUE)
# zones_dhaka = zb_zone(point = city_centre, n_circles = 5)
# tm_shape(zones_dhaka) + tm_borders() +
#   tm_text("label") +
#   tm_basemap(server = leaflet::providers$OpenStreetMap)

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# # Aim: get the largest cities in the world
# cities_worldwide = rnaturalearth::ne_download(scale = 10, type = "populated_places")
# 
# city_names = c(
#   "Dheli",
#   "Mexico City",
#   "Tokyo",
#   "Beijing",
# )
# 
# city_name = "Dheli"
# city_centre = tmaptools::geocode_OSM(city_name, as.sf = TRUE)
# zones_dhaka = zb_zone(point = city_centre, n_circles = 5)
# tm_shape(zones_dhaka) + tm_borders() +
#   tm_text("label")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("itsleeds/geofabrik")
# library(geofabrik)
# leeds_shop_polygons = get_geofabrik(leeds_centroid, layer = "multipolygons", key = "shop", value = "supermarket")

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# saveRDS(leeds_shop_polygons, "leeds_shop_polygons.Rds")
# piggyback::pb_upload("leeds_shop_polygons.Rds")
# piggyback::pb_download_url("leeds_shop_polygons.Rds")
# saveRDS(leeds_centroid, "leeds_centroid.Rds")
# piggyback::pb_upload("leeds_centroid.Rds")
# piggyback::pb_download_url("leeds_centroid.Rds")
# # leeds_roads = get_geofabrik(name = leeds_centroid)
# # leeds_shop_points = get_geofabrik(leeds_centroid, layer = "points", key = "amenity", value = "shop")

## -----------------------------------------------------------------------------
# leeds_shop_polygons = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/leeds_shop_polygons.Rds"))
# z = zb_zone(zones_leeds_official, point = leeds_centroid, n_circles = 5)
# z_supermarkets = aggregate(leeds_shop_polygons["shop"], z, FUN = length)
# tm_shape(z_supermarkets) +
#   tm_polygons("shop", alpha = 0.5, title = "N. Supermarkets")

## -----------------------------------------------------------------------------
# 

