
###################### Aperfeiçoando a base de palavras e seus niveis
# NEsse script, reconstruimos a base salva em "trat.Info.1.0.RData"
# A partir da nova base de lematização ("lemmat300m.1.0.Rdata"), adicionamos à base de niveis:
# (i) plurais : reformulamos "Plurals.1.0"  -> "Plurals.2.0"
# (ii) verbos
# (iii) adjetivos/adverbios
# (iv) adverbios terminados em -ly
# (v) contrações


# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="trat.Info.1.0.RData")
# load(file="lemmat300m.1.0.Rdata")



########### (I) Plurais dos Substantivos

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
# lemmat300m_NNS <- lemmat300m %>% filter(pos == "NNS")
#
# #
#
# N <- c()
# # XXX <- c()
# for(i in 1:length(trat.Info.1.0_nouns$Base.Word)) {
#   p <- trat.Info.1.0_nouns$Base.Word[i]
#   n <- grep(paste0("^", p, "$"), lemmat300m_NNS$lemma)
#   # print(paste0(i, "->", n))
#   print(i)
#   # xxx <- paste0(i, "->", n)
#   # XXX <- c(XXX, xxx)
#   N <- c(N,n)
# }
# rm("i", "n", "p")
# N <- unique(N)
#
# Plurals <- lemmat300m_NNS[N,]   #
# not_found <- trat.Info.1.0_nouns[!(trat.Info.1.0_nouns$Base.Word %in% lemmat300m_NNS$lemma),]  #<------ 143 palavras palavras que não encontramos
# colnames(Plurals) <- c("words", "pos", "Base.Word")
#
# Plurals.2.0 <- full_join(trat.Info.1.0_nouns, Plurals, by="Base.Word")
#
# Plurals.2.0$pos <- "NNS"

# # # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # # save(Plurals.2.0, file="Plurals.2.0.Rdata") # NOT SAVED YET (problema relacionado a como salvar e se vai dobrar os word=lema)





########### (II) VERBOS

# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("trat.Info.1.0.RData")
# load(file="lemmat300m.1.0.Rdata")
#
#
# trat.Info.1.0_verb1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb, noun, verb")
# trat.Info.1.0_verb2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, verb")
# trat.Info.1.0_verb3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "modal verb")
# trat.Info.1.0_verb4 <- trat.Info.1.0 %>% filter(Part.of.Speech == "auxiliary verb")
# trat.Info.1.0_verb5 <- trat.Info.1.0 %>% filter(Part.of.Speech == "verb")
# trat.Info.1.0_verb6 <- trat.Info.1.0 %>% filter(Part.of.Speech == "noun, verb")
# trat.Info.1.0_verb <- rbind(trat.Info.1.0_verb1, trat.Info.1.0_verb2, trat.Info.1.0_verb3,
#                             trat.Info.1.0_verb4, trat.Info.1.0_verb5, trat.Info.1.0_verb6)
# rm("trat.Info.1.0_verb1", "trat.Info.1.0_verb2", "trat.Info.1.0_verb3",
#    "trat.Info.1.0_verb4", "trat.Info.1.0_verb5", "trat.Info.1.0_verb6")
#
#
# verbs <- unique(trat.Info.1.0_verb$Base.Word)
#
# lemmat300m_VBD <- lemmat300m %>% filter(pos == "VBD")
# lemmat300m_VBG <- lemmat300m %>% filter(pos == "VBG")
# lemmat300m_VBN <- lemmat300m %>% filter(pos == "VBN")
# lemmat300m_VBZ <- lemmat300m %>% filter(pos == "VBZ")
#
# lemmat300m_verbs <- rbind(lemmat300m_VBD, lemmat300m_VBG, lemmat300m_VBN, lemmat300m_VBZ)
#
# rm("lemmat300m_VBD", "lemmat300m_VBG", "lemmat300m_VBN", "lemmat300m_VBZ")
#
#
# N <- c()
# # XXX <- c()
# for(i in 1:length(trat.Info.1.0_verb$Base.Word)) {
#   p <- trat.Info.1.0_verb$Base.Word[i]
#   n <- grep(paste0("^", p, "$"), lemmat300m_verbs$lemma)
#   # print(paste0(i, "->", n))
#   print(i)
#   # xxx <- paste0(i, "->", n)
#   # XXX <- c(XXX, xxx)
#   N <- c(N,n)
# }
# rm("i", "n", "p")
# N <- unique(N)
#
# verb_variations <- lemmat300m_verbs[N,]
# not_found <- trat.Info.1.0_verb[!(trat.Info.1.0_verb$Base.Word %in% lemmat300m_verbs$lemma),]  #<------ 143 palavras palavras que não encontramos
# colnames(verb_variations) <- c("words", "pos", "Base.Word")
#
# verb_variations.2.0 <- full_join(trat.Info.1.0_verb, verb_variations, by="Base.Word")


#  # # # # save(verb_variations.2.0, file= "verb_variations.2.0.Rdata")



########### (III) ADJETIVOS


# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("trat.Info.1.0.RData")
# load(file="lemmat300m.1.0.Rdata")
#
#
# trat.Info.1.0_adj1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective")
# trat.Info.1.0_adj2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, verb")
# trat.Info.1.0_adj3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb")
# trat.Info.1.0_adj4 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb, noun, verb")
# trat.Info.1.0_adj5 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, determiner")
# trat.Info.1.0_adj6 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun")
# trat.Info.1.0_adj7 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, pronoun")
#
# trat.Info.1.0_adv1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adverb")
# trat.Info.1.0_adv2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adverb, preposition")
# trat.Info.1.0_adv3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adverb, conjunction")
#
#
# trat.Info.1.0_adj <- rbind(trat.Info.1.0_adj1, trat.Info.1.0_adj2, trat.Info.1.0_adj3,
#                            trat.Info.1.0_adj4, trat.Info.1.0_adj5, trat.Info.1.0_adj6, trat.Info.1.0_adj7,
#                            trat.Info.1.0_adv1, trat.Info.1.0_adv2, trat.Info.1.0_adv3)
# rm("trat.Info.1.0_adj1", "trat.Info.1.0_adj2", "trat.Info.1.0_adj3",
#    "trat.Info.1.0_adj4", "trat.Info.1.0_adj5", "trat.Info.1.0_adj6", "trat.Info.1.0_adj7",
#    "trat.Info.1.0_adv1", "trat.Info.1.0_adv2", "trat.Info.1.0_adv3")
#
# # adject.adverb <- unique(trat.Info.1.0_adj$Base.Word)
#
#
# lemmat300m_JJS <- lemmat300m %>% filter(pos == "JJS")
# lemmat300m_JJR <- lemmat300m %>% filter(pos == "JJR")
# lemmat300m_RBR <- lemmat300m %>% filter(pos == "RBR")
# lemmat300m_RBS <- lemmat300m %>% filter(pos == "RBS")
#
# lemmat300m_adject <- rbind(lemmat300m_JJS, lemmat300m_JJR, lemmat300m_RBR, lemmat300m_RBS)
# rm("lemmat300m_JJS", "lemmat300m_JJR", "lemmat300m_RBR", "lemmat300m_RBS")
#
#
# N <- c()
# # XXX <- c()
# for(i in 1:length(trat.Info.1.0_adj$Base.Word)) {
#   p <- trat.Info.1.0_adj$Base.Word[i]
#   n <- grep(paste0("^", p, "$"), lemmat300m_adject$lemma)
#   # print(paste0(i, "->", n))
#   print(i)
#   # xxx <- paste0(i, "->", n)
#   # XXX <- c(XXX, xxx)
#   N <- c(N,n)
# }
# rm("i", "n", "p")
# N <- unique(N)
#
#
# adj.adv_variations <- lemmat300m_adject[N,]
# not_found <- trat.Info.1.0_adj[!(trat.Info.1.0_adj$Base.Word %in% lemmat300m_adject$lemma),]  #
# colnames(adj.adv_variations) <- c("words", "pos", "Base.Word")
#
#
# adj.adv_variations.2.0 <- full_join(trat.Info.1.0_adj, adj.adv_variations, by="Base.Word")
# adj.adv_variations.2.0 <- unique(adj.adv_variations.2.0)


# # # # save(adj.adv_variations.2.0, file= "adj.adv_variations.2.0.Rdata")







########### (IV) ADVERBIOS COM -LY

# lemmat300m_RB <- lemmat300m %>% filter(pos == "RB")
# lemmat300m_RBly <- lemmat300m_RB[grep("ly$", lemmat300m_RB$words),]
#
#
# trat.Info.1.0_adj1 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective")
# trat.Info.1.0_adj2 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, verb")
# trat.Info.1.0_adj3 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb")
# trat.Info.1.0_adj4 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, adverb, noun, verb")
# trat.Info.1.0_adj5 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, determiner")
# trat.Info.1.0_adj6 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, noun")
# trat.Info.1.0_adj7 <- trat.Info.1.0 %>% filter(Part.of.Speech == "adjective, pronoun")
#
# trat.Info.1.0_adj <- rbind(trat.Info.1.0_adj1, trat.Info.1.0_adj2, trat.Info.1.0_adj3,
#                            trat.Info.1.0_adj4, trat.Info.1.0_adj5, trat.Info.1.0_adj6, trat.Info.1.0_adj7)
# rm("trat.Info.1.0_adj1", "trat.Info.1.0_adj2", "trat.Info.1.0_adj3",
#    "trat.Info.1.0_adj4", "trat.Info.1.0_adj5", "trat.Info.1.0_adj6", "trat.Info.1.0_adj7")
#
#
#
# # # criando matrix com distancias de levenshtein entre as palavras
# # if(require(RecordLinkage) == F) install.packages("RecordLinkage"); require(RecordLinkage)
# i=1
# Mdist <- matrix(nrow = length(lemmat300m_RBly$words), ncol = length(trat.Info.1.0_adj$Base.Word))
# for(i in 1:length(lemmat300m_RBly$words)) {
#   e=1
#   for(e in 1:length(trat.Info.1.0_adj$Base.Word)){
#     d <-levenshteinDist(lemmat300m_RBly$words[i], trat.Info.1.0_adj$Base.Word[e])
#     print(i)
#     Mdist[i,e] <- d
#     e = e+1
#   }
#   i=i+1
# }
# rm("d", "e")
# table(Mdist)
#
# # # # # # save(Mdist, file = "Mdist.adverb.Rdata")
#
# # # selecionando as distancias desejadas
# adverbdist <- which(Mdist == 2, arr.ind = T)
#
# # # # observando os resultados desejados
# i=1
# DFadverbs <- data.frame()
# while(i <= dim(adverbdist)[[1]]) {
#   da <- as.numeric(adverbdist[i,1])
#   db <- as.numeric(adverbdist[i,2])
#   DFadverbs[i, 1] <- lemmat300m_RBly$words[[da]]
#   DFadverbs[i, 2] <- trat.Info.1.0_adj$Base.Word[[db]]
#   i=i+1
# }
# rm("i")
# colnames(DFadverbs) <- c("lemmat300m_RBly", "trat.Info.1.0_adj")
#
# DFadverbs
#
#
# # # Removendo palavras do lemma que sejam mais curtas que a paalvra base, ou dela desconectadas
# i=1
# L <- c()
# DFadverbs <- data.frame(lapply(DFadverbs, as.character), stringsAsFactors=FALSE)
# while(i <= dim(DFadverbs)[1]) {
#   a <- DFadverbs$lemmat300m_RBly[i]
#   b <- DFadverbs$trat.Info.1.0_adj[i]
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
# DFadverbs <- DFadverbs[L,]
# colnames(DFadverbs) <- c("adverbs.ly.lemma", "Base.Word")
#
# rm("a", "b", "ca2", "cb2", "da", "db", "i", "l", "L", "na", "nb", "N")
#
# DFadverbs$pos.lemma <- "RB"
# DFadverbs <- DFadverbs[c(1,3,2)]
#
#
# adv_variations.2.0 <- full_join(trat.Info.1.0_adj, DFadverbs, by="Base.Word")
# adv_variations.2.0 <- unique(adv_variations.2.0)
#
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # # # # save(adv_variations.2.0, file= "adv_variations.2.0.Rdata")






########### (V) CONTRACTIONS


# contractions <- read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/Word Search Lists 2 - Contractions.csv",
#                       sep = ",",
#                       header = F)
#
# contractions <- contractions[4:dim(contractions)[1],]
# colnames(contractions) <- c("contract", "extend")
#
# contractions <- unique(contractions)
#
# contractions$extend_clean <- contractions$extend
# contractions$extend_clean <- sub("not", "", contractions$extend_clean)
#
# if(require(qdap) == F) install.packages("qdap"); require(qdap)
#
# contractions$extend_clean <- beg2char(contractions$extend_clean, "/", 1)
# contractions$extend_clean <- beg2char(contractions$extend_clean, "(", 1)
# contractions$extend_clean <- beg2char(contractions$extend_clean, ";", 1)
# contractions$extend_clean <- beg2char(contractions$extend_clean, "[", 1)
# contractions$extend_clean <- beg2char(contractions$extend_clean, ",", 1)
#
# contractions$extend_clean <- str_to_lower(contractions$extend_clean)
#
# contractions$extend_clean <- sub("^i ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^he ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^she ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^it ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^we ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^you ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^they ", "", contractions$extend_clean)
#
#
#
# contractions$extend_clean <- sub("is", "be", contractions$extend_clean)
# contractions$extend_clean <- sub(" is ", " be ", contractions$extend_clean)
# contractions$extend_clean <- sub("^is ", "be ", contractions$extend_clean)
# contractions$extend_clean <- sub(" is$", " be", contractions$extend_clean)
# contractions$extend_clean <- sub("^are", "be", contractions$extend_clean)
# contractions$extend_clean <- sub(" are ", " be ", contractions$extend_clean)
# contractions$extend_clean <- sub("^are ", "be ", contractions$extend_clean)
# contractions$extend_clean <- sub(" are$", " be", contractions$extend_clean)
# contractions$extend_clean <- sub("^am", "be", contractions$extend_clean)
# contractions$extend_clean <- sub(" am ", " be ", contractions$extend_clean)
# contractions$extend_clean <- sub("^am ", "be ", contractions$extend_clean)
# contractions$extend_clean <- sub(" am$", " be", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^does", "do", contractions$extend_clean)
# contractions$extend_clean <- sub(" does ", " do ", contractions$extend_clean)
# contractions$extend_clean <- sub("^does ", "do ", contractions$extend_clean)
# contractions$extend_clean <- sub(" does$", " do", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^has", "have", contractions$extend_clean)
# contractions$extend_clean <- sub(" has ", " have ", contractions$extend_clean)
# contractions$extend_clean <- sub("^has ", "have ", contractions$extend_clean)
# contractions$extend_clean <- sub(" has$", " have", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^had", "have", contractions$extend_clean)
# contractions$extend_clean <- sub(" had ", " have ", contractions$extend_clean)
# contractions$extend_clean <- sub("^had ", "have ", contractions$extend_clean)
# contractions$extend_clean <- sub(" had$", " have", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^did", "do", contractions$extend_clean)
# contractions$extend_clean <- sub(" did ", " do ", contractions$extend_clean)
# contractions$extend_clean <- sub("^did ", "do ", contractions$extend_clean)
# contractions$extend_clean <- sub(" did$", " do", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^was", "have", contractions$extend_clean)
# contractions$extend_clean <- sub(" was ", " have ", contractions$extend_clean)
# contractions$extend_clean <- sub("^was ", "have ", contractions$extend_clean)
# contractions$extend_clean <- sub(" was$", " have", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^were", "have", contractions$extend_clean)
# contractions$extend_clean <- sub(" were ", " have ", contractions$extend_clean)
# contractions$extend_clean <- sub("^were ", "have ", contractions$extend_clean)
# contractions$extend_clean <- sub(" were$", " have", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^to", "", contractions$extend_clean)
# contractions$extend_clean <- sub(" to ", "", contractions$extend_clean)
# contractions$extend_clean <- sub(" to$", "", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^what ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^when ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^where ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^why ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^how ", "", contractions$extend_clean)
#
# contractions$extend_clean <- sub("^who ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^there ", "", contractions$extend_clean)
# contractions$extend_clean <- sub("^that ", "", contractions$extend_clean)
#
# contractions$extend_clean <- trimws(contractions$extend_clean)
#
# # # # # write.csv2(contractions, file="contractions_clean.csv")


#### ENTREGUE PARA LIMPEZA MANUAL: devolvido para limpeza no doc "Word Search Lists 2", sheet "Contractions_clean"
# # # devolvido:
# contractions <- read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/Word Search Lists 2 - Contractions_clean.csv",
#                       sep = ",",
#                       header = T)
#
# contractions <- contractions[c(1,2,5)]
# contractions.2.0 <- contractions
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# save(contractions.2.0, file= "contractions.2.0.Rdata")








######################################
################  UNINDO TUDO ########


# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("adv_variations.2.0.Rdata")
# load("adj.adv_variations.2.0.Rdata")
# load("verb_variations.2.0.Rdata")
# load("Plurals.2.0.Rdata")
# load("contractions.2.0.Rdata")
# # load(file="trat.Info.1.0.RData")
#
# contractions.2.0 <- contractions.2.0[c(3,1, 2)]
# colnames(contractions.2.0) <- c("lemmas", "words", "pos")
# contractions.2.0$pos <- "contract"
#
# adv_variations.2.0 <- adv_variations.2.0[c(1,4,5)]
# Plurals.2.0 <-Plurals.2.0[c(1,4,5)]
# adj.adv_variations.2.0 <-adj.adv_variations.2.0[c(1,4,5)]
# verb_variations.2.0 <-verb_variations.2.0[c(1,4,5)]
#
# colnames(adv_variations.2.0) <- c("lemmas", "words", "pos")
# colnames(Plurals.2.0) <- c("lemmas", "words", "pos")
# colnames(adj.adv_variations.2.0) <- c("lemmas", "words", "pos")
# colnames(verb_variations.2.0) <- c("lemmas", "words", "pos")
#
#
# lemmasDF.2.0 <- rbind(adv_variations.2.0, Plurals.2.0, adj.adv_variations.2.0,
#                         verb_variations.2.0, contractions.2.0)
#
# lemmasDF.2.0 <- na.exclude(lemmasDF.2.0)
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# save(lemmasDF.2.0, file = "lemmasDF.2.0.Rdata")



