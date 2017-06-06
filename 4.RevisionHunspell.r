# Corrección ortográfica con Hunspell
library(readxl)
library(tm)
library(devtools)
#devtools::install_github("ropensci/hunspell", force = T)
library(hunspell)
library(parallel)
rm(list = ls())

############################## Corrector ortográfico Hunspell ###################


Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "Diccionario/Colombia/"))
palabras_agregadas <- readRDS("palabras_agregadas.rds")


setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo1 <- readRDS("df_titulo1.rds")

setwd(Ruta)
source("FuncionesTexto.R")


# Leer diccionario
esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"), 
                  add_words = palabras_agregadas)

# hunspell_check("casa", dict = esp)
# hunspell_check("drogadiccion", dict = esp)
# hunspell_check("drogadicción", dict = esp)
# hunspell_suggest("drogadiccion", dict = esp)



NOMBREPROYECTO <- df_titulo1$NOMBREPROYECTO

# Separar el texto para usar el diccionario
NOMBREPROYECTO2 <- lapply(NOMBREPROYECTO, separarTexto)

#incorrecto <-  !hunspell_check(NOMBREPROYECTO2[[9]], dict = esp)
#sugerencias <- hunspell_suggest(NOMBREPROYECTO2[[9]][!correct], dict = esp)
#sugerencia_principal = unlist(lapply(sugerencias, function(l) l[[1]]))

#for(i in 1:sum(incorrecto)){
#NOMBREPROYECTO2[[9]][incorrecto][i] <-  sugerencia_principal[i]
#}

check_ortogr <- function(x, diccionario){
  library(hunspell)
  Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
  setwd(paste0(Ruta, "Diccionario/Colombia/"))
  palabras_agregadas <- readRDS("palabras_agregadas.rds")
  
  esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"), 
                    add_words = palabras_agregadas)
  
!hunspell_check(x, dict = esp)  
}

# incorrecto <-  check_ortogr(NOMBREPROYECTO2[[8]])
correc_hunspell <- function(x){
  library(hunspell)
  Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
  setwd(paste0(Ruta, "Diccionario/Colombia/"))
  palabras_agregadas <- readRDS("palabras_agregadas.rds")
  
  esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"), 
                    add_words = palabras_agregadas)
  
 correcto <-  hunspell_check(x, dict = esp)
  incorrecto <-  !correcto
  sugerencias <- hunspell_suggest(x[incorrecto], dict = esp)
  
  sustituir_sugerencias <- function(x){
    if(length(x) == 0)  x <- ""  
    else x <- x
  }
  sugerencias <- lapply(sugerencias, sustituir_sugerencias)
  sugerencia_principal = unlist(lapply(sugerencias, function(l) l[[1]]))
  
  for(i in 1:sum(incorrecto)){
    x[incorrecto][i] <-  sugerencia_principal[i]
  }
  x
}


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3 <- parLapply(cl, NOMBREPROYECTO2, correc_hunspell))
stopCluster(cl)
gc(reset = T)

lista_incorrecta <- lapply(NOMBREPROYECTO2, check_ortogr)

# system.time(NOMBREPROYECTO3a <- lapply(NOMBREPROYECTO2, correc_hunspell))
# Ver NOMBREPROYECTO2[90] y NOMBREPROYECTO3[90]

LimpiarEspacios <- function(x){
  x[x != ""]
}

NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO3, LimpiarEspacios)
NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO4, colapsarTexto)
NOMBREPROYECTO4 <- unlist(NOMBREPROYECTO4, " ")

df_titulo1$NOMBREPROYECTO_ortog <- NOMBREPROYECTO4

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo1, "df_titulo2.rds")
