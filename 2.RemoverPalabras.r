library(readxl)
library(tm) # Lista de stopwords

rm(list = ls())
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo1 <- readRDS("df_titulo1.rds")

setwd(Ruta)
source("FuncionesTexto.R")
# Lectura archivo de regalías
setwd(paste0(Ruta, "/", "datos_procesados"))
df_identifOCAD <- readRDS("df_identifOCAD.rds") 

# Lectura archivo DIVIPOLA
setwd(paste0(Ruta, "/", "datos"))
df_divipola <-  read_excel("DivisionPoliticoAdministrativaColombia.XLS")
names(df_divipola) <- gsub("\n","",names(df_divipola))

names(df_divipola) <- gsub(" ","",names(df_divipola))

NOMBREPROYECTO <- removeWords(df_titulo1$NOMBREPROYECTO,stopwords("spanish"))


# Remover nombres geográficos
nom_geo1 <- gsub(" DPTO", "", df_identifOCAD$"RECURSOS PERTENECIENTES A")
nom_geo1 <- tolower(nom_geo1)
nom_geo1 <- unique(nom_geo1)
nom_geo1 <-  gsub("arauca ", "arauca", nom_geo1)

nom_geo2 <- unique(c(df_divipola$NombredelDepartamento, 
                     df_divipola$CabecerasyCentrosPoblados))

nom_geo <- c(nom_geo1, nom_geo2)
nom_geo <- tolower(nom_geo)
nom_geo <- unique(nom_geo) 
nom_geo <- separarTexto(nom_geo)
nom_geo <- nom_geo[!(nom_geo %in% stopwords("es"))]
nom_geo <- unique(nom_geo)
nom_geo <- c(nom_geo, "bogotá", "bogota")
nom_geo <- gsub("\\(", "", nom_geo)
nom_geo <- gsub("\\)", "", nom_geo)
nom_geo <- c(nom_geo)


NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO, nom_geo[c(1:3000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(3001:6000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(6001:9000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(9001:length(NOMBREPROYECTO2))])

# Algunas palabras para eliminar
remover <- c("amazonía","atlantico", "departamento","departamental","depto", "orinoquía", 
             "llano", "orinoquia","caribe", "oriente", "centro", "municipios", "municipio",
             "isla", "occidente", "cra", "cll","av",
             "caqueta", "mitú", "carrera", "calle", "k", "a", "cl", "cr", "i", "ii","ie",
             "dos", "b", "tres", "pr", "c", "m", "s", "d", "ml",
             "túquerres", "dpto", "kra", "tibú","iii",
             "yaguará", "kr", "ta", "distrito", "martín", "agustín", "gaitán", "yondó",
             "lópez","propio", "jorge", "maría", "años", "quindio", "tolu", "toluviejo",
             "piriola", "subregión", "región", "cabecera", "municipal", "cabecera",
             "cascos", "urbanos", " corregimientos", "rural","amazonía", "orinoquía")   

NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, remover)

NOMBREPROYECTO2 <- gsub(' +',' ',NOMBREPROYECTO2)
NOMBREPROYECTO2 <- trimws(NOMBREPROYECTO2)

NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO2, separarTexto)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, LimpiarEspacios)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, Duplicados)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, colapsarTexto)



df_titulo1$NOMBREPROYECTO <- NOMBREPROYECTO3

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo1, "df_titulo2.rds")
