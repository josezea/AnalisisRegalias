library(widyr)
library(tidytext)
library(dplyr)

Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo5 <- readRDS("df_titulo5.rds")

PalabrasXProyecto <- df_titulo5 %>% mutate(NroProyecto = 1:nrow(df_titulo5)) %>%
  unnest_tokens(Palabras, NOMBREPROYECTO_EDITADO)

cuenta_palabras <- PalabrasXProyecto %>%
  group_by(Palabras) %>% summarise(n = n()) %>% mutate(Porc = 100 * n / sum(n)) %>%
  arrange(-n) %>% mutate(FrecAcum = cumsum(Porc))

# count words co-occuring within sections
pares_palabras <- PalabrasXProyecto %>%
  pairwise_count(Palabras, NroProyecto, sort = TRUE)
pares_palabras <- arrange(pares_palabras, -n)


c2 = data.frame(t(apply(pares_palabras[,1:2], 1, function(x) sort(x))))
pares_palabras_NoDup <- pares_palabras[!duplicated(c2), ]

saveRDS(PalabrasXProyecto, "PalabrasXProyecto.rds")
saveRDS(cuenta_palabras, "cuenta_palabras.rds")
saveRDS(pares_palabras, "pares_palabras.rds")

# Todas las correlaciones
#PalabrasCor <- PalabrasXProyecto %>%
#  group_by(Palabras) %>%
#  pairwise_cor(Palabras, NroProyecto, sort = TRUE)

