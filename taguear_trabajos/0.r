# Esto va a sacar los primeros 2000? caracteres de cada uno de los textos en
# /topic_modeling/textos_individuales, quitarles los espacios por completo y
# ver si tienen ""tesis", "tesina", "traducción comentada", "informe" o
# "propuesta"."

outersect <- function(x, y) {       # para ver los valores que no comparten
  sort(c(setdiff(x, y),
         setdiff(y, x)))
}


textos <- readRDS("textos_limpios.rds")
t2 <- gsub(" ", "", textos) # quitar espacios para lidiar con "t e s i n a s"
t3 <- substr(t2, 1, 500)
t4 <- gsub("bibliotecastesisdigitales", "", t3, ignore.case = TRUE)
t5 <- gsub("contenidoenestatesis", "", t4, ignore.case = TRUE)

tesinas <- grep("tesina", t5, ignore.case = TRUE)
tesinasque <- grep("tesinaque", t5, ignore.case = TRUE)

tesis <- grep("tesis", t5, ignore.case = TRUE)
tesisque <- grep("tesisque", t5, ignore.case = TRUE)

traducciones <- grep("traducción", t5, ignore.case = TRUE)
traduccionescomentadas <- grep("traduccióncomentada", t5, ignore.case = TRUE)
informes <- grep("informe", t5, ignore.case = TRUE)
propuestas <- grep("propuesta", t5, ignore.case = TRUE)

intersect(tesisque, traduccionescomentadas)



length(tesinasque) + length(traduccionescomentadas) + length(informes) + length(tesisque) + length(propuestas)