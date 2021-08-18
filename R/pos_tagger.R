
######### POS TAGGING
# https://slcladal.github.io/tagging.html
# see also:
# https://tm4ss.github.io/docs/Tutorial_1_Web_scraping.html
# http://www.infogistics.com/posdemo.htm


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


# options(stringsAsFactors = F)         # no automatic data transformation
# options("scipen" = 100, "digits" = 4) # suppress math annotation
#
# if(require(dplyr) == F) install.packages("dplyr"); require(dplyr)
# if(require(igraph) == F) install.packages("igraph"); require(igraph)
# if(require(tm) == F) install.packages("tm"); require(tm)
# if(require(NLP) == F) install.packages("NLP"); require(NLP)
# if(require(openNLP) == F) install.packages("openNLP"); require(openNLP)
# # A word of warning is in order here. The `openNLP` library is written is Java and
# # may require a re-installation of Java as well as re-setting the path variable to Java.
# #  https://www.youtube.com/watch?v=yrRmLOcB9fg
# if(require(openNLPdata) == F) install.packages("openNLPdata"); require(openNLPdata)
# # if(require(coreNLP) == F) install.packages("coreNLP"); require(coreNLP)
# if(require(stringr) == F) install.packages("stringr"); require(stringr)
# if(require(koRpus) == F) install.packages("koRpus"); require(koRpus)
# if(require(koRpus.lang.en) == F) install.packages("koRpus.lang.en"); require(koRpus.lang.en)





# You need to change the path that is used in the code below and include the path to `
# en-pos-maxent.bin` on your computer!
POStag <- function(object){
  require("stringr")
  require("NLP")
  require("openNLP")
  require("openNLPdata")
  # define paths to corpus files
  object <- gsub("\\\\", "", object)
  object <- gsub("“|”", "", object)
  corpus.tmp <- object
  # define sentence annotator
  sent_token_annotator <- Maxent_Sent_Token_Annotator()
  # define word annotator
  word_token_annotator <- Maxent_Word_Token_Annotator()
  # define pos annotator
  pos_tag_annotator <- Maxent_POS_Tag_Annotator(language = "en", probs = FALSE,
                                                # WARNING: YOU NEED TO INCLUDE YOUR OWN PATH HERE!
                                                model = "C:/Users/Paren/OneDrive/Documentos/R/win-library/4.0/openNLPdata/models/en-pos-maxent.bin")
  # convert all file content to strings
  Corpus <- lapply(corpus.tmp, function(x){
    x <- as.String(x)  }  )
  # loop over file contents
  lapply(Corpus, function(x){
    y1 <- NLP::annotate(x, list(sent_token_annotator, word_token_annotator))
    y2<- NLP::annotate(x, pos_tag_annotator, y1)
    y2w <- subset(y2, type == "word")
    tags <- sapply(y2w$features, '[[', "POS")
    r1 <- sprintf("%s/%s", x[y2w], tags)
    r2 <- paste(r1, collapse = " ")

    textpos <- r2[[1]]
    textpos <- gsub("\\.\\./CC", "", textpos)
    textpos <- gsub("\\./\\.", ".", textpos)
    textpos <- gsub("/''", "", textpos)
    textpos <- gsub("\\. /..", "", textpos)  # sera melhor . (\\.) ao inves de pontuação ([[:punct:]]) ?
    textpos <- gsub("\\. /...", "", textpos)
    textpos <- gsub("\"", "", textpos)
    r2 <- gsub("/\\.", "", textpos)

    return(r2)  }  )
}



### Carregando uma legenda para testar o tagger
# # # carregando a legenda
# example <- "https://www.youtube.com/watch?v=KQqHDEYpIvI" #
# Legendas <- youtubecaption::get_caption(url = example,
#                                         language = "en",  # ATENCAO PARA A ESCOLHA DA LEGENDA
#                                         savexl = FALSE, openxl = FALSE, path = getwd())
# Legendas_selec <- Legendas$text
# # # # unindo em um texto corrido
# text <- paste(Legendas_selec, collapse= " ")
# # # # clean data
# text <- text %>% str_squish()
# # # inspect data
# # str(text)
#
# # # # função POS tagger
# textpos <- POStag(object = text)
# textpos






##### Transformando o texto em frases

# # # opção 1 (coloca o separador em um string diferente)
# str_count(textpos, boundary("sentence"))   # retorna o numero de sentenças do string
#
# z <- tokenizers::tokenize_sentences(textpos)
# z <- z[[1]]
# y <- tokenizers::tokenize_sentences(text)
# y <- y[[1]]
# XXX <- data.frame(lemma=y, pos=z)
#
#
# # # # opção 2 (coloca o separador no final do string anterior)
# w <- unlist(strsplit(textpos, "(?<=\\.)\\s(?=[A-Z])", perl = T))
# w
# y <- unlist(strsplit(text, "(?<=\\.)\\s(?=[A-Z])", perl = T))
# y
# XXX <- data.frame(lemma=c(y, NA, NA, NA, NA), pos=w)



