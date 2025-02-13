## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  fig.align = "center",
  eval = TRUE, # set to false for CRAN submission
  echo = FALSE,
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE
  # , cache = TRUE
)
library(zonebuilder)
library(tmap)
library(dplyr)

## ----eval=FALSE---------------------------------------------------------------
# # To uses josis template:
# remotes::install_github("robinlovelace/rticles", ref = "josis")
# refs = RefManageR::ReadZotero(group = "418217", .params = list(collection = "8S8LR8TK", limit = 100))
# RefManageR::WriteBib(refs, "vignettes/references.bib")
# u = "www.zotero.org/styles/open-geospatial-data-software-and-standards"
# download.file(u, "vignettes/josis.csl")
# piggyback::pb_upload("cities_p1.png")
# piggyback::pb_upload("cities_p2.png")
# piggyback::pb_download_url("cities_p1.png")
# # [1] "https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/cities_p1.png"
# 
# # Set-up notes for pdf version
# # convert .tex to .md
# # system("pandoc -s -r latex paper.tex -o paper.md")
# # # copy josis specific files and ignore them
# # f = list.files("~/other-repos/rticles/inst/rmarkdown/templates/josis/skeleton", pattern = "josis", full.names = TRUE)
# # file.copy(f, "vignettes")
# rmarkdown::render(input = "vignettes/paper.Rmd", output_file = "zonebuilder-paper.pdf")
# file.rename("vignettes/zonebuilder-paper.pdf", "zonebuilder-paper.pdf")
# browseURL("zonebuilder-paper.pdf")
# piggyback::pb_upload("zonebuilder-paper.pdf")
# piggyback::pb_upload("vignettes/zonebuilder-paper.tex")
# piggyback::pb_download_url("zonebuilder-paper.pdf")
# # [1] "https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/zonebuilder-paper.pdf"
# remotes::install_github("paleolimbot/rbbt")
# # library(rbbt)
# # rbbt::bbt_update_bib(path_rmd = "vignettes/paper.Rmd")

## ----options, fig.cap="Illustration of ideas explored in the lead-up to the development of the ClockBoard zoning system, highlighting the incremental and iterative evolution of the approach.", out.width="32%", fig.show='hold'----
# z1 = zb_zone(x = london_c(), n_segments = 1)
# m1 = qtm(z1, title = "(A) Concentric Annuli")
# sf::sf_use_s2(use_s2 = FALSE)
z1 = zb_zone(london_c(), n_segments = 1, distance_growth = 0)
z1_areas = sf::st_area(z1)
z1_areas_relative = as.numeric(z1_areas / z1_areas[1])
qtm(z1, title = "(A) Concentric Annuli", fill = NULL) +
  tm_layout(frame = FALSE, inner.margins = c(0.02, 0.02, 0.08, 0.02))
qtm(zb_segment(london_c(), n_segments = 12), title = "(B) Clock segments", fill = NULL) +
  tm_layout(frame = FALSE, inner.margins = c(0.02, 0.02, 0.08, 0.02))
qtm(zb_zone(london_c(), n_segments = z1_areas_relative, labeling = "clock", distance_growth = 0), title = "(C) Equal area zones", fill = NULL) +
  tm_layout(frame = FALSE, inner.margins = c(0.02, 0.02, 0.08, 0.02))

## ----t1-----------------------------------------------------------------------
t2 = data.frame("N. annuli" = 1:9, check.names = FALSE)
t2$`Outer annuli label` = LETTERS[1:9]
t2$`N. zones` = t2$`N. annuli` * 12 - 11
t2$`Radius (km)` = zonebuilder::zb_100_triangular_numbers[1:9]
t2$`Area (sqkm)` = pi * t2$`Radius (km)`^2
t2$`Average zone size (km)` = t2$`Area (sqkm)` / t2$`N. zones`
knitr::kable(t2, booktabs = TRUE, caption = "Key attributes of first 9 rings used in the ClockBoard zoning system.", digits = 0)

## ----london, fig.cap="The clockboard zoning system, applied to Greater London, UK.", out.width="70%"----
london_zones = zb_zone(london_c(), london_a())
zb_plot(london_zones, palette = "hcl")

## ----echo=TRUE----------------------------------------------------------------
library(zonebuilder)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# tokyo = tmaptools::geocode_OSM("tokyo", as.sf = TRUE)
# dput(tokyo$point)
# tokyo_coordinates = data.frame(x = 139.759, y = 35.682)
# tokyo = sf::st_as_sf(tokyo_coordinates, coords = c("x", "y"), crs = 4326)
# tokyo_area = osmdata::getbb ('tokyo', format_out = 'sf_polygon')
# mapview::mapview(tokyo_area$multipolygon)

## ----echo=TRUE----------------------------------------------------------------
ClockBoard_tokyo = zb_zone("Tokyo", n_circles = 5)

## ----eval=FALSE---------------------------------------------------------------
# zb_view(ClockBoard_tokyo, alpha = 0.8)

## ----tokyo, fig.cap="ClockBoard zoning system applied to Tokyo, the result of running the reproducible code used to demonstrate the zonebuilder R package.", out.width="75%"----
# library(tmap) # load mapping package
# tmap_mode("view") # interactive visualisation mode
# tm_shape(ClockBoard_tokyo) +
#   tm_borders() +
#   tm_text("label") +
#   tm_scale_bar()
# from system command line:
# pngquant -f --ext .png --quality 60-85 vignettes/tokyo.png 
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/128613050-96fd8882-10c5-47d8-af2f-90fceeba8d81.png")
# LaTeX version:
# 856 KB
# download.file("https://user-images.githubusercontent.com/1825120/128613050-96fd8882-10c5-47d8-af2f-90fceeba8d81.png", "tokyo.png")
# knitr::include_graphics("tokyo.png")

## ----interactive, fig.cap="Screenshot of the zonebuilder web application for creating and downloading ClockBoard zones interactively. The example shows Erbil, Northern Iraq, which was found to have a road layout resembling the ClockBoard zoning system, highlighting the importance of interactive alignment and selection of number of rints. See the interactive version at zonebuilders.github.io/zonebuilder-rust/.", out.width="85%"----
# See https://github.com/zonebuilders/zonebuilder-rust/issues/42#issuecomment-886627851

u = "https://user-images.githubusercontent.com/1825120/128508694-5b5485ca-6f1b-4c21-bdb6-9269a7981dd5.png"
# 779 KB
# download.file(u, "interactive.png")

# for html version:
knitr::include_graphics(u)

# # for pdf version:
# f = basename(u)
# download.file(u, f)
# knitr::include_graphics(f)

## ----location, out.width="85%", fig.cap="Illustration of how the ClockBoard system could be used to describe the approximate location of places. In this hypothetical example, someone is describing key places to visit in and around Leeds to someone who arrives at the train station in zone A, visits the city's famous Roundhay Park in zone C01, before travelling for an evening meal in Bradford, in zone E09."----
# ClockBoard_leeds = zb_zone(x = "leeds")
# ClockBoard_leeds$label_locations = ""
# i = grepl(pattern = "A|C01|E09", x = ClockBoard_leeds$label)
# ClockBoard_leeds$label_locations[i] = ClockBoard_leeds$label[i]
# tmap_mode("view")
# tm_shape(ClockBoard_leeds) +
#   tm_borders() +
#   tm_basemap(server = leaflet::providers$Esri.WorldTopoMap) +
#   tm_text("label_locations", size = 2) +
#   tm_scale_bar()
# download.file(
#   "https://user-images.githubusercontent.com/1825120/127722684-e4f0f58a-44b2-48b9-8bdd-cd09bae4e250.png",
#   "navigation-small.png"
# )
# download.file(
#   "https://user-images.githubusercontent.com/1825120/127722701-36ca3674-0522-40d6-9a69-e745ca628bca.png",
#   "navigation.png"
# )
# knitr::include_graphics("navigation.png")
# 865 kb:
# download.file("https://user-images.githubusercontent.com/1825120/127722701-36ca3674-0522-40d6-9a69-e745ca628bca.png", "navigation.png")
knitr::include_graphics("https://user-images.githubusercontent.com/1825120/127722701-36ca3674-0522-40d6-9a69-e745ca628bca.png")

## ----cityscale, fig.height=2, out.width="100%", fig.cap="Illustration of the ClockBoard zoning system used to visualize a geographically dependendent phenomena: air quality, measured in mass of PM10 particles, measured in micrograms per cubic meter, from the London Atmospheric Emissions Inventory (LAEI). The facets show the data in spatial grid available from the LAEI, facet Am and aggregated to London boroughs B, to ClockBoard zones covering all the input data shown in C, and ClockBoard zones clipped by the administrative boundary of Greater London in D."----
# file.edit("data-raw/london-figures.R") # to reproduce the figure

# For PDF version with vector graphics:
# tmap_mode("plot")
# tm1 = readRDS(url("https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/tm1.Rds"))
# tm1

u = "https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/cityscale.png"
# f = basename(u)
# 155 kb
# if(!file.exists(f)) download.file(url = u, destfile = f)
# knitr::include_graphics(f) # for local high-res version, not working
knitr::include_graphics(u)

## ----intercity, fig.width=7, message=FALSE, warning=FALSE, fig.cap="Use of the ClockBoard zoning system to support inter-city comparison of policy-relevant data, on road traffic casualties. The maps show the spatial distribution of cycling casualties per billion km cycled, a measure that requires spatial data aggregation for meaningful results.", out.width="85%"----
# download preprocessed data (processing script /data-raw/crashes.R)
df = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/ksi_bkm_zone.rds")))
uk = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/uk.rds")))
thames = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/thames.rds")))
# df = readRDS("ksi_bkm_zone.rds")
# uk = readRDS("uk.rds")
# thames = readRDS("thames.rds")
# filter: set zones with less than 10,000 km of cycling per yer to NA
df_filtered = df %>% 
  mutate(ksi_bkm = ifelse((bkm_yr * 1e09) < 2e04, NA, ksi_bkm))
tmap_mode("plot")
tm_shape(uk) +
 tm_fill(col = "white") +
tm_shape(df_filtered, is.master = TRUE) +
  tm_polygons("ksi_bkm", breaks = c(0, 1000, 2500, 5000, 7500, 12500), textNA = "Too little cycling", title = "Killed and seriously injured cyclists\nper billion cycled kilometers") +
  tm_facets(by = "city", ncol=4) +
  tm_shape(uk) +
  tm_borders(lwd = 1, col = "black", lty = 3) +
  tm_shape(thames) +
  tm_lines(lwd = 1, col = "black", lty = 3) +
  tm_layout(bg.color = "lightblue")

## ----popdens, fig.cap="ClockBoard for 36 cities. The blue raster grid cells represent open access population estimates from the WorldPop project.", out.width="100%", eval=FALSE----
# # u = "https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/cities_p2.png"
# # 2.1 MB
# # download.file(u, "cities_p2.png")
# # For HTML version:
# # knitr::include_graphics(u)
# 
# # # For LaTeX version
# # f = basename(u)
# # if(!file.exists(f)) download.file(u, f)
# # knitr::include_graphics(f)

## ----popdens2, fig.cap="ClockBoard for 6 cities with boundaries shown in red. The blue raster grid cells represent open access population estimates from the WorldPop project; the red lines are administrative borders.", out.width="70%"----
u = "https://github.com/zonebuilders/zonebuilder/releases/download/v0.0.2.9000/cities_p1.png"
# 1MB:
# download.file(u, "cities_p1.png")
# For HTML version:
knitr::include_graphics(u)

# # For LaTeX version
# f = basename(u)
# if(!file.exists(f)) download.file(u, f)
# knitr::include_graphics(f)

