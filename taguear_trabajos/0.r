# Esto va a sacar los primeros 2000? caracteres de cada uno de los textos en
# /topic_modeling/textos_individuales, quitarles los espacios por completo y
# ver si tienen ""tesis", "tesina", "traducción comentada", "informe" o
# "propuesta"."

# para corroborar manualmente hay que hacer t2[tesinas, 5] (o la variable de la
# palabra clave que vaya a querer checar). Chance ya comparo eso con lo que diga
# mallet?

# función que copié de internet para ver los valores que no comparten
outersect <- function(x, y) {
  sort(c(setdiff(x, y),
         setdiff(y, x)))
}

# preparar las variables (no sé si hay una mejor manera de hacer esto)
textos <- t1 <- t2 <- t3 <- t4 <- t5 <- t6 <- t7 <- t8 <- readRDS("textos_limpios.rds")
t1[, 5] <- sub("Dirección General.*", "", textos[, 5])  # quita todo lo que va desde la página legal hasta el final
t2 <- t1
t2[which(t1[, 5] == textos[, 5]), 5] <- substr(t1[which(t1[, 5] == textos[, 5]), 5], 1, 400)

# quitar información de sobra
t3[, 5] <- gsub(" ", "", t2[, 5]) # quitar espacios para lidiar con "t e s i n a s"

# grep para encontrar según yo palabras clave
    # tesinas
tesinas <- grep("tesina", t3[, 5], ignore.case = TRUE)
tesinasque <- grep("tesinaque", t3[, 5], ignore.case = TRUE)
    # tesis
tesis <- grep("tesis", t3[, 5], ignore.case = TRUE)
tesisque <- grep("tesisque", t3[, 5], ignore.case = TRUE)
    # traducciones
traducciones <- grep("traducción", t3[, 5], ignore.case = TRUE)
traduccionescomentadas <- grep("traduccióncomentada", t3[, 5], ignore.case = TRUE)

intersect(tesisque, propuestas)



length(tesinasque) + length(traduccionescomentadas) + length(tesisque)

todos <- unique(c(tesinas, tesinasque, tesis, tesisque, traducciones, traduccionescomentadas))
numeros <- 1:492

outersect(todos, numeros)