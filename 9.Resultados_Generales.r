library(widyr)
library(tidytext)
library(dplyr)
library(ggraph)
library(igraph)

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))

#PalabrasXProyecto <- readRDS("PalabrasXProyecto.rds")
PalabrasXProyectoNoDUP <- readRDS("PalabrasXProyectoNoDUP.rds")

#saveRDS(cuenta_palabras, "cuenta_palabras.rds")
#saveRDS(pares_palabras, "pares_palabras.rds")
#saveRDS(pares_palabras_NoDup, "pares_palabras_NoDup.rds")

# Representación gráfica

# Todas las correlaciones
PalabrasCor_sel <- PalabrasXProyecto %>%
  group_by(Palabras) %>%
  filter(n() >= 30) %>%
  pairwise_cor(Palabras, NroProyecto, sort = TRUE)




# Los gráficos rrestringidos pero lo demas dejarlo completo
PalabrasCor_sel <- PalabrasCor_sel %>%
  filter(correlation > 0.2) 

c1 = data.frame(t(apply(PalabrasCor_sel[,1:2], 1, function(x) sort(x))))
PalabrasCor_sel <- PalabrasCor_sel[!duplicated(c1), ]


#X11()
PalabrasCor_sel %>% 
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()




############################ Bigramas ################################# 
library(dplyr)
library(tidytext)
library(janeaustenr)

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

Conteo_bigramas_sel <- Conteo_bigramas %>% filter(n >= 100)
library(forcats)
Conteo_bigramas_sel$bigram <- as.factor(Conteo_bigramas_sel$bigram)
Conteo_bigramas_sel$bigram <- fct_rev(fct_inorder(Conteo_bigramas_sel$bigram))

g2 <- ggplot(Conteo_bigramas_sel, aes(x = bigram, y = n)) +
  geom_bar(stat="identity", width = 0.7, color = "#80202A",
           fill = "#80202A") + theme_classic() +
  theme(text=element_text(family="Trebuchet MS"),axis.text.x = element_text(angle = 90, hjust = 1,
  size = 10), 
  panel.background = element_rect(fill = "transparent", colour = NA),
  plot.background = element_rect(fill = "transparent", colour = NA)) +
  ylab("Número de ficheros") + xlab("Entidad" ) +
   coord_flip() 



df_trigramas <- df_titulo5[c("BPIN", "NOMBREPROYECTO_EDITADO")] %>%
  unnest_tokens(trigram, NOMBREPROYECTO_EDITADO, token = "ngrams", n = 3)

df_trigramas$trigram <- utf8ToLatin1(df_trigramas$trigram)

Conteo_trigramas <- df_trigramas %>%
  count(trigram, sort = TRUE)

Conteo_trigramas$porc <- Conteo_trigramas$n / sum(Conteo_trigramas$n) * 100
Conteo_trigramas$porcacum <- cumsum(Conteo_trigramas$porc)

Conteo_trigramas_sel <- Conteo_trigramas %>% filter(n >= 25)
library(forcats)
Conteo_trigramas_sel$trigram <- as.factor(Conteo_trigramas_sel$trigram)
Conteo_trigramas_sel$trigram <- fct_rev(fct_inorder(Conteo_trigramas_sel$trigram))

g3 <- ggplot(Conteo_trigramas_sel, aes(x = trigram, y = n)) +
  geom_bar(stat="identity", width = 0.7, color = "#80202A",
           fill = "#80202A") + theme_classic() +
  theme(text=element_text(family="Trebuchet MS"),axis.text.x = element_text(angle = 90, hjust = 1,
                                                                            size = 10), 
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA)) +
  ylab("Número de ficheros") + xlab("Entidad" ) +
  coord_flip() 


library(ggraph)
set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)



# Frecuencia de todas las palabras
# Primeras palabras (frecuencias)
# Relación con construcción, relación mejoramiento (principales primeras palabras)
# Fotos
# Digramas

set.seed(2016)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()




PalabrasXProyecto <- df_titulo5 %>% mutate(NroProyecto = 1:nrow(df_titulo5)) %>%
  unnest_tokens(Palabras, NOMBREPROYECTO_EDITADO)







# Dejando solo las primeras palabras
# Pensarla bien
pares_palabras2 <- pares_palabras[pares_palabras$item1 %in% unique_firstword_nomproyec,] 
c3 = data.frame(t(apply(pares_palabras2[,1:2], 1, function(x) sort(x))))
pares_palabras3 <- pares_palabras2[!duplicated(c3), ]

cuenta_palabras <- PalabrasXProyecto %>%
  group_by(Palabras) %>% summarise(n = n()) %>% mutate(Porc = 100 * n / sum(n)) %>%
  arrange(-n) %>% mutate(FrecAcum = cumsum(Porc))

# 9155 todas las palabras, 105 palabras en la primera posición

# Consulta de cuantas veces aparecen las primeras palabras
con_frecPrimPal <- cuenta_palabras[cuenta_palabras$Palabras %in% unique_firstword_nomproyec,]

# Todas las correlaciones
PalabrasCor <- PalabrasXProyecto %>%
  group_by(Palabras) %>%
  filter(n() >= 20) %>%
  pairwise_cor(Palabras, NroProyecto, sort = TRUE)

PalabrasCor2 <- PalabrasCor[PalabrasCor$item1 %in% unique_firstword_nomproyec,] 
PalabrasCor2 <- arrange(PalabrasCor2, item1, -correlation)

consulta <- PalabrasCor2 %>% group_by(item1) %>% summarize(max = max(correlation))
table(PalabrasCor2$correlation > 0.15)
# Dejar palabras que sean frecuentes como primera palabra


# Los gráficos rrestringidos pero lo demas dejarlo completo
library(ggraph)
library(igraph)
X11()
PalabrasCor2 %>%
  filter(correlation > .15) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = 1:128, size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()

require(stringr)
nwords <- function(string, pseudo=F){
  ifelse( pseudo, 
          pattern <- "\\S+", 
          pattern <- "[[:alpha:]]+" 
  )
  str_count(string, pattern)
}

df_titulo5$npalabras<- nwords(df_titulo5$NOMBREPROYECTO_EDITADO)
#install.packages("qdap")
X11()
hist(nwords(df_titulo5$NOMBREPROYECTO_EDITADO))
write.csv(df_titulo5, "df_titulo5.csv")