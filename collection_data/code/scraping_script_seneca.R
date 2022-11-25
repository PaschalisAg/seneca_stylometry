devtools::install_github("ropensci/rperseus")
library(dplyr)
library(purrr)
library(rperseus)
library(purrr)


setwd("../collection_data/")
getwd()


urn <- "urn:cts:latinLit:phi1017"
seneca <- perseus_catalog %>% 
  filter(group_name == "Seneca, Lucius Annaeus (Plays)",
         language == "lat") %>% 
  pull(urn) %>% 
  map_df(get_perseus_text)

write.csv(seneca, "~/raw_text/seneca.csv")

# https://github.com/ropensci/rperseus
# https://scaife.perseus.org/

