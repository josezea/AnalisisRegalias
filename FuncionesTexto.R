
utf8ToLatin1 <- function(x){
  y <- iconv(x, "latin1", "ASCII", "byte")    
  y <- gsub("<c3><a3><c2><a1>", "�", y)
  y <- gsub("<c3><a3><c2><a9>", "�", y)
  y <- gsub("<c3><a3><c2><ad>", "�", y)
  y <- gsub("<c3><a3><c2><b3>", "�", y)
  y <- gsub("<c3><a3><c2><ba>", "�", y)
  y <- gsub("<c3><a3><c2><b1>", "�", y)
  y <- gsub("<c3><a3><c2><bc>", "�", y)
  y <- gsub("<c3><83><c2><a1>", "�", y)
  y <- gsub("<c3><83><c2><a9>", "�", y)
  y <- gsub("<c3><83><c2><ad>", "�", y)
  y <- gsub("<c3><83><c2><b3>", "�", y)
  y <- gsub("<c3><83><c2><ba>", "�", y)
  y <- gsub("<c3><83><c2><b1>", "�", y)
  y <- gsub("<c3><83><c2><bc>", "�", y)
}


rm_words <- function(x, stopwords){
  gsub(paste0("//b(",paste(stopwords, collapse="|"),")//b"), "", x)
}


lemmatizer_function <- function(x, lemmatizer_root, lemmatizer_word){
  x <- ifelse(is.na(match(x, lemmatizer_word)), x,  
              lemmatizer_root[match(x, lemmatizer_word)]) 
  x
}


CleanSpacesNSeparate <- function(x){
  unlist(strsplit(x," "))[unlist(strsplit(x," ")) != ""]
}


join_word <- function(x){ paste(x, collapse= ", ")}

colapsarTexto <- function(x) {
  paste(x, collapse = " ")
}


separarTexto <- function(x){
  unlist(strsplit(x,  " "))
}


LimpiarEspacios<- function(x){
  x[x != ""]
}

Duplicados<- function(x){
  x[!duplicated(x)]
}




