


##########################################
###### (1) Synonyms - dados para formar a lista de sinônimos ----
# é feito trabalhando 10 planilhas, sendo 2 delas parte da sessão "tratamento da informação
##########################################

# if(require(tm) == F) install.packages("tm"); require(tm)
# if(require(qdap) == F) install.packages("qdap"); require(qdap) # alista grande vem do qdap dictionaires
# if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
# if(require(xlsx) == F) install.packages("xlsx"); require(xlsx)


# ## (1.1) carregando as sheets para formar a lista de sinônimos
# Syn1 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 1 - Synonyms1.csv",
#             sep = ",",
#             header = T)
# colnames(Syn1) <- Syn1[1,]
# Syn1 <- Syn1[-1,]
#
# Syn2 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 1 - Copy of Synonyms2.csv",
#             sep = ",",
#             header = T)
# colnames(Syn2) <- Syn2[1,]
# Syn2 <- Syn2[-1,]
#
# Syn3 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 1 - Synonyms3.csv",
#             sep = ",",
#             header = T)
# colnames(Syn3) <- c("Word", "Synonym")
# Syn3 <- Syn3[-1,]
#
# Syn4 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 1 - Copy of Synonyms4.csv",
#             sep = ",",
#             header = T)
# Syn4 <- Syn4[c(4,5)]
# colnames(Syn4) <- c("Word", "Synonym")
# Syn4 <- Syn4[-c(1,2),]
#
# Syn5 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 2 - Copy of Synonyms5.csv",
#             sep = ",",
#             header = T)
# Syn5 <- Syn5[c(1,3)]
# colnames(Syn5) <- c("Word", "Synonym")
# Syn5 <- Syn5[-c(1,2),]
#
# Syn6 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 2 - Synonyms6.csv",
#             sep = ",",
#             header = T)
# colnames(Syn6) <- c("Word", "Synonym")
# Syn6 <- Syn6[-1,]
#
# Syn7 <-   # vem do arquivo Word Search Lists 1 - Copy of Syns+Antonys.csv
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 1 - Copy of Syns+Antonys.csv",
#             sep = ",",
#             header = T)
# Syn7 <- Syn7[c(2,3)]
# colnames(Syn7) <- c("Word", "Synonym")
# Syn7 <- Syn7[-1,]
#
#
#
# Syn8 <-   # vem do arquivo Word Search Lists 2 - Copy of Synonyms Categories
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/Synonym/Word Search Lists 2 - Copy of Synonyms Categories.csv",
#             sep = ",",
#             header = T)
# colnames(Syn8) <- c("Word", "Synonym")
# Syn8 <- Syn8[-1,]
#
#
# # sheet ???     # vem das listas de tratamento da informacao
# trat_infoS1 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet1.csv",
#             sep = ",",
#             header = T)
# trat_infoS1 <- trat_infoS1[c(1,2)]
# colnames(trat_infoS1) <- c("Word", "Synonym")
# trat_infoS1$Synonym <- str_to_lower(trat_infoS1$Synonym)
# trat_infoS1 <- trat_infoS1 %>% filter(Synonym != "")
#
# #Sheet ????   # vem das listas de tratamento da informacao
# trat_infoS5 <-
#   read.csv2("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras/ResourcesData/TratamentoInformacao/Tratamento Informação - Sheet5.csv",
#             sep = ",",
#             header = T)
# trat_infoS5 <- trat_infoS5[c(1,3)]
# colnames(trat_infoS5) <- c("Word", "Synonym")
# trat_infoS5$Synonym <- str_to_lower(trat_infoS5$Synonym)
# trat_infoS5 <- trat_infoS5 %>% filter(Synonym != "")
#
#
# Syn <- rbind(Syn1, Syn2, Syn3, Syn4, Syn5, Syn6, Syn7, Syn8, trat_infoS1, trat_infoS5)
# rm("Syn1", "Syn2", "Syn3", "Syn4", "Syn5", "Syn6", "Syn7", "Syn8", "trat_infoS1", "trat_infoS5")
#
# Syn$Word <- str_to_lower(Syn$Word)
# Syn$Synonym <- str_to_lower(Syn$Synonym)
# Syn <- unique(Syn)
# Syn <- Syn[order(Syn$Word),]
# Syn <- Syn[-1,]
# rownames(Syn) <- NULL



### (1.2) limpando

# Syn$Word <- sub("to ", "", Syn$Word)
# Syn$Synonym <- sub("to ", "", Syn$Synonym)
# Syn$Word <- sub("a ", "", Syn$Word)
# Syn$Word <- sub("few determiner,", "few", Syn$Word)
# Syn <- Syn[-c(grep("wearisome. irksome", Syn$Synonym)),]
# Syn <- rbind(Syn, data.frame(Word=c("tedious", "tedious"), Synonym=c("wearisome", "irksome")))
# Syn <- Syn[-c(grep("valid, lega", Syn$Synonym)),]
# Syn <- rbind(Syn, data.frame(Word=c("legitimate", "legitimate"), Synonym=c("valid", "legal")))
# Syn$Word <- sub("zig -zag", "zig-zag", Syn$Word)
# Syn$Word <- sub("busy ", "busy", Syn$Word)
# Syn$Word <- sub("construction ", "construction", Syn$Word)
# def <- Syn[grep(".* .* .* .*", Syn$Synonym),]      # <----------------- Incluir na lista de definições !!!!!!!
# Syn <- Syn[-c(grep(".* .* .* .*", Syn$Synonym)),]
# Syn <- Syn[-c(grep("in questions", Syn$Synonym)),]
# Syn$Synonym[grep(", determiner ", Syn$Synonym)[[1]]] <- "remaining"
# Syn$Synonym[grep(", determiner", Syn$Synonym)[[1]]] <- "twelve"
# coloc <- Syn[(grep("etc\\.", Syn$Synonym)),]     # <----------------- Incluir na lista de colocations !!!!!
# Syn <- Syn[-c(grep("etc\\.", Syn$Synonym)),]
# Syn$Synonym <- sub(",", "", Syn$Synonym)
# Syn <- unique(Syn)
# Syn <- Syn[-c(grep("premiss", Syn$Synonym)),]
# Syn <- Syn[Syn$Word != Syn$Synonym,]

# Syn <- Syn[-c(grep("say/tell", Syn$Word)),]
# x <- data.frame(Word=c(rep("say", 4), rep("tell", 4)), Synonym=rep(c("recount", "narrate", "explain", "reveal"), 2))
# Syn <- rbind(Syn, x)






# # # limpando stopwords
# stop <- tm::stopwords(kind = "en")
# N <- c()
# M <- c()
# for(i in 1:length(stop)) {
#   n <- grep(paste0("^", stop[i], "$") , Syn$Word)
#   N <- c(N,n)
#   m <- grep(paste0("^", stop[i], "$") , Syn$Synonym)
#   M <- c(M,m)
# }
# x <- unique(c(N,M))
# SSS <- Syn[x,] # <-------------------- Sinonimos de stop words
#
# Syn <- Syn[-x,]
# rm("N", "n", "M", "m", "stop", "i", "x", "SSS")
#
#
# # o que fazer com as linas q tem / na 2a coluna ??? algumas sao por causa de preposição
# syn.with.bar <- Syn[grep("/", Syn$Synonym),]  # <------------ enviado para limpeza manual
# # # # # write.csv2(syn.with.bar, file= "syn.with.bar.csv")
#
# Syn <- Syn[-grep("/", Syn$Synonym),]






############# ESTAMOS AQUI  # <-------------------- ESTAMOS AQUI





# # o pacote qdap tem um retornador de sinonimos
# qdap::synonyms("structure")
# synonym.frame = qdapDictionaries::key.syn  # https://cran.r-project.org/web/packages/qdapDictionaries/qdapDictionaries.pdf
#








# ##### (1.3) Colocando o Level na lista de sinônimos
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="trat.Info.1.0.RData")
#
# trat.Info.1.0 <- trat.Info.1.0[order(trat.Info.1.0$Level),]
#
# trat_ref <- data.frame(ref=trat.Info.1.0$Base.Word)
# trat_ref <- unique(trat_ref)
# trat_ref <- data.frame(index=rownames(trat_ref), ref=trat_ref$ref)
# trat_ref$index <- as.numeric(trat_ref$index)
#
# trat_level <- data.frame(Level=trat.Info.1.0$Level, index=1:length(trat.Info.1.0$Level))
# trat_level$index <- as.numeric(trat_level$index)
# trat_limpo <- left_join(trat_ref, trat_level, by="index")
#
# rm("trat_level", "trat_ref", "def", "coloc")
#
# Syn.Words <- data.frame(indexS=1:length(Syn$Word), ref=Syn$Word, syn_base=Syn$Word)
# SynW_L <- left_join(Syn.Words, trat_limpo, by="ref")
# SynW_L <- SynW_L[c(1,3,5)]
# # # SynW_L <- na.omit(SynW_L)
# SynW_L$indexS <- as.numeric(SynW_L$indexS)
#
#
# Syn.Synonyms <- data.frame(indexS=1:length(Syn$Synonym), ref=Syn$Synonym, syn_syn=Syn$Synonym)
# SynS_L <- left_join(Syn.Synonyms, trat_limpo, by="ref")
# SynS_L <- SynS_L[c(1,3,5)]
# # # SynS_L <- na.omit(SynS_L)
# SynS_L$indexS <- as.numeric(SynS_L$indexS)
#
#
# Syn_leveled <- full_join(SynW_L, SynS_L, by="indexS")
# Syn_leveled <- Syn_leveled[c(2,3,4,5)]
#
# Syn_leveled <- Syn_leveled %>%
#   mutate(Level.x = case_when(Level.x == "A1" ~ 1,
#                              Level.x == "A2" ~ 2,
#                              Level.x == "B1" ~ 3,
#                              Level.x == "B2" ~ 4,
#                              Level.x == "C1" ~ 5,
#                              Level.x == "C2" ~ 6),
#          Level.y = case_when(Level.y == "A1" ~ 1,
#                              Level.y == "A2" ~ 2,
#                              Level.y == "B1" ~ 3,
#                              Level.y == "B2" ~ 4,
#                              Level.y == "C1" ~ 5,
#                              Level.y == "C2" ~ 6))
#
#
#
# N <- c()
# for(i in 1:length(Syn_leveled$syn_base)){
#   if(grepl(" ", Syn_leveled$syn_base[i]) == T & grepl(" ", Syn_leveled$syn_syn[i]) == T){
#     N <- c(N, i)
#   }
# }
#
# a <- Syn_leveled[N,]    # <------------- RESGATAR: synonymos bigramas dos dois lados
#
# Syn_leveled <- Syn_leveled[-N,]
#
# for(i in 1:length(Syn_leveled$syn_base)){
#   if(grepl(" ", Syn_leveled$syn_base[i]) == F & is.na(Syn_leveled$Level.x[i])){
#     Syn_leveled$Level.x[i] <- 7
#   }
# }
# for(i in 1:length(Syn_leveled$syn_syn)){
#   if(grepl(" ", Syn_leveled$syn_syn[i]) == F & is.na(Syn_leveled$Level.y[i])){
#     Syn_leveled$Level.y[i] <- 7
#   }
# }
#
#
# Syn_leveled[is.na(Syn_leveled)] <- .5  # atribuindo o .5 às expressões com espaços
#
#
# # organizando para que na primeira coluna estejam as palavras mais dificeis do par
# maior <- Syn_leveled[Syn_leveled$Level.x > Syn_leveled$Level.y,]
# menor <- Syn_leveled[Syn_leveled$Level.x < Syn_leveled$Level.y,]
# igual <- Syn_leveled[Syn_leveled$Level.x == Syn_leveled$Level.y,]
# menor <- menor[c(3,4,1,2)]
# colnames(menor) <- colnames(maior)
# igual1 <- igual[c(3,4,1,2)]
# colnames(igual1) <- colnames(maior)
#
# Syn_organized <- rbind(maior, menor, igual, igual1)
# colnames(Syn_organized) <- c("B.word_dif", "lvl.base", "Syn_easy", "lvl.syn")
#
#
# rm("igual", "igual1", "maior", "menor", "Syn.Synonyms", "Syn.Words", "SynW_L", "SynS_L", "r", "Syn_leveled_NoNA")





#
# ### testando
#
# # # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # # load(file="testdata_Level.RData")
# #
# # original <- paste(testdata_Level, collapse="")
# #
# # convert <- testdata_Level
# # for(i in 1:length(convert)) {
# #   x <- convert[[i]]
# #   n <- grep(paste0("^",x, "$"), Syn_organized$B.word_dif)
# #   z <- paste(Syn_organized$Syn_easy[n], collapse = "/")
# #   convert[[i]] <- z
# # }
# #
# # convert <- paste(convert, collapse="")
#
# ############## ----
#


