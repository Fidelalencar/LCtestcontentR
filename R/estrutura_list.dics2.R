# ####### Criando lista de verbos e suas variantes
# # (i) primeiro tiramos a lista de verbos da lista de tratamento da informação
# # (ii) ampliamos com a lista lematizadora grande, mas vem muito ruido (de palavras q não sao verbos)
# # (iii) limpamos a lista resultante ficando apenas as 3 formas mais relevantes (-ed, -s, ing, )
# # (iv) fazemos outras limpezas
# # (v) acrescentamos uma lista de verbos que não estao lá   <------  FALTA CORIGIR
# # (vi) acrescentamos uma lista de verbos irregulares e suas formas.  <- melhorar essa lista? - está feita com D&G
#
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("lemmasDF.1.0.RData")
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load(file="trat.Info.1.0.RData")
#
# trat.Info.1.0
# trat.Info.1.0 <- trat.Info.1.0[-grep(".* .*", trat.Info.1.0$Base),] # retirando bigramas
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
# verbs <- unique(trat.Info.1.0_verb$Base.Word)
#
#
#
# i=1
# N <- c()
# for(i in 1:length(verbs)) {
#   print(i)
#   n <- grep(paste0("^",verbs[i], "$"), lemmasDF.1.0$lemma)
#   N <- c(N,n)
#   i <- i+1
# }
# N <- unique(N)
#
# verbs_variations <- lemmasDF.1.0[N,]
#
#
#
#
# C <- c()
# for(i in 1:dim(verbs_variations)[1]) {
#   a <- str_sub(verbs_variations$lemma[i], 1, 2)
#   b <- str_sub(verbs_variations$words[i], 1, 2)
#   if(a==b) {
#     C <- c(C, i)
#   }
# }
# verbs_variations1 <- verbs_variations[C,]
# rm("a", "b", "i")
#
#
# verbs_variations.ING <- verbs_variations1[grepl("ing$", verbs_variations1$words),]  # OK
# verbs_variations.ED <- verbs_variations1[grepl("ed$", verbs_variations1$words),]    # OK
#
# verbs_variations2 <- verbs_variations1[!grepl("ing$", verbs_variations1$words),]
# verbs_variations2 <- verbs_variations2[!grepl("ed$", verbs_variations2$words),]
#
# verbs_variations.S <- verbs_variations2[grepl("s$", verbs_variations2$words),]
#
#
#
#
#
# # # criando matrix com distancias de levenshtein entre as palavras
# i=1
# Mdist <- c()
# for(i in 1:length(verbs_variations.S$words)) {
#   a <- as.character(verbs_variations.S$words[i])
#   b <- as.character(verbs_variations.S$lemma[i])
#   d <- RecordLinkage::levenshteinDist(a, b)#,  adist(
#   #costs=list(substitutions=2),
#   #useBytes=F)   #   ?????
#   Mdist <- c(Mdist, d)
#
#   i=i+1
# }
# table(Mdist)
# verbs_variations.S$dist <- Mdist
#
# verbs_variations.S_clean <- verbs_variations.S[verbs_variations.S$dist<=3,]
# verbs_variations.S_clean <- verbs_variations.S_clean[-grep("^haves", verbs_variations.S_clean$words),]
#
# verbs_variations.S_clean$lemma <- as.character(verbs_variations.S_clean$lemma)
# verbs_variations.S_clean$words <- as.character(verbs_variations.S_clean$words)
#
# C <- c()
# i=1
# for(i in 1:dim(verbs_variations.S_clean)[1]) {
#   a <- str_sub(verbs_variations.S_clean$lemma[i], 1, nchar(verbs_variations.S_clean$lemma[i]))
#   b <- str_sub(verbs_variations.S_clean$words[i], 1, nchar(verbs_variations.S_clean$words[i]))
#   if(b==paste0(a, "rs")) {
#     C <- c(C, i)
#   }
#   i <- i+1
# }
# verbs_variations.S_clean <- verbs_variations.S_clean[-C,]
# C <- c()
# i=1
# for(i in 1:dim(verbs_variations.S_clean)[1]) {
#   a <- str_sub(verbs_variations.S_clean$lemma[i], 1, nchar(verbs_variations.S_clean$lemma[i]))
#   b <- str_sub(verbs_variations.S_clean$words[i], 1, nchar(verbs_variations.S_clean$words[i]))
#   if(b==paste0(a, "ers")) {
#     C <- c(C, i)
#   }
#   i <- i+1
# }
# verbs_variations.S_clean1 <- verbs_variations.S_clean[-C,]
#
# verbs_variations.S_clean1 <- verbs_variations.S_clean1 %>%
#   group_by(lemma) %>%
#   mutate(Count = n())
#
# error <- c("^hons", "^fancies", "^disposals", "^riotous", "^coloureds", "^rereads", "^deliveries", "^advertizers", "^beens", "^discoveries",
#            "^figs", "^recoveries", "^operatives", "^organisers", "^crawlies", "^cooperatives", "^wastages", "^erasures", "^demonstratives",
#            "^obligates", "^financiers", "^exposures", "^initiatives", "^eds", "^constraints", "^treasuries", "^wakens", "^refs", "^analysis",
#            "^enclosures", "^assemblages", "^summonses", "^aspirates", "^drunks", "^loveys", "^adverts", "^apps", "^injuries", "^shots")
# for(i in 1:length(error)) {
#   verbs_variations.S_clean1 <- verbs_variations.S_clean1[-grep(error[i], verbs_variations.S_clean1$words),]
# }
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("als$", verbs_variations.S_clean1$words),]
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("ors$", verbs_variations.S_clean1$words),]
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("ents$", verbs_variations.S_clean1$words),]
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("ees$", verbs_variations.S_clean1$words),]
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("ess$", verbs_variations.S_clean1$words),]
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[!grepl("ous$", verbs_variations.S_clean1$words),]
#
# verbs_variations.S_clean1 <- verbs_variations.S_clean1[c(1,2)]
#
#
#
#
# setwd("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data")
# load("irregularVerbsDF.RData")
#
# past.irg <- irregularVerbs[c(1,2)]
# colnames(past.irg) <- c("lemma", "words")
# part.irg <- irregularVerbs[c(1,3)]
# colnames(part.irg) <- c("lemma", "words")
# irreg.verbs <- rbind(past.irg, part.irg)
#
#
# verbs_miss <-
#   read.csv2("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR/data/verbs/after_clean/verbs_missing1.csv",
#             sep = ",",
#             header = F)
# colnames(verbs_miss) <- c("lemma", "words")
# verbs_miss <- verbs_miss[verbs_miss$words != "",]
#
#
# verbs_vars <- rbind(verbs_variations.S_clean1, verbs_variations.ED, verbs_variations.ING, irreg.verbs, verbs_miss)
# colnames(verbs_vars) <- c("Base.Word", "words")
#
#
# trat.Info.1.0_verb
# verbs <- full_join(verbs_vars, trat.Info.1.0_verb, by="Base.Word")
#
#
# verbs$words <- beg2char(verbs$words, "/", 1)
# verbs$Base.Word[grep("^lie", verbs$Base.Word)] <- "lie"
# e <- data.frame(Base.Word=c("bear", "bear", "bear", "bear"),
#                 words=c("born", "borne", "born", "borne"),
#                 Level=c("C1", "C2", "C1", "C2"),
#                 Part.of.Speech=c("verb","verb","verb","verb"))
# verbs <- rbind(verbs, e)
# verbs <- verbs[-grep("\\(", verbs$words),]
# verbs <- verbs[-grep("\\…", verbs$words),]
#
# c1 <- verbs[is.na(verbs$Base.Word),]
# c2 <- verbs[is.na(verbs$words),]
# c3 <- verbs[is.na(verbs$Level),]
# c4 <- verbs[is.na(verbs$Part.of.Speech),]
# C <- unique(rbind(c1, c2, c3, c4))
# verbs <- na.omit(verbs)
#
# # ### <-------  na verdade a lista de 97 precisa ser acrescentada com as variantes
#
#
#
# rm("a", "b" ,"C", "c1" , "c2", "c3" , "c4", "d" , "e", "error" , "i", "irreg.verbs", "irregularVerbs",
#   "Mdist", "n" , "N" , "part.irg" , "past.irg", "verbs_miss" , "verbs_variations" ,"verbs_variations.ED",
#   "verbs_variations.ING","verbs_variations.S", "verbs_variations.S_clean", "verbs_variations.S_clean1",
#   "verbs_variations1", "verbs_variations2", "verbs_vars")





