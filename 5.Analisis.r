library(widyr)
library(tidytext)
library(dplyr)
library(ggraph)
library(igraph)

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo4 <- readRDS("df_titulo4.rds")
df_titulo4 <- df_titulo4[c("BPIN", "NOMBREPROYECTO_LEMA")]


PalabrasXProyecto <- df_titulo4 %>% mutate(NroProyecto = 1:nrow(df_titulo4)) %>%
  unnest_tokens(Palabras, NOMBREPROYECTO_LEMA)

# count words co-occuring within sections
pares_palabras <- PalabrasXProyecto %>%
  pairwise_count(Palabras, NroProyecto, sort = TRUE)
pares_palabras <- arrange(pares_palabras, -n)

CuentaPalabrasXProyecto <-  PalabrasXProyecto %>%
  group_by(Palabras) %>% summarise(n = n())


# Todas las correlaciones
PalabrasCor <- PalabrasXProyecto %>%
  group_by(Palabras) %>%
  pairwise_cor(Palabras, NroProyecto, sort = TRUE)


# Representación gráfica

# Todas las correlaciones
PalabrasCor_sel <- PalabrasXProyecto %>%
  group_by(Palabras) %>%
  filter(n() >= 30) %>%
  pairwise_cor(Palabras, NroProyecto, sort = TRUE)




# Los gráficos rrestringidos pero lo demas dejarlo completo
X11()
PalabrasCor %>%
  filter(correlation > .15) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation), show.legend = FALSE) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()





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


