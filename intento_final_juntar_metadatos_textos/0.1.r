# En este voy a juntar las páginas de los trabajos, para tener un json limpio

library(rjson)

raw <- fromJSON(file = "textos_sagrados/metadatos.json")

raw_df <- as.data.frame(raw)
raw_df[5]

# se puede namás poner los indices absolutos de raw_df por incrementos de
# cuatro. Es decir: los nombres son 1, 5, 9, etc. los titulos 2, 6, 10, y así
# para siempre

metadatos_df <- data.frame(
    nombre  <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 1]),
    titulo  <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 2]),
    año     <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 3]),
    doc_num <-  as.character(raw_df[(1:ncol(raw_df)) %% 4 == 0])
)

colnames(metadatos_df) <- c("nombre", "titulo", "año", "doc_num")

### sacar textos ###

raw_t <- fromJSON(file = "textos_sagrados/plaintext2.json")

texto <- lapply(raw_t, "[[", 2)
doc_num <- lapply(raw_t, "[[", 1)

texto_juntado <- list()

counter <- 1

for (i in texto){
    texto_1 <- paste(texto[counter], collapse = "--- nueva página ---")
    texto_juntado[counter] <- as.character(texto_1)
    counter <- counter + 1
}

plaintexts <- data.frame(
    doc_num <- as.character(doc_num),
    texto   <- as.character(texto_juntado)
)

colnames(plaintexts) <- c("doc_num", "texto")

### HAY QUE DESCIFRAR QUÉ PASA CON EL MERGE QUE HACE QUE HAYA 524 renglones ###
###     Lo que pasa es que en los plaintexts hay doc_nums así "0668756_A1", y
###     en los metadatos no. En los metadatos salen como "0668756", sin el
###     "_A1". Tons hay que solucionar eso.
###     Una vez solucionado eso, hay que checar que los metadatos sin texto
###     estén bien. Son
###         0847931, 27430, 04982, 02670, y 0677931.

### CORREGIR LOS ERRORES DE "_A1"

todo <- merge(x = metadatos_df,
              y = plaintexts,
              by = "doc_num",
              all = TRUE)

A1 <- setdiff(todo[, 1], metadatos_df[, 4])
sin_A1 <- substr(A1, start = 1, stop = nchar(A1) - 3)

a_cambiar <- which(metadatos_df$doc_num %in% sin_A1)
cambiados <- paste(metadatos_df[a_cambiar, 4], "_A1", sep = "")

metadatos_df_2 <- metadatos_df
metadatos_df_2[a_cambiar, 4] <- cambiados

# Hacer el data frame final

todo2 <- merge(x = metadatos_df_2,
               y = plaintexts,
               by = "doc_num",
               all = TRUE)

todo2[189, 4] <- 2011   # corregir que en TESIUNAM viene así "[2011]"

# Guardar el data frame en un R data file

saveRDS(todo2, file = "todo.rds")
