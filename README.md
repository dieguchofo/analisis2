Este es mi intento final de sacar un .json con textos + metadatos

### trabajos de titulación que no aparecen ###
Dos lecturas del episodio "Proteus" en Ulysses, de James Joyce : el personaje en la literatura clásica y la interpretación del episodio desde el psicoanálisis junguiano
    Sólo está la portada. No autorizó a la UNAM su difusión
The song and the water : el mar, la narración y la vida en The waves, de Virginia Woolf
    Namás no está.
Un acercamiento al personaje de Merlín en Le morte d&rsquo;Arthur
    Namás no está.
A non-revelatory revelation : el proceso incompleto de Anamnesis motivado por el espacio (psico)geográfico en heart of darkness, de Joseph Conrad
    Namás no está.
El villano y el héroe : la representación del otro en tres cuentos de la saga de Sherlock Holmes, escritos por sir Arthur Conan Doyle
    Error mío supongo. Sí está en tesiunam pero no en mi base de datos. Lo voy a ignorar.

# 0.1.r
Correr esto produce un dataframe con 5 columnas:
"doc_num"  "nombre"  "titulo"  "año"  "texto"

La columna de "texto" tiene los textos como un solo string. Tuve que unirlos;
no los voy a tener separados por páginas, pero creo que tampoco es tan
indispensable.

Produce "todo.rds", que es el data frame con todos los textos y sus respectivos
metadatos.



# intento_final/0.r
La manera de hacer un .json chido va a ser con listas. O, mejor dicho, una
lista de listas (como en python).

Lo que voy a tener que hacer es comparar todos los doc_nums de metadatos_df
con todos los doc_nums de raw_t.
    doc_nums de metadatos_df es     'metadatos_df[, 4]'
    doc_nums de raw_t es            'lapply(raw_t, '[[', 1)'


### NO FUNCIONÓ ###
Como primera estrategia voy a convertir ambos textos sagrados (plaintext2.json
y metadatos.json) a data frames. De ahí voy a ver si puedo checar las columnas
"doc_num" y sus elementos y mergear los data frames. Voy a tener que poner NA
para las entradas de metadatos que no tengan plaintext correspondiente.