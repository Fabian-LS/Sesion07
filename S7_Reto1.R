## RETO 01: RSTUDIO CLOUD -> GITHUB

library(DBI)
library(RMySQL)

# realizar la conexion con la base de datos
MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# mostrar las tablas dentro de la base de datos
dbListTables(MyDataBase)

# muestra los compos dentro de la tabla seleccionada
dbListFields(MyDataBase, 'CountryLanguage')

# realizar consulta tipo MySQL
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(DataDB)

# consulta con filtro para los idiomas que se hablan
library(dplyr)
Lesp <- DataDB %>% filter(Language == "Spanish")
Lesp
Lesp.df <- as.data.frame(Lesp)

# graficar dado el filtro realizado anteriormente de idioma
library(ggplot2)
Lesp.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bar(stat = "identity")+
  coord_flip()
