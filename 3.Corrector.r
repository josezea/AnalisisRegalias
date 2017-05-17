library(hunspell)

rm(list = ls())

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo2 <- readRDS("df_titulo2.rds")

setwd(Ruta)
source("FuncionesTexto.R")

# Leer diccionario
esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"))


NOMBREPROYECTO <- df_titulo2$NOMBREPROYECTO

# Separar el texto para usar el diccionario
NOMBREPROYECTO2 <- lapply(NOMBREPROYECTO, separarTexto)

#incorrecto <-  !hunspell_check(NOMBREPROYECTO2[[9]], dict = esp)
#sugerencias <- hunspell_suggest(NOMBREPROYECTO2[[9]][!correct], dict = esp)
#sugerencia_principal = unlist(lapply(sugerencias, function(l) l[[1]]))

#for(i in 1:sum(incorrecto)){
#NOMBREPROYECTO2[[9]][incorrecto][i] <-  sugerencia_principal[i]
#}

check_ortogr <- function(x){
  !hunspell_check(x, dict = esp)  
}
  
# incorrecto <-  check_ortogr(NOMBREPROYECTO2[[8]])

correc_hunspell <- function(x){
correcto <-  hunspell_check(x, dict = esp)
incorrecto <-  !hunspell_check(x, dict = esp)
sugerencias <- hunspell_suggest(x[!correcto], dict = esp)

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



#datosprueba <- NOMBREPROYECTO2[1:10]
#prueba_lista_incorrecta <- lapply(datosprueba, prarevisar)
#prueba <- lapply(datosprueba, FUN = correc_hunspell)

lista_incorrecta <- lapply(NOMBREPROYECTO2, check_ortogr)
system.time(NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO2, correc_hunspell))

LimpiarEspacios<- function(x){
  x[x != ""]
}

NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO3, LimpiarEspacios)
NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO3, colapsarTexto)
NOMBREPROYECTO4 <- unlist(NOMBREPROYECTO4, " ")

df_titulo2$NOMBREPROYECTO_ortog <- NOMBREPROYECTO4

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo2, "df_titulo3.rds")
