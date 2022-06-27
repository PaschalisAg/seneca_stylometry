devtools::install_github("ropensci/rperseus")
library(dplyr)
library(purrr)
library(rperseus)

library(purrr)
urn <- "urn:cts:latinLit:phi1017"
seneca <- perseus_catalog %>% 
  filter(group_name == "Seneca, Lucius Annaeus (Plays)",
         language == "lat") %>% 
  pull(urn) %>% 
  map_df(get_perseus_text)
seneca
write.csv(seneca, "/Users/paschalis/Documents/MA_DH/Thesis/Scraping/seneca.csv")

# https://github.com/ropensci/rperseus
# https://scaife.perseus.org/

# scraping Persius
urn <- "urn:cts:latinLit:phi0969"
persius <- perseus_catalog %>%
  filter(group_name == "Persius, Paulus Flaccus",
         language == "lat") %>%
  pull(urn) %>%
  map_df(get_perseus_text)
persius
