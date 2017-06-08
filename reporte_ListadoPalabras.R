library(dplyr)
library(hunspell)
# Paso 1a: Reporte de Frecuencias para ver posibles palabras para añadir al diccionario
# Paso 1b: Reemplazos manuales


Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
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

# Reporte revisión de ortografía
esp <- dictionary(paste0(Ruta, "Diccionario/Colombia/", "es_CO.dic"))


revisar <- hunspell_check(ranking_palabras$listado, dict = esp)
ranking_palabras$revisar <- revisar
ranking_palabras <- arrange(ranking_palabras, revisar, -Freq )


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
  "etnoeducativo", "etnoeducativo")



eliminar_palabras <- c("k", "c", "m", "ml", "visr", "pr", "glp", "iii", "av", "av", 
                       "eot", "l", "kr", "mts", "clle", "ctei", "n", "dc", "ptap", "mr", 
                       "cer", "diag", "ra", "cc", "kv", "ptar", "tab", "x", "estanislao", 
                       "urb", "cla", "cgto", "iv", "kms", "vip", "xii", "cic", "cis", 
                       "v", "h", "i", "pz", "cle", "clls", "correg", "g", "ky")


#pre inversion
#atraves