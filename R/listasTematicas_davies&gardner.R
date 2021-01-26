#
# # RETIRADO DO Dicionario de frequencia de palavras de Davies & Gardner
#
# # 1. listas de palavras tematicas
# # 2. listas de frequencia por aspectos do idioma (gramticais, expressões, semântica, etc.)
# # 3. Listas das 5000 extraidas do livro ()
# # 4. Lista das 5000 e suas collocations (palavras que mais frequentemente v?m acompanhadas)
# # 5. Lista das collocations dos phrasal verbs
# # 6. Dispersion index e Grafico de rug (Lexical Dispersion Plot)
# ###############
#
# #######################################################################################
# #######################################################################################
# # 1. listas de palavras tematicas
# #######################################################################################
#
if(require(tidyverse) == F) install.packages("tidyverse"); require(tidyverse)
# if(require(tm) == F) install.packages("tm"); require(tm)
#
# ########## TEMATICAS COM SUBCATEOGRIAS
# tempo ----
months <- c("january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december")
weekdays <- c("Sunday", "Monday", "Tuesday", "wednesday", "Thursday", "Friday", "saturday")
seasons <- c("Summer", "Winter", "Fall", "spring", "autumn")
intervals <- c("weekend", "week", "month", "year", "decade", "century", "season", "day", "hour", "minute", "second", "moment", "generation", "millennium", "fortnight")
dayparts <- c("morning", "afternoon", "evening", "night", "noon", "midday", "midnight", "eve")
holidays <- c("christmas", "christmas eve", "easter", "thanksgiving", "labor Day", "new year", "new year's eve")
time_general <- c("present", "past", "future", "yesterday", "today", "tomorrow", "nowadays", "vacation", "sooner or later", "age", "hurry", "calendar", "schedule", "period", "date",
             "late", "soon", "early", "late", "punctual", "now", "ago", "last", "next", "current", "o'clock", "urgency", "quarter to", "quarter of")
#
# # criando lista de todas as palavras (usando os nomes dos vetores como tags da lista) : Aqui ? Facil com tibble
#
timeWords_list <- tibble::lst(months,  weekdays, seasons, intervals, dayparts,  holidays, time_general)
# transformando a lista em data.frame
timeWords_df <- stack(timeWords_list)
names(timeWords_df) <- c("words", "group")
#
# rm(months,  weekdays, seasons, intervals, dayparts, holidays, time_general)
#
# emotions ----
emotions_negative <- c("sorry",  "afraid",  "angry",  "crazy",  "guilty",  "nervous",  "scared", "desperate", "worried",  "bitter",  "uncomfortable" ,
              "anxious" ,"lonely" , "reluctant" , "disappointed", "hostile" , "uncertain" , "upset" , "embarrassed" , "depressed"  ,"suspicious",
              "unhappy" ,"awkward" , "troubled" , "grim", "furious"  ,"confused"  ,"ashamed"  ,"useless" ,"frightened" , "shocked" , "miserable",
              "bored" , "jealous" , "fearful" , "helpless" , "uneasy" ,"frustrated" , "outraged"  ,"impatient" , "hopeless" , "rotten" , "annoyed",
              "stunned" ,"hysterical" , "terrified" , "powerless" , "somber", "gloomy" , "fed up")

emotions_neutral <- c("surprised", "shy", "cautious", "thoughtful", "tense", "puzzled", "energetic", "exhausted", "shaky", "unsure", "startled",
"serene", "ambivalent", "timid", "detached", "smug", "taken aback", "apologetic", "unsettled", "sheepish", "contrite", "infatuated", "bashful",
"distracted", "repentant", "penitent", "rattled ")

emotions_positive <- c("happy", "glad", "confident", "pleased", "excited", "satisfied", "hopeful", "loving", "passionate", "sympathetic", "enthusiastic",
              "humble", "fond", "delighted", "cheerful", "compassionate", "ecstatic", "affectionate", "appreciative", "elated", "thrilled", "genial",
              "euphoric", "overjoyed", "contented", "jovial", "gleeful", "touched", "worshipful")

# criando lista de todas as palavras (usando os nomes dos vetores como tags da lista) : Aqui ? Facil com tibble
emotionsWords_list <- tibble::lst(emotions_negative, emotions_neutral, emotions_positive)
# transformando a lista em data.frame
emotionsWords_df <- stack(emotionsWords_list)
names(emotionsWords_df) <- c("words", "group")
#
# rm(emotions_negative, emotions_neutral, emotions_positive)
#
#
# ########## TEMATICAS ----
#
# color ----
color <- c('white', 'black', 'red', 'green', 'blue', 'brown', 'yellow', 'gray', 'golden', 'pink', 'orange', 'purple', 'pastel', 'violet', 'crimson', 'tan',
           'emerald', 'khaki', 'beige', 'turquoise', 'burgundy', 'indigo', 'aqua', 'magenta', 'teal', 'mauve', 'chartreuse', 'goldenrod', 'azure', 'vermilion')


# clothing ----
clothing <- c('suit', 'shoe', 'ring', 'shirt', 'dress', 'hat', 'tie', 'coat', 'jacket', 'boot', 'belt', 'pants', 'glove', 'uniform', 'skirt',
              'jeans', 'sock', 'sweater', 'robe', 'shorts', 'gown', 'scarf', 'slip', 'vest', 'blouse', 'underwear', 'necklace', 'diaper', 'earring', 'cloak',
              'bracelet', 'bra', 'apron', 'sneakers', 'stocking', 'slipper', 'blazer', 'pajamas', 'bikini', 'sweatshirt', 'baseball cap', 'nightgown',
              'high heels', 'overcoat', 'parka', 'overalls', 'swimsuit', 'tights', 'loafers', 'raincoat', 'cardigan', 'bow tie', 'halter', 'mitten', 'cowboy boot',
              'tank top', 'underpants', 'leggings', 'undershirt', 'suspenders', 'polo shirt', 'petticoat', 'pantyhose', 'trousers', 'pullover', 'leotards', 'camisole',
              'galoshes', 'sweatsuit', 'earmuffs')

clothing_general <- c('pocket', 'button', 'clothing', 'hood', 'jewelry', 'sleeve', 'collar cuff')


# animals ----
animals <- c('dog', 'fish', 'bird', 'horse', 'chicken', 'cat', 'bear', 'fox', 'turkey', 'wolf', 'deer', 'duck', 'tiger', 'cow',
             'mouse', 'eagle', 'snake', 'lion', 'rat', 'pig', 'buffalo', 'cattle', 'hawk', 'whale', 'sheep', 'bee', 'shark', 'rabbit', 'monkey',
             'elephant', 'goat', 'worm', 'crab', 'butterfly', 'turtle', 'crow', 'oyster', 'frog', 'goose', 'spider', 'mosquito', 'elk', 'dolphin',
             'ant', 'coyote', 'lobster', 'owl', 'falcon', 'mule', 'panther', 'penguin', 'dove n', 'squirrel', 'camel', 'raven', 'beetle', 'hog',
             'moose', 'pigeon', 'ape', 'pony', 'swan', 'donkey', 'beaver', 'mole', 'gorilla', 'alligator', 'hare', 'parrot', 'crocodile', 'bison',
             'leopard', 'toad', 'sparrow', 'antelope', 'quail', 'ox', 'raccoon', 'gull', 'heron')

# bodyparts ----
bodyparts <- c('hand', 'eye', 'head', 'face', 'back', 'arm', 'hair', 'leg', 'shoulder', 'finger', 'mouth', 'ear', 'foot', 'knee',
               'neck', 'lip', 'breast', 'chest', 'nose', 'tooth', 'stomach', 'cheek', 'hip', 'tongue', 'heel', 'toe', 'elbow', 'thumb', 'wrist', 'forehead',
               'chin', 'belly', 'fist', 'ankle', 'thigh', 'waist', 'eyebrow', 'beard', 'calf', 'nostril', 'armpit', 'toenail', 'moustache', 'collarbone')


# family ----
family <- c('child', 'mother', 'father', 'kid', 'parent', 'wife', 'son', 'baby', 'brother', 'husband', 'daughter', 'sister',
            'mom', 'dad', 'uncle', 'twin', 'aunt', 'grandmother', 'daddy', 'cousin', 'mama', 'grandfather', 'ancestor',
            'sibling', 'bride', 'widow', 'grandparent', 'grandchildren', 'grandma', 'papa', 'guardian', 'groom', 'nephew',
            'grandson', 'grandpa', 'orphan', 'niece', 'granddaughter', 'ex-wife', 'granny', 'brother-in-law', 'ex-husband', 'mother-in-law',
            'godfather', 'fianc?', 'soninlaw', 'sister-in-law', 'fianc?e', 'father-in-law', 'grandchild', 'daughter-in-law', 'triplet', 'widower', 'foster child', 'godmother')

# food ----
food <- c('fish', 'ice', 'salt', 'egg', 'sugar', 'chicken', 'fruit', 'pepper', 'meat', 'rice', 'vegetable', 'cream', 'apple', 'milk',
          'cheese', 'bread', 'turkey', 'sauce', 'potato', 'bean', 'butter', 'tomato', 'corn', 'cake', 'onion', 'roll', 'chocolate', 'salad',
          'olive', 'garlic', 'honey', 'soup', 'lemon', 'nut', 'salmon', 'orange ', 'sandwich', 'pie', 'beef', 'pizza', 'mushroom', 'olive oil',
          'cherry', 'dessert', 'pork', 'pasta', 'carrot', 'lamb', 'toast', 'steak', 'banana', 'grape', 'peanut', 'trout', 'crab', 'pea', 'lime',
          'burger', 'strawberry', 'peach', 'lobster', 'cereal', 'sausage', 'yogurt', 'lettuce', 'pear', 'cabbage', 'almond', 'hamburger', 'jelly',
          'pancake', 'plum', 'broccoli', 'pecan', 'biscuit', 'cucumber', 'cod', 'pudding', 'hot dog', 'asparagus', 'pickle ', 'pineapple', 'spaghetti',
          'doughnut', 'melon', 'vegetable oil', 'margarine', 'blackberry', 'taco', 'bagel', 'waffle', 'custard', 'lentil', 'cauliflower', 'legume',
          'kiwi', 'cashew', 'sunflower seed', 'pepperoni', 'jello')

food_general <- c('cup', 'dinner', 'plate', 'lunch', 'meal', 'knife', 'breakfast', 'fork', 'spoon', 'grill', 'snack', 'supper', 'picnic', 'napkin', 'toothpick')


# material  ----
material <- c('paper', 'glass', 'wood', 'stone ', 'gold', 'plastic', 'metal', 'lead', 'silver', 'steel', 'leather',
              'cotton', 'fabric', 'brick', 'silk', 'rubber', 'aluminum', 'copper', 'marble', 'bronze', 'brass', 'ink', 'ceramic',
              'silicon', 'tin', 'cement', 'wool', 'linen', 'cardboard', 'ivory', 'granite', 'tar', 'nickel', 'acrylic', 'limestone',
              'denim', 'titanium', 'sandstone', 'cobalt', 'cashmere', 'polyester', 'chromium', 'formica', 'burlap', 'teflon')

# nationalities ----
nationalities <- str_to_lower(c('American', 'Indian', 'English', 'French', 'African', 'British', 'Chinese', 'Russian', 'German',
                   'Japanese', 'Iraqi', 'Israeli', 'Arab', 'Palestinian', 'Jewish', 'Mexican', 'Italian', 'Spanish', 'Canadian',
                   'Latin', 'Korean', 'Irish', 'Greek', 'Cuban', 'Polish', 'Native American', 'Iranian', 'Dutch', 'Egyptian',
                   'Australian', 'Turkish', 'South African', 'Brazilian', 'Bosnian', 'Vietnamese', 'Swiss', 'Pakistani', 'Haitian',
                   'Czech', 'Swedish', 'Syrian', 'Serbian', 'Lebanese', 'Serb', 'Kuwaiti', 'Thai', 'Dominican', 'Danish', 'Puerto Rican',
                   'Portuguese', 'Scottish', 'Norwegian', 'Albanian', 'Indonesian', 'Hungarian', 'Colombian', 'Austrian', 'Jordanian',
                   'Belgian', 'Lithuanian', 'Argentine', 'Filipino', 'Nigerian', 'Yugoslav', 'Croatian', 'Ethiopian', 'Somali', 'Chilean',
                   'Croat', 'Spaniard', 'Armenian', 'Ukrainian', 'Taiwanese', 'Welsh', 'Peruvian', 'Jamaican', 'Georgian', 'Arabian', 'Romanian', 'Finnish'))


# professions ----

professions <- c('teacher', 'doctor', 'author', 'artist', 'professor', 'lawyer', 'editor', 'coach', 'writer', 'attorney', 'scientist',
'secretary', 'judge', 'reporter', 'actor', 'athlete', 'farmer', 'pilot', 'engineer', 'producer', 'nurse', 'journalist', 'priest', 'designer',
'historian', 'singer', 'counselor', 'baker', 'detective', 'poet', 'musician', 'economist', 'publisher', 'chef', 'photographer', 'actress', 'painter',
'architect', 'police officer', 'surgeon', 'contractor', 'dancer', 'social worker', 'therapist', 'businessman', 'pastor', 'performer', 'cook', 'fisherman',
'mechanic', 'banker', 'vendor', 'technician', 'sailor', 'diplomat', 'butler', 'seller', 'monk', 'philosopher', 'psychiatrist', 'interpreter', 'firefighter',
'waiter', 'astronaut', 'miner', 'nun', 'gardener', 'salesman', 'carpenter', 'prostitute', 'accountant', 'maid', 'waitress', 'dentist', 'barber', 'translator',
'laborer', 'security guard', 'referee', 'sculptor', 'pianist', 'fireman', 'nanny', 'receptionist', 'coroner', 'pharmacist', 'magistrate', 'cashier',
'business owner', 'horseman', 'illustrator', 'cartoonist', 'dermatologist', 'plumber', 'cameraman', 'valet', 'electrician', 'chauffeur', 'blacksmith', 'personal trainer')

professions_general <- c('president', 'director', 'official', 'worker', 'manager', 'expert', 'employee', 'agent', 'researcher', 'chief', 'investigator', 'boss', 'administrator', 'specialist', 'operator', 'clerk', 'coordinator')

government <- c('senator', 'governor', 'representative', 'vice president', 'politician', 'prime minister',
                'congressman', 'ambassador')

military <- c('soldier', 'general', 'captain', 'commander', 'colonel')


# sports ----

sports_general <- c('point', 'game', 'team', 'win', 'record', 'score', 'shoot', 'ball', 'league', 'competition', 'bike', 'championship',
                    'uniform', 'stadium', 'tournament', 'medal', 'final', 'Olympics', 'gym', 'bicycle', 'saddle', 'trophy', 'athletics',
                    'World Cup', 'golf club', 'rink', 'freestyle', 'puck', 'sailboat', 'gymnasium', 'finish line', 'golf ball', 'cleat',
                    'racquet', 'ice skates', 'surfboard', 'racecar', 'hockey stick')


sports_participants <- c('player', 'coach', 'crowd', 'athlete', 'captain', 'opponent', 'champion', 'quarterback', 'pitcher', 'rookie', 'batter',
'spectator', 'skier', 'boxer', 'golfer', 'referee', 'diver', 'jockey', 'swimmer', 'umpire', 'cyclist', 'skater', 'surfer', 'goalie', 'gymnast',
'weight lifter', 'ice skater')

sports <- c('baseball', 'football', 'golf', 'basketball', 'fishing', 'tennis', 'soccer', 'hockey', 'swimming', 'skiing', 'boxing',
                     'wrestling', 'volleyball', 'cycling', 'bowling', 'diving', 'sailing', 'gymnastics', 'lacrosse', 'rowing', 'rugby',
                     'jogging', 'badminton', 'field hockey', 'racquetball', 'windsurfing', 'mountain climbing', 'motocross', 'horse racing')

# transportation ----

transportation_general <- c('street', 'drive', 'road', 'fly', 'station', 'driver', 'flight', 'traffic', 'airport', 'pilot', 'highway',
                            'passenger', 'journey', 'parking lot', 'intersection', 'freeway', 'pedestrian', 'oneway', 'bus stop', 'road trip',
                            'speed limit', 'RV', 'round trip', 'stop sign', 'stoplight')


transportation <- c('car', 'train', 'ship', 'plane', 'truck', 'boat', 'bus', 'van', 'bike', 'jet', 'helicopter', 'airplane', 'automobile',
                    'bicycle', 'cab', 'metro', 'taxi', 'subway', 'ferry', 'ambulance', 'motorcycle', 'jeep', 'tractor', 'carriage', 'SUV',
                    'convertible', 'limo', 'pickup truck', 'space shuttle', 'limousine', 'minivan', 'police car', 'scooter', 'school bus',
                    'spaceship', 'sport car', 'trolley', 'sailboat', 'cruise ship', 'steamer', 'snowmobile', 'steamboat', 'streetcar',
                    'sport utility vehicle', 'rowboat', 'fire engine', 'cable car', 'dump truck', 'wheeler')


# weather ----

weather_general <- c('hot', 'cold', 'cool', 'warm', 'dry', 'mild', 'sunny', 'damp', 'icy', 'chilly', 'windy',
                     'cloudy', 'humid', 'foggy', 'overcast', 'scorching', 'partly cloudy', 'rain', 'snow', 'flood', 'shower',
                     'hail', 'thunder', 'drizzle')

weather_nouns <- c('season', 'sun', 'heat', 'wind', 'ice', 'sky', 'storm', 'temperature', 'cloud', 'dust', 'climate',
                   'hurricane', 'breeze', 'forecast', 'lightning', 'fog', 'drought', 'rainbow',
                   'sunshine', 'haze', 'avalanche', 'tornado', 'humidity', 'pollen', 'thermometer', 'blizzard', 'thunderstorm',
                   'Fahrenheit', 'precipitation', 'smog', 'dew', 'snowflake', 'Celsius', 'snowstorm', 'meteorologist',
                   'cyclone', 'sunburn', 'monsoon', 'downpour', 'raindrop', 'barometer', 'sleet', 'slush', 'rainstorm',
                   'heat wave', 'air pressure', 'meteorology', 'wind chill')


########## UNINDO as listas tematicas ----

tematicas_list <- tibble::lst(color, clothing, clothing_general, animals, bodyparts, family, food, food_general, material,
                              nationalities, professions, professions_general, government, military, sports_general,
                              sports_participants, sports, transportation_general, transportation, weather_general, weather_nouns)
# transformando a lista em data.frame
tematicas_df <- stack(tematicas_list)
names(tematicas_df) <- c("words", "group")
#
# rm(color, clothing, clothing_general, animals, bodyparts, family, food, food_general, material,
#    nationalities, professions, professions_general, government, military, sports_general,
#    sports_participants, sports, transportation_general, transportation, weather_general, weather_nouns)
#
# unindo tempo, emotions e as outras tematicas
thems <- rbind(timeWords_df, emotionsWords_df, tematicas_df)


#' CRIANDO UMA FUNCAO PARA RETORNAR A BASE DE DADOS COM TODAS AS PALAVRAS TEMATICAS (com palavra base e variantes)
#' tematicasDGvariantes()
#' função sem parametro. retorna DF com as listas tematicas de Davies & Gardner.
#' No entanto, elas está expandida, pois contem (1) uma coluna com os lemmas
#' (lista original com valores repetidos para os tokens de mesmo lemma);
#' (2) coluna de tokens (as tokens variantes dos lemmas foram obtidas
#' com a base hash_lemmas do pacote lexicon)
#' (3) coluna 'group' que agrupa as palavras por grupos temáticos
#' (são eles: months, weekdays, seasons, intervals, dayparts, holidays, time_general,
#' emotions_negative, emotions_neutral, emotions_positive, color, clothing,
#' clothing_general, animals, bodyparts, family, food, food_general, material,
#'  nationalities, professions, professions_general, government, military,
#'  sports_general, sports_participants, sports, transportation_general,
#'  transportation, weather_general, weather_nouns)
tematicasDGvariantes <- function() {
  # tentando expandir as palavras tematicas (thems) para todos os tokens variantes (a partir de hash_lemmas da biblioteca lexicon)
  if(require(lexicon) == F) install.packages("lexicon"); require(lexicon)
  data(hash_lemmas)
  #
  # PASSO IMPORTANTE:
  # hash_lemmas s? tem a lista das palavras modificadas. Ou seja, as palavras base s? est?o na segunda coluna (lemma), n?o na primeira (token)
  # aqui eu aumento a hash_lemmas adicionando as palavras base
  hash_lemmas_unique <- unique(hash_lemmas$lemma) # vetor de lemmas
  base_words <- data.frame(cbind(token = hash_lemmas_unique, lemma = hash_lemmas_unique)) # duplicando o vetor de lemmas unicos em um data frame (para virar o lemma e sua "variante" identica)
  hash_lemmas <- rbind(hash_lemmas, base_words) #aqui eu adiciono o vetor com lemma e variante identica a base original (hash_lemmas)
  hash_lemmas <- hash_lemmas %>% arrange(lemma) # reordenando

  # extraindo as colunas que nao interessam temporariamente
  hash <- as.factor(hash_lemmas$lemma)
  them <- as.factor(thems$words)
  #
  #
  # # limpando a area de trabalho
  # ls()
  # rm("emotionsWords_df", "emotionsWords_list", "tematicas_df", "tematicas_list", "timeWords_df",  "timeWords_list")
  #
  #
  # aqui eu encontro os indexes de 'hash' que tem palavras de 'them'
  x <- hash %in% them
  h <- subset(hash_lemmas, subset = x)  # limpando a base "hash_lemmas" para ter apenas as com palavras de 'them'
#### Inicialmente eu usava essas duas linhas ao invés da de cima, mas deu problema para criar o pacote.
#  x1 <- which(x, arr.ind = TRUE)
#  h <- hash_lemmas[x1]
####
  # # aqui esta o resultado que eu queria. IMPORTANTE:
  # # 1. foi fundamental adicionar a 'hash_lemmas'  lista das palavras modificadas. Ou seja, as palavras "base" s? estavam na segunda coluna (lemma), n?o na primeira (token)
  # # 2. muitas palavras de them s?o "express?es", termos que acho que realmente n?o faziam sentido estar em hash_lemmas. Portanto, a lista 'them' cresce, mas com muitas palavras n?o presentes em hash_lemmas
  #
  #
  # finalmente aumentamos a lista original de palavras tematicas adicionando as variantes
  thems$lemma <- thems$words
  thems$words <- NULL
  thems_com_variantes <- h %>% full_join(thems, by = "lemma")
  i <- which(is.na(thems_com_variantes$token)) # identificando com index as linhas com valor NA
  for (value in i) { # preenchendo os valores NA na coluna token com os valores da coluna lemma
    thems_com_variantes$token[value] <- thems_com_variantes$lemma[value]
  }
  thems_com_variantes <- thems_com_variantes %>% arrange(lemma)

  return(thems_com_variantes)
}


#
#
#
# rm("base_words", "h", "hash", "hash_lemmas", "hash_lemmas_unique", "them", "thems", "x", "x1")
#
#
# ## RAPIDO ADENDO: duas fun??es interessantes para estudar match: match() [retorna indices] e %in% [retorna valores logicos]
# #
# #
# # nouns <- c("call", "jump", "dance", "orange", "car", "car", "jump")
# # verbs <- c("do", "jump", "dance","call", "send", "make")
# #
# # x <- match(nouns, verbs) # match returns a vector of the positions of (first) matches of its first argument in its second.
# #
# # x <- na.omit(x) # pode usar tb a funcao  " na.exclude() "
# ##
#
#
# # exportando
#
# getwd()
# setwd("C:/Users/Paren/Dropbox/Udacity/LearningCommunityConteudo/listas_palavras")
# write.csv2(thems_com_variantes, file = "Listas_tematicas_comVariantes.csv")
#
#
#
