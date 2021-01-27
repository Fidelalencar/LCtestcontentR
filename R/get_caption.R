
#'legenda_sent_completa(x, y)
#'
#'A função retorna um DF com a legenda organizada em sentenças completas a cada linha.
#'
#'@param x é string com link para legenda;
#'
#'@param y é string indicando qual o idioma da legenda,
#'o valor default é "en-US". Para entender quais os possiveis strings de 'y',
#'ver o parametro language da função get_caption() do pacote "youtubecaption"
#'
legenda_sent_completa <- function(Insira_Link_do_Video_aqui, languag ="en-US") {
  if(require(youtubecaption) == F) install.packages("youtubecaption"); require(youtubecaption)
  if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
  if(require(tm) == F) install.packages("tm"); require(tm)
  if(require(tokenizers) == F) install.packages("tokenizers"); require(tokenizers)
  #pegando a legenda
  Legendas <- get_caption(url = Insira_Link_do_Video_aqui,
                          language = languag,  # "en-GB", # ATENCAO PARA A ESCOLHA DA LEGENDA
                          savexl = FALSE, openxl = FALSE, path = getwd())
  # Convertendo as legendas em data frame com as sentencas completas
  # Unindo legendas por sentenca.
  texto <- paste(Legendas$text, sep = " ", collapse = " ") # unindo as legendas em um unico texto
  texto <- str_replace_all(texto, "\n", " ")                 # recompondo os espaços
  # tokenizando por sentenca
  t <- tokenize_sentences(texto, lowercase = FALSE, strip_punct = FALSE, simplify = FALSE)
  t <- as.data.frame(t[[1]]) # transformando em data.frame
  t["text"] <- t["t[[1]]"] # mudando o nome
  t["t[[1]]"] <- NULL
  Legendas <- t
  return(Legendas)
}

