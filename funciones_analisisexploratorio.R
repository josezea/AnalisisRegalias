#font_import("Trebuchet MS")
#extrafont::loadfonts(device="win")
library(ggplot2)


barplotDNP <- function(data, Var, Freq, xlabel, ylabel, main_title = ""){
  Var <- eval(expr = substitute(Var), envir = data) 
  Freq <- eval(expr = substitute(Freq), envir = data) 
  
  g <- ggplot(data, aes(x = Var, y = Freq)) +
    geom_bar(stat="identity", width = 0.7, color = "#80202A", fill = "#80202A") + 
    theme(text=element_text(family="Trebuchet MS"),
          axis.text.x = element_text(angle = 90, hjust = 1,                                                                         size = 10), 
          #panel.background = element_rect(fill = "transparent", colour = NA),
          plot.background = element_rect(fill = "transparent", colour = NA)) +
    ylab(ylabel) + xlab(xlabel) + ggtitle(main_title) +  coord_flip() 
  g
}


Frecuencias_otros <- function(data,  Freq_var, grouping_var, label_others, posit){

#grouping_var <- eval(expr = substitute(grouping_var), envir = data) 
#Freq_var <- eval(expr = substitute(Freq_var), envir = data) 
data <- as.data.frame(data)
data  <- data[order(data[,2], decreasing = T),]

data[,1] <- factor(c(as.character(data[1:posit, 1]), 
                     rep(label_others, nrow(data) -posit)))

grouping_var <- data[,1]
Freq_var <- data[,2]

query <- aggregate(Freq_var, list(grouping_var), FUN = sum) 
query  <- query[order(query[,2], decreasing = T), ]

Freq_var <- query[,2]
grouping_var <- query[,1]


orden <- order(Freq_var, decreasing = T)
orden_otros <- which(grouping_var == label_others)
orden <- c(orden, orden_otros)
orden <- orden[!duplicated(orden,fromLast = T)]
query <- query[orden, ]

return(query)
}



#consulta <- df_titulo5 %>% group_by(firstword_nomproyec) %>% 
#  summarise(Frec = n())

#a <- Frecuencias_otros(data = consulta, Freq_var = Frec,
#                  grouping_var = firstword_nomproyec , 
#                  label_others = "Otros", posit = 10)
