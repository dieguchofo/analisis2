La idea es que cada folder sea para una extracción de datos diferente.

    todo.rds es un data frame con las columnas
    "doc_num" "nombre" "titulo" "año" "texto"

u2029 es el caracter paragraph separator. Chance me sirve de algo? Aunque la 
verdad no creo que de mucho

# /topic_modeling
Aquí estoy haciendo mi desmadre de MALLET, además de preparar los textos con R.

Para usar el folder textos_individuales/ hay que correr 0.r y luego 0.2.py

# HACE FALTA
Tengo varias opciones cuando se trata de tema:
    - separar las palabras por año y ver qué sale de las palabras más comunes
    - separar los trabajos por tipo de trabajo y ver qué sale
    - usar un programa ya hecho de topic modeling.

# palabras comunes
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

# longitudes
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