

##################################
### (1) testando e executando o exercicio de sinonimos


# example <- "https://www.youtube.com/watch?v=4GsjEPRMzdw" # easy
# example <- "https://www.youtube.com/watch?v=LsFdROZ2OdA" # difficult
# Legendas <- youtubecaption::get_caption(url = example,
#                                         language = "en",  # ATENCAO PARA A ESCOLHA DA LEGENDA
#                                         savexl = FALSE, openxl = FALSE, path = getwd())
#
# Legendas_selec <- Legendas$text[20:140]
# LegendasU <- paste(Legendas_selec, collapse= " ")
# LegendasU
#
# LL <- our_tokenizer(LegendasU)
# LL
#
# testdata_Level <- LL
#
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # load(file="testdata_Level.RData")
# # load(file="Syn.1.0.Rdata")
# # testdata_Level <- testdata_Level[["easy"]]
# # testdata_Level <- testdata_Level[["difficult"]]
#
#
# # ajustes para facilitar o trabalho
# testdata_Level <- testdata_Level#[1:220]
# convert <- testdata_Level
#
# # separo os elementos com pontuação
# convert1 <- convert[!grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert)] # nao remover nem - nem ' nem ’
# pontuacao <- convert[grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert)]
# posit_pontuacao <- grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert) #
# posit_NA <- is.na(convert1)
# convert1 <- convert1[!is.na(convert1)]
#
#
#
# convert2 <- convert1
# vazio <- c()
# print("Checando sinônimos")
# for(i in 1:length(convert1)) {
#   x <- convert1[[i]]
#   n <- grep(paste0("^", x, "$"), Syn_organized$B.word_dif)
#   if(is_empty(n)) {
#     vazio <- c(vazio, i)
#     w <- x
#     } else {
#     z <- paste(Syn_organized$Syn_easy[n], collapse = " / ")
#     w <- paste(x, " (", z, ")", sep = "")
#     convert2[i] <- w
#   }
# }
# rm("w", "x", "z", "n", "i")
# # convert2
#
# print("Checando sinônimos dos lemmas")
# #vazio1 <- c()
# for(i in vazio) {
#   x <- our_lemmatizer2(convert2[i], lemmasDF.2.1)[[1]]
#   n <- grep(paste0("^",x, "$"), Syn_organized$B.word_dif)
#   if(is_empty(n)) {
#     #vazio1 <- c(vazio1, i)
#     w <- x
#   } else {
#     z <- paste(Syn_organized$Syn_easy[n], collapse = " / ")
#     w <- paste(convert2[i], " (", z, ")", sep = "")
#     convert2[[i]] <- w
#   }
# }
# rm("w", "x", "z", "n", "i")
#
#
# print("recriando a pontuação")
# final <- rep(NA, length(convert))
# p <- 1
# c <- 1
# for(i in 1:length(final)) {
#   if(posit_pontuacao[i] == T) {
#     final[i] <- pontuacao[p]
#     p <- p+1
#   } else {
#     final[i] <- convert2[c]
#     c <- c+1
#   }
# }
# rm("p", "c", "i")
#
#
# Legendas_selec
# paste(convert, collapse = "", sep = "")
# convert
# paste(final, collapse = "", sep = "")

############## ----









##################################
### (2) testando e executando o exercicio de Antonimos


# example <- "https://www.youtube.com/watch?v=4GsjEPRMzdw" # easy
# example <- "https://www.youtube.com/watch?v=LsFdROZ2OdA" # difficult
# Legendas <- youtubecaption::get_caption(url = example,
#                                         language = "en",  # ATENCAO PARA A ESCOLHA DA LEGENDA
#                                         savexl = FALSE, openxl = FALSE, path = getwd())
#
# Legendas_selec <- Legendas$text[20:60]
# LegendasU <- paste(Legendas_selec, collapse= " ")
# LegendasU
#
# LL <- our_tokenizer(LegendasU)
# LL
#
# testdata_Level <- LL
#
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # load(file="testdata_Level.RData")
# # load(file="Antony.1.0.Rdata")
# # testdata_Level <- testdata_Level[["easy"]]
# # testdata_Level <- testdata_Level[["difficult"]]
#
#
# # ajustes para facilitar o trabalho
# testdata_Level <- testdata_Level
# convert <- testdata_Level
#
# # separo os elementos com pontuação
# convert1 <- convert[!grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert)] # nao remover nem - nem ' nem ’
# pontuacao <- convert[grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert)]
# posit_pontuacao <- grepl(" |\\,|\\.|\\?|\\!|\\%|\\(|\\)|\\]|\\[|\\:|<|>", convert) #
# posit_NA <- is.na(convert1)
# convert1 <- convert1[!is.na(convert1)]
#
#
#
# convert2 <- convert1
# vazio <- c()
# print("Checando sinônimos")
# for(i in 1:length(convert1)) {
#   x <- convert1[[i]]
#   n <- grep(paste0("^", x, "$"), Ant_organized$B.word_dif)
#   if(is_empty(n)) {
#     vazio <- c(vazio, i)
#     w <- x
#     } else {
#     z <- paste(Ant_organized$Ant_easy[n], collapse = " / ")
#     w <- paste(x, " (", z, ")", sep = "")
#     convert2[i] <- w
#   }
# }
# rm("w", "x", "z", "n", "i")
# # convert2
#
# print("Checando sinônimos dos lemmas")
# #vazio1 <- c()
# for(i in vazio) {
#   x <- our_lemmatizer2(convert2[i], lemmasDF.2.2)[[1]]
#   n <- grep(paste0("^",x, "$"), Ant_organized$B.word_dif)
#   if(is_empty(n)) {
#     #vazio1 <- c(vazio1, i)
#     w <- x
#   } else {
#     z <- paste(Ant_organized$Ant_easy[n], collapse = " / ")
#     w <- paste(convert2[i], " (", z, ")", sep = "")
#     convert2[[i]] <- w
#   }
# }
# rm("w", "x", "z", "n", "i")
#
#
# print("recriando a pontuação")
# final <- rep(NA, length(convert))
# p <- 1
# c <- 1
# for(i in 1:length(final)) {
#   if(posit_pontuacao[i] == T) {
#     final[i] <- pontuacao[p]
#     p <- p+1
#   } else {
#     final[i] <- convert2[c]
#     c <- c+1
#   }
# }
# rm("p", "c", "i")
#
#
# Legendas_selec
# paste(convert, collapse = "", sep = "")
# convert
# paste(final, collapse = "", sep = "")


































