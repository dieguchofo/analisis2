# En este archivo voy a intentar importar "table_with_frequencies.txt" para
# tener un data frame limpio.

# Lo que tengo que hacer es esto:
# un data frame con las columnas que sean las palabras y los renglones los
# trabajos. Para hacer esto tengo que:
# 1. limpiar los ids de la variable 'ids' (que solo queden los ids sin 'primera')
# 2. idear una manera de construir el data frame de manera que quede así:
#
# id    de      la      ...     golpe
# 123   1.23    0.23    ...     0.02
# 234   2.43    1.27    ...     0
# 345   5.21    6.21    ...     0.01
#
# 'ids' ya es el vector que necesito para la primera columna (a lo mejor lo
# tengo que guardar como character para que no lo tome en cuenta dist()).
#
#
#
#
#
#
#
#
#
#


raw <- read.csv2("comprobacion_hipotesis/estilo/table_with_frequencies.txt")
raw_txt <- readLines("comprobacion_hipotesis/estilo/table_with_frequencies.txt")

ids <- unlist(strsplit(raw_txt[1], " "))
de <- unlist(strsplit(raw[1, 1], " "))
la <- unlist(strsplit(raw[2, 1], " "))
golpe <- unlist(strsplit(raw[5000, 1], " "))

datos <- strsplit(raw[1:5000, 1], " ")
