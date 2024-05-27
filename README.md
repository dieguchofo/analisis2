La idea es que cada folder sea para una extracción de datos diferente.

    todo.rds es un data frame con las columnas
    "doc_num" "nombre" "titulo" "año" "texto"


ANTES DE SEGUIR HAY QUE HACER ESTOS CARACTERES ESPACIOS:
\u2029
\u2028

# /taguear_trabajos
Este tiene el objetivo de taguear los trabajos como tesis/tesina, traducción,
propuesta de material didáctico, o informe de servicio social/de experiencia
profesional.
Esto lo puedo hacer en MALLET o buscando las frases "tesis", "tesina",
"traducción comentada", "informe" y "propuesta".
Yo creo que lo mejor va a ser una combinación de ambas. MALLET, por más bueno
que sea, no puede decir con certeza qué tipo de trabajo es cada uno. 

Tengo que comparar los resultados que tenga buscando frases concretas con los
resultados de MALLET.

## 0.r
Voy a sacar tres categorías:
1. tesis y tesinas,
2. traducciones, y
3. el resto.

# /topic_modeling
Aquí estoy haciendo mi desmadre de MALLET, además de preparar los textos con R.

# HACE FALTA
Tengo varias opciones cuando se trata de tema:
    - separar las palabras por año y ver qué sale de las palabras más comunes
    - separar los trabajos por tipo de trabajo y ver qué sale
    - usar un programa ya hecho de topic modeling.

## /preparar_textos
Hay que correr esto para tener los archivos .txt de los textos individuales:
0.r hace un .txt limpio (sólo letras, números y espacios) por cada trabajo de
titulación.
0.1.r hace un .txt por cada año (esto es obsoleto, pues no produce resultados
confiables con MALLET ni con ningún otro tipo de análisis de textos que
dependa de la proximidad entre palabras, dado que las últimas palabras de un
texto están alado de las primeras del siguiente)
0.2.py solamente hace que los nombres de los textos en /textos_individuales
sean 001.txt en vez de 1.txt, etc.
0.3.r hace 0.r pero su output es "textos_limpios.rds"

## /palabras comunes
### es_stop_words.txt
Esta lista la saqué del blog de Mauricio Matias C., "Palabras Vacías en Español (stop words) ft Python"
(https://cr0wg4n.medium.com/palabras-vac%C3%ADas-en-espa%C3%B1ol-stop-words-ft-python-3117e52d2bff)

### en_stop_words.txt
Esta lista la saqué de "NLKT's list of english stopwords"
(https://gist.github.com/sebleier/554280)

### 1.r
#### findings
Tal vez es porque no soy lo suficientemente creativo, pero lo que hice aquí
creo que no rindió muchos frutos. No porque el método sea malo sino porque creo
que sí voy a necesitar separar los trabajos o por año o por tipo de trabajo o 
ambos.

# /longitudes
## findings
No encontré ninguna tendencia importante. Es una línea casi recta. Igual hay
que ver cómo hacer esas líneas de tendencias pa ver si sube o baja o qué.
Si sí voy a usar esta gráfica (alguna de las dos longitudes_absolutas_y_promedio),
tengo que hacer bonito el eje x, porque ahorita está todo encimado.

## descripción
Primero reemplaza "\\t" ,"\\r" y "\\n" con " " y luego reemplaza 100 veces "  " con " ".
Estoy ignorando los caracteres especiales de unicode (como "\\u2028", etc.)
porque no sé cómo reemplazarlos con sus caracteres reales (me imagino que no es
posible y que por eso están así) y creo que son tan pocos y usados de manera
tan equitativa que no van a modificar las tendencias.

El Yannick Eduardo se echó una tesis de 300 páginas. Hay que tomarlo en cuenta
y chance excluirlo. NO AFECTA NADA SI QUITO SU TESIS.

# findings extras
Esto no es verdad porque u2029 aparece en como 1 de cada 15 trabajos de titualación:
    u2029 es el caracter paragraph separator. Chance me sirve de algo? Aunque la
    verdad no creo que de mucho
