# Esto pretende idenetificar qué tipo de trabajo es cada trabajo

# HAY QUE APRENDER A USAR MALLET EN R
# NO ES MALLET PERO: https://www.youtube.com/watch?v=3ozjwHWf-6E&t=537s

library(mallet)
library(topicmodels)
library(dplyr)
library(tm)

# data frame con los textos limpios
data <- readRDS("textos_limpios.rds")

# stopwords
sw_es <- scan("palabras_comunes/es_stop_words.txt", what = "character")
sw_en <- scan("palabras_comunes/en_stop_words.txt", what = "character")
sw <- c(sw_es, sw_en)

textos_instances <-
  mallet.import(text.array = data$texto,
                stoplist = sw,
                token.regexp = "\\p{L}[\\p{L}\\p{P}]+\\p{L}")
