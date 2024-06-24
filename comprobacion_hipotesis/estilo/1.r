# En este archivo voy a intentar importar "table_with_frequencies.txt" para
# tener un data frame limpio.

# El data frame llamado 'freq' tiene esta estructura:
#
#       de      la      ...     golpe
# 123   1.23    0.23    ...     0.02
# 234   2.43    1.27    ...     0
# 345   5.21    6.21    ...     0.01

# dist() saca una matriz de distancias que se ve así:
#
#         0345656_A1   0603306   0604231   0604700   0605308   0605326   0605334   0605505   0606395
# 0603306  3.6477784
# 0604231  3.3571142 2.6952365
# 0604700  1.9298609 2.5993149 1.9740865
# 0605308  2.9731537 3.5175711 2.4496107 1.5104680
# 0605326  1.5890595 2.7744264 2.5415485 1.0294648 2.1331627
# 0605334  1.5562992 3.3085412 2.5674122 1.1195359 1.9840004 0.9841842
# 0605505  4.2780152 1.7270435 2.6079667 3.0182040 3.4303240 3.5400830 3.8852297
# 0606395  2.3864069 3.0281460 2.3681581 1.5693556 1.9907588 2.0093004 1.6211140 3.0813564
# 0606600  1.8353236 3.7238804 3.3228342 2.0307096 2.5014533 1.5619232 1.5271696 4.4558517 2.3630120
#
# Parece un data frame pero es un vector de números. El output de typeof(dist(freq)) es "double", y
# los índices de los elementos van del 1 al 120786.

# Lo que tengo que hacer ahora es dividir los datos de freq por año. Para hacer esto tengo que:
# 1. Importar los metadatos para tener los pares de doc_num y año
# 2. Hacer un data frame sólo con dos columnas: doc_num y año
# 3. Mergear este data frame con 'freq' con los doc_nums como la columna común
# 4. Hacer 17 data frames distintos, uno para cada año, con las frecuencias relativas (y sin los años ni doc_nums).

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
