# Hello, world!!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'



# CAPTURA DE LEGENDAS do YouTube: youtubecaption E analise básica do que é falado ----

##### CRIANDO A FUNCAO ----
#' Dados_basicos_legenda(x, y)
#'
#' A funçaõ retorna dados básicos gerais sobre o texto das legendas.
#' @param x é string com link para video do youtube.
#' @param y é um string indicando qual o idioma da legenda, o valor
#' default é "en-US". Para entender quais os possiveis strings de 'y', ver o
#' parametro language da função get_caption() do pacote "youtubecaption"
Dados_basicos_legenda <- function(Insira_Link_do_Video_aqui, language ="en-US") {

  # Captura da legenda:
  if(require(youtubecaption) == F) install.packages("youtubecaption"); require(youtubecaption)


  #Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=fK2IJ43ppd0"


  Legendas <- get_caption(url = Insira_Link_do_Video_aqui,
                          language = language,  # "en-GB", # ATENCAO PARA A ESCOLHA DA LEGENDA
                          savexl = FALSE, openxl = FALSE, path = getwd())
  # video sobre "slow aging": "https://www.youtube.com/watch?v=QRt7LjqJ45k"
  # video sobre sabao e Covid-19: "https://www.youtube.com/watch?v=-LKVUarhtvE"


  if(require(dplyr) == F) install.packages("dplyr"); require(dplyr)
  if(require(RSQLite) == F) install.packages("RSQLite"); require(RSQLite)
  Legendas_vec <- pull(Legendas, start) # essa linha converte o tibble em vetor
  TdurationLegendas <- max(Legendas_vec) # ___ segundos = ___ minutos

  Legendas_string <- pull(Legendas, text) # essa linha converte o tibble em vetor
  NcharLegendas <- nchar(Legendas_string) # numero de caracteres por linha

  library(stringr)
  Nwords_Legendas <- str_count(Legendas_string, boundary("word"))
  TpalavrasLegendas <-sum(Nwords_Legendas) # ___ palavras


  if(require(tm) == F) install.packages("tm"); require(tm)
  Legendas_corpus <- Corpus(VectorSource(Legendas_string)) # criando corpus

  Legendas_corpus <- tm_map(Legendas_corpus, tolower)
  Legendas_corpus <- tm_map(Legendas_corpus, removeNumbers)
  Legendas_corpus <- tm_map(Legendas_corpus, removePunctuation)
  Legendas_corpus <- tm_map(Legendas_corpus, removeWords, stopwords("english"))
  Legendas_corpus <- tm_map(Legendas_corpus, stripWhitespace)
  Legendas_corpus <- tm_map(Legendas_corpus, stemDocument, language = "english")

  # para saber o numero de palavras sem repetição
  textsplitWord_dtm <- DocumentTermMatrix(Legendas_corpus)
  textsplitWordMatrix <- as.matrix(textsplitWord_dtm)
  textsplitWordSorted <- sort(colSums(textsplitWordMatrix), decreasing = T)
  textsplitWordDF <- data.frame(word = names(textsplitWordSorted), freq = textsplitWordSorted)
  NwordsLegendas <- count(textsplitWordDF)  # ___ palavras diferentes

  #resultados : duracao / num de palavras / num de palavras diferentes
  TpalavrasLegendas  # ___ palavras
  NwordsLegendas     # ___  palavras diferentes
  TdurationLegendas  # ___ segundos
  ratioVocPorsec <- NwordsLegendas/TdurationLegendas # ___ palavras diferentes por segundo
  ratioPalavPorsec <- TpalavrasLegendas/TdurationLegendas # ___ palavras por segundo

  N_de_Palavras <- round(as.numeric(TpalavrasLegendas), 1)
  Vocabulario <- round(as.numeric(NwordsLegendas), 1)
  Tempo_minutos <- round((TdurationLegendas/60), 1)
  Vocabulario_PorSeg <- round(as.numeric(ratioVocPorsec), 2)
  Palavras_PorSeg <- round(as.numeric(ratioPalavPorsec), 2)

  #rm("Insira_Link_do_Video_aqui", "Legendas", "Legendas_corpus", "Legendas_string",
  #   "Legendas_vec", "N_de_Palavras", "NcharLegendas", "Nwords_Legendas", "NwordsLegendas",
  #   "Palavras_PorSeg", "ratioPalavPorsec", "ratioVocPorsec", "TdurationLegendas",
  #   "Tempo_minutos", "textsplitWord_dtm", "textsplitWordDF", "textsplitWordMatrix", "textsplitWordSorted",
  #   "TpalavrasLegendas", "Vocabulario", "Vocabulario_PorSeg")

  tabela <- as.data.frame(cbind(N_de_Palavras, Vocabulario, Tempo_minutos, Vocabulario_PorSeg, Palavras_PorSeg))
  return(tabela)
}

# ----
#### USANDO A FUNCAO 1 VEZ ----
# Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=fK2IJ43ppd0"
# Dados_basicos_legenda(Insira_Link_do_Video_aqui)



##### USANDO A FUNCAO REPETIDAMENTE PARA GERAR TABELA COM DADOS DE VARIOS VIDEOS!!! ----

# videos <- c(
#   "https://www.youtube.com/watch?v=HIdflecvQG8",
#   "https://www.youtube.com/watch?v=fK2IJ43ppd0",
#   "https://www.youtube.com/watch?v=JCTzbc76WXY",
#   "https://www.youtube.com/watch?v=QRt7LjqJ45k",
#   "https://www.youtube.com/watch?v=-LKVUarhtvE",
#   "https://www.youtube.com/watch?v=BSSqhe7mT2Y",
#   "https://www.youtube.com/watch?v=GFKzE52XRmw",
#   "https://www.youtube.com/watch?v=g-i6QMvIAA0",
#   "https://www.youtube.com/watch?v=YGV5o6UHjxM",
#   "https://www.youtube.com/watch?v=IQpQVOPokhk",
#   "https://www.youtube.com/watch?v=PWLu5bVCY8A",
#   "https://www.youtube.com/watch?v=pFeDOqgoE-k",
#   "https://www.youtube.com/watch?v=dLme6kE5XaU",
#   "https://www.youtube.com/watch?v=Hvysy11716g",
#   "https://www.youtube.com/watch?v=Hvysy11716g",
#   "https://www.youtube.com/watch?v=A02Ucd6monY",
#   "https://www.youtube.com/watch?v=4lTbWQ8zD3w",
#   "https://www.youtube.com/watch?v=0Tk82hEHNnY",
#   "https://www.youtube.com/watch?v=ytKCcYxUU04",
#   "https://www.youtube.com/watch?v=xw2OEKAHIhM")



#' Dados_basicos_legenda_vetor(x,y)
#' A funçaõ retorna  um data.frame com dados básicos gerais sobre o texto
#' das legendas.
#' @param x é vetor de strings com links para video do youtube.
#' @param y é um string indicando qual o idioma da legenda, o valor default é
#' "en-US". Para entender quais os possiveis strings de 'y', ver o parametro
#' language da função get_caption() do pacote "youtubecaption".
#' ATENÇÃO: não foi construída uma forma de indicar a lingua de cada legenda.
#' Portanto, é necessário que todos os links de videos adicionados tenham a
#' legenda desejada no mesmo idioma.
Dados_basicos_legenda_vetor <- function(Insira_vetor_de_Links_aqui) {
  if(require(purrr) == F) install.packages("purrr"); require(purrr)
  tabela <- as.data.frame(  # essas linhas convertem a lista em data.frame
    matrix(unlist(
      map(Insira_vetor_de_Links_aqui, Dados_basicos_legenda)),
      nrow = length(Insira_vetor_de_Links_aqui),
      byrow = TRUE))

  colnames(tabela) <- c("Number of words", "Vocabulary",
                        "duration(min)", "Vocabulary per sec",
                        "Words per sec")
  return(tabela)
}
