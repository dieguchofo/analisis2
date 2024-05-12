library(ggplot2)
library(dplyr)

todo <- readRDS("todo.rds")

## LIMPIAR TEXTOS (copiado de longitudes/1.r)
prueba <- prueba2 <- prueba3 <- prueba4 <- prueba5 <- prueba6 <- prueba7 <- todo
prueba2[, 5] <- gsub("\\n", " ", prueba[, 5])
prueba3[, 5] <- gsub("\\\\n", " ", prueba2[, 5])
prueba4[, 5] <- gsub("\\\\t", " ", prueba3[, 5])
prueba5[, 5] <- gsub("\\\\r", " ", prueba4[, 5])
prueba6[, 5] <- prueba5[, 5]
for (x in 1:11) {                 # 11 es el número de iteraciones necesario
    prueba6[, 5] <- gsub("  ", " ", prueba6[, 5])
}

# ESTO NO SIRVE
# separar los textos entre comillas
prueba7[, 5] <- strsplit(prueba6[, 5], "(?<=\")\\s+|\\s+(?=\")", perl = TRUE)

# # hacer todo un gran blob de palabras individuales.
# individuales <- strsplit(todo2$texto, "\\W")
# individuales2 <- unlist(individuales)
# individuales3 <- individuales2[individuales2 != ""] # quita los strings vacíos

