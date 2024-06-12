# Esto va a escribir los archivos para la carpeta "corpus", con los nombres de
# los archivos así: AÑO-DE-PUBLICACIÓN_ID-NUMBER

raw <- readRDS("textos_con_puntuacion.rds")

# Escribir los textos anuales

# Iterate through each row of the data frame
for(i in 1:nrow(raw)) {
    # Get the ID and plaintext from the current row
    id <- raw[i, 1]
    año <- raw[i, 4]
    plaintext <- raw[i, 5]

    # Define the filename with the ID as the name
    filename <- paste0("estilometria/corpus/", año, "_", id, ".txt")

    # Write the plaintext to the .txt file
    writeLines(plaintext, filename)
}