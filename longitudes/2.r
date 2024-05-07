# Es igual a longitudes/1.r pero excluye los datos de las tesis absurdamente
# largas.
# Grafica
# "longitudes_absolutas.png",
# "longitudes_absolutas_y_promedio.png",
# "longitudes_absolutas_y_promedio_menores_400000.png",
# "longitudes_absolutas_menores_400000.png", y
# "longitudes_promedio_menores_400000.png"

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

promedios <- aggregate(l_y_a5[, 2], list(año = l_y_a5[, 1]), mean)  # promedios
colnames(promedios) <- c("año", "longitud_promedio")
promedios2 <- promedios     # para que quede bonita la gráfica
promedios2[, 1] <- as.integer(promedios[, 1]) - 2000
promedios2[1:4, 1] <- c("06", "07", "08", "09")

# HACERLA EN LÍNEA

ggplot(data = promedios2, aes(x = año, y = longitud_promedio, group = 1)) +
    geom_line()
    ggsave(
        filename = "graficas/longitudes/longitudes_promedio_menores_400000.png",
        width = 5,
        height = 3
    )

# gráfica de puntos de todas las longitudes de todos los trabajos
p <- ggplot(data = l_y_a4, aes(año, longitud)) +
        geom_point(size = 0.25, alpha = 0.25)
        ggsave(
            filename = "graficas/longitudes/longitudes_absolutas.png",
            plot = p,
            width = 5,
            height = 5
        )

p2 <- ggplot(data = l_y_a5, aes(año, longitud)) +
        geom_point(size = 0.25, alpha = 0.25)
        ggsave(
            filename = "graficas/longitudes/longitudes_absolutas_menores_400000.png",
            plot = p2,
            width = 5,
            height = 5
        )

# gráfica con puntos absolutos y línea de promedio
p3 <- ggplot() +
    geom_line(data = promedios, aes(año, longitud_promedio, group = 1)) +
    geom_point(data = l_y_a4, aes(año, longitud), size = 0.25, alpha = 0.25)
            ggsave(
            filename = "graficas/longitudes/longitudes_absolutas_y_promedio.png",
            plot = p3,
            width = 5,
            height = 5
        )

# sin < 400000
p3 <- ggplot() +
    geom_line(data = promedios, aes(año, longitud_promedio, group = 1)) +
    geom_point(data = l_y_a5, aes(año, longitud), size = 0.25, alpha = 0.25)
            ggsave(
            filename = "graficas/longitudes/longitudes_absolutas_y_promedio_menores_400000.png",
            plot = p3,
            width = 5,
            height = 5
        )
