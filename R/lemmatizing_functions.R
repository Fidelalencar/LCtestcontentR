
###################################################
############# FUNCOES DE LEMMATIZACAO #############

#### CRIANDO NOSSO LEMMATIZADOR
# fazendo uma funçaõ que faz o lemmatization usando humspell mas adaptando para
# repetir as palavras sem lemma no dict deles.

if(require(hunspell) == F) install.packages("hunspell"); require(hunspell)

our_lemmatizer <- function(words) {
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
  return(words_lemma)
}




#### CRIANDO FUNÇÃO QUE RETORNA infos sobre o que o algoritmo não consegue lemmatizar

non_lemmatized <- function(words, logico=FALSE) {
  words_lemma <- hunspell_stem(words)
  # aqui eu substituo os elementos vazios (length=0, pois não encontrou lemma) pela palavra referente do texto
  lemma <- rep(NA, length(words_lemma)) #cria vetor com mesma dimensão do vetor de palavras com o valor logico se houve ou não lemma
  for (i in 1:length(words_lemma)) {
    if(length(words_lemma[[i]]) == 0) {
      lemma[i] <- TRUE
      words_lemma[[i]] <- words[i]
    } else {
      lemma[i] <- FALSE
    }
  }
  if(logico==TRUE) {
    return(lemma) # se o parametro logico=T, retorna o vetor logico sobre onde houve lemmatizacao
  } else {
    return(subset(words_lemma, subset = lemma)) # se o parametro logico=F, retorna a lista de palavras
  }
}



#### criando funcao que converte lista em DF (os elementos vetores da lista, teem
#seu 1o subelemento considerado)

conv_lista_DF <- function(lista) {
  DF <- data.frame(rep(NA, length(lista)))
  for(i in 1:length(lista)) {
    if(length(lista[[i]]) > 1) {
      DF[i,] <- lista[[i]][1]
    } else {
      DF[i,] <- lista[i]
    }
  }
  colnames(DF)[1] <- "first_words"
  return(DF)
}




# # para rodar as funcoes de lemmatizacao
# Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=2W85Dwxx218"
# words <- palavras_legenda(Insira_Link_do_Video_aqui,language="en",removestopwords=FALSE,
#                           stemm=FALSE,unicas=FALSE)
#


