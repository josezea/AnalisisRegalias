library(dplyr)
library(hunspell)
# Paso 1a: Reporte de Frecuencias para ver posibles palabras para a�adir al diccionario
# Paso 1b: Reemplazos manuales


Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regal�as/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo <- readRDS("df_titulo.rds")


listado <- unlist(strsplit (df_titulo$NOMBRE_DEL_PROYECTO, split = " "))
listado <- tolower(listado)
listado <- gsub("-", " ", listado)
listado <- gsub("[[:punct:]]", "", listado)
listado <- gsub("[[:digit:]]+", "", listado)
listado <- gsub(' +',' ',listado)
listado <- trimws(listado)

#listado <- unique(listado)
length(listado)

ranking_palabras <- as.data.frame(table(listado))
ranking_palabras <- arrange(ranking_palabras, -Freq)
ranking_palabras$listado <- as.character(ranking_palabras$listado)

# Reporte revisi�n de ortograf�a
esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"))


revisar <- hunspell_check(ranking_palabras$listado, dict = esp)
ranking_palabras$revisar <- revisar
ranking_palabras <- arrange(ranking_palabras, revisar, -Freq )


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
  "etnoeducativo", "etnoeducativo")



eliminar_palabras <- c("k", "c", "m", "ml", "visr", "pr", "glp", "iii", "av", "av", 
                       "eot", "l", "kr", "mts", "clle", "ctei", "n", "dc", "ptap", "mr", 
                       "cer", "diag", "ra", "cc", "kv", "ptar", "tab", "x", "estanislao", 
                       "urb", "cla", "cgto", "iv", "kms", "vip", "xii", "cic", "cis", 
                       "v", "h", "i", "pz", "cle", "clls", "correg", "g", "ky")


#pre inversion
#atraves