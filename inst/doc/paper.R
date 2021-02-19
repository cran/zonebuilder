## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  echo = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE--------------------------------------------------------------
#  refs = RefManageR::ReadZotero(group = "418217", .params = list(collection = "8S8LR8TK", limit = 100))
#  RefManageR::WriteBib(refs, "vignettes/references.bib")

## ---- eval=FALSE, echo=FALSE--------------------------------------------------
#  # generate bibliography
#  
#  citr::tidy_bib_file(rmd_file = "vignettes/paper.Rmd", messy_bibliography = "~/uaf/allrefs.bib", file = "vignettes/references.bib")

## ----setup--------------------------------------------------------------------
library(zonebuilder)

## ---- fig.width=7, message=FALSE, warning=FALSE-------------------------------
library(dplyr)
library(tmap)

# download preprocessed data (processing script /data-raw/crashes.R)
df = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/ksi_bkm_zone.rds")))
uk = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/uk.rds")))
thames = readRDS(gzcon(url("https://github.com/zonebuilders/zonebuilder/releases/download/0.0.1/thames.rds")))

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

## -----------------------------------------------------------------------------

## Transport planning

## Navigation and informal use

# References


