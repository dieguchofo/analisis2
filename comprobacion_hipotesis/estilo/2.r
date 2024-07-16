# Aquí voy a sacar la regresión de la gráfica. Hasta la línea 98 es una copia
# de 1.r

### HACER EL DATA FRAME DE FRECUENCIA RELATIVA X TRABAJO ###

# obtener los ids de los trabajos
raw_txt <- readLines("comprobacion_hipotesis/estilo/table_with_frequencies.txt")
ids1 <- unlist(strsplit(raw_txt[1], " "))   # sacar los datos
ids2 <- gsub("\"primera_|\"segunda_", "", ids1) # borrar información innecesaria
ids <- substr(ids2, 1, nchar(ids2) - 1) # borrar información innecesaria

# obtener las frecuencias relativas
raw <- read.csv2("comprobacion_hipotesis/estilo/table_with_frequencies.txt")

datos <- strsplit(raw[1:5000, 1], " ")          # hacer una lista en la que cada elemento es un vector con la información
                                                # de cada línea del .txt (una línea es una palabra y sus frecuencias)
datos_df1 <- data.frame(datos)                  # hacerlo data frame
colnames(datos_df1) <- datos_df1[1, ]           # hacer los nombres de las columnas las palabras (para que las columnas se llamen "de", "la", etc.)
datos_df2 <- datos_df1[2:nrow(datos_df1), ]     # borrar la primera línea del data frame, que eran las palabras (convertí la primera línea en los nombres de las columnas)
row.names(datos_df2) <- ids                     # nombrar las líneas los ids de los trabajos
datos_df2[] <- lapply(datos_df2, as.numeric)    # transformar las celdas a datos numéricos en vez de caracteres
freq <- datos_df2                               # namás pa que tenga un mejor nombre. Freq de frecuencias relativas.

### DIVIDIR POR AÑO ###
metadatos1 <- readRDS("textos_con_puntuacion.rds")
metadatos <- data.frame(metadatos1$año, row.names = metadatos1$doc_num)

freqM1 <- merge(x = metadatos,                  # juntar los metadatos de año y doc_num con 'freq'. frequency + Metadatos
                y = freq,
                by = 0)

freqM2 <- freqM1[, 2:ncol(freqM1)]
colnames(freqM2)[1] <- "metadatosAño"
row.names(freqM2) <- freqM1[, 1]                # freqM2 tiene los doc_nums como row names y los años de publicación como la primera columna

## 17 VARIABLES PARA 17 AÑOS ##
a2006 <- freqM2[which(grepl("2006", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2007 <- freqM2[which(grepl("2007", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2008 <- freqM2[which(grepl("2008", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2009 <- freqM2[which(grepl("2009", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2010 <- freqM2[which(grepl("2010", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2011 <- freqM2[which(grepl("2011", freqM2$metadatosAño)), 2:ncol(freqM2)]
# limpiar un trabajo que no limpié bien y mueve todo
a2011 <- a2011[-grep("0674722", row.names(a2011)), ]
a2012 <- freqM2[which(grepl("2012", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2013 <- freqM2[which(grepl("2013", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2014 <- freqM2[which(grepl("2014", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2015 <- freqM2[which(grepl("2015", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2016 <- freqM2[which(grepl("2016", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2017 <- freqM2[which(grepl("2017", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2018 <- freqM2[which(grepl("2018", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2019 <- freqM2[which(grepl("2019", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2020 <- freqM2[which(grepl("2020", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2021 <- freqM2[which(grepl("2021", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2022 <- freqM2[which(grepl("2022", freqM2$metadatosAño)), 2:ncol(freqM2)]
a2023 <- freqM2[which(grepl("2023", freqM2$metadatosAño)), 2:ncol(freqM2)]

### CALCULAR DISTANCIAS ###
d06 <- dist(a2006)
d07 <- dist(a2007)
d08 <- dist(a2008)
d09 <- dist(a2009)
d10 <- dist(a2010)
d11 <- dist(a2011)
d12 <- dist(a2012)
d13 <- dist(a2013)
d14 <- dist(a2014)
d15 <- dist(a2015)
d16 <- dist(a2016)
d17 <- dist(a2017)
d18 <- dist(a2018)
d19 <- dist(a2019)
d20 <- dist(a2020)
d21 <- dist(a2021)
d22 <- dist(a2022)
d23 <- dist(a2023)

# promedios (mean)
m06 <- mean(d06)
m07 <- mean(d07)
m08 <- mean(d08)
m09 <- mean(d09)
m10 <- mean(d10)
m11 <- mean(d11)
m12 <- mean(d12)
m13 <- mean(d13)
m14 <- mean(d14)
m15 <- mean(d15)
m16 <- mean(d16)
m17 <- mean(d17)
m18 <- mean(d18)
m19 <- mean(d19)
m20 <- mean(d20)
m21 <- mean(d21)
m22 <- mean(d22)
m23 <- mean(d23)

# graficar
juntos <- c(m06, m07, m08, m09, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23)

png("comprobacion_hipotesis/estilo/estilo.png")
plot(juntos, type = "l", xaxt = "n", main = "estilo", xlab = "", ylab = "")
axis(1, at = 1:18, labels = 2006:2023)
dev.off()

# smooth
png("comprobacion_hipotesis/estilo/estilo_smooth.png")
scatter.smooth(juntos, type = "l", col = "#ADADAD", xaxt = "n", main = "estilo", xlab = "", ylab = "")
axis(1, at = 1:18, labels = 2006:2023)
dev.off()