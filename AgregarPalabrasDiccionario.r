# Corrección ortográfica con Hunspell
library(readxl)
library(tm)
rm(list = ls())

############################## Corrector ortográfico Hunspell ###################


# Agregar palabras al diccionario
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(Ruta)
source("FuncionesTexto.R")

palabras_especiales <- c("drogadicción", "institución", "pavimentación", "implementación", "polideportivo",
                         "remodelación", "vehicular",
                         "optimización", "polideportiva", "polideportivos", "recreacional",
                         "perimetral", "afrodescendiente", "vehiculares", "biosaludables",
                         "coulvert", "volqueta", "adoquín", "adoquín", "electrificación",
                         "motoniveladora", "compactador", "emprendimiento", "veredales",
                         "afrocolombiana", "agroindustrial", "mitigación", "reforestación",
                         "polifuncional", "retroexcavadora", "panelera", "polideportivas","preinversión",
                         "reservorios", "sostenibilidad", "afrodescendientes", "agroforestales",
                         "biodiversidad", "biomédicos", "conectividad", "exprovincia",
                         "antibacteriales", "habitacionales", "microfutbol", "multifuncionales",
                         "corregimental", "estratificación", "etnodesarrollo", "masificación",
                         "megacolegio", "tsunami", "vibrocompactador", "agroindustria", "bilingüismo",
                         "carreteable", "descolmatación", "hídrico", "interconexión", "predial",
                         "repotenciación", "reubicación", "socioeconómica", "afro", "bilingüe",
                         "afrocolombianas", "autoconsumo", "autosostenible", "caficultura",
                         "hídricos", "impulsión", "internet", "lulo", "microempresarial", "nutricionales",
                         "silvopastoriles", "sisben", "subsector", "empleabilidad",
                         "etnoeducativo", "etnoeducativo",
                         "amazonía","atlántico", "orinoquía", "pacífico")

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
nom_geo <- c(nom_geo)



palabras_agregadas <- unique(c(nom_geo, palabras_especiales))
setwd(paste0(Ruta, "Diccionario/Colombia/"))
saveRDS(palabras_agregadas, "palabras_agregadas.rds")

