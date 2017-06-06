library(readxl)
library(tm) # Lista de stopwords

rm(list = ls())
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regal�as/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo3 <- readRDS("df_titulo3.rds")
dir()
nom_geo <- readRDS("nombres_geogr�ficos.rds")


setwd(Ruta) 
source("FuncionesTexto.R")
# Lectura archivo de regal�as
setwd(paste0(Ruta, "/", "datos_procesados"))
df_identifOCAD <- readRDS("df_identifOCAD.rds") 

NOMBREPROYECTO <- df_titulo3$NOMBREPROYECTO_ortogLema

# stopwords

NOMBREPROYECTO <- removeWords(NOMBREPROYECTO, stopwords("sp"))

NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO, nom_geo[c(1:3000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(3001:6000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(6001:9000)])
NOMBREPROYECTO2 <- removeWords(NOMBREPROYECTO2, nom_geo[c(9001:length(NOMBREPROYECTO2))])

# Algunas palabras para eliminar
remover <- c("amazon�a","atlantico", "departamento","departamental","depto", "dpto", "doto",
             "orinoqu�a", "llano", "orinoquia","caribe", "oriente", "centro", "municipios",
             "municipio", "isla", "occidente", "cra", 
             "caqueta", "mit�", "carrera", "calle","clle", "clles", 
             "dos",  "tres", "cuatro", "cinco", "tercero", "primero", "segundo", "seis",
             "t�querres", "dpto", "kra", "tib�","iii",
             "yaguar�", "distrito", "mart�n", "agust�n", "gait�n", "yond�",
             "l�pez","propio", "jorge", "mar�a", "a�os", "quindio", "tolu", "toluviejo",
             "piriola", "subregi�n", "regi�n", "cabecera", "municipal", "cabecera",
             "cascos", "urbanos", " corregimientos","amazon�a", "orinoqu�a",
             "providencia", "guajira", "pablo", "pablar", "guajiro", 
             "choc�", "aguadas", "aguada", "aguar", "rosa", "roso",
             "negra", "amazonas",  "amazona", "santa", "viterbo", "pis",
             "ips", "bpa", "castilla", "casto", "perez", "prez", 
             "pinares","oriente", "quiroz", "lle", "vise", "toe", "eot", "granar", "granada",
             "palestina", "palestino" , "psi", "negro", "box",
             "paraiso", "para�so", "boa", "barbacoas", "delicia",
             "barbara", "barbar",
             "bonito", "remedios", "pae", "teresa", "pse",
             "dos", "tres", "kra", "tib�", "iii", "visr", "glp", 
             "eot", "mts", "clle", "ctei", "ptap", "cer", 
             "diag",  "ptar", "tab", "urb", 
             "cla", "cgto",  "kms", "vip", "xii", "cic", "cis",  
             "cle", "clls", "correg", "palmarito", "hacia", "doble", "avenir")


             

NOMBREPROYECTO3 <- removeWords(NOMBREPROYECTO2, remover)


# Quitar palabras de longitud 2 y 1
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, separarTexto)


eliminar_palabrascortas <- function(x, longitud){
  filtro_cortas <- nchar(x) <= longitud
  x[!filtro_cortas]
}
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, eliminar_palabrascortas, 2)

NOMBREPROYECTO3 <- unlist(lapply(NOMBREPROYECTO3, colapsarTexto))

NOMBREPROYECTO3 <- gsub(' +',' ',NOMBREPROYECTO3)
NOMBREPROYECTO3 <- trimws(NOMBREPROYECTO3)

NOMBREPROYECTO3<- lapply(NOMBREPROYECTO3, separarTexto)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, LimpiarEspacios)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, Duplicados)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO3, colapsarTexto)
NOMBREPROYECTO3 <- unlist(NOMBREPROYECTO3)


df_titulo3$NOMBREPROYECTO_EDITADO <- NOMBREPROYECTO3

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regal�as/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo3, "df_titulo4.rds")
