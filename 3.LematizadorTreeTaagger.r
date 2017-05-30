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
system.time(NOMBREPROYECTO3ad <- parLapply(cl, NOMBREPROYECTO2[7001:7300], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3ae <- parLapply(cl, NOMBREPROYECTO2[7301:7600], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)



numb_cores <- detectCores() - 1
cl <- makeCluster(numb_cores)
system.time(NOMBREPROYECTO3af <- parLapply(cl, NOMBREPROYECTO2[7601:7900], 
                                           treetagger))
stopCluster(cl)
gc(reset = T)