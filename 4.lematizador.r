
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo3 <- readRDS("df_titulo3.rds")


setwd(paste0(Ruta,"/lemmatizer"))
lemamatizer <- read.table("lemmatization-es.txt")
lemamatizer$V1 <- iconv(lemamatizer$V1, from="UTF-8", to="LATIN1") 
lemamatizer$V2 <- iconv(lemamatizer$V2, from="UTF-8", to="LATIN1")

setwd(Ruta)
source("FuncionesTexto.R")


raices <- lemamatizer$V1
palabras <- lemamatizer$V2
#names(raices) <- palabras
#raices["caminos"]


NOMBREPROYECTO <- df_titulo3$NOMBREPROYECTO_ortog
NOMBREPROYECTO2 <- as.list(NOMBREPROYECTO)
NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO2, FUN = separarTexto)
NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO3, FUN = LimpiarEspacios)
#NOMBREPROYECTO4[1076]

#for(i in 1:length(NOMBREPROYECTO3[[6]])){
#  lematizada <- ambiente[[ NOMBREPROYECTO3[[6]][2] ]]  
 # NOMBREPROYECTO3[[6]][i] <- ifelse(is.null(lematizada),NOMBREPROYECTO3[[6]][i], 
#                                    lematizada) 
#}

ambiente <- new.env(hash = TRUE, size = nrow(lemamatizer))

for (i in 1:length(palabras)) {
  assign(x = palabras[i], value = raices[i], envir = ambiente)
}

#ambiente[["jugaron"]]

funcion_lematizacion <- function(x){
  for( i in 1:length(x) ){
    lematizada <- ambiente[[ x[i] ]]  
    x[i] <- ifelse(is.null(lematizada), x[i], lematizada) 
  }
  return(x)
  }


NOMBREPROYECTO5 <- lapply(NOMBREPROYECTO4, FUN = funcion_lematizacion)
NOMBREPROYECTO5 <- lapply(NOMBREPROYECTO5, FUN = colapsarTexto)
NOMBREPROYECTO5 <- unlist(NOMBREPROYECTO5, " ")

# lematizar por segunda vez

NOMBREPROYECTO6 <- lapply(NOMBREPROYECTO5, FUN = separarTexto)
NOMBREPROYECTO6 <- lapply(NOMBREPROYECTO6, FUN = LimpiarEspacios)

NOMBREPROYECTO7 <- lapply(NOMBREPROYECTO6, FUN = funcion_lematizacion)
NOMBREPROYECTO7 <- lapply(NOMBREPROYECTO7, FUN = colapsarTexto)
NOMBREPROYECTO7 <- unlist(NOMBREPROYECTO7, " ")

df_titulo3$NOMBREPROYECTO_LEMA <- NOMBREPROYECTO5
df_titulo3$NOMBREPROYECTO_LEMA2 <- NOMBREPROYECTO7

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo3, "df_titulo4.rds")
