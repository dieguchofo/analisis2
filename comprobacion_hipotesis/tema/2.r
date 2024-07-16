# En este voy a intentar hacer lo mismo que en estilo/1.r, que es calcular las
# distancias entre cada trabajo y sus respectivos valores de cada tema y
# promediarlas y graficarlas. Si mi hipótesis es correcta, deberían aumentar
# las distancias. Lo voy a hacer con 50 topics, a ver qué sale.

### HACER DATA FRAME DE LOS DATOS ###
raw <- read.csv2("comprobacion_hipotesis/tema/50-doc-topics.csv", header = FALSE, sep = ",")

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

colnames(datos2)[1:2] <- c("doc_num", "año")
datos3 <- sapply(datos2[, 3:ncol(datos2)], as.numeric)
datos <- cbind(datos3, datos2$año)
colnames(datos)[ncol(datos)] <- "año"
datos <- as.data.frame(datos)

### 17 VARIABLES POR 17 AÑOS ###
a2006 <- datos[which(grepl("2006", datos$año)), 1:ncol(datos) - 1]
a2007 <- datos[which(grepl("2007", datos$año)), 1:ncol(datos) - 1]
a2008 <- datos[which(grepl("2008", datos$año)), 1:ncol(datos) - 1]
a2009 <- datos[which(grepl("2009", datos$año)), 1:ncol(datos) - 1]
a2010 <- datos[which(grepl("2010", datos$año)), 1:ncol(datos) - 1]
a2011 <- datos[which(grepl("2011", datos$año)), 1:ncol(datos) - 1]
a2012 <- datos[which(grepl("2012", datos$año)), 1:ncol(datos) - 1]
a2013 <- datos[which(grepl("2013", datos$año)), 1:ncol(datos) - 1]
a2014 <- datos[which(grepl("2014", datos$año)), 1:ncol(datos) - 1]
a2015 <- datos[which(grepl("2015", datos$año)), 1:ncol(datos) - 1]
a2016 <- datos[which(grepl("2016", datos$año)), 1:ncol(datos) - 1]
a2017 <- datos[which(grepl("2017", datos$año)), 1:ncol(datos) - 1]
a2018 <- datos[which(grepl("2018", datos$año)), 1:ncol(datos) - 1]
a2019 <- datos[which(grepl("2019", datos$año)), 1:ncol(datos) - 1]
a2020 <- datos[which(grepl("2020", datos$año)), 1:ncol(datos) - 1]
a2021 <- datos[which(grepl("2021", datos$año)), 1:ncol(datos) - 1]
a2022 <- datos[which(grepl("2022", datos$año)), 1:ncol(datos) - 1]
a2023 <- datos[which(grepl("2023", datos$año)), 1:ncol(datos) - 1]

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

png("comprobacion_hipotesis/tema/tema.png")
plot(juntos, type = "l", xaxt = "n", main = "tema", xlab = "", ylab = "")
axis(1, at = 1:18, labels = 2006:2023)
dev.off()

# smooth
png("comprobacion_hipotesis/tema/tema_smooth.png")
scatter.smooth(juntos, type = "l", col = "#ADADAD", xaxt = "n", main = "tema", xlab = "", ylab = "")
axis(1, at = 1:18, labels = 2006:2023)
dev.off()