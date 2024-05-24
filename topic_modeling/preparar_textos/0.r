# Esto va a escribir un .txt individual para cada trabajo de titulación

library(dplyr)
library(tidyr)

todo <- readRDS("todo.rds")

## LIMPIAR TEXTOS (copiado de longitudes/1.r)
prueba <- prueba2 <- prueba3 <- prueba4 <- prueba5 <- prueba6 <- prueba7 <- prueba8 <- todo
prueba2[, 5] <- gsub("\\n", " ", prueba[, 5])
prueba3[, 5] <- gsub("\\\\n", " ", prueba2[, 5])
prueba4[, 5] <- gsub("\\\\t", " ", prueba3[, 5])
prueba5[, 5] <- gsub("\\\\r", " ", prueba4[, 5])
prueba6[, 5] <- prueba5[, 5]
for (x in 1:11) {                 # 11 es el número de iteraciones necesario
    prueba6[, 5] <- gsub("  ", " ", prueba6[, 5])
}
prueba7[, 5] <- gsub("[^[:alnum:][:space:]]", "", prueba6[, 5]) # quitar non-word characters # nolint
prueba8[, 5] <- gsub('["\']', "", prueba7[, 5])   # quitar las comillas
prueba9 <- drop_na(prueba8)

textos <- prueba9[, 5]

# PRUEBA, ESTO LO ESCRIBIÓ CHATGPT

write_text_to_file <- function(text, index) {
  filename <- paste0("topic_modeling/textos_individuales2/", index, ".txt")  # Construct filename
  writeLines(text, filename)  # Write text to file
}

lapply(seq_along(textos), function(i) write_text_to_file(textos[i], i))