# Esto va a escribir los archivos para la carpeta "textos_individuales_ids".
# Los nombres de los archivos van a ser sus IDs.

raw <- readRDS("textos_limpios.rds")

# Escribir los textos anuales

# Iterate through each row of the data frame
for(i in 1:nrow(raw)) {
    # Get the ID and plaintext from the current row
    id <- raw[i, 1]
    plaintext <- raw[i, 5]

    # Define the filename with the ID as the name
    filename <- paste0("topic_modeling/textos_ids/", id, ".txt")

    # Write the plaintext to the .txt file
    writeLines(plaintext, filename)
}