library(widyr)
library(tidytext)
library(dplyr)
library(ggraph)
library(igraph)
library(forcats)
library(extrafont)
font_import("Trebuchet MS")
extrafont::loadfonts(device="win")

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 

setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo5 <- readRDS("df_titulo5.rds")

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



