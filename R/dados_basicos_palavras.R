

##### Neste script, adicionamos a legenda e temos análises das palavras do texto.

if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
if(require(tm) == F) install.packages("tm"); require(tm)
if(require(tokenizers) == F) install.packages("tokenizers"); require(tokenizers)
if(require(youtubecaption) == F) install.packages("youtubecaption"); require(youtubecaption)
if(require(dplyr) == F) install.packages("dplyr"); require(dplyr)
if(require(RSQLite) == F) install.packages("RSQLite"); require(RSQLite)
if(require(purrr) == F) install.packages("purrr"); require(purrr)
if(require(stringr) == F) install.packages("stringr"); require(stringr)

#' palavras_legenda()
#'
#' função que retorna um vetor com as palavras da legenda.
#'
#' @param Insira_Link_do_Video_aqui é o string do link do video do youtube
#' @param language é um string indicando qual o idioma da legenda, o valor
#' default é "en". Para entender quais os possiveis strings de 'y', ver o
#' parametro language da função get_caption() do pacote "youtubecaption"
#' @param removestopwords é lógico, default=T, remove as stop words (pacote tm)
#' @param stemm é lógico, default=F, transforma as palavras em stemms (pacote tm)
#' @param unicas é lógico, default=T, retorna o vetor sem palavras repetidas
palavras_legenda <- function(Insira_Link_do_Video_aqui,
                             language="en",
                             removestopwords=TRUE,
                             stemm=FALSE,
                             unicas=TRUE) {
# limpando, stemming e convertendo para o formato adequado

  Legendas <- get_caption(url = Insira_Link_do_Video_aqui,
                          # Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=R7YmA_-8zZo"
                          language = language,  # ATENCAO PARA A ESCOLHA DA LEGENDA
                          savexl = FALSE, openxl = FALSE, path = getwd())

  ## B2. limpando, stemming e convertendo as legendas para o formato adequado
  Legendas_string <- pull(Legendas, text) # converte o tibble em vetor
  Legendas_corpus <- Corpus(VectorSource(Legendas_string)) # converte os vetores em corpus
  Legendas_corpus_limpo <- tm_map(Legendas_corpus, tolower)
  if (removestopwords == TRUE) {
    Legendas_corpus_limpo <- tm_map(Legendas_corpus_limpo, removeWords, stopwords("english")) # Limpando as stopwords
  }
  Legendas_corpus_limpo <- tm_map(Legendas_corpus_limpo, removeNumbers)
  Legendas_corpus_limpo <- tm_map(Legendas_corpus_limpo, stripWhitespace)
  if (stemm == TRUE) {
    Legendas_corpus_limpo <- tm_map(Legendas_corpus_limpo, stemDocument, language = "english")
  }
  # inspect(Legendas_corpus_limpo[1])
  Legendas_corpus_limpo <- as.data.frame(Legendas_corpus_limpo$content)
  Legendas_corpus_limpo <- map(Legendas_corpus_limpo, tokenize_words) # convertendo o dataframe em lista
  Legendas_corpus_limpo <- data.frame(matrix(unlist(Legendas_corpus_limpo), # Convertendo a lista em Data Frame
                                             nrow=length(Legendas_corpus_limpo), byrow=F), stringsAsFactors=FALSE)
  Legendas_corpus_limpo <- map(Legendas_corpus_limpo, tokenize_words) # convertendo o dataframe em lista
  Legendas_corpus_limpo <- data.frame(matrix(unlist(Legendas_corpus_limpo), # Convertendo a lista em Data Frame
                                             nrow=length(Legendas_corpus_limpo), byrow=F), stringsAsFactors=FALSE)
  # mudando o nome da coluna
  Legendas_corpus_limpo["words"] <- Legendas_corpus_limpo["matrix.unlist.Legendas_corpus_limpo...nrow...length.Legendas_corpus_limpo..."]
  Legendas_corpus_limpo$matrix.unlist.Legendas_corpus_limpo...nrow...length.Legendas_corpus_limpo... <- NULL

  palavras <- as.vector(Legendas_corpus_limpo$words)
  if (unicas == TRUE) {
    palavras <- unique(palavras)
  }
  return(palavras)
}



#
# ## B3. Carregando a Lista de 5000 palavras ----
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# FiveThouMostFreq <- read.csv2("5000MostFreqWords.csv", sep = ";",  header = T)
# # limpando, stemming e convertendo no formato adequado
# FiveThouMostFreq <- Corpus(VectorSource(as.vector(FiveThouMostFreq$Word)))
# FiveThouMostFreq <- tm_map(FiveThouMostFreq, stemDocument, language = "english")
# FiveThouMostFreq <- tm_map(FiveThouMostFreq, stripWhitespace)
# FiveThouMostFreq <- data.frame(matrix(unlist(FiveThouMostFreq$content), # Convertendo a lista em Data Frame
#                                       nrow=length(FiveThouMostFreq$content), byrow=F), stringsAsFactors=FALSE)
# FiveThouMostFreq["words"] <- FiveThouMostFreq["matrix.unlist.FiveThouMostFreq.content...nrow...length.FiveThouMostFreq.content..."]
# # mudando o nome da coluna
# FiveThouMostFreq$matrix.unlist.FiveThouMostFreq.content...nrow...length.FiveThouMostFreq.content... <- NULL
# FiveThouMostFreq$words <- str_replace(FiveThouMostFreq$words, " ", "") # ainda precisava limpar os espacos no inicio das strings
#
#
# ## B4. Fazendo o match e identificando quantas palvras existem em comum entre as legendas e o dicionario de 5 mil palavras
# Common_words <- inner_join(Legendas_corpus_limpo, FiveThouMostFreq) # encontrando as palavras que estao nas legendas e no dicionario
# Common_words <- unique(Common_words)  # retirando as duplicatas
#
#
# #######
#
#
#
# ########## C1. Chamando pacotes necessarios ----
#
#
#
# ##### C2. FUNCAO RETORNA NUMERO DE OCORRENCIA DE TERMOS (DE UMA LISTA) (PROPORCAO OCORRENCIA / TOTAL PALAVRAS)
# #####     ADICIONANDO COMO COLUNA DO DF DA SELECAO DE SENTENCAS ----
#
#
#
#
#
#
# ##### C.2.2. Convertendo as legendas em data frame com as sentencas completas
# # Unindo legendas por sentenca.
# texto <- paste(Legendas$text, sep = " ", collapse = " ") # unindo as legendas em um unico texto
# texto <- str_replace_all(texto, "\n", " ")                 # recompondo os espaÃ§os
# # tokenizando por sentenca
# t <- tokenize_sentences(texto, lowercase = FALSE, strip_punct = FALSE, simplify = FALSE)
# t <- as.data.frame(t[[1]]) # transformando em data.frame
# t["text"] <- t["t[[1]]"] # mudando o nome
# t["t[[1]]"] <- NULL
# Legendas <- t
#
#
#
# ##### C2.3.Filtrando OS VERBOS TO BE ----
#
# # Legendas <- subset(Legendas, Legendas$segment_id <= 100) # caso precise filtrar o numero de linhas da legenda
#
# n <- grep("'m | am |'s | is |'re | are ", Legendas$text, value = F) # retorna as linhas que tem ocasiÃ£o do verbo to be no presente
# Legendas <- as.data.frame(Legendas[n,])             # filtrando apenas as linhas com verbo to be
# Legendas["text"] <- Legendas["Legendas[n, ]"]   # mudando o nome
# Legendas["Legendas[n, ]"] <- NULL
#
#
#
#
# ###### C2.4. Inserindo e limpando a lista de palavras - (CArregando apens verbos e nouns da lista das 5 mil palavras) ----
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# FiveThouMostFreq <- read.csv2("5000MostFreqWords.csv", sep = ";",  header = T)
# # ficando somente com verbos e adjetivos
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "a") # artigo / pronomes pessoais
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "c") # conjunÃ§Ãµes
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "p") # pronouns
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "d") # determines
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "m") # numeral
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "e") # there (existencial)
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "j") # adjetivo
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "u") # interjeiÃ§Ã£o
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "x") # not, n't
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "r") # adverbs
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "i")
# FiveThouMostFreq <- subset(FiveThouMostFreq, FiveThouMostFreq$Part.of.speech != "t")
# # "v") # 1001 verbos
# # "n") # 2542 nouns
# FiveThouMostFreq$Word <- str_trim(FiveThouMostFreq$Word)
# FiveThouMostFreq <- Corpus(VectorSource(as.vector(FiveThouMostFreq$Word)))
# # FiveThouMostFreq <- tm_map(FiveThouMostFreq, stemDocument, language = "english")
# FiveThouMostFreq <- tm_map(FiveThouMostFreq, stripWhitespace)
# FiveThouMostFreq <- data.frame(matrix(unlist(FiveThouMostFreq$content), # Convertendo a lista em Data Frame
#                                       nrow=length(FiveThouMostFreq$content), byrow=F), stringsAsFactors=FALSE)
# FiveThouMostFreq["words"] <- FiveThouMostFreq["matrix.unlist.FiveThouMostFreq.content...nrow...length.FiveThouMostFreq.content..."]
# # mudando o nome da coluna
# FiveThouMostFreq$matrix.unlist.FiveThouMostFreq.content...nrow...length.FiveThouMostFreq.content... <- NULL
# lista <- unique(FiveThouMostFreq$words)
#
#
# ##### C2.5. Criando a funcao para matche de uma sentenca e lista de termos.
# matches_na_sentenca <- function(Insira_sentenca) {
#   Insira_sentenca <- str_to_lower(Insira_sentenca) # Inserindo e limpando sentenÃ§a
#   vezes = length(lista) # "the" "be"  "and" "of"  "a"
#   vetor <- rep(NA, vezes) # E' boa pra'tica nao criar objetos que expandem o tamanho. Crie objeto fixo e use indexacao para preenche-lo.
#   i = 1
#   for(it in 1:vezes) {
#     palavra <- paste("(^| )", lista[it], "( |$)", sep = "", collapse = "")
#     m <- gregexpr(palavra, Insira_sentenca)
#     m1 <- unlist(m)
#     if(m1 == -1) {
#       match = 0
#     } else {
#       match = length(m[[1]])
#     }
#     vetor[i] <- match # indexacao
#     i = i+1
#   }
#   total <- str_count(Insira_sentenca, boundary("word")) # quantas palavras tem na sentenca
#   vetor # vetor com quantidades de cada palavra da lista
#   soma <- sum(vetor) # quantidade de palavras da lista encontradas na sentenca
#   perc_p_basicas <- soma/total  # quanto maior o valor, "mais bÃ¡sica" Ã© a frase
#   return(perc_p_basicas)
# }
#
#
# ## Para rodar a funcao da sentenca
# # Insira_sentenca <- "my house may be on fire"
# # x <- matches_na_sentenca("my house is on fire")
#
#
# ##### C2.6. criando o loop em que se insere a lista de sentencas e .----
#
# matches_da_legenda <- function(Legenda) {
#   Legenda$matches <- rep(NA, length(Legenda$text))
#   e = 1
#   for(et in 1:length(Legenda$text)) {
#     x <- matches_na_sentenca(Legenda$text[et])
#     Legenda$matches[e] <- x # indexacao
#     e = e+1
#   }
#   return(Legenda)
# }
#
#
#
# ##### C2.7.RODANDO A FUNCAO  E  ORDENANDO----
#
# Legendas <- matches_da_legenda(Legendas)
#
# Legendas <- Legendas[order(Legendas$matches, decreasing = T),]   # ordenando pelo valor dos matches (maiores primeiro)
#
#
# #######################
# ######################
#
#
#
#
#
#
# ##### E1. OUTRAS COISAS QUE PODEM SER UTEIS NOS PROXIMOS PASSOS ----
#
# # 3 como manipular com characters para strings
# length(FiveThouMostFreq$words[3])
# length(toString(FiveThouMostFreq$words[3]))
#
# if(require(stringr) == F) install.packages("stringr"); require(stringr)
# FiveThouMostFreq$words[3][str_length(FiveThouMostFreq$words[3])]
#
#
# # como usar funcoes repetidamente
# if(require(purrr) == F) install.packages("purrr"); require(purrr)
# tabela <- map(c("casa", "relogio"),
#               "casa", grep)
#
#
# # como adicionar elemento a lista
# x <- list("a","b")
# x <- append(letters[3], x)
#





##### RETORNANDO PALAVRAS MAIS FREQUENTES

palavras_frequentes <- function(Insira_Link_do_Video_aqui,
                                language ="en",
                                stemm=FALSE,
                                qntt=40) {

  vector <- palavras_legenda(Insira_Link_do_Video_aqui, languag="en",
                             removestopwords=TRUE,
                             stemm=stemm,
                             unicas=FALSE)

  df <- data.frame(table(vector))

  df_M1 <- df %>% filter(df$Freq > 1) # selecionando os termos q aparecem mais de 1 vez

  ordem <- order(df_M1$Freq, decreasing = FALSE) # obter a ordenacao do volume

  levels <- df_M1$vector[ordem]  # criar os n?veis ordenados
  df_M1$vector <- factor(df_M1$vector, levels=levels, ordered=TRUE) # criar um factor com n?veis ordenados

  df_M1 <- df_M1[order(df_M1$Freq, decreasing = TRUE),]
  df_M1 <- df_M1[1:qntt,]

  graf <- ggplot(data = df_M1) + aes(x = df_M1$vector, y = df_M1$Freq) + #para add cores: "fill = word" como argumento em aes()
    geom_bar(stat = "identity") + labs(x = "Palavras", y = 'Frequencia') +
    guides(fill=FALSE) +
    coord_flip()

  return(graf)
}



#### CRIANDO NOSSO LEMMATIZADOR
# fazendo uma funçaõ que faz o lemmatization usando humspell mas adaptando para
# repetir as palavras sem lemma no dict deles.

if(require(hunspell) == F) install.packages("hunspell"); require(hunspell)

# Insira_Link_do_Video_aqui = "https://www.youtube.com/watch?v=2W85Dwxx218"
# words_v <- palavras_legenda(Insira_Link_do_Video_aqui,
#                              language="en",
#                              removestopwords=FALSE,
#                              stemm=FALSE,
#                              unicas=FALSE)

our_lemmatizer <- function(words, logico=FALSE) {
  words_lemma <- hunspell_stem(words)

  # aqui eu substituo os elementos vazios (length=0, pois não encontrou lemma) pela palavra referente do texto
  lemma <- rep(NA, length(words_lemma)) #cria vetor com mesma dimensão do vetor de palavras com o valor logico se houve ou não lemma
  for (i in 1:length(words_lemma)) {
    if(length(words_lemma[[i]]) == 0) {
      lemma[i] <- FALSE
      words_lemma[[i]] <- words[i]
    } else {
      lemma[i] <- TRUE
    }
  }

  if(logico==FALSE) { # se o parametro logico=F, retorna a lista de palavras
    return(words_lemma)
  } else {
    return(lemma) # se o parametro logico=T, retorna o vetor logico sobre se houve lemmas ou não
  }
}



