# esto es namás para husmear los textos

raw <- readRDS("textos_con_puntuacion.rds")

ind <- grep("0665312", raw$doc_num) # indice
raw[ind, 3]
