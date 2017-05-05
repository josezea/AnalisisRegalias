

library(RODBC) 
library(sqldf)
dbhandle <- odbcDriverConnect('driver={SQL Server}; 
                               server=vbidev; 
                               database = MAPAI_Fuente1;
                               trusted_connection = true')



pry.EstadoProyecto <- sqlQuery(dbhandle, 
'select *
 from MAPAI_Fuente1.pry.EstadoProyecto')

dim(pry.EstadoProyecto)
table(pry.EstadoProyecto$NombreOrigen)

pry.IdentificacionProyecto_Aprob <- sqlQuery(dbhandle,
                                    "select * 
                                    from MAPAI_Fuente1.pry.IdentificacionProyecto
                                    where  NombreOrigen = 'SUIFP SGR'")




#¿Cómo sacar las causas de un proyectos?

# Archivo de causas
# Proyectos y Suif SGR
if(FALSE){
pry.Causa <- sqlQuery(dbhandle, 
'select * 
 from MAPAI_Fuente1.pry.Causa')
dim(pry.Causa)

pry.Causa$Bpin <- as.character(pry.Causa$Bpin )

# traerle la columna estado de la tabla de identificación
library(dplyr)
prueba <- pry.IdentificacionProyecto_Aprob %>% left_join(pry.Causa,m, by = "Bpin")   
          



pry.Efecto <- sqlQuery(dbhandle, 
'select * 
 from MAPAI_Fuente1.pry.Efecto')

dim(pry.Efecto)
}

setwd("C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/datos")
library(readxl)
datos_ocad <- read_excel("AVANCEOCAD_15032017_R.xlsx")
datos_ocad$BPIN <- as.character(datos_ocad$BPIN)


#################################################################
# Ediciones de los datos (Eliminación de duplicados) y conservar Bpin de los proyectos

# Identificación proyecto

pry.IdentificacionProyecto_Aprob$Bpin<- as.character(pry.IdentificacionProyecto_Aprob$Bpin)
table(duplicated(pry.IdentificacionProyecto_Aprob$Bpin))

#pry.IdentificacionProyecto_Aprob[10,] == pry.IdentificacionProyecto_Aprob[11,]

# Eliminar duplicados 
duplicated(pry.IdentificacionProyecto_Aprob$Bpin)

pry.IdentificacionProyecto_Aprob <- pry.IdentificacionProyecto_Aprob[!duplicated(pry.IdentificacionProyecto_Aprob$Bpin),]
dim(pry.IdentificacionProyecto_Aprob)

# Seleccionar solo los que aparecen en la página web SGR: 
# https://www.sgr.gov.co/SMSCE/MonitoreoSGR/AvancesOCAD.aspx

dim(datos_ocad)
table( datos_ocad$BPIN %in% pry.IdentificacionProyecto_Aprob$Bpin)
# 4 registros no aparecen en la identificaciónd e proyecto 

codigosfalt <- datos_ocad[!(datos_ocad$BPIN %in% pry.IdentificacionProyecto_Aprob$Bpin),]

table(pry.IdentificacionProyecto_Aprob$Bpin %in% datos_ocad$BPIN)


seleccionvariable <- c("IdOrigen", "NombreOrigen", "FechaInsercionRegistro", 
                 "IdUnicoFuente", "IdProyecto", "Bpin",  "UltimaFechaTransferencia", 
                 "ProblemaCentral", "Descripcion", "Magnitud", 
                 "AnalisisDeParticipantes", "ObjetivoGeneral", "Supuesto", "IdAlternativaSolucion", 
                 "AlternativaSolucion", "ResultadoEvaluacionMulticriterio", "AnioInicio", 
                 "AnioFinal", "IdEntidadResponsable", "CodigoEntidadResponsable", 
                 "EntidadResponsable", "ImagenDelProyecto", "UrlFichaDelProyecto", 
                 "IdEstadoActual", "CodigoEstadoActual", "EstadoActual", "IdEstadoAprobacion", 
                 "EstadoAprobacion", "IdEstadoPriorizacion", "EstadoPriorizacion", 
                 "Puntaje", "AvanceFisico", "AvanceProducto", "AvanceFinanciero", 
                 "AvanceGestion", "IdProgramaProgramacion", "CodigoProgramaProgramacion", 
                 "ProgramaProgramacion", "IdSubprogramaProgramacion", "CodigoSubprogramaProgramacion", 
                 "SubProgramaProgramacion", "IdSector", "CodigoSector", "Sector", 
                 "FechaEstadoActual", "IdSectorGasto", "CodigoSectorGasto", "SectorGasto", 
                 "EsRegionalizable", "ConpesAsociado", "IdTipoProyecto", "TipoProyecto", 
                 "IdProyectoEstandard", "ProyectoEstandar", "IdFase", "Fase", 
                 "IdSolicitudRecursosPara", "SolicitudRecursosPara", "Formulador", 
                 "CalificacionOcad", "PriorizacionOcad", "Proceso", "TasaInteresOportunidad", 
                 "FechaAprobacion", "PeriodoAnio", "PeriodoMes")

pry.IdentificacionProyecto_Aprob$Bpin %in% datos_ocad$BPIN


df_identifOCAD <- merge( datos_ocad, pry.IdentificacionProyecto_Aprob, all.x = T,
                          by.x = "BPIN", by.y = "Bpin")


# Eliminar los saltos de linea, de página y las tabulaciones
removersaltos <- function(x){
  gsub("[\r\n\t]", "",  x)
}

isfactorchar <- function(x){
  is.character(x) | is.factor(x)
}
index <- as.vector(as.matrix(unlist(lapply(df_identifOCAD,  FUN = isfactorchar))))
pr <- df_identifOCAD

for(i in which(index)){
  df_identifOCAD[,i] <- removersaltos(df_identifOCAD[,i]) 
}
setwd("C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/datos_procesados")
write.table(df_identifOCAD, "df_identifOCAD.csv", sep = "\t", dec = ",", row.names = F)
saveRDS(df_identifOCAD, "df_identifOCAD.rds")


# Pendiente la del plan de desarrollo

