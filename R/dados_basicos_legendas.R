#############################
### Script para funcoes de dados basicos de pre-analise das legendas de um video
#############################
# # # INDICE
# (1) retorna dados basicos da legenda
# (2) reproduz o processo anterior para muitas legendas
# (3) retorna informações sobre nivel de dificuldade da legenda

############

# if(require(youtubecaption) == F) install.packages("youtubecaption"); require(youtubecaption)
# if(require(purrr) == F) install.packages("purrr"); require(purrr)
# if(require(dplyr) == F) install.packages("dplyr"); require(dplyr)
# if(require(RSQLite) == F) install.packages("RSQLite"); require(RSQLite)
# if(require(tm) == F) install.packages("tm"); require(tm)
# library(stringr)
# library(tidyverse)


######################
# (1) CAPTURA DE LEGENDAS do YouTube: youtubecaption E analise básica do que é falado ----

##### CRIANDO A FUNCAO ----

#' Dados_basicos_legenda(x, y)
#'
#' A funçaõ retorna dados básicos gerais sobre o texto das legendas.
#' @param Insira_Link_do_Video_aqui é string com link para video do youtube.
#' @param language é um string indicando qual o idioma da legenda, o valor
#' default é "en". Para entender quais os possiveis strings de 'y', ver o
#' parametro language da função get_caption() do pacote "youtubecaption"
Dados_basicos_legenda <- function(Insira_Link_do_Video_aqui, language ="en") {

  # Captura da legenda:


  #Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=fK2IJ43ppd0"


  Legendas <- youtubecaption::get_caption(url = Insira_Link_do_Video_aqui,
                          language = language,  # "en-GB", # ATENCAO PARA A ESCOLHA DA LEGENDA
                          savexl = FALSE, openxl = FALSE, path = getwd())
  # video sobre "slow aging": "https://www.youtube.com/watch?v=QRt7LjqJ45k"
  # video sobre sabao e Covid-19: "https://www.youtube.com/watch?v=-LKVUarhtvE"


  Legendas_vec <- pull(Legendas, start) # essa linha converte o tibble em vetor
  TdurationLegendas <- max(Legendas_vec) # ___ segundos = ___ minutos

  Legendas_string <- pull(Legendas, text) # essa linha converte o tibble em vetor
  NcharLegendas <- nchar(Legendas_string) # numero de caracteres por linha

  Nwords_Legendas <- str_count(Legendas_string, boundary("word"))
  TpalavrasLegendas <-sum(Nwords_Legendas) # ___ palavras



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





######################
# (2) USANDO A FUNCAO REPETIDAMENTE PARA GERAR TABELA COM DADOS DE VARIOS VIDEOS!!! ----

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
#'
#' A funçaõ retorna  um data.frame com dados básicos gerais sobre o texto
#' das legendas.
#' @param Insira_vetor_de_Links_aquix é vetor de strings com links para video do youtube.
#' @param vlanguage é um vetor de strings indicando quais os idiomas das legendas,
#' o valor default deveria ser "en-US", mas não consegui fazer funcionar.
#' Para entender quais os possiveis strings do vetor 'y', ver o parametro
#' language da função get_caption() do pacote "youtubecaption".
#' ATENÇÃO: tentei adicionar no segundo parametro, a possibilidade de inserir
#' uma lista de vetores com os idiomas das legendas para ser levado em consideração
#' (em paralelo) com o primeiro parametro.
#' Aparentemente funcionou, no entanto, agora é preciso sempre inserir esse vetor.
#' Não consegui fazer funcionar o valor default.
Dados_basicos_legenda_vetor <- function(Insira_vetor_de_Links_aqui, vlanguage) {
  tabela <- as.data.frame(  # essas linhas convertem a lista em data.frame
    matrix(unlist(
      purrr::map2(Insira_vetor_de_Links_aqui, vlanguage, Dados_basicos_legenda)),
      nrow = length(Insira_vetor_de_Links_aqui),
      byrow = TRUE))

  colnames(tabela) <- c("Number of words", "Vocabulary",
                        "duration(min)", "Vocabulary per sec",
                        "Words per sec")
  return(tabela)
}



######################
# (3) Retornando indicadores de nivel de dificuldade do vocabulario da legenda




#' Level_legenda()
#'
#' função que recebe um vetor de palavras e retorna uma lista contendo as palavras detectadas
#' para cada nível; as palavras não detectadas em nenhum nivel ;
#' vetor com as palavras consideradas na legenda ;
#' Pequeno DF indicando a proporção de palavras por nivel
#'
#' @param words é o vetor string com as palavras to texto
Level_legenda <- function(words) {
  words <- words[!grepl(" |\\-|\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:", words)]
  words <- words[!grepl("<|>", words)]
  words <- removeWords(words, tm::stopwords(kind = "en")) # do tm
  words <- words[!is.na(words)]
  words <- words[words != ""]
  words <- words[words != " "]
  trat.Info.1.0a1 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "A1")
  trat.Info.1.0a2 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "A2")
  trat.Info.1.0b1 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "B1")
  trat.Info.1.0b2 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "B2")
  trat.Info.1.0c1 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "C1")
  trat.Info.1.0c2 <- trat.Info.1.0 %>% filter(trat.Info.1.0$Level == "C2")
  Na1 <- c()
  Na2 <- c()
  Nb1 <- c()
  Nb2 <- c()
  Nc1 <- c()
  Nc2 <- c()
  N0 <- c()
  lw <- length(words)
  for(i in 1:lw) {
    np <- words[i]  # tirei o removePunctuation()
    na1 <- grep(paste0("^", np, "$"), trat.Info.1.0a1$Base.Word)
    na2 <- grep(paste0("^", np, "$"), trat.Info.1.0a2$Base.Word)
    nb1 <- grep(paste0("^", np, "$"), trat.Info.1.0b1$Base.Word)
    nb2 <- grep(paste0("^", np, "$"), trat.Info.1.0b2$Base.Word)
    nc1 <- grep(paste0("^", np, "$"), trat.Info.1.0c1$Base.Word)
    nc2 <- grep(paste0("^", np, "$"), trat.Info.1.0c2$Base.Word)
    Na1 <- c(Na1, na1)
    Na2 <- c(Na2, na2)
    Nb1 <- c(Nb1, nb1)
    Nb2 <- c(Nb2, nb2)
    Nc1 <- c(Nc1, nc1)
    Nc2 <- c(Nc2, nc2)
    n0  <- c(na1, na2, nb1, nb2, nc1, nc2)
    if(length(n0) == 0) {
      N0 <- c(N0, i)
    }
  }
  count <- data.frame(total.words= c(length(Na1),length(Na2),length(Nb1),
                                     length(Nb2),length(Nc1),length(Nc2),
                                     length(N0)),
                      percent.total.words = c(length(Na1)/lw,length(Na2)/lw,length(Nb1)/lw,
                                              length(Nb2)/lw,length(Nc1)/lw,length(Nc2)/lw,
                                              length(N0)/lw))
  row.names(count) <- c("A1", "A2", "B1", "B2", "C1", "C2", "NoLvl")

  results <- list(A1=trat.Info.1.0a1$Base.Word[Na1],
                  A2=trat.Info.1.0a2$Base.Word[Na2],
                  B1=trat.Info.1.0b1$Base.Word[Nb1],
                  B2=trat.Info.1.0b2$Base.Word[Nb2],
                  C1=trat.Info.1.0c1$Base.Word[Nc1],
                  C2=trat.Info.1.0c2$Base.Word[Nc2],
                  Nolvl=words[N0],
                  words.text=words,
                  Count=count)

  return(results)
}

##### dados que criei para testar essa funcao
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="testdata_Level.RData")







