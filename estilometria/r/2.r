# esto es namás para husmear los textos

raw <- readRDS("textos_con_puntuacion.rds")

# ver los textos inputting su doc_num
ind <- grep("0674722", raw$doc_num) # indice
raw[ind, 3:4]

f <- as.numeric(raw[, 4])
sort(f)
