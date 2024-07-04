# Scenario 2: GI applied on the main corpus but HO is split into two chunks
# ----------------------------------------------------------------------

# load necessary library
# install.packages("stylo")
library(stylo)

# change the working directory to where the analysis data is located
# if error then: Session > Choose Directory > set to "../../../analysis"
setwd("../../../analysis/")
getwd()  # confirm the current working directory

# load the corpus from the specified directory
# HO is split into two chunks
raw.corpus <- load.corpus(
  files = "all",  # load all files in the directory
  corpus.dir = "corpora/corpus_imp_hero_chunks/",  # directory containing the corpus
  encoding = "UTF-8"  # ensure correct text encoding
)

# tokenize the corpus, converting the text into individual words/tokens
tokenized.corpus <- txt.to.words.ext(
  raw.corpus,
  corpus.lang = "Latin.corr",  # use Latin.corr to standardize 'u' and 'v'
  preserve.case = FALSE  # convert all text to lowercase to avoid case sensitivity issues
)

# remove pronouns from the tokenized corpus as they can be genre-specific and affect analysis
corpus.no.pronouns <- delete.stop.words(
  tokenized.corpus,
  stop.words = stylo.pronouns(corpus.lang = "Latin.corr")  # use predefined Latin pronouns list
)

# extract character 4-grams (tetragrams) from the corpus without pronouns
corpus.char.tetragrams <- txt.to.features(
  corpus.no.pronouns,
  features = "c",  # extract character features
  ngram.size = 4  # set n-gram size to 4
)

# create a frequency list of the 4-grams, keeping the top 5000 most frequent features
features.char.tetragrams <- make.frequency.list(
  corpus.char.tetragrams,
  head = 2000,  # number of features to include
  relative = TRUE  # compute relative frequencies
)

# generate a table of frequencies for the extracted features
data <- make.table.of.frequencies(
  corpus.char.tetragrams,
  features.char.tetragrams,
  relative = TRUE  # use relative frequencies
)

# print the row names of the table to identify the specific rows for the disputed texts
options(max.print = 150)
rownames(data)


# Herc. O chunk 1 = 54th row
# double-check
rownames(data)[54]
# Herc. O chunk 2 = 55th row
rownames(data)[55]

# imposters method
# help("imposters") 
# after the comma the range of the columns to be selected is being given
# the same applies for the code snippets below
hero_chunk1 <- data[54, 1:2000]
hero_chunk2 <- data[55, 1:2000]

# indicating the text that belongs to the possible candidate (i.e., Seneca)
# use c for non-contiguous rows in order to concatenate them
# exclude Octavia too
candidate.author.seneca <- data[c(52:53, 56:61),1:2000] # the 10 plays by Seneca exlcuding the disputed plays
rownames(candidate.author.seneca)


# building the reference set that includes the imposters by excluding the texts by Seneca and the disputed play
imposters.set <- data[-c(52:61),1:2000]
rownames(imposters.set)

imposters.hero.chunk1 <- imposters(
  reference.set = imposters.set,
  test = hero_chunk1,
  candidate.set = candidate.author.seneca,
  iterations = 100,
  distance = "wurzburg") # cosine delta distance

imposters.hero.chunk2 <- imposters(
  reference.set = imposters.set,
  test = hero_chunk2,
  candidate.set = candidate.author.seneca,
  iterations = 100,
  distance = "wurzburg") # cosine delta distance

imposters.optimize(data)