#
# # RETIRADO DO Dicionario de frequencia de palavras de Davies & Gardner
#
# # 1. listas de palavras tematicas [no script: listasTematicas_davies&gardner]
# # 2. listas de frequencia por aspectos do idioma (gramticais, expressões, semântica, etc.)
# # 3. Listas das 5000 extraidas do livro ()
# # 4. Lista das 5000 e suas collocations (palavras que mais frequentemente v?m acompanhadas)
# # 5. Lista das collocations dos phrasal verbs
# # 6. Dispersion index e Grafico de rug (Lexical Dispersion Plot)
# ###############


# #######################################################################################
# #######################################################################################
# # 2. listas de frequencia por aspectos do idioma
# #######################################################################################
#
#
# Opposites p. 106 ----

opposite <- c('new', 'old', 'good', 'bad', 'big', 'little', 'large', 'small', 'young', 'old', 'black', 'white', 'high',
               'low', 'long', 'short', 'public', 'private', 'right', 'left', 'right', 'wrong', 'same', 'different', 'best',
               'worst', 'early', 'late', 'easy', 'hard', 'soft', 'hard', 'better', 'worse', 'possible', 'impossible',
               'hot', 'cold', 'true', 'false', 'poor', 'rich', 'strong', 'weak', 'dead', 'alive', 'open', 'closed', 'light',
               'dark', 'light', 'heavy', 'positive', 'negative', 'happy', 'sad', 'modern', 'ancient', 'close', 'far', 'wide',
               'narrow', 'beautiful', 'ugly', 'powerful', 'weak', 'interesting', 'boring', 'deep', 'shallow')

# transformando em DF de duas colunas
opposites <- cbind.data.frame(split(opposite, rep(1:2, times=length(opposite)/2)), stringsAsFactors=F)
names(opposites) <- c("word", "opposite")

x <- data.frame(cbind(opposites$opposite, opposites$word))
names(x) <- c("word", "opposite")

opposites <- data.frame(rbind(opposites, x)) # lista completa (com os valores invertidos)
#
# rm(x, opposite)
#
#
# # voc spoken_english ----
#
# spoken_english <- c('lot', 'news', 'thanks', 'vote', 'bit', 'troop', 'jury', 'murder', 'poll', 'witness',
#                     'terrorism', 'think', 'know', 'talk', 'mean', 'happen', 'thank', 'join', 'guess', 'vote',
#                     'testify', 'convict', 'excuse', 'tune', 'campaign', 'rape', 'bomb', 'prosecute',
#                     'jail', 'indict', 'veto', 'interesting', 'Iraqi', 'correct', 'guilty', 'OK', 'rigid',
#                     'terrific', 'unbelievable', 'partisan', 'undercover', 'convicted', 'prolife', 'teenage',
#                     'antiwar', 'well', 'very', 'here', 'really', 'right', 'today', 'all', 'actually', 'OK',
#                     'tonight', 'certainly', 'absolutely', 'pretty', 'ahead', 'obviously', 'basically', 'tomorrow', 'yesterday', 'like', 'frankly')
#
#
#
# # voc fiction ----
#
# fiction <- c('hand', 'eye', 'head', 'room', 'door', 'face', 'mother', 'father', 'voice', 'girl', 'boy', 'arm', 'hair', 'light',
# 'window', 'bed', 'wall', 'floor', 'finger', 'shoulder', 'look', 'sit', 'stand', 'walk', 'pull', 'wait', 'smile', 'stare', 'shake',
# 'laugh', 'close', 'nod', 'wonder', 'hang', 'lay', 'lean', 'notice', 'step', 'sleep', 'touch', 'dead', 'dark', 'sorry', 'empty',
# 'tall', 'quiet', 'strange', 'thin', 'alone', 'thick', 'silent', 'gray', 'brown', 'yellow', 'tired', 'pale', 'asleep', 'glad',
# 'stupid', 'wet', 'away', 'maybe', 'suddenly', 'slowly', 'inside', 'please', 'okay', 'anyway', 'outside', 'somewhere', 'straight',
# 'barely', 'closer', 'quietly', 'gently', 'softly', 'besides', 'upstairs', 'o\'clock', 'silently')
#
#
#
# # voc popular magazines ----
# voc_popular_magazines <- c('photograph', 'artist', 'cup', 'painting', 'weight', 'heat', 'garden', 'inch', 'fat', 'sugar',
#                        'salt', 'trail', 'bike', 'pepper', 'fruit', 'vegetable', 'muscle', 'teaspoon', 'diet', 'tablespoon',
#                        'paint', 'stir', 'bake', 'install', 'chop', 'hunt', 'hike', 'drain', 'boost', 'blend', 'slice', 'sprinkle',
#                        'ski', 'boast', 'simmer', 'coat', 'cruise', 'whisk', 'rotate', 'rinse', 'digital', 'solar', 'medium', 'organic',
#                        'olive', 'immune', 'chopped', 'tender', 'rear', 'dried', 'soy', 'optional', 'excess', 'inexpensive', 'planetary',
#                        'dietary', 'decorative', 'saturated', 'handy', 'nutritional', 'evenly', 'finely', 'thinly', 'outdoors', 'clockwise',
#                        'coarsely', 'lengthwise', 'solo', 'opposite', 'ultra', 'uphill', 'chemically', 'diagonally', 'snugly', 'seamlessly',
#                        'electrically', 'downwind', 'counterclockwise', 'nutritionally', 'refreshingly')
#
#
#
#
# # voc_newspapers ----
#
# voc_newspapers <- c('game', 'team', 'season', 'player', 'official', 'county', 'director', 'executive', 'district', 'coach', 'league', 'manager',
#                     'editor', 'restaurant', 'sales', 'resident', 'fan', 'baseball', 'football', 'chairman', 'win', 'coach', 'score', 'retire', 'pitch', 'host',
#                     'average', 'oversee', 'staff', 'total', 'commute', 'email', 'bat', 'rebound', 'single', 'preheat', 'lease', 'saut?', 'renovate', 'refrigerate',
#                     'chief', 'Olympic', 'defensive', 'downtown', 'offensive', 'longtime', 'retail', 'retired', 'consecutive', 'associated', 'allstar', 'pro',
#                     'nonprofit', 'select', 'veteran', 'head', 'managing', 'winning', 'saturated', 'statewide', 'PM', 'AM', 'downtown', 'defensively', 'offensively',
#                     'nightly', 'upfront', 'athletically')
#
#
#
#
# # voc_acad_journals ----
#
# voc_acad_journals <- c('student', 'study', 'teacher', 'education', 'level', 'research', 'community', 'result', 'process', 'development',
# 'use', 'policy', 'data', 'effect', 'experience', 'activity', 'model', 'analysis', 'behavior', 'difference', 'provide', 'suggest',
# 'develop', 'require', 'base', 'indicate', 'describe', 'identify', 'represent', 'increase', 'present', 'note', 'determine', 'occur',
# 'relate', 'establish', 'examine', 'state', 'compare', 'reflect', ' social', 'political', 'economic', 'significant', 'cultural', 'environmental',
# 'physical', 'specific', 'similar', 'individual', 'various', 'religious', 'positive', 'traditional', 'academic', 'African', 'sexual',
# 'particular', 'present', 'effective', 'however', 'thus', 'for example', 'therefore', 'eg', 'significantly', 'generally', 'highly',
# 'in addition', 'relatively', 'ie', 'moreover', 'frequently', 'specifically', 'primarily', 'approximately', 'furthermore', 'similarly', 'previously', 'effectively')
#
#
#
# # new_words ----
# new_words <- c('email', 'terrorism', 'terrorist', 'affiliation', 'adolescent', 'homeland', 'website', 'Sunni', 'wireless', 'prep', 'Taliban',
# 'insurgent', 'globalization', 'SUV', 'RPG', 'anthrax', 'steroid', 'genome', 'blog', 'detainee', 'militant', 'ethanol', 'insurgency', 'yoga',
# 'recount', 'cleric', 'coping', 'tsunami', 'cellphone', 'host', 'click', 'email', 'download', 'preheat', 'bully', 'makeover', 'freak', 'partner',
# 'mentor', 'morph', 'vaccinate', 'restart', 'reconnect', 'saut?', 'hijack', 'cowrite', 'ditch', 'reference', 'swipe', 'outsource', 'transition',
# 'upload', 'refuel', 'profile', 'encrypt', 'workout', 'prep', 'splurge', 'snack', 'online', 'terrorist', 'Afghan', 'Taliban', 'Shiite', 'Pakistani',
# 'samesex', 'sectarian', 'upscale', 'embryonic', 'Islamist', 'iconic', 'faithbased', 'broadband', 'handheld', 'pandemic', 'webbased', 'nonstick',
# 'steroid', 'insurgent', 'avian', 'dotcom', 'Chechen', 'oldschool', 'clueless', 'performanceenhancing', 'highstakes', 'AlQaida', 'stcentury', 'gated',
# 'online', 'famously', 'postoperatively', 'offline', 'wirelessly', 'healthfully', 'preemptively', 'intraoperatively', 'triply', 'dayahead', 'forensically',
# 'inferiorly', 'preemptively', 'multiculturally', 'counterintuitively', 'synchronically')
#
#
#
#
#
# # irregular_plurals p. 178----
#
# irregular_plurals <- c('lives', 'leaves', 'wives', 'shelves', 'wolves', 'knives', 'thieves', 'calves', 'selves', 'halves', 'hooves', 'scarves',
#                        'housewives', 'elves', 'loaves', 'bookshelves', 'sheaves', 'potatoes', 'tomatoes', 'heroes', 'mosquitoes', 'echoes', 'volcanoes',
#                        'negroes', 'frescoes', 'dominoes', 'torpedoes', 'embargoes', 'cargoes', 'people', 'police', 'staff', 'fish', 'personnel',
#                        'aircraft', 'deer', 'salmon', 'cattle', 'sheep', 'trout', 'tuna', 'militia', 'livestock', 'spacecraft', 'clergy', 'offspring',
#                        'infantry', 'sperm', 'poultry', 'moose', 'cavalry', 'catfish', 'dice', 'gentry', 'herring', 'bison', 'pike', 'squid', 'cod',
#                        'flora', 'fauna', 'caribou', 'shellfish', 'reindeer', 'series', 'thanks', 'species', 'sales', 'clothes', 'means', 'works',
#                        'statistics', 'earnings', 'headquarters', 'corps', 'ethics', 'odds', 'Olympics', 'dynamics', 'graphics', 'remains', 'surroundings',
#                        'credentials', 'binoculars', 'sneakers', 'humanities', 'grassroots', 'outskirts', 'scissors', 'barracks', 'belongings', 'riches',
#                        'pajamas', 'demographics', 'fundamentals', 'residuals', 'whereabouts', 'essentials', 'auspices', 'alumni', 'stimuli', 'fungi', 'nuclei',
#                        'cacti', 'foci', 'pylori', 'syllabi', 'radii', 'loci', 'cognoscenti', 'literati', 'larvae', 'algae', 'nebulae', 'vertebrae', 'supernovae',
#                        'antennae', 'minutiae', 'formulae', 'personae', 'vitae', 'pneumoniae', 'hyphae', 'sequelae', 'data', 'media', 'bacteria', 'curricula',
#                        'memorabilia', 'spectra', 'strata', 'maxima', 'consortia', 'fora', 'memoranda', 'ova', 'referenda', 'matrices', 'appendices', 'interstices',
#                        'analyses', 'crises', 'hypotheses', 'diagnoses', 'parentheses', 'theses', 'emphases', 'oases', 'neuroses', 'criteria', 'phenomena', 'genera',
#                        'schemata', 'stigmata', 'women', 'men', 'gentlemen', 'fishermen', 'businessmen', 'freshmen', 'policemen', 'congressmen', 'gunmen',
#                        'servicemen', 'firemen', 'craftsmen', 'countrymen', 'linemen', 'salesmen', 'spokesmen', 'horsemen', 'sportsmen', 'workmen', 'chairmen',
#                        'teeth', 'mice', 'geese', 'brethren', 'lice', 'oxen')
#
#
#
#
#
#
#
# # Variations of the 'Simple Past' and 'Past Participle' forms - p. 186 -----
# # ATENCAO - FALTA COLOCAR A FORMA BASICA DO VERBO COMO REFERENCIA!
#
# # Variations of Simple Past forms
# simplepast_forms <- c("learned", "learnt", "drank", "drunk", "sank", "sunk",
#                       "forbade", "forbad", "spilled", "spilt", "hung", "hanged",
#                       "burned", "burnt", "lit", "lighted", "thrived",
#                       "throve", "knelt", "kneeled", "dreamed", "dreamt", "strove",
#                       "strived", "shone", "shined", "sprang", "sprung", "wove",
#                       "weaved", "bade", "bid", "spat", "spit", "dove", "dived", "shrank",
#                       "shrunk", "knitted", "knit", "leaped", "leapt", "stunk", "stank",
#                       "sneaked", "snuck")
#
# simplepast_forms <- cbind.data.frame(split(simplepast_forms, rep(1:2, times=length(simplepast_forms)/2)), stringsAsFactors=F)
# names(simplepast_forms) <- c("most_freq", "2_most_freq")
#
#
# # Variations of Past Participle forms
# pastparticiple_forms <- qcv(terms="swelled swollen, thrived thriven, learned learnt,
#                             forgotten forgot, woven weaved, struck stricken,
#                             shrunk shrunken, spilled spilt, shown showed,
#                             forbidden forbade, shaved shaven, sown sowed, dreamed dreamt,
#                             lit lighted, woken waked, burned burnt, beaten beat,
#                             hung hanged, lied lay, mowed mown, knelt kneeled,
#                             bitten bit, got gotten, bid bidden, sheared shorn,
#                             shone shined, spit spat, sewn sewed, sawed sawn,
#                             knit knitted, striven strived, sneaked snuck, laid lain,
#                             leaped leapt, proved proven", split = ",")
#
# pastparticiple_form <- qcv(terms=pastparticiple_forms, split = " ")
# rm(pastparticiple_forms)
# pastparticiple_form <- cbind.data.frame(split(pastparticiple_form, rep(1:2, times=length(simplepast_forms)/2)), stringsAsFactors=F)
# names(pastparticiple_form) <- c("most_freq", "2_most_freq")
#
#
#
#
# # most frequent suffixes used for noun creation p. 194----
#
#
# age <- c('baggage', 'lineage', 'entourage', 'assemblage', 'plumage', 'drainage', 'leakage', 'blockage', 'slippage', 'stoppage', 'postage', 'brokerage', 'postage', 'mileage',
# 'voltage', 'acreage', 'yardage', 'shrinkage', 'orphanage', 'hermitage', 'parsonage')
# al <- c('approval', 'survival', 'arrival', 'withdrawal', 'removal')
# an_ian <- c('American', 'German', 'Italian', 'European', 'Indian', 'German', 'Italian', 'Egyptian', 'Russian', 'historian', 'politician', 'musician', 'guardian', 'technician')
# ance_ence <- c('performance', 'appearance', 'existence', 'resistance', 'emergence', 'importance', 'silence', 'confidence', 'significance', 'compliance')
# ant_ent <- c('president', 'student', 'consultant', 'assistant', 'opponent', 'lubricant', 'pollutant', 'disinfectant', 'stimulant', 'coolant')
# cy <- c('privacy', 'efficiency', 'presidency', 'accuracy', 'consistency')
# dom <- c('freedom', 'wisdom', 'boredom', 'stardom', 'martyrdom')
# ee <- c('employee', 'appointee', 'detainee', 'trainee', 'interviewee', 'nominee', 'trustee', 'referee', 'amputee', 'addressee', 'retiree', 'narratee', 'escapee',
#         'returnee', 'absentee', 'devotee')
# er_or <- c('director', 'teacher', 'professor', 'leader', 'manager', 'computer', 'monitor', 'lawyer', 'philosopher', 'astronomer', 'New Yorker', 'Londoner', 'cottager')
# ery <- c('recovery', 'discovery', 'delivery', 'robbery', 'bribery')
# ry <- c('fishery', 'nursery', 'bakery', 'winery', 'brewery', 'imagery', 'pottery')
# ese <- c('Japanese', 'Chinese', 'Portuguese', 'Vietnamese', 'Timorese', 'legalese', 'bureaucratese', 'vocalese', 'computerese', 'lawyerese')
# ess <- c('actress', 'princess', 'waitress', 'mistress', 'hostess', 'princess', 'duchess', 'empress', 'countess')
# ette <- c('cigarette', 'dinette', 'kitchenette', 'rosette', 'statuette')
# ful <- c('handful', 'mouthful', 'spoonful', 'roomful', 'fistful')
# hood <- c('neighborhood', 'childhood', 'likelihood', 'adulthood', 'motherhood')
# ician  <- c('physician', 'politician', 'musician', 'technician', 'pediatrician')
# ie_y  <- c('sweetie', 'auntie', 'birdie', 'junkie', 'veggie')
# ing  <- c('meeting', 'understanding', 'beginning', 'learning', 'feeling', 'building', 'painting', 'recording', 'landing',
#           'crossing', 'dwelling', 'lining', 'coloring', 'binding', 'coating', 'fencing', 'shirting')
# ism <- c('Buddhism', 'Marxism', 'Nazism', 'Hinduism', 'criticism', 'terrorism', 'capitalism', 'nationalism', 'communism')
# ist <- c('leftist', 'Baptist', 'racist', 'feminist', 'realist', 'artist', 'scientist', 'journalist', 'tourist', 'psychologist')
# ite  <- c('muscovite', 'Israelite',  'Shiite', 'Mennonite', 'suburbanite', 'Luddite', 'urbanite')
# ity  <- c('security', 'ability', 'activity', 'reality', 'responsibility')
# let <- c('booklet', 'tablet', 'starlet', 'leaflet', 'coverlet')
# ment <- c('development', 'treatment', 'movement', 'agreement', 'argument')
# ness  <- c('darkness', 'awareness', 'illness', 'consciousness', 'fitness')
# ship <- c('membership', 'ownership', 'friendship', 'partnership', 'citizenship', 'craftsmanship', 'sportsmanship', 'workmanship', 'musicianship', 'showmanship')
# tion <- c('production', 'election', 'collection', 'investigation', 'competition')
# ure <- c('pressure', 'failure', 'departure', 'closure', 'seizure')
#
#
# suffix_list <- tibble::lst(age, al, an_ian, ance_ence, ant_ent, cy, dom, ee, er_or, ery, ry, ese, ess, ette, ful, hood, ician, ie_y, ing, ism, ist, ite, ity, let, ment, ness, ship, tion, ure)
# # transformando a lista em data.frame
# suffix_df <- stack(suffix_list)
# names(suffix_df) <- c("words", "group")
#
# rm(age, al, an_ian, ance_ence, ant_ent, cy, dom, ee, er_or, ery, ry, ese, ess, ette, ful, hood, ician, ie_y, ing, ism, ist, ite, ity, let, ment, ness, ship, tion, ure)
#
#
#
# # most frequent suffixes used for adjectives creation p. 202 ----
#
# al <- c("national", "political", "social", "real", "local", "federal", "international", "special", "general",
#          "personal", "medical", "natural", "central", "environmental", "physical")
# ive <- c("positive", "effective", "native", "negative", "active", "alive", "expensive", "conservative", "massive",
#          "creative", "competitive", "alternative", "aggressive", "sensitive", "extensive")
# ous <- c("serious", "various", "religious", "previous", "dangerous", "famous", "obvious", "enormous", "numerous",
#          "nervous", "tremendous", "curious", "continuous", "indigenous", "conscious")
# ent  <- c("different", "recent", "current", "independent", "present", "ancient", "silent", "consistent", "excellent",
#           "violent", "apparent", "permanent", "innocent", "prominent", "confident")
# less  <- c("homeless", "endless", "countless", "useless", "helpless", "relentless", "restless", "harmless", "hopeless",
#             "meaningless", "stainless", "reckless", "worthless", "motionless", "powerless")
# ate  <- c("private", "late", "appropriate", "corporate", "separate", "immediate", "ultimate", "accurate", "desperate",
#            "legitimate", "adequate", "moderate", "delicate", "intimate", "associate")
# like  <- c("like", "unlike", "alike", "childlike", "businesslike", "dreamlike", "lifelike", "warlike", "godlike",
#             "ladylike", "birdlike", "catlike", "flu like", "humanlike", "earthlike")
# ful <- c("beautiful", "successful", "powerful", "wonderful", "useful", "careful", "helpful", "painful", "awful",
#           "peaceful", "meaningful", "grateful", "colorful", "faithful", "hopeful")
#
#
# # collective nouns p. 210 ----
# # alguns collectives eu n?o entendo....
#
# batch  <- c("cookies", "letters", "eggs", "biscuits", "chocolate")
# bunch  <- c("people", "guys", "kids", "things", "stuff")
# clump  <- c("grass", "hair", "trees", "bushes", "brush")
# crowd  <- c("people", "reporters", "men", "onlookers", "students")
# flock  <- c("birds", "sheep", "geese", "pigeons", "crows")
# gang  <- c("thugs", "men", "boys", "thieves", "kids")
# group  <- c("people", "students", "men", "women", "friends")
# herd  <- c("cattle", "buffalo", "cows", "elephants", "deer")
# host  <- c("others", "problems", "issues", "reasons", "things")
# pack  <- c("cigarettes", "wolves", "lies", "dogs", "cards")
# series  <- c("events", "questions", "articles", "meetings", "studies")
# set  <- c("rules", "circumstances", "values", "questions", "problems")
# shoal  <- c("fish", "time", "wind", "torment")
# swarm  <- c("bees", "people", "mosquitoes", "locusts", "flies")
# troop  <- c("boy scouts", "soldiers", "horsemen", "monkeys", "baboons")
# act  <- c("violence", "terrorism", "war", "congress", "love")
# bit  <- c("information", "time", "money", "luck", "history")
# chip  <- c("stone", "wood", "paint", "mica", "glass")
# chunk  <- c("ice", "money", "change", "meat", "time")
# game  <- c("baseball", "golf", "basketball", "chess", "life")
# grain  <- c("sand", "salt", "rice", "truth", "dust")
# item  <- c("clothing", "evidence", "interest", "information", "gossip")
# loaf  <- c("bread", "wonder", "rye", "wheat", "sourdough")
# lump  <- c("coal", "clay", "sugar", "meat", "ice")
# piece  <- c("paper", "evidence", "legislation", "equipment", "cake")
# scrap  <- c("paper", "information", "food", "fabric", "wood")
# sheet  <- c("paper", "plastic", "ice", "rain", "glass")
# slice  <- c("bread", "pizza", "life", "cheese", "lemon")
# sliver  <- c("light", "moon", "land", "glass", "silicon")
# speck  <- c("dust", "blood", "light", "dirt", "land")
# sprinkling  <- c("freckles", "stars", "salt", "sugar", "lights")
# strip  <- c("land", "paper", "bacon", "cloth", "sand")
# trace  <- c("blood", "irony", "fat", "fear", "cholesterol")
# barrel  <- c("oil", "water", "gasoline", "monkeys", "petroleum")
# basket  <- c("food", "fruit", "goods", "bread", "stocks")
# box  <- c("chocolates", "tissues", "matches", "cereal", "candy")
# crate  <- c("ammunition", "food", "wrenches", "fruit", "equipment")
# cup  <- c("coffee", "tea", "water", "sugar", "milk")
# keg  <- c("beer", "dynamite", "gunpowder", "bolts", "powder")
# packet  <- c("information", "cigarettes", "seeds", "sugar", "data")
# sack  <- c("flour", "potatoes", "rice", "groceries", "grain")
# heap  <- c("trouble", "history", "rubble", "clothes", "garbage")
# pile  <- c("rubble", "papers", "books", "rocks", "clothes")
# stick  <- c("dynamite", "butter", "gum", "furniture", "wood")
# wedge  <- c("cheese", "lime", "lemon", "light", "land")
# dozens  <- c("people", "times", "others", "interviews", "companies")
# score_s  <- c("people", "students", "others", "children", "interviews")
# load_s  <- c("laundry", "money", "crap", "fun", "wood")
# mass_es  <- c("people", "humanity", "earth", "material", "hair")
# armful  <- c("books", "wood", "papers", "clothes", "flowers")
# fistful  <- c("dollars", "cash", "hair", "bills", "coins")
# handful  <- c("people", "states", "companies", "others", "men")
# mouthful  <- c("food", "water", "air", "smoke", "blood")
# spoonful  <- c("sugar", "soup", "rice", "oatmeal", "food")
# pair  <- c("shoes", "jeans", "scissors", "pants", "binoculars")
# couple  <- c("years", "weeks", "days", "months", "times")
#
#
# # phrasal verbs p. 218 ----
#
#  c("56638 go on", "11233 be back", "5489 come over", "40285 come back", " 10733 wake up", "5446 hold on",
#    "37168 come up", "10698 look back", "5274 line up", "35719 go back", "10328 go away", "5254 hang on",
#    "33613 pick up", "10038 take off", "5251 go through", "28067 find out", "9841 carry out", "5222 turn up",
#    "26705 come out", "9092 look down", "5214 pay off", "26094 go out", "8851 take up", "5194 bring in", "25268 grow up",
#    "8736 look out", "5182 turn back", "23949 point out", "8266 take over", "5156 hang up", "23563 come in",
#    "8033 pull out", "5039 put out", "23284 turn out", "7932 hold up", "4998 break up", "21711 set up", "7619 move on",
#    "4992 lay out", "19900 end up", "7511 go in", "4958 hang out", "18558 give up", "7458 catch up", "4944 welcome back",
#    "18207 make up", "7457 open up", "4874 build up", "17658 be about", "7381 reach out", "4853 start out", "17375 sit down",
#    "7342 turn around", "4822 slow down", "17356 look up", "7237 look around", "4817 sit up", "16116 come on", "7056 take out",
#    "4792 get away", "15388 get up", "6846 go off", "4719 move in", "14697 take on", "6693 put up", "513 look over",
#    "14609 go down", "6378 set out", "4481 pull up", "14505 figure out", "6376 break down", "4472 walk away", "14368 show up",
#    "5981 keep up", "4413 call out", "13668 get back", "5915 bring up", "4346 hold out", "12733 come down", "5891 check out",
#    "4193 cut off", "12618 go up", "5736 wind up", "4164 take away", "12600 get out", "5690 clean up", "4017 bring about",
#    "12559 stand up", "5557 shut down", "3981 come along", "3952 run out", "3901 stand out", "3826 sign up", "3935 bring out",
#    "3827 set off", "3804 back up", "11512 work out", "5491 go over")
#
#
#
#
#
#
#
# ##################################################################
# ###################### AREA DE TRABALHO  ----
#
# irregular_plurals <- removeNumbers(irregular_plurals)
# irregular_plurals <- removePunctuation(irregular_plurals)
# irregular_plurals <- gsub(') ,\n', ", ", irregular_plurals)
# irregular_plurals <- gsub(' , ', '", "', irregular_plurals)
# irregular_plurals <- gsub('\", \"', '", "', irregular_plurals)
# irregular_plurals <- gsub("  ", "', '", irregular_plurals)
# irregular_plurals <- gsub(" \n", "', '", irregular_plurals)
# irregular_plurals <- gsub(" n'", "'", irregular_plurals)
# irregular_plurals <- gsub("\n", "", irregular_plurals)
#
#
#
#
# ##################################################################
# ######################### Por fazer
#
#
#
#
#
# # american x british p. 168 ----
# # freq de sinonimos, pag. 175 ----
# # small little pg. 181 ----
#
#
#
#
#
#
# # Outros codigos para manipular listas ----
# #### criando t?bua (lista) de todas as palavras
# # timeWords_list <- list(months,  weekdays, seasons, intervals, dayparts,  holidays, time_general) # une os vetores em uma lista
# # names(timeWords_list) <- c("months",  "weekdays", "seasons", "intervals", "dayparts",  "holidays", "time_general") # adiciona o vetor como tags dos elementos da lista
# # str(timeWords_list) # resumo da lista
# # labels(timeWords_list) # ou names(timetable)   # ambos retornam os tags da lista
# ####
#
# ####
# # criando t?bua de todas as palavras (aqui, as "classes" saem numeradas por causa da func unlist())
# # v1 <- unlist(timeWords_list, use.names = T)
# # timeWords_df <- as.data.frame(cbind(v1, names(v1)))
# # rownames(timeWords_df) <- NULL
# # if(require(tm) == F) install.packages("tm"); require(tm)
# # timeWords_df[2] <- removeNumbers(as.vector(timeWords_df[[2]])) # aqui removemos os numeros.... mas cuidado, pq se tiver outros numeros nos strings, da ruim
# ####
#
#
#
#
#
# #######################################################################################
# #######################################################################################
# # 6. tentando criar (1) dispersion index e (2) grafico de rug (Lexical Dispersion Plot)----
# #######################################################################################
# # https://lexically.net/downloads/version7/HTML/dispersion_in_wordlist.html
# # https://stats.stackexchange.com/questions/325549/how-to-measure-dispersion-in-word-frequency-data
# # https://www.mark-davies.info/articles/davies_43.pdf
# # https://www.researchgate.net/publication/332120488_Analyzing_dispersion
#
#
# ## 1. minha tentativa
# # inserindo o texxto de teste
# v <- c("Trump called, relaxing the restrictions his biggest decision as federal projections warn of a
#            possible infection spike. As new federal projections warned of a spike in coronavirus infections
#            if shelter-in-place orders were lifted after only 30 days, President Trump said Friday that the
#            question of when to relax federal social distancing guidelines was the biggest decision I'll ever
#            make. As a practical matter, the stay-at-home orders that have kept much of the nation hunkered
#            down have been made by governors and mayors at the state and local levels. But many governors were moved to act in part by the federal guidelines meant to slow the spread
#            of the coronavirus. Mr. Trump, who has often sounded impatient for the nation - and particularly
#            its economy - to reopen, said that he would listen to the advice of the medical experts
#            before acting, but also said that he would convene a new task force with business leaders on it
#            next week to think about when to act. At a news briefing at the White House on Friday. I have a problem the the the the the the the")
#
#
# # tokenizando o texto
# if(require(tm) == F) install.packages("tm"); require(tm)
# v <- removePunctuation(v)
# # 2 formas de tokenizar
# if(require(tau) == F) install.packages("tau"); require(tau)
# v_token <- tokenize(v) # for a simple regular expression based tokenizer provided by package tau. Obs: (1) Esse tokenizador considera os espacos e pontuacao como tokens; (2) mantem "character's"como token unico
# v_token1 <- strsplit(v, " ")[[1]] # outro tokenizador
#
#
# # inserindo o vetor com o que interessa ser detectado no texto
# matches <- c("the", "as", "to")
#
# # gerando o vetor T/F e convertendo em 0/1
# x <- v_token1 %in% matches
# x <- as.numeric(x)
#
# # x <- rbinom(100, size=1, prob=0.3) # caso queira um vetor 0/1 pronto para teste
#
# z <- data.frame(x)# convertendo o vetor em data.frame
#
# # plotando o "rug graph"
# ggplot(z, aes(c(1:length(x)),x))+
#    geom_point(shape="|",
#               size=5,
#               stroke = 10
#    ) + ylim(c(1, 1))
#
# sd(x)
#
#
#
# ## 2.  usando o pacote 'qdap'
# # link: https://educationalresearchtechniques.com/2017/08/09/diversity-and-lexical-dispersion-analysis-in-r/
# # outro link: https://www.rdocumentation.org/packages/qdap/versions/2.4.3/topics/dispersion_plot
#
# if(require(qdap) == F) install.packages("qdap"); require(qdap)
# v_token1 <- data.frame(v_token1) # nesse pacote, o vetor->DF utilizado deve conter as palavras
#
# div<-diversity(v_token1$v_token1)  # Aqui se obtem os ?ndices de dispers?o: ? possivel colocar vai de um vetor (de textos) para comparar os textos
#
# dispersion_plot(v_token1$v_token1, matches) # aqui se visualiza a dispers?o: tamb?m ? possivel colocar mais de um vetor para comparar textos
#
#
#
# ## 3. Outra tentativa de Lexical Dispersion Plot
# # ver no ?ltimo 1/4 do link: http://trinker.github.io/qdap/vignettes/qdap_vignette.html
#
# term_match(raj$dialogue, c(" love ", "love", " night ", "night"))
#
# with(rajSPLIT , dispersion_plot(dialogue,       # coluna do DF onde buscar o match
#                                 c("love"),      # termo a ser identificado
#                                 grouping.var = list(fam.aff, sex), # variavel para criar as linhas
#                                 rm.vars = act)) # variavel para separar "as caixas"
# # mudando o esquema de cores
# with(rajSPLIT, dispersion_plot(dialogue, c("love", "night"),
#                                bg.color = "black",  # cor do fundo
#                                grouping.var = list(fam.aff, sex),
#                                color = "yellow",
#                                total.color = "white", # cor da dispers?o na linha de todas as palavras
#                                horiz.color="grey20"))
#
# # buscando a dispers?o lexical das palavras mais frequentes retirando as stopwords
# wrds <- freq_terms(pres_debates2012$dialogue, stopwords = Top200Words) #frequencia retirando as stopwords
# wrds2 <- spaste(wrds) # Adicionando espa?os (ver: leading/trailing), caso necessario
# # wrds2 <- c(" governor~~romney ", wrds2[-c(3, 12)]) # selecionando lista para buscar n texto : Use `~~` to maintain spaces
# with(pres_debates2012 , dispersion_plot(dialogue,
#                                         wrds2$WORD[1:10],
#                                         # rm.vars = time,
#                                         color="blue", bg.color="grey", horiz.color="grey20"))
