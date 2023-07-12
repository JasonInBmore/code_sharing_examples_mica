# This is an example of how code can be shared with others
# and how it can be easily run on their computers. In this case, the datasets 
# come from the internet, and if you have the three libraries installed, the script
# will create a basic map and save it. The saved map picture will look the same on our computers.




library(tidyverse)
library(sf)  ### geospatial analytics
library(tmap) ### mapping

#### messages are being added
#### when the script is ran, the these messages help you track 
#### when parts of the scripts run and where errors occur 

message("\n\n\n")
message("The script is starting")
message("The time is ", Sys.time())

### you can add in pauses in a script
### useful in situations when a script is ran with "source"
Sys.sleep(2)



#~~~~~~ read map data files straight from the open baltimore
### these are dataframes with map points and lines attached
hoods <- sf::read_sf("https://services1.arcgis.com/UWYHeuuJISiGmgXx/ArcGIS/rest/services/neighborhood_2010/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson")
qcts <- sf::read_sf("https://services1.arcgis.com/UWYHeuuJISiGmgXx/arcgis/rest/services/Cenus_Tracts/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson")
vacants_rehabs <- sf::read_sf("https://services1.arcgis.com/UWYHeuuJISiGmgXx/arcgis/rest/services/Vacant_Building_Rehab/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson")  


#~~~~~~ build the map
  v1 <-
    tm_shape(hoods) +
    tm_borders(alpha = 0.5) +
    tm_shape(qcts) +
    tm_fill(col = "yellow", alpha = 0.2) +
    tm_shape(vacants_rehabs) +
    tm_dots(size = .1, palette = "Set3", alpha = .2) +
    tm_layout(main.title = "Vacant Building Rehabs with QCTS", 
      main.title.size = .7) +
    tm_credits(paste("Data Accessed on", format(Sys.Date(), "%b %d, %Y")), 
               position=c("left", "bottom"))
  
  
  # Is this a pretty map? Not right now, but this basic map was only 10 lines of code. 
  # With a handful of additional lines it can look much better. ggplot and leaflet are 
  # two other great R libraries for mapping.
  
  
  #~~~~~~ save map image
  tmap::tmap_save(v1, "Vacant_Building_Rehabs_QCTS.png", height=4.2)
  

  message("map has been created and saved")
  message("script finished at ", Sys.time())
  

  

