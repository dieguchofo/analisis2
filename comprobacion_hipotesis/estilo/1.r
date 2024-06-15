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

head_freq <- freq[1:10, 1:10]

a <- dist(head_freq, method = "euclidean")
a[10]
