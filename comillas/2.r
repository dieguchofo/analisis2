# Esto va a sacar un .txt por cada trabajo de titulación. La diferencia con el
# resto de scripts que tengo que hacen eso es que estos no van a estar limpios
# de signos de puntuación.

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
for (x in 1:11) {                 # 11 es el número de iteraciones necesario
    prueba8[, 5] <- gsub("  ", " ", prueba8[, 5])
}

# escribir los textos
textos <- prueba8[, 5]

write_text_to_file <- function(text, index) {
  filename <- paste0("comillas/textos_con_puntuacion/", index, ".txt")  # Construct filename
  writeLines(text, filename)  # Write text to file
}

lapply(seq_along(textos), function(i) write_text_to_file(textos[i], i))
