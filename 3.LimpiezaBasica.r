
rm(list = ls())
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo <- readRDS("df_titulo.rds")
# Procesamiento de texto
NOMBREPROYECTO <- df_titulo$NOMBRE_DEL_PROYECTO
NOMBREPROYECTO <- tolower(df_titulo$NOMBRE_DEL_PROYECTO)
NOMBREPROYECTO <- gsub("-", "", NOMBREPROYECTO)
NOMBREPROYECTO <- gsub("[[:punct:]]", "", NOMBREPROYECTO)
NOMBREPROYECTO <- gsub("[[:digit:]]+", "", NOMBREPROYECTO)
NOMBREPROYECTO <- gsub(' +',' ',NOMBREPROYECTO) # remover espacios
NOMBREPROYECTO <- trimws(NOMBREPROYECTO) # Quitar espacios en los extremos




df_titulo$NOMBREPROYECTO <- NOMBREPROYECTO
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo, "df_titulo1.rds")
