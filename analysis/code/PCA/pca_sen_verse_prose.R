# setting the working directory
setwd("~/Documents/seneca_paper/seneca_stylometry/analysis/")

# check if correct working dir
getwd()

# load the necessary libraries
library(stylo)
# library(gplots)
# library(pheatmap)

# load the Senecan corpus containing only the Senecan plays
raw.corpus <- load.corpus(files = "all", 
                          corpus.dir = "corpus_seneca_verse_prose/",
                          encoding = "UTF-8")

# tokenize the loaded corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus,
                                     corpus.lang = "Latin.corr",
                                     preserve.case = F)

# remove the pronouns in the corpus
corpus.no.pronouns <- delete.stop.words(tokenized.corpus,
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

# extract the features from the preprocessed corpus
corpus.char.4.grams <- txt.to.features(corpus.no.pronouns,
                                       ngram.size = 4,
                                       features = "c")

# create a vector of features in a descending order
freq.features.4grams <- make.frequency.list(corpus.char.4.grams,
                                            head = 5000,
                                            relative = T)

freqs.4grams.table <- make.table.of.frequencies(corpus.char.4.grams,
                                                features = freq.features.4grams,
                                                relative = T)

# apply PCA corr matrix to the given Senecan corpus
results.pca.4grams.corr <- stylo(frequencies = freqs.4grams.table,
                                 analysis.type = "PCR",
                                 mfw.min = 100,
                                 mfw.max = 2000,
                                 incrementation = 100,
                                 distance.measure = "wurzburg",
                                 custom.graph.title = "Seneca verse against Seneca prose?",
                                 write.png.file = T,
                                 gui = T)
