## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  echo = FALSE,
  collapse = TRUE,
  comment = "#>",
  message = FALSE
)
library(zonebuilder)
library(tmap)
library(dplyr)

## ---- eval=FALSE--------------------------------------------------------------
#  # To uses josis template:
#  remotes::install_github("robinlovelace/rticles", ref = "josis")
#  refs = RefManageR::ReadZotero(group = "418217", .params = list(collection = "8S8LR8TK", limit = 100))
#  RefManageR::WriteBib(refs, "vignettes/references.bib")
#  # Set-up notes for pdf version
#  # convert .tex to .md
#  # system("pandoc -s -r latex paper.tex -o paper.md")
#  # # copy josis specific files and ignore them
#  # f = list.files("~/other-repos/rticles/inst/rmarkdown/templates/josis/skeleton", pattern = "josis", full.names = TRUE)
#  # file.copy(f, "vignettes")
#  rmarkdown::render(input = "vignettes/paper.Rmd", output_file = "../zonebuilder-paper.pdf")
#  browseURL("zonebuilder-paper.pdf")
#  piggyback::pb_upload("zonebuilder-paper.pdf")

## ----options, fig.cap="Illustration of ideas explored in the lead-up to the development of the ClockBoard zoning system, highlighting the incremental and iterative evolution of the approach.", out.width="32%", fig.show='hold'----
#  # z1 = zb_zone(x = london_c(), n_segments = 1)
#  # m1 = qtm(z1, title = "(A) Concentric Annuli")
#  # sf::sf_use_s2(use_s2 = FALSE)
#  z1 = zb_zone(london_c(), n_segments = 1, distance_growth = 0)
#  z1_areas = sf::st_area(z1)
#  z1_areas_relative = as.numeric(z1_areas / z1_areas[1])
#  zb_plot(z1, title = "(A) Concentric Annuli")
#  zb_plot(zb_segment(london_c(), n_segments = 12), title = "(B) Clock segments")
#  qtm(zb_zone(london_c(), n_segments = z1_areas_relative, labeling = "clock", distance_growth = 0), title = "(C) Equal area zones", fill = NULL)

## ----t1-----------------------------------------------------------------------
#  txt = "Number of rings,Diameter across (km),Area (sq km)
#  1,1,2,3.14
#  2,2,6,28.27
#  3,3,12,113.10
#  4,4,20,314.16
#  5,5,30,706.86
#  6,6,42,1385.44
#  7,7,56,2463.01
#  8,8,72,4071.50
#  9,9,90,6361.73"
#  t1 = read.csv(text = txt, check.names = FALSE)
#  knitr::kable(t1, booktabs = TRUE, caption = "Key attributes of first 9 rings used in the ClockBoard zoning system.")

## ---- fig.width=7, message=FALSE, warning=FALSE-------------------------------
#  # download preprocessed data (processing script /data-raw/crashes.R)
#  df = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/ksi_bkm_zone.rds")))
#  uk = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/uk.rds")))
#  thames = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/thames.rds")))
#  
#  # filter: set zones with less than 10,000 km of cycling per yer to NA
#  df_filtered = df %>%
#    mutate(ksi_bkm = ifelse((bkm_yr * 1e09) < 2e04, NA, ksi_bkm))
#  
#  tmap_mode("plot")
#  tm_shape(uk) +
#   tm_fill(col = "white") +
#  tm_shape(df_filtered, is.master = TRUE) +
#    tm_polygons("ksi_bkm", breaks = c(0, 1000, 2500, 5000, 7500, 12500), textNA = "Too little cycling", title = "Killed and seriously injured cyclists\nper billion cycled kilometers") +
#    tm_facets(by = "city", ncol=4) +
#    tm_shape(uk) +
#    tm_borders(lwd = 1, col = "black", lty = 3) +
#    tm_shape(thames) +
#    tm_lines(lwd = 1, col = "black", lty = 3) +
#    tm_layout(bg.color = "lightblue")

