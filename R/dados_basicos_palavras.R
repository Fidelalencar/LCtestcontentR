

##### Neste script, adicionamos a legenda e temos análises das palavras do texto.

# if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
# if(require(tm) == F) install.packages("tm"); require(tm)
# if(require(tokenizers) == F) install.packages("tokenizers"); require(tokenizers)
# if(require(youtubecaption) == F) install.packages("youtubecaption"); require(youtubecaption)
# if(require(dplyr) == F) install.packages("dplyr"); require(dplyr)
# if(require(RSQLite) == F) install.packages("RSQLite"); require(RSQLite)
# if(require(purrr) == F) install.packages("purrr"); require(purrr)
# if(require(stringr) == F) install.packages("stringr"); require(stringr)

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

  Legendas <- youtubecaption::get_caption(url = Insira_Link_do_Video_aqui,
                                          # Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=R7YmA_-8zZo"
                                          language = language,  # ATENCAO PARA A ESCOLHA DA LEGENDA
                                          savexl = FALSE, openxl = FALSE, path = getwd())

  Legendas_string <- Legendas$text
  Legendas_string <- str_to_lower(Legendas_string)
  Legendas_string <- gsub("\\n", " ", Legendas_string)
  words <- our_tokenizer(Legendas_string)

  if (removestopwords == TRUE) {
    words <- removeWords(words, tm::stopwords(kind = "en")) # Limpando as stopwords
  }

  if (stemm == TRUE) {
    words <- stemDocument(words, language = "english")
  }

  if (unicas == TRUE) {
    words <- unique(words)
  }

  return(words)
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

#metodo 1
#' palavras_frequentes()
#'
#' Função que retorna um grafico de barras de frequencia das palavras da legenda.
#' Como input, fornecemos um string com o URL da legenda do youtube
#'
#' @param Insira_Link_do_Video_aqui é o string do link do video do youtube
#' @param language é um string indicando qual o idioma da legenda, o valor
#' default é "en". Para entender quais os possiveis strings de 'y', ver o
#' parametro language da função get_caption() do pacote "youtubecaption"
#' @param qntt é quantidade de palavras mais frequentes que desejamos ver exibidas em barras
#'
palavras_frequentes <- function(Insira_Link_do_Video_aqui,
                                language ="en",
                                qntt=30) {

  require(ggalt)
  require(tidyquant)


  vector0 <- palavras_legenda(Insira_Link_do_Video_aqui, languag="en", # otimo exemplo: "https://www.youtube.com/watch?v=j5v8D-alAKE"
                             removestopwords=TRUE,
                             stemm=FALSE,
                             unicas=FALSE)


  # criando a quantidade de palavras no original
  vector <- our_tokenizer(vector0)
  vector <- vector[!grepl("[0-9]", vector)]
  vector <- vector[!grepl(c(" |:|,"), vector)]
  vector <- vector[!grepl("\\;|\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|\\\\", vector)]
  vector <- vector[!grepl(" ", vector)]
  # vector <- vector[!grepl("^-", vector)]
  vector <- vector[!grepl("\"", vector)]
  # N <- c()                             # acho que não precisa mais, pq toquenizei na primeira linha
  # for(i in 1:length(vector)) {
  #   if(vector[i] == "") {
  #     N <- c(N,i)
  #   }
  # }
  # vector <- vector[-N]

  vector1 <- data.frame(words=vector)
  vector1 <- vector1 %>%
    group_by(words) %>%
    mutate(count_orig. = n())
  vector1 <- vector1[!grepl("^-$", vector1$words),]
  vector1 <- vector1[!grepl("^;$", vector1$words),]

  # criando a quantidade de palavras lemmatizadas
  vector_lem <- our_lemmatizer3(vector0, return = "first")
  vector_lem <- our_tokenizer(vector_lem)
  vector_lem <- vector_lem[!grepl("[0-9]", vector_lem)]
  vector_lem <- vector_lem[!grepl(c(" |:|,"), vector_lem)]
  vector_lem <- vector_lem[!grepl("\\;|\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|\\\\", vector_lem)]
  vector_lem <- vector_lem[!grepl(" ", vector_lem)]
  # vector_lem <- vector_lem[!grepl("^-", vector_lem)]
  vector_lem <- vector_lem[!grepl("\"", vector_lem)]

  vector1_lem <- data.frame(words=vector_lem)
  vector1_lem <- vector1_lem %>%
    group_by(words) %>%
    mutate(count_lemmat. = n())
  vector1_lem <- vector1_lem[!grepl("^-$", vector1_lem$words),]
  vector1_lem <- vector1_lem[!grepl("^;$", vector1_lem$words),]


  # reunindo as contagens e adicionando a diferença
  df0 <- cbind(vector1, vector1_lem)
  df <- unique(df0)
  colnames(df) <- c("orig.", "count_orig.", "lemma.", "count_lemmat.")
  df <- df %>% mutate(diff = count_lemmat.- count_orig.)


  # df <- df[order(-df$count_lemmat., -df$diff), ] # ordenando por 2 colunas
  df <- df[order(-df$count_orig.), ]

  df <- df[1:qntt,]  # extraindo apenas o mais importante
  print(df)


  graf <- ggplot(df, aes(x=count_orig., xend = count_lemmat., y = reorder(lemma., count_lemmat.) )) +
    geom_dumbbell(colour = "#a3c4dc",
                  colour_xend="#0e668b",
                  size=2.0,
                  dot_guide=T,
                  dot_guide_size=0.15,
                  dot_guide_colour="grey60"
    ) +
    labs(x = "n. most common original -> n. lemmatized words", y=" Lemmatized word") +
    scale_x_continuous(breaks=seq(from=min(df$count_orig.), to=max(df$count_lemmat.), by=2))


  return(graf)
}


# #metodo 2
# if(require(qdap) == F) install.packages("qdap"); require(qdap)
# x2 <- qdap::all_words(raj$dialogue, alphabetical = FALSE)




## RETORNO GRAFICO DE DISPERSÃO DE PALAVRAS DESEJADAS


#' dispers()
#'
#' função que recebe o vetor de palavras (legenda) e o vetor de palavras desejadas
#' e retorna a dispersao das palavras desejadas no vetor da legenda:
#' AINDA e' preciso conferir melhor se esta funcionando otratamento para nao encontrar palavras como substrings
#' E eu ja tentei usar ^ $ nos vetores de palavras mas nao funcionou
#' @param p é o vetor de palavras gerado por palavras_legenda( ,unicas=F)
#' @param desejadas e' a lista de palavras que se deseja ver como: LCtestcontentR::bodyparts
#'
dispers <- function(p,# é o vetor de palavras gerado por palavras_legenda( ,unicas=F)
                    desejadas #e' a lista de palavras que se deseja ver como: LCtestcontentR::bodyparts
) {
  p <- paste(p, collapse = " ")
  desej <- c()
  for(i in 1:length(desejadas)) {
    desej <- c(desej, paste0(" ", desejadas[i], " "))
  }
  graf <- with(data.frame(p), qdap::dispersion_plot(p, desej,
                                                    bg.color = "gray",  # cor do fundo,
                                                    color = "blue",
                                                    total.color = "white", # cor da dispers?o na linha de todas as palavras
                                                    horiz.color="grey20"))
  return(graf)
}

## exemplo de como rodar:
# z <- LCtestcontentR::dispers(p=LCtestcontentR::palavras_legenda(Insira_Link_do_Video_aqui,
#                                                                 language = "en-GB",
#                                                                 unicas=FALSE),
#                              desejadas=unique(LCtestcontentR::opposite))
# ATENÇÃO! a fauncao da erro quando tem palavra repetida na lista de desejadas




#
#
# #######################################################################################
# #######################################################################################
# # 6. tentando criar (1) dispersion index e (2) grafico de rug (Lexical Dispersion Plot)----
# #######################################################################################
# # https://lexically.net/downloads/version7/HTML/dispersion_in_wordlist.html
# # https://stats.stackexchange.com/questions/325549/how-to-measure-dispersion-in-word-frequency-data
# # https://www.mark-davies.info/articles/davies_43.pdf
# # https://www.researchgate.net/publication/332120488_Analyzing_dispersion
#
#
# ## 1. minha tentativa
# # inserindo o texxto de teste
# v <- c("Trump called, relaxing the restrictions his biggest decision as federal projections warn of a
#            possible infection spike. As new federal projections warned of a spike in coronavirus infections
#            if shelter-in-place orders were lifted after only 30 days, President Trump said Friday that the
#            question of when to relax federal social distancing guidelines was the biggest decision I'll ever
#            make. As a practical matter, the stay-at-home orders that have kept much of the nation hunkered
#            down have been made by governors and mayors at the state and local levels. But many governors were moved to act in part by the federal guidelines meant to slow the spread
#            of the coronavirus. Mr. Trump, who has often sounded impatient for the nation - and particularly
#            its economy - to reopen, said that he would listen to the advice of the medical experts
#            before acting, but also said that he would convene a new task force with business leaders on it
#            next week to think about when to act. At a news briefing at the White House on Friday. I have a problem the the the the the the the")
#
#
# # tokenizando o texto
# if(require(tm) == F) install.packages("tm"); require(tm)
# v <- removePunctuation(v)
# # 2 formas de tokenizar
# if(require(tau) == F) install.packages("tau"); require(tau)
# v_token <- tokenize(v) # for a simple regular expression based tokenizer provided by package tau. Obs: (1) Esse tokenizador considera os espacos e pontuacao como tokens; (2) mantem "character's"como token unico
# v_token1 <- strsplit(v, " ")[[1]] # outro tokenizador
#
#
# # inserindo o vetor com o que interessa ser detectado no texto
# matches <- c("the", "as", "to")
#
# # gerando o vetor T/F e convertendo em 0/1
# x <- v_token1 %in% matches
# x <- as.numeric(x)
#
# # x <- rbinom(100, size=1, prob=0.3) # caso queira um vetor 0/1 pronto para teste
#
# z <- data.frame(x)# convertendo o vetor em data.frame
#
# # plotando o "rug graph"
# ggplot(z, aes(c(1:length(x)),x))+
#    geom_point(shape="|",
#               size=5,
#               stroke = 10
#    ) + ylim(c(1, 1))
#
# sd(x)
#
#
#
# ## 2.  usando o pacote 'qdap'
# # link: https://educationalresearchtechniques.com/2017/08/09/diversity-and-lexical-dispersion-analysis-in-r/
# # outro link: https://www.rdocumentation.org/packages/qdap/versions/2.4.3/topics/dispersion_plot
#
# if(require(qdap) == F) install.packages("qdap"); require(qdap)
# v_token1 <- data.frame(v_token1) # nesse pacote, o vetor->DF utilizado deve conter as palavras
#
# div<-diversity(v_token1$v_token1)  # Aqui se obtem os ?ndices de dispers?o: ? possivel colocar vai de um vetor (de textos) para comparar os textos
#
# dispersion_plot(v_token1$v_token1, matches) # aqui se visualiza a dispers?o: tamb?m ? possivel colocar mais de um vetor para comparar textos
#
#
#
# ## 3. Outra tentativa de Lexical Dispersion Plot
# # ver no ?ltimo 1/4 do link: http://trinker.github.io/qdap/vignettes/qdap_vignette.html
#
# term_match(raj$dialogue, c(" love ", "love", " night ", "night"))
#
# with(rajSPLIT , dispersion_plot(dialogue,       # coluna do DF onde buscar o match
#                                 c("love"),      # termo a ser identificado
#                                 grouping.var = list(fam.aff, sex), # variavel para criar as linhas
#                                 rm.vars = act)) # variavel para separar "as caixas"
# # mudando o esquema de cores
# with(rajSPLIT, dispersion_plot(dialogue, c("love", "night"),
#                                bg.color = "black",  # cor do fundo
#                                grouping.var = list(fam.aff, sex),
#                                color = "yellow",
#                                total.color = "white", # cor da dispers?o na linha de todas as palavras
#                                horiz.color="grey20"))
#
# # buscando a dispers?o lexical das palavras mais frequentes retirando as stopwords
# wrds <- freq_terms(pres_debates2012$dialogue, stopwords = Top200Words) #frequencia retirando as stopwords
# wrds2 <- spaste(wrds) # Adicionando espa?os (ver: leading/trailing), caso necessario
# # wrds2 <- c(" governor~~romney ", wrds2[-c(3, 12)]) # selecionando lista para buscar n texto : Use `~~` to maintain spaces
# with(pres_debates2012 , dispersion_plot(dialogue,
#                                         wrds2$WORD[1:10],
#                                         # rm.vars = time,
#                                         color="blue", bg.color="grey", horiz.color="grey20"))
