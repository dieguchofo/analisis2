# saca un scatter.smooth de las longitudes

library(ggplot2)
library(dplyr)

todo <- readRDS("todo.rds")

# Limpiar los caracteres vacíos ("\\t", "\\r", "\\n" y dobles espacios)

prueba <- todo[, 5]
prueba2 <- gsub("\\n", " ", prueba)
prueba3 <- gsub("\\\\n", " ", prueba2)
prueba4 <- gsub("\\\\t", " ", prueba3)
prueba5 <- gsub("\\\\r", " ", prueba4)
prueba6 <- prueba5
for (x in 1:11) {                 # 11 es el número de iteraciones necesario
    prueba6 <- gsub("  ", " ", prueba6)
}


todo2 <- todo
todo2[, 5] <- prueba6   # al final tiene que ser con la última pruebaN


# A sacar longitudes

l1 <- nchar(todo2[, 5])     # longitudes
l_y_a <- data.frame(        # longitudes y años
    año <- todo2[, 4],
    longitud = l1
)

l_y_a2 <- l_y_a[order(l_y_a$año), ]         # ordenar cronológicamente
colnames(l_y_a2) <- c("año", "longitud")    # corregir los nombres

l_y_a3 <- l_y_a2[complete.cases(l_y_a2), ]  # quitar los NA
l_y_a4 <- l_y_a3
rownames(l_y_a4) <- NULL

# Quitar la tesis de yannick eduardo y las dos del 2011
l_y_a5 <- subset(l_y_a4, (l_y_a4[, 2] < 400000)) # la unicas mayores a 400000

promedios1 <- aggregate(l_y_a5[, 2], list(año = l_y_a5[, 1]), mean)  # promedios
colnames(promedios1) <- c("año", "longitud_promedio")

promedios <- promedios1[, 2]

# smooth
png("longitudes/longitudes_smooth.png")
scatter.smooth(promedios, type = "l", col = "#ADADAD", xaxt = "n", main = "longitudes", xlab = "", ylab = "")
axis(1, at = 1:18, labels = 2006:2023)
dev.off()

scatter.smooth(promedios)
