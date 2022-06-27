library(stylo)

setwd("/Users/paschalis/Documents/MA_DH/Thesis/Code/Analysis")
getwd()

raw.corpus <- load.corpus(files = "all", corpus.dir = "corpus_seneca",
                          encoding = "UTF-8")
# tokenized.texts = load.corpus.and.parse(files="all", corpus)

# stylo.pronouns(corpus.lang = "Latin.corr")
tokenized.corpus <- txt.to.words.ext(raw.corpus, corpus.lang = "Latin.corr", 
                                     preserve.case = FALSE)

corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

# tokenized.corpus <- txt.to.words.ext(corpus.no.pronouns, corpus.lang = "Latin.corr", 
                                    # preserve.case = FALSE)
# summary(tokenized.corpus[0:33])

corpus.char.5.grams <- txt.to.features(corpus.no.pronouns, ngram.size = 5,
                                       features = "c")
# looking at character 5 grams segregates HO from the rest of the Senecan corpus
# although it doesn't behave like an outlier because it contains passages verbatim
# from Seneca

# computing a list of MFWs (trimmed to top 3000 items)

features = make.frequency.list(corpus.char.5.grams, head = 3000)

# producing a table of relative frequencies:
data = make.table.of.frequencies(corpus.char.5.grams, features = features, relative = TRUE)


# pca char 4-grams
results_pca = stylo(frequencies = data, analysis.type = "PCR",
                    mfw.min = 100, mfw.max = 1500, distance.measure = "eder", 
                    custom.graph.title = "Seneca against himself", gui = TRUE)

summary(result_pca)

result_pca$pca.coordinates


col <- colorRampPalette(rev(RColorBrewer::brewer.pal(n = 9, name = "Reds")))(9)

pheatmap(as.matrix(result_pca$pca.coordinates), color = col, 
         display_numbers = TRUE,  number_format = "%.2f", fontsize_number = 7,
         main = "Heatmap with the coordinates\nbetween the Seneca corpus",
         treeheight_row = 70, treeheight_col = 70, number_color = "grey0",
         legend = TRUE, border_color = "black", angle_col = 45)


# run the same PCA as before, but this time look at the top 100-200 MFC 4/5-grams
# this time a covariance matrix was generated
results_pca_1 = stylo(frequencies = data, analysis.type = "PCR",
                    mfw.min = 100, mfw.max = 200, distance.measure = "eder", 
                    custom.graph.title = "Imitators against Seneca\n(looking at the top MFCs)", gui = TRUE)

# gui = TRUE, in order to set the culling to 0-100-20
# and check twice the parameters of the model

# the results from the MDS are not included in the thesis, but they are interesting as well
results_mds = stylo(frequencies = data, analysis.type = "MDS",
                    mfw.min = 100, mfw.max = 200, distance.measure = "eder",
                    gui = TRUE)

