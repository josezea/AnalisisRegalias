# Palabras geográficas

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 

setwd(Ruta)
source("FuncionesTexto.R")


# Lectura archivo DIVIPOLA
setwd(paste0(Ruta, "/", "datos"))
df_divipola <-  read_excel("DivisionPoliticoAdministrativaColombia.XLS")

# Lectura archivo de regalías
setwd(paste0(Ruta, "/", "datos_procesados"))
df_identifOCAD <- readRDS("df_identifOCAD.rds") 

dir()
names(df_divipola) <- gsub("\n","",names(df_divipola))

names(df_divipola) <- gsub(" ","",names(df_divipola))

# Remover nombres geográficos
nom_geo1 <- gsub(" DPTO", "", df_identifOCAD$"RECURSOS PERTENECIENTES A")
nom_geo1 <- tolower(nom_geo1)
nom_geo1 <- unique(nom_geo1)
nom_geo1 <-  gsub("arauca ", "arauca", nom_geo1)

nom_geo2 <- unique(c(df_divipola$NombredelDepartamento, 
                     df_divipola$NombredeMunicipiosyCorregimientosDepartamentales))

nom_geo <- c(nom_geo1, nom_geo2)
nom_geo <- tolower(nom_geo)
nom_geo <- unique(nom_geo) 
nom_geo <- separarTexto(nom_geo)
nom_geo <- nom_geo[!(nom_geo %in% stopwords("es"))]
nom_geo <- unique(nom_geo)
nom_geo <- c(nom_geo, "bogotá", "bogota")
nom_geo <- gsub("\\(", "", nom_geo)
nom_geo <- gsub("\\)", "", nom_geo)
nom_geo <- nom_geo[!(nom_geo %in% c("puente", "rio", "viejo", "osos", "palmar", 
                      "plata", "paz", "toro", "caro", "bahía", "seco"))]



Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(nom_geo, "nombres_geográficos.rds")


  
  