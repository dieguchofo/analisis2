library(ggplot2)
library(dplyr)
library(knitr)

todo <- readRDS("todo.rds")

## LIMPIAR TEXTOS (copiado de longitudes/1.r)
prueba <- todo[, 5]
prueba2 <- gsub("\\n", " ", prueba)
prueba3 <- gsub("\\\\n", " ", prueba2)
prueba4 <- gsub("\\\\t", " ", prueba3)
prueba5 <- gsub("\\\\r", " ", prueba4)
prueba6 <- prueba5
for (x in 1:11) {                 # 11 es el número de iteraciones necesario
    prueba6 <- gsub("  ", " ", prueba6)
}

todo2 <- todo
todo2[, 5] <- prueba6   # al final tiene que ser con la última pruebaN

# hacer todo un gran blob de palabras individuales.
individuales <- strsplit(todo2$texto, "\\W")
individuales2 <- unlist(individuales)
individuales3 <- individuales2[individuales2 != ""] # quita los strings vacíos
individuales4 <- tolower(individuales3)

# ordenarlas (creo que esto es redundante)
pal_comunes <- table(individuales4)
pal_comunes2 <- sort(pal_comunes, decreasing = TRUE)

# hacerlas data frame
pal_comunes_df <- data.frame(pal_comunes)
pal_comunes_df <- data.frame(
    palabra = pal_comunes_df$individuales4,
    frecuencia = pal_comunes_df$Freq
)

# ordenarlas otra vez
pal_comunes_df2 <- pal_comunes_df
pal_comunes_df2 <- pal_comunes_df2[order(pal_comunes_df2$frecuencia, decreasing = TRUE), ]

# tabla plaiantext de las primeras 200
pt_pal_comunes_df2 <- knitr::kable(pal_comunes_df2[1:200, ], format = "pipe")

# quitar las stop words
sw_es <- scan("palabras_comunes/es_stop_words.txt", what = "character")   # stop words español
cw_comunes <- pal_comunes_df2[!(pal_comunes_df2$palabra %in% sw_es), ] # content words comunes

sw_en <- scan("palabras_comunes/en_stop_words.txt", what = "character")   # stop words inglés
cw_comunes2 <- cw_comunes[!(cw_comunes$palabra %in% sw_en), ]

pt_cw_comunes <- knitr::kable(cw_comunes2[1:200, ], format = "pipe")
