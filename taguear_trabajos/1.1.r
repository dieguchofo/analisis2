# Voy a usar "2-topic-keys.csv" que produjo MALLET para categorizar los
# trabajos (MALLET produjo un .txt que yo manualmente edité para hacerlo un
# .csv). Si el primer topic (que interpreto como tesis/tesina) predomina sobre
# el segundo, lo tagueo tesis/tesina. Si el segundo predomina, lo tagueo "otro"
# (traducción, didáctica, informe). Luego manualmente tendré que corroborar.

# A los indecisos los voy a juzgar manualmente a partir de sus títulos

raw <- read.csv2("taguear_trabajos/2-doc-topics.csv", header = FALSE, sep = ",")

# sacar los row names
rn1 <- raw[, 2]
rn <- gsub("file:/data/Diego/UNAM/Titulacion/codigo/mio/analisis2/topic_modeling/textos_ids/|.txt", "", rn1)

metadatos1 <- readRDS("textos_con_puntuacion.rds")
metadatos <- data.frame(metadatos1$año, metadatos1$titulo, row.names = metadatos1$doc_num)

# hacer el data frame
datos1 <- raw[, 3:ncol(raw)]
row.names(datos1) <- rn
colnames(datos1) <- NULL

datos2 <- merge(x = metadatos,
                y = datos1,
                by = 0)

columna_vacia <- rep(NA, times = nrow(datos2))

datos3 <- datos2
datos3[, 4:5] <- lapply(datos2[, 4:5], as.numeric)

datos4 <- cbind(datos3, columna_vacia)

# si el valor del tema que yo interpreto como "tesis/tesinas" es mayor al que
# intepreto como "otro", lo marco con una "t", si no, con una "o"
for(i in 1:nrow(datos4)) {
    if(datos4[i, 4] > datos[i, 5]) {
        datos4[i, 6] <- "t"              # "t" de Tesis y Tesina
    } else {
        datos4[i, 6] <- "o"              # "o" de Otro
    }
}

# sacar los que no son clear cut

# mi juicio (arbitrario) es que si ningún tema tiene un valor mayor de 0.75, no
# se puede decir con suficiente seguridad que son tesis/tesina o no.

datos5 <- cbind(datos4, columna_vacia)
colnames(datos5) <- c("id", "año", "titulo", "1", "2", "t/o", "indecisos")

for(i in 1:nrow(datos5)) {
    if(datos5[i, 4] > 0.75) {
        datos5[i, 7] <- "d"              # "d" de Deciso
    } else if(datos5[i, 4] < 0.25) {
        datos5[i, 7] <- "d"
    } else {
        datos5[i, 7] <- "i"              # "i" de Indeciso
    }
}


# Hay 92 trabajos que son indecisos. Voy a taguearlos manualmente. Para
# ahorrarme tener que escribir comillas, voy a decir que 1 es para tesis/tesina
# y 0 es para otro

datos <- cbind(datos5, columna_vacia)
colnames(datos)[8] <- "manual"

# lo voy a hacer de 10 en 10 para no perderme

datos[grep("i", datos$indecisos), c(3, 8)][1:10, ]                              # ver
datos[grep("i", datos$indecisos), 8][1:10] <- c(1, 1, 0, 0, 0, 1, 0, 0, 0, 0)   # escribir

datos[grep("i", datos$indecisos), c(3, 8)][11:20, ]
datos[grep("i", datos$indecisos), 8][11:20] <- c(1, 0, 0, 1, 0, 1, 0, 1, 0, 1)

datos[grep("i", datos$indecisos), c(3, 8)][21:30, ]
datos[grep("i", datos$indecisos), 8][21:30] <- c(1, 0, 1, 0, 1, 0, 1, 1, 1, 0)

datos[grep("i", datos$indecisos), c(3, 8)][31:40, ]
datos[grep("i", datos$indecisos), 8][31:40] <- c(1, 0, 1, 0, 1, 1, 1, 1, 0, 0)

datos[grep("i", datos$indecisos), c(3, 8)][41:50, ]
datos[grep("i", datos$indecisos), 8][41:50] <- c(0, 0, 0, 0, 0, 0, 1, 1, 0, 0)

datos[grep("i", datos$indecisos), c(3, 8)][51:60, ]
datos[grep("i", datos$indecisos), 8][51:60] <- c(0, 0, 1, 0, 1, 0, 1, 1, 0, 0)

datos[grep("i", datos$indecisos), c(3, 8)][61:70, ]
datos[grep("i", datos$indecisos), 8][61:70] <- c(0, 1, 0, 1, 1, 0, 1, 1, 1, 0)

datos[grep("i", datos$indecisos), c(3, 8)][71:80, ]
datos[grep("i", datos$indecisos), 8][71:80] <- c(1, 0, 0, 0, 0, 1, 0, 0, 0, 0)

datos[grep("i", datos$indecisos), c(3, 8)][81:90, ]
datos[grep("i", datos$indecisos), 8][81:90] <- c(0, 0, 0, 1, 0, 1, 1, 0, 1, 1)

datos[grep("i", datos$indecisos), c(3, 8)][91:92, ]
datos[grep("i", datos$indecisos), 8][91:92] <- c(1, 0)

# corroborar
datos[grep("i", datos$indecisos), c(3, 8)]

# ver qué tan acertado es mallet
datos[grep("i", datos$indecisos), c(6,8)]
colnames(datos)
