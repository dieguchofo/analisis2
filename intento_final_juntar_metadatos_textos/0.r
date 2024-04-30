# Esto es mi ultimo intento de crear un json de metadatos y textos

# falta añadir los textos checando los doc_nums

library(rjson)

raw <- fromJSON(file = "textos_sagrados/metadatos.json")

raw_df <- as.data.frame(raw)
raw_df[5]

# se puede namás poner los indices absolutos de raw_df por incrementos de
# cuatro. Es decir: los nombres son 1, 5, 9, etc. los titulos 2, 6, 10, y así
# para siempre

metadatos_df <- data.frame (
    nombre  <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 1]),
    titulo  <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 2]),
    año     <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 3]),
    doc_num <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 0])
)

colnames(metadatos_df) <- c("nombre", "titulo", "año", "doc_num")

### sacar textos ###

raw_t <- fromJSON(file = "textos_sagrados/plaintext2.json")
# raw_t_df <- as.data.frame(raw_t)

# lapply(raw_t, '[[', 2)  # No sé cómo funciona esto, pero accede a los primeros
                          # elementos de todas las listas


texto <- lapply(raw_t, '[[', 2)
doc_num <- lapply(raw_t, '[[', 1)

#plaintext_df <- data.frame(doc_num, texto)

# ESTO ES LO DEL JAVI QUE AL CHILE NO ENTENDI

out <- vector("list", nrow(metadatos_df))
for(i in c(metadatos_df[, 4])){
  out[[i]] <- do.call("rbind", lapply(raw_t, function(x) x[[i]]))
}


