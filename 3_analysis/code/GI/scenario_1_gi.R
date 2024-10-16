# Scenario 1: GI applied on the main corpus without any pre-processing
# ----------------------------------------------------------------------

# install.packages("stylo")

# set the working directory for GI scenario 1
# with file.path there is no need to worry about the different operating systems, it'll handle them automatically
# setwd(file.path("~", "Documents", "projects", "seneca_paper", "seneca_stylometry", 
                # "3_analysis", "results", "GI_results"))
# if there is an error in the previous command, then "Session" > "Set Working Directory", "Choose Directory...", 
# "seneca_stylometry/3_analysis/pca_bct_results/bct_sen_luc_stat"

# verify directory
getwd()

# load necessary library
library(stylo)

# load the corpus from the specified directory
raw.corpus <- load.corpus(
  files = "all",  # load all files in the directory
  corpus.dir = file.path("3_analysis", "corpora", "gi_scen_1_corpus"),  # directory containing the corpus
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

# identify and confirm the rows for the disputed texts
# Octavia = 56th row
# Hercules Oetaeus = 54th row
rownames(data)[56]  # confirm row for Octavia
rownames(data)[54]  # confirm row for Hercules Oetaeus

# use the imposters method for authorship attribution

# octavia text (56th row)
oct <- data[56, 1:2000]

# Hercules Oetaeus text (54th row)
hero <- data[54, 1:2000]

# texts by Seneca (excluding disputed plays) for candidate set
# all Senecan plays should be there except for Octavia and Hercules Oetaeus
candidate.author.seneca <- data[c(52:53, 55, 57:61), 1:2000]  # rows of Seneca's known works
rownames(candidate.author.seneca)  # confirm the candidate author set

# build the reference set including imposters (excluding Seneca's works and disputed plays)
# Senecan original plays and plays under examination should be out of this
imposters.set <- data[-c(52:61), 1:2000]  # exclude rows corresponding to Seneca and disputed plays
rownames(imposters.set)  # confirm the imposters set

# apply imposters method for Octavia
imposters.octavia <- imposters(
  reference.set = imposters.set,
  test = oct,
  candidate.set = candidate.author.seneca,
  iterations = 100,  # number of iterations for imposters method
  distance = "wurzburg"  # use Cosine Delta distance measure
)

# apply imposters method for Hercules Oetaeus
imposters.hero <- imposters(
  reference.set = imposters.set,
  test = hero,
  candidate.set = candidate.author.seneca,
  iterations = 100,  # number of iterations for imposters method
  distance = "wurzburg"  # use Cosine Delta distance measure
)

# optimize imposters method parameters
# using a grid search approach, it tries to define a grey area 
# where the attribution scores are not reliable
# up until now I haven't found a way to set a random seed (neither globally nor locally) 
# to make the results reproducible
imposters.optimize(data)