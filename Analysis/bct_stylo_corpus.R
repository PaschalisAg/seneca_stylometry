install.packages("gplots")
install.packages("pheatmap")

library(stylo)
library(gplots)
library(pheatmap)


setwd("/Users/paschalis/Documents/MA_DH/Thesis/Code/Analysis/")
getwd()
raw.corpus <- load.corpus(files = "all", corpus.dir = "corpus",
                          encoding = "UTF-8")

tokenized.corpus <- txt.to.words.ext(raw.corpus, corpus.lang = "Latin.corr", 
                                     preserve.case = FALSE)

# tokenized.corpus$seneca_herf2.txt[1:30]

# summary(tokenized.corpus[1:10])

# stylo.pronouns(corpus.lang = "Latin.corr")

corpus.no.pronouns <- delete.stop.words(tokenized.corpus,
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))
# summary(corpus.no.pronouns[1:10])

# if we run it by removing the pronouns, the same distribution will
# be returned

corpus.char.5.grams <- txt.to.features(corpus.no.pronouns, ngram.size = 5,
                                       features = "c")
# corpus.char.4.grams[1]
# help("make.ngrams")
# help("make.samples")

frequent.features <- make.frequency.list(corpus.char.5.grams, 
                                         head = 3000)
# frequent.features <- make.frequency.list(corpus.char.5.grams, head = 3000)

freqs <- make.table.of.frequencies(corpus.char.5.grams,
                                   features = frequent.features, relative = TRUE)


# computing BCT with consensus strenght of 0.6
bct.results = stylo(corpus.dir = "corpus", frequencies = freqs, distance.measure = "eder",
                    analysis.type = "BCT", mfw.min = 100, mfw.max = 1500, 
                    increment = 100, consensus.strength = 0.6, gui = TRUE)

summary(bct.results)
bct.results$distance.table

col <- colorRampPalette(rev(RColorBrewer::brewer.pal(n = 9, name = "Reds")))(9)

pheatmap(as.matrix(distances), color = col, 
         display_numbers = TRUE,  number_format = "%.1f", fontsize_number = 6,
         main = "Heatmap with the Eder's Delta distances\nbetween the texts in the corpus",
         treeheight_row = 70, treeheight_col = 70, number_color = "black",
         legend = TRUE, border_color = "black", angle_col = 45)
