# Esto es como 1.r, pero va a sacar un corpus con la primera mitad con un
# nombre y la segunda con otro, pa ver cómo salen las gráficas.
# La primera mitad va del 2006 al 2015 y la segunda del 2016 al 2023

raw <- readRDS("textos_con_puntuacion.rds")

# Escribir los textos anuales

# Iterate through each row of the data frame
for(i in 1:nrow(raw)) {
    # Get the ID and plaintext from the current row
    id <- raw[i, 1]
    año <- as.numeric(raw[i, 4])
    plaintext <- raw[i, 5]

    if(año <= 2015) {
        mitad <- "primera_"
    } else {
        mitad <- "segunda_"
    }

    # Define the filename with the ID as the name
    filename <- paste0("estilometria/corpus/", mitad, id, ".txt")

    # Write the plaintext to the .txt file
    writeLines(plaintext, filename)
}