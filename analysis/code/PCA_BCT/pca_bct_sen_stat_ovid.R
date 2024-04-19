library(stylo)
# library(pheatmap)

setwd("../../../analysis/")
getwd()

# load the corpus for the validation of PCA
raw.corpus <- load.corpus(files = "all", corpus.dir = "corpora/corpus_pca_bct/",
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
                               custom.graph.title = "PCA Seneca (plays) versus Lucan, and Statius", # title of the plot
                               pca.visual.flavour="classic", # flavour of the PCA plot
                               write.pdf.file=T, # write the results into png files
                               gui = T) # gui = True to double-check the parameters

# BCT 4grams - top 100-2000-100 MFC 4 grams - consensus strength 0.5
bct.results.4grams_100_2000MFC = stylo(frequencies = freqs.4grams, # MFCs char 4grams
                                       distance.measure="wurzburg", # Cosine Delta
                                       analysis.type = "BCT", # Bootstrap Consensus Tree
                                       mfw.min = 100, mfw.max = 2000, increment = 100, # frequency band used
                                       custom.graph.title="BCT Seneca (plays), versus Lucan and Statius", # title of the graph
                                       write.pdf.file=T, # write results into png files
                                       gui = T) # graphic user interface
