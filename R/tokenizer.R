#### Script para nossas ferramentas de tokenização.

#' our_tokenizer()
#'
#' Função que pode receber um string, um vetor ou uma coluna de DF (para pacote
#' legendas do youtube) e retorna um vetor com as palavras tokenizadas
#'
#' @param tokens_E_caracs string ou vetor de palavras a ser tokenizadas
#'
our_tokenizer <- function(tokens_E_caracs) { # pode receber um string, um vetor ou uma coluna de DF (para pacote legendas do youtube)
  tokens_E_caracs <- paste(tokens_E_caracs, collapse= " ")
  tokens_E_caracs <- gsub("\\n", " ", tokens_E_caracs)
  tokens_E_caracs <- gsub("’", "'", tokens_E_caracs)
  tokens_E_caracs <- gsub("…", " ", tokens_E_caracs)
  tokens_E_caracs <- tau::tokenize(tokens_E_caracs)
  tokens_E_caracs <- tokens_E_caracs[!is.na(tokens_E_caracs)]
  ## INFOS SOBRE A FUNCAO do pacote tau:
  #(1) ela considera os espacos e pontuacao como tokens;
  #(2) excessão: palavras co apostrofe mantem "'s", "'re" no token, não o separa
  #(3) ela trata numeros como letras de palavras (não os separa)
  #(3.1) Acho que o ideal seria separar os numeros tb
  #(4) a funcao funciona direto na coluna da legenda (gerada pelo youtubecaption) = OTIMO!

  ## Adaptando o tokenizador para separar os numeros
  # (1) aqui ele separa os numeros das letras, mas nao da pontuacao
  tokens_E_caracs1 <- unlist(strsplit(tokens_E_caracs, "(?=[A-Za-z])(?<=[0-9])|(?=[0-9])(?<=[A-Za-z])", perl=TRUE))
  # (2) aqui separa os numeros da pontuacao
  tokens_E_caracs2 <- character()
  for(i in 1:length(tokens_E_caracs1)) {
    e <- unlist(strsplit(tokens_E_caracs1[i], "(?=[\\[\\!\"#\\$%&\\'\\(\\)\\*\\+,/;<=>\\?@\\[\\\\\\]\\^`\\{\\|\\}~])(?<=[0-9])|(?=[0-9])(?<=[\\[\\!\"#\\$%&'\\(\\)\\*\\+,/;<=>\\?@\\[\\\\\\]\\^`\\{\\|\\}~])", perl=TRUE))
    tokens_E_caracs2 <- c(tokens_E_caracs2, e)
  }
  tokens_E_caracs2 <- tokens_E_caracs2[!is.na(tokens_E_caracs2)]
  return(tokens_E_caracs2)
}






