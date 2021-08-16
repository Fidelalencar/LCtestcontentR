
###################################################
############# FUNCOES DE LEMMATIZACAO #############
### (essa é a versão2 .  a versão 1 já apaguei)


our_lemmatizer2 <- function(words, base=lemmasDF.2.0, return="all") {

  words <- words[!grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:", words)] # nao remover nem - nem ' nem ’
  words <- words[!grepl("<|>", words)]
  lemmed <- c()
  for(i in 1:length(words)) {
    np <- words[i]
    n <- grep(paste0("^", np, "$"), base$words)

    if(length(n) > 1 & return == "first") {  # caso a lista tenha mais de uma palavra na primeira coluna e eu precise só de uma
      n <- n[1]
    }

    #print(paste0("palavra na base : ", np, "-> ", "index das palavras: ", i))
    if(length(n) == 0) {
      n <- np
    } else {
      n <- base$lemmas[n]
    }
    lemmed <- c(lemmed, n)
  }
  # selecionando apensa os valores que nao terminam com espaco
  lemmed <- grep("[^ ]$", lemmed, value = T)
  return(lemmed)
}


non_lemmatized2 <- function(words, base=lemmasDF.2.0, return="all") {
  non_lemmatized <- c()
  words <- words[!grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:", words)] # nao remover nem - nem ' em ’
  words <- words[!grepl("<|>", words)]
  words <- unique(words)
  for(i in 1:length(words)) {
    np <- words[i]
    # np <- words[i]
    n <- grep(paste0("^",np, "$"), base$words)
    # print(paste0("palavra na base : ", n, "-> ", "index das palavras: ", i))
    # print(length(n))
    # print(length(n)== 0)
    if(length(n) == 0) {
      w <- words[i]
      non_lemmatized <- c(non_lemmatized, w)
    }
  }
  S <- tm::stopwords(kind = "en")
  non_lemmatized <- non_lemmatized[!non_lemmatized %in% S]
  # selecionando apensa os valores que nao terminam com espaco
  # non_lemmatized <- grep("[^ ]$", non_lemmatized, value = T)
  return(non_lemmatized)
}



our_lemmatizer3 <- function(text, base=lemmasDF.2.0, return="first"){
  final <- text
  text_tok <- our_tokenizer(text)
  text_lem <- our_lemmatizer2(text_tok, base=base, return=return)
  #
  posit_pontuacao <- grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", text_tok) #
  pontuacao <- text_tok[grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", text_tok)]
  final <- rep(NA, length(text_tok)) # recriando a pontuação
  p <- 1
  c <- 1
  for(e in 1:length(final)) {
    if(posit_pontuacao[e] == T) {
      final[e] <- pontuacao[p]
      p <- p+1
    } else {
      final[e] <- text_lem[c]
      c <- c+1
    }
  }
  #print(paste(final, collapse=""))
  z <- paste(final, collapse="")
  return(z)
}





####################################################################################################
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





