# Limpia los textos de todos los caracteres sobrantes como "\n" o "\\r"
# Grafica la longitud en caracteres promedio anual de los trabajos.
# Saca "longitudes_promedio.png"

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

promedios <- aggregate(l_y_a3[, 2], list(año = l_y_a3[, 1]), mean)  # promedios
colnames(promedios) <- c("año", "longitud_promedio")
promedios2 <- promedios     # para que quede bonita la gráfica
promedios2[, 1] <- as.integer(promedios[, 1]) - 2000
promedios2[1:4, 1] <- c("06", "07", "08", "09")

# HACERLA EN LÍNEA

ggplot(data = promedios2, aes(x = año, y = longitud_promedio, group = 1)) +
    geom_line()
    ggsave(
        filename = "graficas/longitudes/longitudes_promedio.png",
        width = 5,
        height = 3
    )
