
###################### Criando a Base de Base de antonimos


# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/antonyms")
# files <- list.files() # retorna a lista de calendarios baixados
#
#
# Antonyms2 <- read.csv2(paste0("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/antonyms/",
#                               files[[1]]),
#                        sep = ",",
#                        header = F)
# colnames(Antonyms2) <- Antonyms2[2,]
# Antonyms2 <- Antonyms2[-c(1,2),]
# rownames(Antonyms2) <- NULL
# colnames(Antonyms2) <- c("word", "opposite")
#
#
# Antonyms1 <- read.csv2(paste0("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/antonyms/",
#                               files[[2]]),
#                        sep = ",",
#                        header = F)
# colnames(Antonyms1) <- Antonyms1[2,]
# Antonyms1 <- Antonyms1[-c(1,2),]
# rownames(Antonyms1) <- NULL
# colnames(Antonyms1) <- c("word", "opposite")
#
#
# syn_Ant1 <- read.csv2(paste0("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/antonyms/",
#                               files[[3]]),
#                        sep = ",",
#                        header = F)
# syn_Ant1 <- syn_Ant1[c(2,3)]
# colnames(syn_Ant1) <- syn_Ant1[2,]
# syn_Ant1 <- syn_Ant1[-c(1,2),]
# rownames(syn_Ant1) <- NULL
# colnames(syn_Ant1) <- c("word", "opposite")
#
#
# Ant_def <- read.csv2(paste0("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/antonyms/",
#                              files[[4]]),
#                       sep = ",",
#                       header = F)
# Ant_def <- Ant_def[c(2,3)]
# colnames(Ant_def) <- Ant_def[3,]
# Ant_def <- Ant_def[-c(1,2,3),]
# rownames(Ant_def) <- NULL
# colnames(Ant_def) <- c("word", "opposite")
#
#
# antonyms <- rbind(Antonyms2, Antonyms1, syn_Ant1, Ant_def)
# rm("Antonyms2", "Antonyms1", "syn_Ant1", "Ant_def", "files")
#
#
# # limpando
# antonyms$opposite <- as.character(antonyms$opposite)
# antonyms$word <- as.character(antonyms$word)
#
# antonyms <- unique(antonyms)
# antonyms$word <- str_to_lower(antonyms$word)
# antonyms$opposite <- str_to_lower(antonyms$opposite)
#
#
# antonyms$word <- sub("^to ", "", antonyms$word)
# antonyms$opposite <- sub("^to ", "", antonyms$opposite)
#
# antonyms$word <- sub("\\(.*)", "", antonyms$word)
# antonyms$opposite <- sub("\\(.*)", "", antonyms$opposite)
#
# antonyms <- antonyms[-grep("fresh", antonyms$word),]
#
#
# antonyms <- rbind(data.frame(word=c("fresh", "fresh"), opposite=c("old", "stale")), antonyms)
#
# antonyms$word <- sub(" -", "-", antonyms$word)
# antonyms$opposite <- sub("- ", "-", antonyms$opposite)
#
# antonyms$word <- str_trim(antonyms$word)
# antonyms$opposite <- str_trim(antonyms$opposite)
# rownames(antonyms) <- NULL






# ########## Colocando o Level na lista de antonios
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
#
#
# Antony.Words <- data.frame(indexS=1:length(antonyms$word), ref=antonyms$word, Ant_base=antonyms$word)
# AntW_L <- left_join(Antony.Words, trat_limpo, by="ref")
#
# AntW_L <- AntW_L[c(1,3,5)]
# # # SynW_L <- na.omit(SynW_L)
# AntW_L$indexS <- as.numeric(AntW_L$indexS)
#
#
#
#
# Ant.apposites <- data.frame(indexS=1:length(antonyms$opposite), ref=antonyms$opposite, ant_ant=antonyms$opposite)
# AntOp_L <- left_join(Ant.apposites, trat_limpo, by="ref")
# AntOp_L <- AntOp_L[c(1,3,5)]
# # # SynS_L <- na.omit(SynS_L)
# AntOp_L$indexS <- as.numeric(AntOp_L$indexS)
#
#
#
# Ant_leveled <- full_join(AntW_L, AntOp_L, by="indexS")
#
#
# Ant_leveled <- Ant_leveled[c(2,3,4,5)]
#
#
#
# Ant_leveled <- Ant_leveled %>%
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
# for(i in 1:length(Ant_leveled$Ant_base)){
#   if(grepl(" ", Ant_leveled$Ant_base[i]) == T & grepl(" ", Ant_leveled$ant_ant[i]) == T){
#     N <- c(N, i)
#   }
# }
#
# a <- Ant_leveled[N,]    # <------------- RESGATAR: antonimos bigramas dos dois lados
#
# Ant_leveled <- Ant_leveled[-N,]
#
#
#
# for(i in 1:length(Ant_leveled$Ant_base)){
#   if(grepl(" ", Ant_leveled$Ant_base[i]) == F & is.na(Ant_leveled$Level.x[i])){
#     Ant_leveled$Level.x[i] <- 7
#   }
# }
# for(i in 1:length(Ant_leveled$ant_ant)){
#   if(grepl(" ", Ant_leveled$ant_ant[i]) == F & is.na(Ant_leveled$Level.y[i])){
#     Ant_leveled$Level.y[i] <- 7
#   }
# }
#
#
# Ant_leveled[is.na(Ant_leveled)] <- .5  # atribuindo o .5 às expressões com espaços
#
#
#
# # organizando para que na primeira coluna estejam as palavras mais dificeis do par
# maior <- Ant_leveled[Ant_leveled$Level.x > Ant_leveled$Level.y,]
# menor <- Ant_leveled[Ant_leveled$Level.x < Ant_leveled$Level.y,]
# igual <- Ant_leveled[Ant_leveled$Level.x == Ant_leveled$Level.y,]
# menor <- menor[c(3,4,1,2)]
# colnames(menor) <- colnames(maior)
# igual1 <- igual[c(3,4,1,2)]
# colnames(igual1) <- colnames(maior)
#
# Ant_organized <- rbind(maior, menor, igual, igual1)
# colnames(Ant_organized) <- c("B.word_dif", "lvl.base", "Ant_easy", "lvl.ant")
# #
# #
# # rm("igual", "igual1", "maior", "menor", "Ant.apposites", "Antony.Words", "AntW_L", "AntOp_L", "r", "a", "x")
#
# Ant_organized <- unique(Ant_organized)
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # # # save(Ant_organized, file= "Antony.1.0.Rdata")







########## EXPANDIDO O lemmasDF.2.0 -> Criando lemmasDF.2.2
#
# O lemmatizador lemmasDF.2.2 é a expansão do lemmasDF.2.0
# em que se adiciona todas as variações das palavras da lista
# dos antonimos que não estavam na lista com niveis ("trat.Info.1.0").


# x <- Ant_organized[Ant_organized$lvl.base =="7",]
# y <- x$B.word_dif
#
# i=1
# N <- c()
# for(i in 1:length(y)) {
#   print(i)
#   n <- grep(paste0("^", y[i], "$"), lemmat300m$words)
#   N <- c(N, n)
# }
#
# N1 <- unique(N)
#
# # view(lemmat300m[N1,])
#
# expansao_Ant <- lemmat300m[N1,]
# expansao_Ant_lista <- expansao_Ant$lemma
#
#
# i=1
# M <- c()
# for(i in 1:length(expansao_Ant_lista)) {
#   print(i)
#   n <- grep(paste0("^", expansao_Ant_lista[[i]], "$"), lemmat300m$lemma)
#   M <- c(M, n)
# }
# M1 <- unique(M)
#
# # view(lemmat300m[M1,])
#
#
# complemento <- lemmat300m[M1,]
# complemento <- complemento[c(3,1,2)]
# original <- lemmasDF.2.0
# colnames(complemento) <- colnames(original)
# lemmasDF.2.2 <- rbind(original, complemento)
# lemmasDF.2.2 <- unique(lemmasDF.2.2)
#
# # setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# # # # save(lemmasDF.2.2, file= "lemmasDF.2.2.Rdata")








