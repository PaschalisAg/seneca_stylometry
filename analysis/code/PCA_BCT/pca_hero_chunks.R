library(stylo)
# library(pheatmap)

setwd("../../../analysis/")
getwd()

# load the corpus for the validation of PCA
raw.corpus <- load.corpus(files = "all", corpus.dir = "corpora/corpus_sen_hero_chunks/",
                          encoding = "UTF-8")

tokenized.corpus <- txt.to.words.ext(raw.corpus, corpus.lang = "Latin.corr", 
                                     preserve.case = F) # break texts into tokens

corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

corpus.char.4.grams <- txt.to.features(corpus.no.pronouns, 
                                       features = "c", 
                                       ngram.size = 4) # break the text into character 4-grams

frequent.features.4grams <- make.frequency.list(corpus.char.4.grams, 
                                                head = 2000) # extract the features

freqs.4grams <- make.table.of.frequencies(corpus.char.4.grams,
                                          features = frequent.features.4grams, 
                                          relative = T) # relative=True to compute the relative frequency

# PCA correlation - top 100-2000-100 incr.100 MFCs 4-grams
results_pca_4grams_cor = stylo(frequencies = freqs.4grams, 
                               analysis.type = "PCR",
                               mfw.min = 100, mfw.max = 2000, increment=100, 
                               distance.measure = "wurzburg", # Cosine Delta
                               custom.graph.title = "PCA Seneca (plays) versus himself (HO in two chunks)", # title of the plot
                               pca.visual.flavour="classic", # flavour of the PCA plot
                               write.pdf.file=T, # write the results into png files
                               gui = T) # gui = True to double-check the parameters