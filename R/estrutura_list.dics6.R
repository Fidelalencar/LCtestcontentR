

# ################# Criando a lista de exemplos
#
# if(require(xlsx) == F) install.packages("xlsx"); require(xlsx)
# List_examples <- read.xlsx(path = "C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras",
#                              file = "List_examples.xlsx",
#                              header = F,
#                              sheetName = "Sheet1")
#
# colnames(List_examples) <- c("examples", "base_Word")
#
# z <- data.frame(table(List_examples$base_Word))
#
# table(z$Freq)
#
#
#
# n <- grep("nature", List_examples$base_Word)
# nn <- sample(n, 1)
# List_examples$examples[nn]
#
#
# # devtools::load_all("C:/Users/Paren/Dropbox/Learning_Community/LCtestcontentR")
# # library(tm)
# # basewordlemmatized_raw <- our_lemmatizer2(List_examples$base_Word)
#
#
# df <- cbind(List_examples$base_Word,  c(basewordlemmatized_raw, NA, NA, NA, NA, NA, NA))
#
#
# # N: 3356, 3357, 3358, 4360, 7908, 11129, 12806, 12807
#
# basewordlemmatized <- c(basewordlemmatized_raw[1:3355], NA, NA, NA, basewordlemmatized_raw[3356:length(basewordlemmatized_raw)])
# df <- cbind(List_examples$base_Word,  c(basewordlemmatized, NA, NA, NA))
#
# basewordlemmatized <- c(basewordlemmatized[1:4359], NA, basewordlemmatized[4360:length(basewordlemmatized)])
# df <- cbind(List_examples$base_Word,  c(basewordlemmatized, NA, NA))
#
# basewordlemmatized <- c(basewordlemmatized[1:7907], NA, basewordlemmatized[7908:length(basewordlemmatized)])
# df <- cbind(List_examples$base_Word,  c(basewordlemmatized, NA))
#
# basewordlemmatized <- c(basewordlemmatized[1:11128], NA, basewordlemmatized[11129:length(basewordlemmatized)])
# df <- cbind(List_examples$base_Word,  basewordlemmatized)
#
#
# List_examples[3] <- basewordlemmatized
#
# colnames(List_examples) <- c("examples", "base_Word", "base_Word_lemmatized")
#
#
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# # # save(List_examples, file="List_examples.RData")







########### tratando

# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# load("List_examples.RData")


# # separando os dados em uma lista com base words de uma so palavra e outra de mais palavras
# List_examples1 <- List_examples[!grepl(". .", List_examples$base_Word),]
# List_examples2 <- List_examples[grepl(". .", List_examples$base_Word),]









