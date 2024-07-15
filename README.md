La idea es que cada folder sea para una extracción de datos diferente.

    todo.rds es un data frame con las columnas
    "doc_num" "nombre" "titulo" "año" "texto"


# /comprobacion_hipotesis
En este voy a llevar a cabo los experimentos que me van a permitir comprobar la
hipótesis de que el estilo se ha ido homogeneizando y los temas se han ido
diversificando. Tengo dos datasets: las frecuencias relativas de cada palabra
en cada trabajo que saqué con stylo, y los pesos de cada tema en cada trabajo
que sacó MALLET. Lo que voy a hacer sencillamente es dividir los datos por año,
sacar la distancia euclideana entre cada renglón de los datasets con 'dist()' y
ver las distancias promedio de cada año. Si las distancias promedio del dataset
que sacó stylo disminuyen, mi hipótesis es correcta, y si las distancias
promedio del dataset de MALLET aumentan, mi hipótesis es correcta.

## /estilo
### 1.r
grafica las distancias promedio por año entre los trabajos, tomando sus las
frecuencias relativas de las 5000 palabras más frecuentes como sus posiciones
en un espacio de 5000 dimensiones. Su input es "table_with_frequencies.txt",
que produjo stylo, y su output "estilo.png".

## /tema
### 1.r
Lo mismo que estilo/1.r, pero con los scores de 50 temas sacados por MALLET. Su
input es "50-doc-topics.csv" y su output "tema.png".


# COSAS QUE HACER
- taguear los trabajos con el método siguiente: Cada trabajo tiene un score
para cada tópico. El score mayor que tenga cada trabajo va a ser el que se
tome como el real. Es decir, si un trabajo tiene .69 de traducción, es un 
trabajo de traducción; si tiene .40 de poesía, .30 de traducción, .25 de
didáctica y .5 de novela, es una tesina/tesis.

# /estilometria
Estoy usando el paquete de R 'stylo'.

Cada que corres stylo, genera una gráfica y además un .csv. Creo que eso es lo
que voy a tener que luego procesar con "gephi".

## /corpus
Stylo necesita una carpeta llamada "corpus" en el que estén los plaintexts




# /taguear_trabajos
## 0.r
Es inservible. Este método no fue el correcto.

## 1.r
El método que usé para esto es casi perfecto. Una falla, por ejemplo, es la
traducción comentada con el id 0641393, que tiene de score de tesis/tesina
0.6866955170883267 y de otro 0.31330448291167334.

## 1.1.r
Esto es 1.r pero manualmente tagueo los que considero que no se pueden taguear
automáticamente. 

Checando los resultados de mallet contra los míos respecto a los indecisos,
estamos de acuerdo en 51 trabajos de 92. O sea, en ese rango, es malísimo.
Tengo que corroborar los que según yo son decisos, porque qué tal que así es
en cualquier rango (no creo)

## 0.r
Sinceramente esto es muy difícil de automatizar porque no hay una manera
estándar de hacer las portadas. Muchas veces las traducciones también tienen la
palabra "tesis" en la portada. Además, hay tesis y tesinas sobre traducción, y
no es claro cuándo es una traducción y cuándo es una tesis o tesina.

Voy a tener que hacerlo muy sistemáticamente:
1. 

Voy a sacar tres categorías:
1. tesis y tesinas,
2. traducciones, y
3. el resto.

# /topic_modeling
Aquí estoy haciendo mi desmadre de MALLET, además de preparar los textos con R.

## /mallet
### /4_topics
#### /r
Creo que es mejor usar mallet desde R. Hay que ver cómo hacer eso.
En este folder voy a intentar interpretar los outputs de MALLET cuando hice el
experimento de sacar cuatro temas. Creo que esto me puede ayudar a categorizar
los trabajos.

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

# /comillas
Esto es un intento fallido de separar las citas del texto que escribió la
persona. Creo que es una causa perdida.

# /longitudes
## findings
No encontré ninguna tendencia importante. Es una línea casi recta. Igual hay
que ver cómo hacer esas líneas de tendencias pa ver si sube o baja o qué.
Si sí voy a usar esta gráfica (alguna de las dos longitudes_absolutas_y_promedio),
tengo que hacer bonito el eje x, porque ahorita está todo encimado.

## descripción
Primero reemplaza "\\t" ,"\\r" y "\\n" con " " y luego reemplaza 100 veces "  "
con " ".
Estoy ignorando los caracteres especiales de unicode (como "\\u2028", etc.)
porque no sé cómo reemplazarlos con sus caracteres reales (me imagino que no es
posible y que por eso están así) y creo que son tan pocos y usados de manera
tan equitativa que no van a modificar las tendencias.

El Yannick Eduardo se echó una tesis de 300 páginas. Hay que tomarlo en cuenta
y chance excluirlo. NO AFECTA NADA SI QUITO SU TESIS.

# findings extras
u2029, a pesar de ser el caracter "paragraph separator", no me sirve para
identificar los párrafos porque solamente aparece en como 1 de cada 15 trabajos