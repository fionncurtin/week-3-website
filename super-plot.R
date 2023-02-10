library(tidyverse)
library(tidycensus)
library(leaflet)

montana_bachelors <- 
  get_acs(geography = "county",
          variables = "DP02_0068P",
          year = 2020,
          state = "MT",
          geometry = TRUE)

pal <- colorNumeric(
  palette = "magma",
  domain = montana_bachelors$estimate
)

montana_plot <- leaflet() %>%
  addProviderTiles(providers$Stamen.TonerLite) %>%
  addPolygons(data = montana_bachelors,
              color = ~pal(estimate),
              weight = 0.5,
              smoothFactor = 0.2,
              fillOpacity = 0.5,
              label = ~estimate) %>%
  addLegend(position = "bottomright",
            pal = pal,
            values = montana_bachelors$estimate,
            title = "% with bachelor's<br/>degree")

write_rds(montana_plot, "montana_plot.rds")






us_bachelors <- 
  get_acs(geography = "state",
          variables = "DP02_0068P",
          year = 2020,
          geometry = TRUE)

pal <- colorNumeric(
  palette = "magma",
  domain = us_bachelors$estimate
)

us_plot <- leaflet() %>%
  addProviderTiles(providers$Stamen.TonerLite) %>%
  addPolygons(data = us_bachelors,
              color = ~pal(estimate),
              weight = 0.5,
              smoothFactor = 0.2,
              fillOpacity = 0.5,
              label = ~estimate) %>%
  addLegend(position = "bottomright",
            pal = pal,
            values = us_bachelors$estimate,
            title = "% with bachelor's<br/>degree")

write_rds(us_plot, "us_plot.rds")

