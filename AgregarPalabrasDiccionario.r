# Correcci�n ortogr�fica con Hunspell
library(readxl)
library(tm)
rm(list = ls())

############################## Corrector ortogr�fico Hunspell ###################


# Agregar palabras al diccionario
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regal�as/" 
setwd(Ruta)
source("FuncionesTexto.R")

palabras_especiales <- c("drogadicci�n", "instituci�n", "pavimentaci�n", "implementaci�n", "polideportivo",
                         "remodelaci�n", "vehicular",
                         "optimizaci�n", "polideportiva", "polideportivos", "recreacional",
                         "perimetral", "afrodescendiente", "vehiculares", "biosaludables",
                         "coulvert", "volqueta", "adoqu�n", "adoqu�n", "electrificaci�n",
                         "motoniveladora", "compactador", "emprendimiento", "veredales",
                         "afrocolombiana", "agroindustrial", "mitigaci�n", "reforestaci�n",
                         "polifuncional", "retroexcavadora", "panelera", "polideportivas","preinversi�n",
                         "reservorios", "sostenibilidad", "afrodescendientes", "agroforestales",
                         "biodiversidad", "biom�dicos", "conectividad", "exprovincia",
                         "antibacteriales", "habitacionales", "microfutbol", "multifuncionales",
                         "corregimental", "estratificaci�n", "etnodesarrollo", "masificaci�n",
                         "megacolegio", "tsunami", "vibrocompactador", "agroindustria", "biling�ismo",
                         "carreteable", "descolmataci�n", "h�drico", "interconexi�n", "predial",
                         "repotenciaci�n", "reubicaci�n", "socioecon�mica", "afro", "biling�e",
                         "afrocolombianas", "autoconsumo", "autosostenible", "caficultura",
                         "h�dricos", "impulsi�n", "internet", "lulo", "microempresarial", "nutricionales",
                         "silvopastoriles", "sisben", "subsector", "empleabilidad",
                         "etnoeducativo", "etnoeducativo",
                         "amazon�a","atl�ntico", "orinoqu�a", "pac�fico")

# Lectura archivo DIVIPOLA
setwd(paste0(Ruta, "/", "datos"))
df_divipola <-  read_excel("DivisionPoliticoAdministrativaColombia.XLS")

# Lectura archivo de regal�as
setwd(paste0(Ruta, "/", "datos_procesados"))
df_identifOCAD <- readRDS("df_identifOCAD.rds") 

dir()
names(df_divipola) <- gsub("\n","",names(df_divipola))

names(df_divipola) <- gsub(" ","",names(df_divipola))

# Remover nombres geogr�ficos
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
nom_geo <- c(nom_geo, "bogot�", "bogota")
nom_geo <- gsub("\\(", "", nom_geo)
nom_geo <- gsub("\\)", "", nom_geo)
nom_geo <- c(nom_geo)



palabras_agregadas <- unique(c(nom_geo, palabras_especiales))
setwd(paste0(Ruta, "Diccionario/Colombia/"))
saveRDS(palabras_agregadas, "palabras_agregadas.rds")

