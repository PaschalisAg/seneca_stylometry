library(stylo)


setwd("/Users/paschalis/Documents/MA_DH/Thesis/Code/Analysis")
getwd()

raw.corpus <- load.corpus(files = "all", corpus.dir = "corpus",
                          encoding = "UTF-8")
# tokenized.texts = load.corpus.and.parse(files="all", corpus)

# stylo.pronouns(corpus.lang = "Latin.corr")
tokenized.corpus <- txt.to.words.ext(raw.corpus, corpus.lang = "Latin.corr", 
                                     preserve.case = FALSE)

corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

# summary(tokenized.corpus[0:33])

corpus.char.4.grams <- txt.to.features(corpus.no.pronouns, ngram.size = 4,
                                       features = "c")

# computing a list of MFWs (trimmed to top 3000 items)

features = make.frequency.list(corpus.char.4.grams, head = 3000)

# producing a table of relative frequencies:
data = make.table.of.frequencies(corpus.char.4.grams, features = features, relative = TRUE)


# getting the name of the texts
# rownames(data)

# disputed texts: Octavia (21th row) and Hercules Oetaeus (19th row)

# running imposters for Octavia using Eder Delta distance
imposters.results = imposters(reference.set = data[-c(21), 100:250], test = data[21, 100:250], 
          distance = 'eder', iterations = 1000)

# running imposters for Hercules Oetaeus using Eder Delta distance
imposters.results1 = imposters(reference.set = data[-c(19), 100:250], test = data[19, 100:250], 
          distance = 'eder', iterations = 1000)

# optimizing the decision scores
# it takes a table with frequencies as a parameters (in our case "data")
# authorial classes should be represented by >1 texts (otherwise they will be automatically excluded)

# running the computationally-intense optimization
imposters.optimize(data)

# on how to interpret the results see:
# https://computationalstylistics.github.io/docs/imposters

# help("imposters")

print(imposters.results)
print(imposters.results1)

summary(imposters.results)
summary(imposters.results1)


