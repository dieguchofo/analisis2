# Voy a usar "2-topic-keys.csv" que produjo MALLET para categorizar los
# trabajos (MALLET produjo un .txt que yo manualmente edité para hacerlo un
# .csv). Si el primer topic (que interpreto como tesis/tesina) predomina sobre
# el segundo, lo tagueo tesis/tesina. Si el segundo predomina, lo tagueo "otro"
# (traducción, didáctica, informe). Luego manualmente tendré que corroborar.

# falta ver qué hacer con los indecisos

raw <- read.csv2("taguear_trabajos/2-doc-topics.csv", header = FALSE, sep = ",")

# sacar los row names
rn1 <- raw[, 2]
rn <- gsub("file:/data/Diego/UNAM/Titulacion/codigo/mio/analisis2/topic_modeling/textos_ids/|.txt", "", rn1)

metadatos1 <- readRDS("textos_con_puntuacion.rds")
metadatos <- data.frame(metadatos1$año, row.names = metadatos1$doc_num)

# hacer el data frame
datos1 <- raw[, 3:ncol(raw)]
row.names(datos1) <- rn
colnames(datos1) <- NULL

datos2 <- merge(x = metadatos,
                y = datos1,
                by = 0)

columna_vacia <- rep(NA, times = nrow(datos2))

datos3 <- datos2
datos3[, 3:4] <- lapply(datos2[, 3:4], as.numeric)

datos <- cbind(datos3, columna_vacia)

for(i in 1:nrow(datos)) {
    if(datos[i, 3] > datos[i, 4]) {
        datos[i, 5] <- "t"              # "t" de Tesis y Tesina
    } else {
        datos[i, 5] <- "o"              # "o" de Otro
    }
}

# sacar los que no son clear cut
datos <- cbind(datos, columna_vacia)
colnames(datos) <- c("id", "año", "1", "2", "t/o", "indecisos")

for(i in 1:nrow(datos)) {
    if(datos[i, 3] > 0.75) {
        datos[i, 6] <- "d"              # "d" de Deciso
    } else if(datos[i, 3] < 0.25) {
        datos[i, 6] <- "d"
    } else {
        datos[i, 6] <- "i"              # "i" de Indeciso
    }
}

nrow(datos[grep("i", datos$indecisos), ])
