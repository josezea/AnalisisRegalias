rm(list = ls())
# Corrección ortográfica con Hunspell

library(koRpus)
library(readxl)
library(tm)
library(devtools)
#devtools::install_github("ropensci/hunspell", force = T)
library(hunspell)
library(parallel)
rm(list = ls())

############################## Corrector ortográfico Hunspell ###################


Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 

setwd(paste0(Ruta, "/", "resultados_parciales"))
df_titulo2 <- readRDS("df_titulo2.rds")

Sys.setlocale("LC_ALL", "Spanish_Colombia.1252")
library(koRpus)

treetagger <- function(x){
library(koRpus)  
txt2 <- treetag(x, treetagger="manual", lang = "es", 
                encoding = "UTF-8",
                TT.options=list(path="C:/TreeTagger", preset = "es"),
                format = "obj")

texto <- slot(txt2, "TT.res")
texto_lematizado <- ifelse(texto$lemma == "<unknown>", texto$token, 
                           texto$lemma)

texto_lematizado <- paste(texto_lematizado, collapse = " ")
texto_lematizado
}

NOMBREPROYECTO2 <- df_titulo2$NOMBREPROYECTO_ortog

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3a <- parLapply(cl, NOMBREPROYECTO2[1:300], treetagger))
stopCluster(cl)
gc(reset = T)

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3b <- parLapply(cl, NOMBREPROYECTO2[301:600], treetagger))
stopCluster(cl)
gc(reset = T)

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3c <- parLapply(cl, NOMBREPROYECTO2[601:900], treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3d <- parLapply(cl, NOMBREPROYECTO2[901:1200], treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3e <- parLapply(cl, NOMBREPROYECTO2[1201:1400], treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3f <- parLapply(cl, NOMBREPROYECTO2[1401:1600], treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3g <- parLapply(cl, NOMBREPROYECTO2[1601:1700], treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3h <- parLapply(cl, NOMBREPROYECTO2[1701:1850], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3i <- parLapply(cl, NOMBREPROYECTO2[1851:2000], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3j <- parLapply(cl, NOMBREPROYECTO2[2001:2300], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3k <- parLapply(cl, NOMBREPROYECTO2[2301:2400], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3l <- parLapply(cl, NOMBREPROYECTO2[2401:2600], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3m <- parLapply(cl, NOMBREPROYECTO2[2601:2900], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3n <- parLapply(cl, NOMBREPROYECTO2[2901:3200], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)




numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3o <- parLapply(cl, NOMBREPROYECTO2[3201:3400], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3p <- parLapply(cl, NOMBREPROYECTO2[3401:3700], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)




numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3q <- parLapply(cl, NOMBREPROYECTO2[3701:3800], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)




numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3r <- parLapply(cl, NOMBREPROYECTO2[3801:4000], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3s <- parLapply(cl, NOMBREPROYECTO2[4001:4300], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3t <- parLapply(cl, NOMBREPROYECTO2[4301:4600], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3u <- parLapply(cl, NOMBREPROYECTO2[4601:4900], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3v <- parLapply(cl, NOMBREPROYECTO2[4901:5100], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3w <- parLapply(cl, NOMBREPROYECTO2[5101:5400], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3x <- parLapply(cl, NOMBREPROYECTO2[5401:5600], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3y <- parLapply(cl, NOMBREPROYECTO2[5601:5800], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3z <- parLapply(cl, NOMBREPROYECTO2[5801:6100], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3aa <- parLapply(cl, NOMBREPROYECTO2[6101:6300], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3ab <- parLapply(cl, NOMBREPROYECTO2[6301:6600], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3ac <- parLapply(cl, NOMBREPROYECTO2[6601:6900], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3ad <- parLapply(cl, NOMBREPROYECTO2[6901:7200], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3ae <- parLapply(cl, NOMBREPROYECTO2[7201:7250], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3af <- parLapply(cl, NOMBREPROYECTO2[7251:7300], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)


NOMBREPROYECTO3 <- c(NOMBREPROYECTO3a, NOMBREPROYECTO3b, 
            NOMBREPROYECTO3c, NOMBREPROYECTO3d, NOMBREPROYECTO3e, NOMBREPROYECTO3f, 
            NOMBREPROYECTO3g, NOMBREPROYECTO3h, NOMBREPROYECTO3i, NOMBREPROYECTO3j, 
            NOMBREPROYECTO3k, NOMBREPROYECTO3l, NOMBREPROYECTO3m, NOMBREPROYECTO3n, 
            NOMBREPROYECTO3o, NOMBREPROYECTO3p, NOMBREPROYECTO3q, NOMBREPROYECTO3r, 
            NOMBREPROYECTO3s, NOMBREPROYECTO3t, NOMBREPROYECTO3u, NOMBREPROYECTO3v, 
            NOMBREPROYECTO3w, NOMBREPROYECTO3x, NOMBREPROYECTO3y, NOMBREPROYECTO3z,
            NOMBREPROYECTO3aa, NOMBREPROYECTO3ab, NOMBREPROYECTO3ac, NOMBREPROYECTO3ad,
            NOMBREPROYECTO3ae, NOMBREPROYECTO3af)
length(NOMBREPROYECTO4)

rm(NOMBREPROYECTO3a, NOMBREPROYECTO3b, 
   NOMBREPROYECTO3c, NOMBREPROYECTO3d, NOMBREPROYECTO3e, NOMBREPROYECTO3f, 
   NOMBREPROYECTO3g, NOMBREPROYECTO3h, NOMBREPROYECTO3i, NOMBREPROYECTO3j, 
   NOMBREPROYECTO3k, NOMBREPROYECTO3l, NOMBREPROYECTO3m, NOMBREPROYECTO3n, 
   NOMBREPROYECTO3o, NOMBREPROYECTO3p, NOMBREPROYECTO3q, NOMBREPROYECTO3r, 
   NOMBREPROYECTO3s, NOMBREPROYECTO3t, NOMBREPROYECTO3u, NOMBREPROYECTO3v, 
   NOMBREPROYECTO3w, NOMBREPROYECTO3x, NOMBREPROYECTO3y, NOMBREPROYECTO3z,
   NOMBREPROYECTO3aa, NOMBREPROYECTO3ab, NOMBREPROYECTO3ac, NOMBREPROYECTO3ad,
   NOMBREPROYECTO3ae, NOMBREPROYECTO3af)

gc(reset = T)

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4a <- parLapply(cl, NOMBREPROYECTO2[7301:7600], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4b <- parLapply(cl, NOMBREPROYECTO2[7601:7900], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4c <- parLapply(cl, NOMBREPROYECTO2[7901:8200], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4d <- parLapply(cl, NOMBREPROYECTO2[8201:8500], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4e <- parLapply(cl, NOMBREPROYECTO2[8501:8700], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4e1 <- parLapply(cl, NOMBREPROYECTO2[8701:8800], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4f <- parLapply(cl, NOMBREPROYECTO2[8801:9000], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4g <- parLapply(cl, NOMBREPROYECTO2[9001:9100], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4g1 <- parLapply(cl, NOMBREPROYECTO2[9101:9200], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4h <- parLapply(cl, NOMBREPROYECTO2[9201:9300], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4i <- parLapply(cl, NOMBREPROYECTO2[9301:9500], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4j <- parLapply(cl, NOMBREPROYECTO2[9501:9700], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4k <- parLapply(cl, NOMBREPROYECTO2[9701:10000], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4l <- parLapply(cl, NOMBREPROYECTO2[10001:10300], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)

numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4m <- parLapply(cl, NOMBREPROYECTO2[10301:10600], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO4n <- parLapply(cl, NOMBREPROYECTO2[10601:10689], 
                                          treetagger))
stopCluster(cl)
gc(reset = T)


NOMBREPROYECTO4 <- c(NOMBREPROYECTO4a, NOMBREPROYECTO4b, NOMBREPROYECTO4c,
                     NOMBREPROYECTO4d, NOMBREPROYECTO4e, NOMBREPROYECTO4e1,
                     NOMBREPROYECTO4f, NOMBREPROYECTO4g,
NOMBREPROYECTO4g1,NOMBREPROYECTO4h, NOMBREPROYECTO4i,NOMBREPROYECTO4j,
NOMBREPROYECTO4k, NOMBREPROYECTO4l, NOMBREPROYECTO4m, NOMBREPROYECTO4n)

NOMBREPROYECTO5 <- c(NOMBREPROYECTO3, NOMBREPROYECTO4)

setwd(Ruta)
source("FuncionesTexto.R")

NOMBREPROYECTO6 <- unlist(NOMBREPROYECTO5, " ")

df_titulo2$NOMBREPROYECTO_ortogLema <- NOMBREPROYECTO6

Encoding(df_titulo2$NOMBREPROYECTO_ortogLema) <- "UTF-8"
df_titulo2$NOMBREPROYECTO_ortogLema <- iconv(df_titulo2$NOMBREPROYECTO_ortogLema,
                                             "UTF-8", "latin1")
Ruta <- "C:/Users/jzea/Google Drive/Laboral 2017/DNP/Regalías/" 
setwd(paste0(Ruta, "/", "resultados_parciales"))
saveRDS(df_titulo2, "df_titulo3.rds")