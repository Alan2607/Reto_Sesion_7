library(ggplot2)
library(dplyr)
library(pool)
library(DBI)
library(RMySQL)

midb <- dbPool(
  RMySQL::MySQL(), 
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)


dbListTables(midb)

dbListFields(midb, 'CountryLanguage')

datos <- dbGetQuery(midb, "select * from CountryLanguage")
names(datos)

espa <- datos %>% filter(Language == "Spanish")
espa <- as.data.frame(espa) 

espa %>% ggplot(aes( x = CountryCode, y=Percentage, colour=IsOfficial)) + 
  geom_bin2d() +
  coord_flip()
