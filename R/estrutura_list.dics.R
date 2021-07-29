
# #################################################
# ########### Scripts para organizar as planilhas de listas de palavras do Drive:
# #################################################


####################################################################################
##### (1) Corrigindo a lista de lemmatização ----



# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("lemmas_82thousandDF.RData")
#
#
# lemmas_82thousandDF$lemma <- sub("^directed$", 'direct', lemmas_82thousandDF$lemma)
# lemmas_82thousandDF$lemma <- sub("^lasted", 'last', lemmas_82thousandDF$lemma)
# lemmas_82thousandDF$lemma <- sub("^fined$", 'fine', lemmas_82thousandDF$lemma)
# lemmas_82thousandDF$lemma <- sub("^senses$", 'sense', lemmas_82thousandDF$lemma)
#
# n <- grep("^closed$", lemmas_82thousandDF$words)
# lemmas_82thousandDF$lemma[n] <- "close"
# n <- grep("^closes$", lemmas_82thousandDF$words)
# lemmas_82thousandDF$lemma[n] <- "close"
# n <- grep("^closing$", lemmas_82thousandDF$words)
# lemmas_82thousandDF$lemma[n] <- "close"
#
# lemmasDF.1.0 <- lemmas_82thousandDF
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# save(lemmasDF.1.0, file="lemmasDF.1.0.RData") ## <- NÃO SALVEI AINDA


#############################




####### (1.1) ########## LEMMATIZADOR UM SEGUNDO LEMATIZADOR (menor)


# lemmat_menor_bruto <-read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/lemmatizador_menor/Tratamento Informação - Sheet10.csv",
#                                sep = ",",
#                                header = F)
#
# lemmat_menor_bruto <- lemmat_menor_bruto[c(1,2,3,4,5,6)]
# colnames(lemmat_menor_bruto) <- lemmat_menor_bruto[3,]
# lemmat_menor_bruto <- lemmat_menor_bruto[-c(1, 2,3),]
# colnames(lemmat_menor_bruto) <- c("Base.form", "pos", "variations", "Freq", "Ra", "Disp")
# lemmat_menor_bruto[8598,] <- c("instead", "Prep", ":", "72", "100", "0.97")
#
#
#
# for(i in 1:length(lemmat_menor_bruto$Base.form)) {
#   if(lemmat_menor_bruto$Base.form[i] == "@") {
#     lemmat_menor_bruto$Base.form[i] <- NA
#   }
# }
# for(i in 1:length(lemmat_menor_bruto$Base.form)-1) {
#   if(is.na(lemmat_menor_bruto$Base.form[i+1])) {
#     lemmat_menor_bruto$Base.form[i+1] <- lemmat_menor_bruto$Base.form[i]
#   }
# }
#
#
# for(i in 1:length(lemmat_menor_bruto$pos)) {
#   if(lemmat_menor_bruto$pos[i] == "@") {
#     lemmat_menor_bruto$pos[i] <- NA
#   }
# }
# for(i in 1:length(lemmat_menor_bruto$pos)-1) {
#   if(is.na(lemmat_menor_bruto$pos[i+1])) {
#     lemmat_menor_bruto$pos[i+1] <- lemmat_menor_bruto$pos[i]
#   }
# }
#
# lemmat_menor_bruto <- lemmat_menor_bruto[-grep("%", lemmat_menor_bruto$variations),]
#
# for(i in 1:length(lemmat_menor_bruto$variations)) {
#   if(lemmat_menor_bruto$variations[i] == ":") {
#     lemmat_menor_bruto$variations[i] <- lemmat_menor_bruto$Base.form[i]
#   }
# }
#
#
#
# grep("", lemmat_menor_bruto$Base.form)
#
#
# is_empty(lemmat_menor_bruto$Base.form[3])

##########################################




####### (1.2) ########## LEMMATIZADOR do OpenNLP

# # https://raw.githubusercontent.com/richardwilly98/elasticsearch-opennlp-auto-tagging/master/src/main/resources/models/en-lemmatizer.dict
#
# lemmat300m <-read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/lemmat.opennlp.csv",
#                                sep = ";",
#                                header = F)
#
# colnames(lemmat300m) <- c("words", "pos", "lemma")
# lemmat300m$words <- str_to_lower(lemmat300m$words)
# lemmat300m$pos <- str_to_lower(lemmat300m$pos)
# lemmat300m$lemma <- str_to_lower(lemmat300m$lemma)
# lemmat300m$words <- as.factor(lemmat300m$words)
# lemmat300m$pos <- as.factor(lemmat300m$pos)
# lemmat300m$lemma <- as.factor(lemmat300m$lemma)

# # tem 168376 lemmas unicos e 259576 words unicas
# table(lemmat300m$pos) # tem 33 pos
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # #   save(lemmat300m, file="lemmat300m.1.0.Rdata")



# CC	  Coordinating conjunction	          and, or, but
# CD	  Cardinal number	                    one, two, three
# DT	  Determiner	                        a, the
# EX	  Existential                         there	There/EX was a party in progress
# FW	  Foreign word	                      persona/FW non/FW grata/FW
# IN	  Preposition or subordinating con	  uh, well, yes
# JJ	  Adjective	                          good, bad, ugly
# JJR	  Adjective, comparative	            better, nicer
# JJS	  Adjective, superlative	            best, nicest
# LS	  List item marker	                  a., b., 1., 2.
# MD	  Modal	                              can, would, will
# NN	  Noun, singular or mass	            tree, chair
# NNS	  Noun, plural	                      trees, chairs
# NNP	  Proper noun, singular	              John, Paul, CIA
# NNPS	Proper noun, plural	                Johns, Pauls, CIAs
# PDT	  Predeterminer	                      all/PDT this marble, many/PDT a soul
# POS	  Possessive ending	                  John/NNP 's/POS, the parentss/NNP '/POS distress
# PRP	  Personal pronoun	                  I, you, he
# PRP$	Possessive pronoun	                mine, yours
# RB	  Adverb	                            evry, enough, not
# RBR	  Adverb, comparative	                later
# RBS	  Adverb, superlative	                latest
# RP	  Particle	                          RP
# SYM	  Symbol	                            CO2
# TO	  to	                                to
# UH	  Interjection	                      uhm, uh
# VB	  Verb, base form	                    go, walk
# VBD	  Verb, past tense	                  walked, saw
# VBG	  Verb, gerund or present particip	  walking, seeing
# VBN	  Verb, past participle	              walked, thought
# VBP	  Verb, non-3rd person singular pr  	walk, think
# VBZ	  Verb, 3rd person singular presen	  walks, thinks
# WDT	  Wh-determiner	                      which, that
# WP	  Wh-pronoun	                        what, who, whom (wh-pronoun)
# WP$	  Possessive                          wh-pronoun	whose, who (wh-words)
# WRB	  Wh-adverb	                          how, where, why (wh-adverb)


#############################








##########################################
##########################################
############ RESOUCES_DATA
##########################################
#
# if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
# if(require(xlsx) == F) install.packages("xlsx"); require(xlsx)

##########################################
# ##### (2) Organizando as listas de Tratamento da Informação ----
# # elas sao compostas de 6 listas. Sendo 2 delas a velha lista de 5000 palavras de davis&gardner em 2 versões
# # nas versoes saidas do livro e da internet.
##########################################
# #
# # Sheet1
# trat_infoS1 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet1.csv",
#             sep = ",",
#             header = T)
# trat_infoS1 <- trat_infoS1[c(1:5)]
#
# #Sheet3
# trat_infoS3 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet3.csv",
#             sep = ",",
#             header = F)
# trat_infoS3 <- trat_infoS3[c(1,2,3,4)]
# colnames(trat_infoS3) <- trat_infoS3[3,]
# trat_infoS3 <- trat_infoS3[-c(1, 2,3),]
#
# #Sheet4
# trat_infoS4 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet4.csv",
#             sep = ",",
#             header = T)
# colnames(trat_infoS4) <- trat_infoS4[2,]
# trat_infoS4 <- trat_infoS4[-c(1, 2),]
#
# #Sheet5
# trat_infoS5 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet5.csv",
#             sep = ",",
#             header = T)
#
# #Sheet6  (Davies&Gardner do livro)
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# FiveT <- read.csv2("5000_freq_dic_Davies&gardner.csv", sep = ";",  header = F)
# trat_infoS6 <- FiveT
# # adicional do sheet 6 (Davies&Gardner da internet)
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# FiveThouMostFreq <- read.csv2("5000MostFreqWords.csv", sep = ";",  header = T)
#
#
# ### (a) unindo as sheets 1, 3 e 5 (são as sheets mais completas)
# s1 <- trat_infoS1[c(1,3,4)]
# s3 <- trat_infoS3[c(1,3,4)]
# s5 <- trat_infoS5[c(1,4,2)]
# colnames(s5) <- colnames(s1)
# colnames(s3) <- colnames(s1)
#
# table(s1$Level, exclude = NULL)
# table(s1$Part.of.Speech, exclude = NULL)
# table(s3$Level, exclude = NULL)
# table(s3$Part.of.Speech, exclude = NULL)
# table(s5$Level, exclude = NULL)
# table(s5$Part.of.Speech, exclude = NULL)
#
# s1 <- unique(s1)
# s3 <- unique(s3)
# s5 <- unique(s5)
#
# S15 <- rbind(s1,s5)
# S15 <- unique(S15)
#
# a <- s3$Base.Word[!(s3$Base.Word %in% S15$Base.Word)]
# log <- !(s3$Base.Word %in% S15$Base.Word)
# a <- s3[log,]
#
# S135 <- rbind(S15,a)
#
# table(S135$Part.of.Speech, exclude= NULL)
#
# S135$Part.of.Speech <- gsub("verb, noun", "noun, verb", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("verb noun", "noun, verb", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("noun verb",  "noun, verb", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("noun adjective", "adjective, noun", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("adjective noun", "adjective, noun", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("noun, adjective", "adjective, noun", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("adverb, adjective", "adjective, adverb", S135$Part.of.Speech)
# S135$Part.of.Speech <- gsub("preposition, adverb","adverb, preposition", S135$Part.of.Speech)
#
# S135 <- unique(S135)   #
#
# S135$Base.Word <- str_to_lower(S135$Base.Word)
#
#
# table(S135$Level, exclude = NULL)
# table(S135$Part.of.Speech, exclude = NULL)
#
# rm("a", "log", "S15", "FiveT", "s1", "s3", "s5", "trat_infoS1", "trat_infoS3", "trat_infoS5")
#
# # S135$Base.Word <- as.factor(S135$Base.Word)
# # S135count <- S135 %>%
# #   group_by(Base.Word) %>%
# #   summarise(Count = n())
# # S135count <- right_join(S135, S135count, "Base.Word")
# # S135count.maisq1 <- S135count %>% filter(S135count$Count > 1)
#
#
# ### (b) investigando as 2 listas de 5000 Davies&Gardner (Sheet 6) (menos completas)
# # O sheet 6 é a convergencia da lista das 5 mil de davies e gardner (fontes livro e internet)
#
# trat_infoS6 <- trat_infoS6[c(1,2,3)]
# FiveThouMostFreq <- FiveThouMostFreq[c(2,3, 1)]
# colnames(trat_infoS6) <- colnames(FiveThouMostFreq)
# S6 <- rbind(trat_infoS6, FiveThouMostFreq)
# S6$Word <- str_trim(S6$Word)
#
# S6copia <- S6[c(1,2)]
# S6copia <- unique(S6copia)
# S6 <- S6[row.names(S6copia),]
# S6 <- S6[order(S6$Word),]
# row.names(S6) <- c(1:length(S6$Word))
# S6$Word <- str_to_lower(S6$Word)
# a <- S6[!(S6$Word %in% S135$Base.Word),]
# a <- a[order(a$Word),]
# a$Level <- NA
# # write.csv(a, "lista270.csv")  # Arquivo para colocar Level das palavras
#
#
# ## (c) investigando a sheet 4
#
# s4 <- trat_infoS4[c(1,4,2)]
# s4 <- s4[order(s4$Word),]
# row.names(s4) <- c(1:length(s4$Word))
# s4$Word <- str_to_lower(s4$Word)
# b <- s4[!(s4$Word %in% S135$Base.Word),]
# b <- b[order(b$Word),]
# b$Level <- NA
#
# # write.csv(b, "lista13.csv")
# # essa lista tb foi enviada a thiago para ele colocar o level das palavras
#
#
# ### (d) unindo tudo : listas  S135 , lista270 e lista13
# # o tratamento manual das duas listas remanescentes  (lista270 e lista13)
# # está disponível na sheet 9 do mesmo documento (Tratamento da informacao)
#
# trat_infoS9 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet9.csv",
#             sep = ",",
#             header = T)
#
# colnames(trat_infoS9) <- trat_infoS9[1,]
# trat_infoS9 <- trat_infoS9[-1,]
#
# trat_infoS9$Word <- gsub("â€™", "'", trat_infoS9$Word)
# trat_infoS9$Word <- str_to_lower(trat_infoS9$Word)
#
# trat_infoS9 <- trat_infoS9[c(1,3,2)]
#
# colnames(trat_infoS9) <- colnames(S135)
# trat.Info.1.0 <- rbind(S135, trat_infoS9)
# trat.Info.1.0$Base.Word <- str_to_lower(trat.Info.1.0$Base.Word)
#
# trat.Info.1.0 <- unique(trat.Info.1.0) # LISTA DE TRATAMENTO DA INFORMACAO PRONTA
#
# # pequena limpeza final
# trat.Info.1.0$Base.Word <- gsub("!","", trat.Info.1.0$Base.Word)  # limpando registros com exclamação
# x <- trat.Info.1.0[grepl("!", trat.Info.1.0$Base.Word),]
# x <- trat.Info.1.0[grepl("\\.", trat.Info.1.0$Base.Word),] # nao vamos limpar os pontos
# trat.Info.1.0 <- trat.Info.1.0[!grepl("\\,", trat.Info.1.0$Base.Word),] # removendo o único registro com virgula, pois é um erro
#
#
# # # caso queira dobrar as palavras com hifem ... talvevz queira tirar elas
# # comhifem <- trat.Info.1.0[grepl("\\-", trat.Info.1.0$Base.Word),]
#
# # # caso queira dobrar as palavras com espaco ... talvevz queira tirar elas
# # comespaco <- trat.Info.1.0[grepl(" ", trat.Info.1.0$Base.Word),]
#
# rm("a", "b", "x", "FiveThouMostFreq", "s4", "S6", "S6copia", "trat_infoS4", "trat_infoS6", "trat_infoS9", "S135")
# trat.Info.1.0 <- trat.Info.1.0[-grep("whoever p", trat.Info.1.0$Base.Word),]

# n <- grep("^reort$", trat.Info.1.0$Base.Word)
# trat.Info.1.0$Base.Word[n] <- "report"
# trat.Info.1.0 # Dados concluidos

# trat.Info.1.0_BIgrams <- trat.Info.1.0[grep(".* .*", trat.Info.1.0$Base),]    ############ PARA  A LISTA DE BIGRAMAS!!!!

# trat.Info.1.0 <- trat.Info.1.0[-grep(".* .*", trat.Info.1.0$Base),]

# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# save(trat.Info.1.0, file="trat.Info.1.0.RData")
#
# load(file="trat.Info.1.0.RData")



######################## AREA DE TABALHO ############################################

# para melhorar a lista com niveis, é preciso melhorar:
# (1) eixo limpeza do texto
# - stop words OK
#       - adicionar contrações aos stop words
# (2) Eixo melhora da lista com niveis
# - plurais
# - formas do verbo
# - contrações

######################################################################################



############## ----



##########################################
##### (3) Listas - pequenos aprimoramentos ----



############## ----
#### (3.1) aprimoramento dos verbos....

# finais -s da terceira do singular
# finais -ing do gerundio
# finais -ed do passado/participio


## <------------------------------------- ver script "estrutura_list.dics2"

############## ----


######################## AREA DE TABALHO ###############################################
#### (3.2) plurais ----

# if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
# if(require(RecordLinkage) == F) install.packages("RecordLinkage"); require(RecordLinkage)

# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("lemmas_82thousandDF.RData")
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="trat.Info.1.0.RData")
#

###########################
## # Serão feitos 3 procedicentos: (substitutions=2)
## car -> cars                "s"   ( dist = 1)   -> 24306 lemmas terminados com s    Mdist = 125 milhoes
## movie -> movies  * pega no "s"   ( dist = 1)
## bus -> buses               "es"  ( dist = 2)   -> 7574  lemmas terminados com es   Mdist = 38.9 milhoes
## family -> families         "ies" ( dist = 4)   -> 1491  lemmas terminados com ies  Mdist =  7.7 milhoes
## irregulares                  Lista a parte
##########################


# # # criando lista lematizadora com words terminados em s
# lemmas_82thousandDF <- lemmas_82thousandDF[lemmas_82thousandDF$lemma!=lemmas_82thousandDF$words,]
# index.words.s <- grep(".*ie[s]$", lemmas_82thousandDF$word)
# Lemmas.final.s <- lemmas_82thousandDF[index.words.s,]
# rm("index.words.s")
#


# # # selecionando os substantivos da lista de niveis
# trat.Info.1.0_nouns1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun")
# trat.Info.1.0_nouns2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun, verb")
# trat.Info.1.0_nouns3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb, noun, verb")
# trat.Info.1.0_nouns4 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun, pronoun, determiner")
# trat.Info.1.0_nouns5 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun, adverb")
# trat.Info.1.0_nouns6 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun")
# trat.Info.1.0_nouns <- rbind(trat.Info.1.0_nouns1, trat.Info.1.0_nouns2, trat.Info.1.0_nouns3,
#                              trat.Info.1.0_nouns4, trat.Info.1.0_nouns5, trat.Info.1.0_nouns6)
# rm("trat.Info.1.0_nouns1", "trat.Info.1.0_nouns2", "trat.Info.1.0_nouns3",
#       "trat.Info.1.0_nouns4", "trat.Info.1.0_nouns5", "trat.Info.1.0_nouns6")


# # # Aqui o procedimento é feito 3 vezes para os 3 processos ... (não é reprodutivel como está abaixo)
# como dito, cada procedimento tem ajustes especificos
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
#
#  (1) matrix ies               (2)   matrix  es
#  load("Mdist.IES.Rdata")    # load("Mdist.ES.Rdata")
#  Mdist <- Mdist.IES         # Mdist <- Mdist.ES
#
#  (3) não salvei a matriz. tenho apenas o resultado
# plural.S <- read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals.csv",
#                      sep = ",",
#                      header = T)
# DFplurals.S <- plural.S[c(2,3)]
# rm("plural.S")
# colnames(DFplural.S) <- c("plurals.f.lemma", "Base.Word")
#


# # # criando matrix com distancias de levenshtein entre as palavras
# i=1
# Mdist <- matrix(nrow = length(Lemmas.final.s$words), ncol = length(trat.Info.1.0_nouns$Base.Word))
# for(i in 1:length(Lemmas.final.s$words)) {
#   e=1
#   for(e in 1:length(trat.Info.1.0_nouns$Base.Word)){
#     d <- adist(Lemmas.final.s$words[i], trat.Info.1.0_nouns$Base.Word[e],
#                costs=list(substitutions=2),
#                useBytes=F)   #   ?????
#     Mdist[i,e] <- d
#     e = e+1
#   }
#   i=i+1
# }
# rm("d", "e")
# table(Mdist)
#


# # # selecionando as distancias desejadas
# plurals <- which(Mdist == 4, arr.ind = T)
#
# # # observando os resultados desejados
# i=1
# DFplurals <- data.frame()
# while(i <= dim(plurals)[[1]]) {
#   da <- as.numeric(plurals[i,1])
#   db <- as.numeric(plurals[i,2])
#   DFplurals[i, 1] <- Lemmas.final.s$words[[da]]
#   DFplurals[i, 2] <- trat.Info.1.0_nouns$Base.Word[[db]]
#   i=i+1
# }
# rm("i")
# colnames(DFplurals) <- c("lemmas_final.s", "trat.Info.1.0_nouns")
#


# # # Removendo palavras do lemma que sejam mais curtas que a paalvra base, ou dela desconectadas
# i=1
# L <- c()
# DFplurals <- data.frame(lapply(DFplurals, as.character), stringsAsFactors=FALSE)
# while(i <= dim(DFplurals)[1]) {
#   a <- DFplurals$lemmas_final.s[i]
#   b <- DFplurals$trat.Info.1.0_nouns[i]
#   # ca3 <- str_sub(a, 1, 3)
#   # cb3 <- str_sub(b, 1, 3)
#   ca2 <- str_sub(a, 1, 3)
#   cb2 <- str_sub(b, 1, 3)
#   na <- nchar(a)
#   nb <- nchar(b)
#
#   if((ca2 == cb2) & (na > nb) & (na < (nb+3))) {
#      l <- TRUE
#   } else {
#      l <- FALSE
#   }
#
#   print(l)
#   L <- c(L, l)
#   i = i+1
#   }
# DFplurals1 <- DFplurals[L,]
# colnames(DFplurals1) <- c("plurals.f.lemma", "Base.Word")



# # # Unindo as 3 bases

# # ... PROCEDIMENTOS NÃO ANOTADOS

# # unindo as palavras encontradas à base com levels ('xxx' para cada uma das 3 bases de resultado)
# trat..plurals <- right_join(trat.Info.1.0_nouns, xxx, by="Base.Word")
# trat..plurals_xxx <- trat..plurals

# # ... MAIS PROCEDIMENTOS NÃO ANOTADOS

# # contando os registros de palavras repetidas, pois as repetidas devem ser analisadas manualmente
# PLURALS <- rbind(xxx1, xxx2, xxx3)
# PLURALS <- unique(PLURALS)
# PLURALS$Base.Word <- as.factor(PLURALS$Base.Word)
#
# count <- PLURALS %>% group_by(Base.Word) %>%        # contando a qntdd de palavras
#           summarise(COUNT.Base.Word = length(Base.Word))
#
# PLURALS <- full_join(PLURALS, count, by="Base.Word")


# # Separando as que tem repetição das que nao tem
# PLURALSOK <- PLURALS[PLURALS$COUNT.Base.Word==1,]
# PLURALSCONFERIR <- PLURALS[PLURALS$COUNT.Base.Word>1,]
#
# write.csv(PLURALSOK, file="PLURALSOK.csv")
# write.csv(PLURALSCONFERIR, file="PLURALSCONFERIR.csv")

# # ... ENTREGUE PARA ANALISE MANUAL


# # # Convergimos os 3 resultados : plurais_ok ; plurais_conferir ; plurais_irregulares
#
#
# plurals_conf <-
#   read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals/after_clean/Plurals - Resultado plurais.csv",
#             sep = ",",
#             header = T)
# plurals_conf <- plurals_conf[c(2,1)]
# # colnames(trat_infoS3) <- trat_infoS3[3,]
# # trat_infoS3 <- trat_infoS3[-c(1, 2,3),]
#
#
# plurals_ok <-
#   read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals/after_clean/Plurals - PluralsOK.csv",
#             sep = ",",
#             header = T)
# plurals_ok <- plurals_ok[c(2,1)]
#
# plurals_irreg <-
#   read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals/after_clean/Plurals - irregular_D&G.csv",
#             sep = ",",
#             header = T)
# plurals_irreg <- plurals_irreg[c(1,2)]
# colnames(plurals_irreg) <- c("Base.Word", "plurals.f.lemma")
#
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="trat.Info.1.0.RData")
#
# trat.Info.1.0
# trat.Info.1.0 <- trat.Info.1.0[-grep(".* .*", trat.Info.1.0$Base),] # retirando bigramas
# trat.Info.1.0_nouns1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun")
# trat.Info.1.0_nouns2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun, verb")
# trat.Info.1.0_nouns3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb, noun, verb")
# trat.Info.1.0_nouns4 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun, pronoun, determiner")
# trat.Info.1.0_nouns5 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun, adverb")
# trat.Info.1.0_nouns6 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun")
# trat.Info.1.0_nouns <- rbind(trat.Info.1.0_nouns1, trat.Info.1.0_nouns2, trat.Info.1.0_nouns3,
#                              trat.Info.1.0_nouns4, trat.Info.1.0_nouns5, trat.Info.1.0_nouns6)
# rm("trat.Info.1.0_nouns1", "trat.Info.1.0_nouns2", "trat.Info.1.0_nouns3",
#       "trat.Info.1.0_nouns4", "trat.Info.1.0_nouns5", "trat.Info.1.0_nouns6")
#
#
# x <- full_join(trat.Info.1.0_nouns, plurals_ok, by="Base.Word")
# x <- x[!is.na(x$plurals.f.lemma),]
#
# x1 <- full_join(trat.Info.1.0_nouns, plurals_conf, by="Base.Word")
# x1 <- x1[!is.na(x1$plurals.f.lemma),]
#
# plurals_irreg <- plurals_irreg[-grep("to be investigated", plurals_irreg$plurals.f.lemma),]
# plurals_irreg <- plurals_irreg[-grep("only plural form", plurals_irreg$plurals.f.lemma),]
# plurals_irreg <- plurals_irreg[-grep("only singular form", plurals_irreg$plurals.f.lemma),]
# x2 <- full_join(trat.Info.1.0_nouns, plurals_irreg, by="Base.Word")
# x2 <- x2[!is.na(x2$plurals.f.lemma),]
# x2 <- x2[!is.na(x2$Level),]
#
# PL <- rbind(x, x1, x2)
# PL <- unique(PL)
#
# # Aqui sobra uma última lista de plurais faltantes (XXX) a ser feita manualmente
# XXX <- left_join(trat.Info.1.0_nouns, PL, by="Base.Word")
# XXX <- XXX[is.na(XXX$Level.y),]
# XXX <- XXX[!is.na(XXX$plurals.f.lemma),]
#
# # write.csv(XXX, file="pluraisfaltantes_finais.csv")
#
#
# # # convergindo PL e os plurais faltantes (XXX)
#
# plurals_faltantes <-
#   read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals/after_clean/Plurals - plurals_mising_final.csv",
#             sep = ",",
#             header = T)
# plurals_faltantes <- plurals_faltantes[!is.na(plurals_faltantes$plurals.f.lemma),]
# colnames(plurals_faltantes) <- colnames(PL)
# Plurals <- rbind(PL, plurals_faltantes)
#
#
# rm("plurals_conf", "plurals_faltantes", "plurals_irreg", "plurals_ok", "trat.Info.1.0",
#    "trat.Info.1.0_BIgrams", "trat.Info.1.0_nouns", "x", "x1", "x2", "XXX", "PL")
#
#
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/plurals/after_clean")
# # write.csv(Plurals, file="Plurals.csv")
# #
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # save(Plurals, file="Plurals.1.0.Rdata")
#
# # load("Plurals.1.0.Rdata")


####ACABOU plurals!!!

# # # Para unir com as outraas listas
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("Plurals.1.0.Rdata")
#
# Plurals <- Plurals[c(4,2,3)]
# colnames(Plurals) <- c("Base.Word", "Level", "Part.of.Speech")



############## ----





############## ----
#### (3.3) contrações....

# Dois arquivos entregues para limpeza

# key_contractions <- read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/key_contractions.csv",
#                      sep = ",",
#                      header = T)

# more_contractions <- read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/more_contractions.csv",
#                       sep = ",",
#                       header = T)

# JA Foi entregue. está na word search list 2 , na planilha Contractions

############## ----



############## ----
#### (3.4) stopwords....


# # # # pequena lista de stopwords
# if(require(qdapDictionaries) == F) install.packages("qdapDictionaries"); require(qdapDictionaries)
# x <- data(BuckleySaltonSWL)
# y <- data(OnixTxtRetToolkitSWL1)
#
#
# if(require(rcorpora) == F) install.packages("rcorpora"); require(rcorpora)
# if(require(corpora) == F) install.packages("corpora"); require(corpora)
# w <- corpora("words/stopwords/en")[[2]]


# tm::stopwords(kind = "en")

############## ----















#----------------# Aplicando a DISTANCIA DE LEVENSHTEIN #--------------------#

# if(require(RecordLinkage) == F) install.packages("RecordLinkage"); require(RecordLinkage)
# # levenshteinDist(x,y) # diferença em "tecladas"
# # levenshteinSim(x,y)  # diferença "" equilibrada pelo tamanho do string
# # ?levenshteinSim      #
#
# ## Preparando os dados para a comparação
#
# Syn_u <- paste0(Syn[[1]], Syn[[2]])
# Syn_u <- Syn_u

## Criando a Matriz de Comparação
# i=1
# M <- matrix(nrow = length(Syn_u), ncol = length(Syn_u))
# for(i in 1:(length(Syn_u)-1)) {
#   c <- i+1
#   x <- levenshteinDist(Syn_u[i], Syn_u[c:length(Syn_u)])
#   # x <- 10 - round(levenshteinSim(Syn_u[i], Syn_u[c:length(Syn_u)]), digits=1)*10  # tentando com a levenshtein modificada
#   # x <- round(jarowinkler(levenshteinSim(Syn_u[i], Syn_u[c:length(Syn_u)])*100)/100   # tentando com jarowinkler(x,y) -> falta ajeitar o arredondamento
#   M[i,] <- c(rep(NA, i), x)
#   i = i+1
#   }
#
# ## Escolhendo a distância de interesse a ser observada (começar do zero ao ....)
# comps <- which(M == 1, arr.ind = T)
# comps
#
# ## Visualizando casos com a distância de interesse
# comp=1
# comp
# Syn[comps[comp,1],]
# Syn[comps[comp,2],]
# comp <- comp + 1

#---------------------------------------------------------------------------#









