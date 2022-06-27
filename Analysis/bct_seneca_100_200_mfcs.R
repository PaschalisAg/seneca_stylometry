library(stylo)
library(gplots)
library(pheatmap)

setwd("/Users/paschalis/Documents/MA_DH/Thesis/Code/Analysis/")
getwd()
raw.corpus <- load.corpus(files = "all", corpus.dir = "corpus_seneca",
                          encoding = "UTF-8")


tokenized.corpus <- txt.to.words.ext(raw.corpus, corpus.lang = "Latin.corr", 
                                     preserve.case = FALSE)

# tokenized.corpus$seneca_herf2.txt[1:30]

# summary(tokenized.corpus[1:10])

# stylo.pronouns(corpus.lang = "Latin.corr")

corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))
# summary(corpus.no.pronouns[1:10])

corpus.char.4.grams <- txt.to.features(corpus.no.pronouns, ngram.size = 4,
                                       features = "c")

# help("make.ngrams")
# help("make.samples")

frequent.features <- make.frequency.list(corpus.char.4.grams, 
                                         head = 3000)


freqs <- make.table.of.frequencies(corpus.char.4.grams,
                                   features = frequent.features, relative = TRUE)

# computing BCT with consensus strenght of 0.6
bct.results = stylo(corpus.dir = "corpus_seneca", frequencies = freqs, distance.measure = "eder",
                    analysis.type = "BCT", mfw.min = 100, mfw.max = 200, 
                    increment = 20, consensus.strength = 0.6, gui = TRUE)