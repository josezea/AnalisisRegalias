rm(list = ls())
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(Ruta)
dir()
source("FuncionesTexto.R")


setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo4 <- readRDS("df_titulo4.rds")
NOMBREPROYECTO <- df_titulo4$NOMBREPROYECTO_EDITADO
NOMBREPROYECTO2 <- lapply(NOMBREPROYECTO, FUN = separarTexto)
NOMBREPROYECTO2 <- lapply(NOMBREPROYECTO2, FUN = LimpiarEspacios)

# Deslematizar 

lematizada <- c("alcantarillar", "hollar", "quebrar", "cascar",
                "patinódromo", "visr", "pis", "acoquinamiento", "avenir")

deslematizada <-  c("alcantarillado", "huellas", "quebrada ","casco", 
"patinadero", "vise", "ips", "adoquín", "avenida")

ambiente1 <- new.env(hash = TRUE, size = length(lematizada))


for (i in 1:length(lematizada)) {
  assign(x = lematizada[i], value = deslematizada[i], envir = ambiente1)
}

#ambiente1[["cascar"]]
#ambiente1[["alcantarillar"]]
#ambiente1[["hollar"]]

# which(df_titulo4$BPIN == 2012155720005)
# x <- NOMBREPROYECTO2[[857]]
# i <- 857

funcion_deslematizar <- function(x){
  for( i in 1:length(x) ){
    valor_deslematizado <- ambiente1[[ x[i] ]]  
    x[i] <- ifelse(is.null(valor_deslematizado), x[i], valor_deslematizado) 
  }
  return(x)
}

NOMBREPROYECTO3 <- lapply(NOMBREPROYECTO2, FUN = funcion_deslematizar)
NOMBREPROYECTO3 <- unlist(lapply(NOMBREPROYECTO3, colapsarTexto))


######################### Corrección ortográfica manual ########################
setwd(paste0(Ruta, "CorreccionOrtograficaManual"))
corregirmanual <- read_excel("CorreccionOrtogManual.xlsx")

corregida <- corregirmanual$Corregida
erroneas <- corregirmanual$Errroneas

ambiente <- new.env(hash = TRUE, size = nrow(corregida))

for (i in 1:length(corregida)) {
  assign(x = erroneas[i], value = corregida[i], envir = ambiente)
}

#ambiente[["vias"]]
#ambiente[["optimizacion"]]
#ambiente[["fdfd"]]


# x <- NOMBREPROYECTO2[[90]]

funcion_corrortog <- function(x){
  for( i in 1:length(x) ){
    corregida <- ambiente[[x[i]]]  
    x[i] <- ifelse(is.null(corregida), x[i], corregida) 
  }
  return(x)
}

NOMBREPROYECTO4 <- lapply(NOMBREPROYECTO3, FUN = funcion_corrortog)
NOMBREPROYECTO4 <- unlist(lapply(NOMBREPROYECTO4, colapsarTexto))

df_titulo4$NOMBREPROYECTO_EDITADO <- NOMBREPROYECTO4



Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo4, "df_titulo5.rds")
write.table(df_titulo4, "df_titulo5.csv", sep = "\t")




# identificar palabras a deslematizar (revisar el archivo de reestructuración) 

#identificar_palabras <- function(x, list){
#  paste(grep(paste0("\\b(", paste0(list, collapse = "|"), ")\\b"), 
#             unlist(strsplit(x, " "))), collapse = ", ")
#}

#IndicaDeslematizar <- unlist(lapply(NOMBREPROYECTO4,  FUN = identificar_palabras,
#                                    lista)) 

#Revisionproy <- df_titulo4[df_titulo4$IndicaDeslematizar != "",]
#write.csv(Revisionproy, "Revisionproy.csv")



#df_titulo4$IndicaDeslematizar <- IndicaDeslematizar

