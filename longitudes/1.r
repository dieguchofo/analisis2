library(ggplot2)

todo <- readRDS("todo.rds")

# Limpiar los caracteres vacíos ("\\t", "\\r", "\\n" y dobles espacios)
# faltan los unicode como \\u2028 y el resto. Checar si son vacíos o si no.
# grep("\\u", prueba6) sirve para ver cuáles tienen esos caracteres.
# prueba6 es un vector con los textos limpios. Al seguir limpiando será prueba7
# y así.

prueba <- todo[, 5]
prueba2 <- gsub("\\n", " ", prueba)
prueba3 <- gsub("\\\\n", " ", prueba2)
prueba4 <- gsub("\\\\t", " ", prueba3)
prueba5 <- gsub("\\\\r", " ", prueba4)
prueba6 <- prueba5
for (x in 1:100) {
    prueba6 <- gsub("  ", " ", prueba6)
}

nchar(prueba)
nchar(prueba2)
nchar(prueba3)
nchar(prueba4)
nchar(prueba5)
nchar(prueba6)

grep("\\u", prueba6)

todo2 <- todo
todo2[, 5] <- prueba6
todo2[301,]
# l1 <- nchar(todo[, 5])  # cantidad de caracteres en cada trabajo de titulación
# años <- todo$año
# 
# l2_df <- data.frame(
#     año = años,
#     texto = l1
# )
# 
# l3_df <- l2_df[order(l2_df$año), ]
# 
# plot(l3_df)
# 
# todo[2, 5]
# 
# l2_df[176, ]
# 