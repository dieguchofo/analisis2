a <- c("hola, estoy aquí en mi casa. Estoy descubriendo cómo funciona r. R es un lenguaje de programación para estadística. ÑÑÑñññ. \"hola\" dijo mi amigo.")

b <- strsplit(a, "(?<=\")\\s+|\\s+(?=\")", perl = TRUE)

c <- strsplit(a, " ")
