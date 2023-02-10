library(tidyverse)
library(tidycensus)
library(leaflet)

morris_bachelors <- 
  get_acs(geography = "tract",
          variables = "DP02_0068P",
          year = 2020,
          state = "NJ",
          county = "Morris",
          geometry = TRUE)

pal <- colorNumeric(
  palette = "magma",
  domain = morris_bachelors$estimate
)

morris_plot <- leaflet() %>%
  addProviderTiles(providers$Stamen.TonerLite) %>%
  addPolygons(data = morris_bachelors,
              color = ~pal(estimate),
              weight = 0.5,
              smoothFactor = 0.2,
              fillOpacity = 0.5,
              label = ~estimate) %>%
  addLegend(position = "bottomright",
            pal = pal,
            values = morris_bachelors$estimate,
            title = "% with bachelor's<br/>degree")

write_rds(morris_plot, "morris_plot.rds")