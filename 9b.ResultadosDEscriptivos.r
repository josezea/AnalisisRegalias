
rm(list = ls())

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta))
source("funciones_analisisexploratorio.r")


setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo5 <- readRDS("df_titulo5.rds")


# Todas las palabras
todaspalabras <- unlist(strsplit(df_titulo5$NOMBREPROYECTO_EDITADO, " "))
consulta_todaspalabras <- as.data.frame(table(todaspalabras))
consulta_todaspalabras <- arrange(consulta_todaspalabras, -Freq)
consulta_todaspalabras$porc <- consulta_todaspalabras$Freq / sum(consulta_todaspalabras$Freq) * 100
consulta_todaspalabras$acumporc <- cumsum(consulta_todaspalabras$porc)

#consulta_todaspalabras_sel <- consulta_todaspalabras %>% filter(Freq > 400)
consulta_todaspalabras_sel <- consulta_todaspalabras[1:30,]

#n_otras <-  sum(consulta_todaspalabras[consulta_todaspalabras$acumporc >= 95, "n"])
#n_porc <- sum(consulta_primerapalabra[consulta_todaspalabras$acumporc >= 95, "porc"])
#n_acumporc <- 100
#df_Otras <- data.frame(firstword_nomproyec = "Otras", n = n_otras, porc = n_porc, acumporc = n_acumporc)
#consulta_primerapalabra_sel <- rbind(consulta_primerapalabra_sel, df_Otras)

consulta_todaspalabras_sel$todaspalabras <- fct_rev(fct_inorder(factor(consulta_todaspalabras_sel$todaspalabras)))


grafico_consulta_todaspalabras_sel <- barplotDNP(data = consulta_todaspalabras_sel, 
                                                 Var = todaspalabras, Freq = Freq, xlabel = "Frecuencias", 
                                                 ylabel = "Palabras", main_title = "Frecuencias palabras (títulos)")

setwd(paste0(Ruta, "/", "resultados_parciales"))
print(grafico_consulta_todaspalabras_sel)
ggsave("grafico_consulta_todaspalabras_sel.png")

############################################################################


################################# Primeras palabras ######################## 
library(stringr)
firstword_nomproyec <- stringr::word(df_titulo5$NOMBREPROYECTO_EDITADO, 1)
unique_firstword_nomproyec <- unique(firstword_nomproyec)
df_titulo5$firstword_nomproyec <- firstword_nomproyec

consulta_pp <- df_titulo5 %>% group_by(firstword_nomproyec) %>% 
               summarise(Frec = n()) %>% arrange(-Frec)

consulta_pp_sel <- Frecuencias_otros(consulta_pp, firstword_nomproyec, 
                                     Frec, "Otras", 30)
names(consulta_pp_sel) <- c("primera_palabra", "Frecuencia")  

consulta_pp_sel$primera_palabra <- fct_rev(fct_inorder(factor(consulta_pp_sel$primera_palabra)))
g_consulta_pp_sel <- barplotDNP(data = consulta_pp_sel, 
                      Var = primera_palabra, Freq = Frecuencia, 
                      xlabel = "Frecuencias", 
                      ylabel = "Primera Palabra",
                      main_title = "Frecuencias primeras palabrass (títulos)")

setwd(paste0(Ruta, "/", "resultados_parciales"))
print(g_consulta_pp_sel)
ggsave("g_consulta_pp_sel.png")
############################################################################

  
############################ Bigramas ###################################### 
library(dplyr)
library(tidytext)
#library(janeaustenr)
  
setwd(Ruta)
dir()
source("FuncionesTexto.R")
  
df_bigramas <- df_titulo5[c("BPIN", "NOMBREPROYECTO_EDITADO")] %>%
unnest_tokens(bigram, NOMBREPROYECTO_EDITADO, token = "ngrams", n = 2)
  
df_bigramas$bigram <- utf8ToLatin1(df_bigramas$bigram)
  
Conteo_bigramas <- df_bigramas %>%
                   count(bigram, sort = TRUE)
  
Conteo_bigramas$porc <- Conteo_bigramas$n / sum(Conteo_bigramas$n) * 100
Conteo_bigramas$porcacum <- cumsum(Conteo_bigramas$porc)
  
Conteo_bigramas_sel <- Frecuencias_otros(Conteo_bigramas, bigram, 
                                           n, "Otras", 30)
names(Conteo_bigramas_sel) <- c("Bigrama", "Frecuencia")  
Conteo_bigramas_sel <- Conteo_bigramas_sel[-31,]

Conteo_bigramas_sel$Bigrama <- fct_rev(fct_inorder(factor(Conteo_bigramas_sel$Bigrama)))
g_Conteo_bigramas_sel <- barplotDNP(data = Conteo_bigramas_sel, 
                                    Var = Bigrama, Freq = Frecuencia, 
                                    xlabel = "Frecuencias", 
                                    ylabel = "Bigrama",
                                    main_title = "Frecuencias bigramas (títulos)")
  
setwd(paste0(Ruta, "/", "resultados_parciales"))
print(g_Conteo_bigramas_sel)
ggsave("g_Conteo_bigramas_sel.png")
############################################################################


############################ Trigramas ################################# 
  
df_trigramas <- df_titulo5[c("BPIN", "NOMBREPROYECTO_EDITADO")] %>%
                unnest_tokens(trigram, NOMBREPROYECTO_EDITADO, 
                              token = "ngrams", n = 3)
  
df_trigramas$trigram <- utf8ToLatin1(df_trigramas$trigram)
  
Conteo_trigramas <- df_trigramas %>%
                    count(trigram, sort = TRUE)
  
Conteo_trigramas$porc <- Conteo_trigramas$n / sum(Conteo_trigramas$n) * 100
Conteo_trigramas$porcacum <- cumsum(Conteo_trigramas$porc)
  
  
Conteo_trigramas_sel <- Frecuencias_otros(Conteo_trigramas, bigram, 
                                           n, "Otras", 30)
names(Conteo_trigramas_sel) <- c("Trigrama", "Frecuencia")  
Conteo_trigramas_sel <- Conteo_trigramas_sel[-31,]
  
Conteo_trigramas_sel$Trigrama <- fct_rev(fct_inorder(factor(Conteo_trigramas_sel$Trigrama)))
g_Conteo_trigramas_sel <- barplotDNP(data = Conteo_trigramas_sel, 
                                      Var = Trigrama, Freq = Frecuencia, 
                                      xlabel = "Frecuencias", 
                                      ylabel = "Trigrama",
                                      main_title = "Frecuencias Trigramas (títulos)")
  
setwd(paste0(Ruta, "/", "resultados_parciales"))
print(g_Conteo_trigramas_sel)
ggsave("g_Conteo_trigramas_sel.png")
############################################################################


####### Conservar las primeras palabras más comunes con quienes aparecen ###
  
principales_pp <- as.character(as.matrix(consulta_pp[1:5,"firstword_nomproyec"]))
  
  
#lista <- Conteo_bigramas_sel$bigram
texto <- Conteo_bigramas$bigram
  
  tokenizar <- function(x, posic){
    unlist(strsplit(x, " "))[posic]
  }
  
  
# texto <- Conteo_bigramas$bigram
# Conteo_bigramas$pal1 <- unlist(lapply(texto, tokenizar, 1))
# Conteo_bigramas$pal2<- unlist(lapply(texto, tokenizar, 2))
# ParejaPalabras<- filter(Conteo_bigramas, pal1 == "construcción")
  
f_parejaspalabras <- function(x){
texto <- Conteo_bigramas$bigram
Conteo_bigramas$pal1 <- unlist(lapply(texto, tokenizar, 1))
Conteo_bigramas$pal2<- unlist(lapply(texto, tokenizar, 2))
ParejaPalabras<- filter(Conteo_bigramas, pal1 == x)
ParejaPalabras <- ParejaPalabras[c("pal2", "n")]
}  

# construcción  

Pareja_Construccion <-   f_parejaspalabras("construcción")  

Conteo_Pareja_Construccion <- Frecuencias_otros(Pareja_Construccion, n, pal2, 
                                          "Otras", 30)
names(Conteo_Pareja_Construccion) <- c("PalabrasVSConstruccion", "Frecuencia")  
Conteo_Pareja_Construccion <- Conteo_Pareja_Construccion[-31,]

Conteo_Pareja_Construccion$PalabrasVSConstruccion <- fct_rev(fct_inorder(factor(Conteo_Pareja_Construccion$PalabrasVSConstruccion)))
g_Pareja_Construccion <- barplotDNP(data = Conteo_Pareja_Construccion, 
                                     Var = PalabrasVSConstruccion, Freq = Frecuencia, 
                                     xlabel = "Frecuencias", 
                                     ylabel = "PalabrasVSConstruccion",
                                     main_title = "Palabras vs Construccion")


print(g_Pareja_Construccion)
ggsave("g_Pareja_Construccion.png")


# mejoramiento

Pareja_mejoramiento <-   f_parejaspalabras("mejoramiento")  

Conteo_Pareja_mejoramiento <- Frecuencias_otros(Pareja_mejoramiento, n, pal2, 
                                                "Otras", 30)
names(Conteo_Pareja_mejoramiento) <- c("PalabrasVSmejoramiento", "Frecuencia")  
Conteo_Pareja_mejoramiento <- Conteo_Pareja_mejoramiento[-31,]

Conteo_Pareja_mejoramiento$PalabrasVSmejoramiento <- fct_rev(fct_inorder(factor(Conteo_Pareja_mejoramiento$PalabrasVSmejoramiento)))
g_Pareja_mejoramiento <- barplotDNP(data = Conteo_Pareja_mejoramiento, 
                                    Var = PalabrasVSmejoramiento, Freq = Frecuencia, 
                                    xlabel = "Frecuencias", 
                                    ylabel = "PalabrasVSmejoramiento",
                                    main_title = "Palabras vs Mejoramiento")


print(g_Pareja_mejoramiento)
ggsave("g_Pareja_mejoramiento.png")



# fortalecimiento

Pareja_fortalecimiento <-   f_parejaspalabras("fortalecimiento")  

Conteo_Pareja_fortalecimiento<- Frecuencias_otros(Pareja_fortalecimiento, n, pal2, 
                                                "Otras", 30)
names(Conteo_Pareja_fortalecimiento) <- c("PalabrasVSfortalecimiento", "Frecuencia")  
Conteo_Pareja_fortalecimiento <- Conteo_Pareja_fortalecimiento[-31,]

Conteo_Pareja_fortalecimiento$PalabrasVSfortalecimiento <- fct_rev(fct_inorder(factor(Conteo_Pareja_fortalecimiento$PalabrasVSfortalecimiento)))
g_Pareja_fortalecimiento <- barplotDNP(data = Conteo_Pareja_fortalecimiento, 
                                    Var = PalabrasVSfortalecimiento, Freq = Frecuencia, 
                                    xlabel = "Frecuencias", 
                                    ylabel = "PalabrasVSfortalecimiento",
                                    main_title = "Palabras vs Fortalecimiento")


print(g_Pareja_fortalecimiento)
ggsave("g_Pareja_fortalecimiento.png")





# estudio

Pareja_estudio <-   f_parejaspalabras("estudio")  

Conteo_Pareja_estudio<- Frecuencias_otros(Pareja_estudio, n, pal2, 
                                                  "Otras", 30)
names(Conteo_Pareja_estudio) <- c("PalabrasVSestudio", "Frecuencia")  
Conteo_Pareja_estudio <- Conteo_Pareja_estudio[-31,]

Conteo_Pareja_estudio$PalabrasVSestudio <- fct_rev(fct_inorder(factor(Conteo_Pareja_estudio$PalabrasVSestudio)))
g_Pareja_estudio<- barplotDNP(data = Conteo_Pareja_estudio, 
                                       Var = PalabrasVSestudio, Freq = Frecuencia, 
                                       xlabel = "Frecuencias", 
                                       ylabel = "PalabrasVSestudio",
                                       main_title = "Palabras vs Estudio")


print(g_Pareja_estudio)
ggsave("g_Pareja_estudio.png")


# implementación

Pareja_implementación <-   f_parejaspalabras("implementación")  

Conteo_Pareja_implementación<- Frecuencias_otros(Pareja_implementación, n, pal2, 
                                          "Otras", 30)
names(Conteo_Pareja_implementación) <- c("PalabrasVSimplementación", "Frecuencia")  
Conteo_Pareja_implementación <- Conteo_Pareja_implementación[-31,]

Conteo_Pareja_implementación$PalabrasVSimplementación <- fct_rev(fct_inorder(factor(Conteo_Pareja_implementación$PalabrasVSimplementación)))
g_Pareja_implementación<- barplotDNP(data = Conteo_Pareja_implementación, 
                              Var = PalabrasVSimplementación, Freq = Frecuencia, 
                              xlabel = "Frecuencias", 
                              ylabel = "PalabrasVSimplementación",
                              main_title = "Palabras vs Implementación")


print(g_Pareja_implementación)
ggsave("g_Pareja_implementación.png")

