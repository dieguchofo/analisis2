# Esto hace lo que 2.r pero saca "textos_con_puntuacion.rds"

library(dplyr)
library(tidyr)

todo <- readRDS("todo.rds")
todo2 <- na.exclude(todo)

## LIMPIAR TEXTOS (copiado de longitudes/1.r)
prueba <- prueba2 <- prueba3 <- prueba4 <- prueba5 <- prueba6 <- prueba7 <- prueba8 <- prueba9 <- prueba10 <- prueba11 <- todo2
prueba2[, 5] <- gsub("\\n", " ", prueba[, 5])
prueba3[, 5] <- gsub("\\\\n", " ", prueba2[, 5])
prueba4[, 5] <- gsub("\\\\t", " ", prueba3[, 5])
prueba5[, 5] <- gsub("\\\\r", " ", prueba4[, 5])
prueba6[, 5] <- gsub("\u2029", " ", prueba5[, 5])
prueba7[, 5] <- gsub("\u2028", " ", prueba6[, 5])
prueba8[, 5] <- prueba7[, 5]
for (x in 1:12) {                 # 11 es el número de iteraciones necesario (12 es uno más porque no vaya a ser)
    prueba8[, 5] <- gsub("  ", " ", prueba8[, 5])
}

# escribir el .rds
saveRDS(prueba8, file = "textos_con_puntuacion.rds")