#### APRIMORANDO A TOKENIZACAO


## textos para testar

# language = "en"
# Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=2W85Dwxx218"
# Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=zfttRfTmtuE"
# Legendas <- get_caption(url = Insira_Link_do_Video_aqui,
#                         # Insira_Link_do_Video_aqui <- "https://www.youtube.com/watch?v=R7YmA_-8zZo"
#                         language = language,  # ATENCAO PARA A ESCOLHA DA LEGENDA
#                         savexl = FALSE, openxl = FALSE, path = getwd())
#
#
# texto <- "You2're 2best44 kno33wn 9for a number of novels dealing with the social
# and marital interplay between ?migr? Americans, English people, and continental
# Europeans. Examples of such, The Ambassadors. his late works have been compared
# to impressionist painting."
#
# tokens_E_caracs <- texto
# tokens_E_caracs <- Legendas$text


## tokenizando com pacote 'tau'

#if(require(tau) == F) install.packages("tau"); require(tau)

our_tokenizer <- function(tokens_E_caracs) { # pode receber um string, um vetor ou uma coluna de DF (para pacote legendas do youtube)
  tokens_E_caracs <- tau::tokenize(tokens_E_caracs)
  ## INFOS SOBRE A FUNCAO do pacote tau:
  #(1) ela considera os espacos e pontuacao como tokens;
  #(2) excessão: mantem "'s", "'re" no token, não o separa
  #(3) ela trata numeros como letras de palavras (não os separa)
  #(3.1) Acho que o ideal seria separar os numeros tb
  #(4) a funcao funciona direto na coluna da legenda (gerada pelo youtubecaption) = OTIMO!

  ## Adaptando o tokenizador para separar os numeros
  # (1) aqui ele separa os numeros das letras, mas nao da pontuacao
  tokens_E_caracs1 <- unlist(strsplit(tokens_E_caracs, "(?=[A-Za-z])(?<=[0-9])|(?=[0-9])(?<=[A-Za-z])", perl=TRUE))
  # (2) aqui separa os numeros da pontuacao
  tokens_E_caracs2 <- character()
  for(i in 1:length(tokens_E_caracs1)) {
    e <- unlist(strsplit(tokens_E_caracs1[i], "(?=[\\[\\!\"#\\$%&'\\(\\)\\*\\+,/;<=>\\?@\\[\\\\\\]\\^`\\{\\|\\}~])(?<=[0-9])|(?=[0-9])(?<=[\\[\\!\"#\\$%&'\\(\\)\\*\\+,/;<=>\\?@\\[\\\\\\]\\^`\\{\\|\\}~])", perl=TRUE))
    tokens_E_caracs2 <- c(tokens_E_caracs2, e)
  }
  return(tokens_E_caracs2)
}





#### Identificadores de posicoes
# funcoes que retornam vetores logicos identificando a posicao dos espacos, quebras, pontuacao, etc.

## identificador dos espacos
spc <- grepl(" ", tokens_E_caracs)
## identificador de quebras
qbr <- grepl("\n", tokens_E_caracs)
## identificador de pontuacao
pnt <- grepl("[!@#$%&*()_=+{}.,]|-|\\[|\\]", tokens_E_caracs)
## identificador de numeros (identifica numeros soltos ou presentes em palavras)
nmb <- grepl("[0-9]", tokens_E_caracs)




