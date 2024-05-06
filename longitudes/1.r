# primero que nada, esto limpia las tesis de caracteres vacíos como "\\t"
# "\\n" y "\\r". Los reemplaza con " " y luego reemplaza todos los "  "
# (dobles espacios) con " " (un espacio). Es un loop que itera 100 veces,
# que creo que es suficiente.
# Luego, tengo pensado que reemplaze los caracteres especiales de unicode como
# "\\u2028"

library(ggplot2)

todo <- readRDS("todo.rds")

# Limpiar los caracteres vacíos ("\\t", "\\r", "\\n" y dobles espacios)

prueba <- todo[, 5]
prueba2 <- gsub("\\n", " ", prueba)
prueba3 <- gsub("\\\\n", " ", prueba2)
prueba4 <- gsub("\\\\t", " ", prueba3)
prueba5 <- gsub("\\\\r", " ", prueba4)
prueba6 <- prueba5
for (x in 1:100) {
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

l_y_a2 <- l_y_a[order(l_y_a$año), ]

plot(l_y_a2)
