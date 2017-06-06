
rm(list = ls())
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "datos_procesados"))



df_identifOCAD <- readRDS("df_identifOCAD.rds" )
names(df_identifOCAD) <- gsub(" ", "_", names(df_identifOCAD) )

df_titulo <- subset(df_identifOCAD,select = c(BPIN, NOMBRE_DEL_PROYECTO))

indice_nomerroneo <- which(nchar(df_titulo$NOMBRE_DEL_PROYECTO) == max(nchar(df_titulo$NOMBRE_DEL_PROYECTO)))

# problema con nombre
which(df_titulo$BPIN == 2016005500008)
df_titulo$NOMBRE_DEL_PROYECTO[10180] <- "Alcantarillado Sanitario"

setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo, "df_titulo.rds")

