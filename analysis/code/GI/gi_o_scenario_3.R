library(stylo)

# change the working directory
setwd("../../../analysis/")
getwd()

# load the corpus
raw.corpus <- load.corpus(
  files = "all",
  corpus.dir = "corpora/corpus_imposters_cento/",
  encoding = "UTF-8"
)

# tokenize corpus
tokenized.corpus <- txt.to.words.ext(
  raw.corpus,
  corpus.lang = "Latin.corr",
  preserve.case = F
)

# remove pronouns
corpus.no.pronouns <- delete.stop.words(
  tokenized.corpus,
  stop.words = stylo.pronouns(corpus.lang = "Latin.corr")
)

# extract the features - character 4grams
corpus.char.tetragrams <- txt.to.features(
  corpus.no.pronouns,
  features = "c",
  ngram.size = 4
)

# create a list with the features generated
features.char.tetragrams <-make.frequency.list(
  corpus.char.tetragrams,
  head = 5000,
  relative = T
)

# make the table for the frequencies and the features
data <- make.table.of.frequencies(
  corpus.char.tetragrams,
  features.char.tetragrams,
  relative = T
)

# print the name of the rows of the table
# we do that in order to find the exact row where the features
# of the disputed text(s) is/are.
options(max.print = 100)
rownames(data)


# Octavia = 42th row
# double-check
rownames(data)[42]
rownames(data)[40]

# imposters method
# help("imposters") 
# indicating the text to be tested (i.e., Octavia - 42th row)
# after the comma the range of the columns to be selected is being given
# the same applies for the code snippets below
oct <- data[42, 1:2000]
hero <- data[40, 1:2000]

# indicating the text that belongs to the possible candidate (i.e., Seneca)
# use c for non-contiguous rows in order to concatenate them
candidate.author.seneca <- data[c(38:39, 41, 43:47),1:2000] # the 10 plays by Seneca exlcuding the disputed plays
rownames(candidate.author.seneca)


# building the reference set that includes the imposters by excluding the texts by Seneca and the disputed play
imposters.set <- data[-c(38:47),1:2000]
rownames(imposters.set)

imposters.octavia <- imposters(
  reference.set = imposters.set,
  test = oct,
  candidate.set = candidate.author.seneca,
  iterations = 1000,
  distance = "wurzburg") # cosine delta distance

imposters.hero <- imposters(
  reference.set = imposters.set,
  test = hero,
  candidate.set = candidate.author.seneca,
  iterations = 1000,
  distance = "wurzburg") # cosine delta distance

imposters.optimize(data, distance="wurzburg")