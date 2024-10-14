# uncomment and run if not installed
# install.packages("stylo")

# set the working directory
# with file.path there is no need to worry about the different operating systems, it'll handle them automatically
setwd(file.path("~", "Documents", "projects", "seneca_paper", "seneca_stylometry", 
                "3_analysis", "pca_bct_results", "pca_seneca_corpus"))
# if there is an error in the previous command, then "Session" > "Set Working Directory", "Choose Directory...", 
# "seneca_stylometry/3_analysis/pca_bct_results/pca_seneca_corpus"
# verify directory
getwd()

library(stylo)
# library(pheatmap)

# load the corpus for the validation of PCA
raw.corpus <- load.corpus(files = "all", 
                          corpus.dir = file.path("..", "..", "..", 
                                                 "corpora", "corpus_seneca"),
                          encoding = "UTF-8")

# tokenize the corpus using the extended Latin
tokenized.corpus <- txt.to.words.ext(raw.corpus, 
                                     corpus.lang = "Latin.corr", 
                                     preserve.case = F) # break texts into tokens

# remove the pronouns using the extended Latin
corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

# extract features (character 4-grams)
corpus.char.4.grams <- txt.to.features(corpus.no.pronouns, 
                                       features = "c", 
                                       ngram.size = 4) # break the text into character 4-grams

# create a list of the features and their raw frequencies
frequent.features.4grams <- make.frequency.list(corpus.char.4.grams, 
                                                head = 2000) # extract the features

# create a table that combine features, documents, and relative frequencies
freqs.4grams <- make.table.of.frequencies(corpus.char.4.grams,
                                          features = frequent.features.4grams, 
                                          relative = T) # relative=True to compute the relative frequency

# PCA correlation - top 100-2000-100 incr.100 MFCs 4-grams
results_pca_4grams_cor = stylo(frequencies = freqs.4grams, 
                               analysis.type = "PCR",
                               mfw.min = 100, mfw.max = 2000, increment=100, 
                               distance.measure = "wurzburg", # Cosine Delta
                               custom.graph.title = "Comparison of Seneca's plays", # title of the plot
                               pca.visual.flavour="classic", # flavour of the PCA plot
                               write.pdf.file=T, # write the results into png files
                               gui = T) # gui = True to double-check the parameters

# REPLICATION STEPS ON STYLO'S GUI (PCA-Correlation validation)

# Note: `stylo_config.txt` provides a detailed version of the parameters used throughout this experiment. 
# It can be found in `seneca_stylometry/3_analysis/results/pca_bct_results/pca_seneca_corpus/stylo_config.txt`.

#-----------------------------------

#1) Run the script in the cell below, which will opent the Graphic User Interface (GUI) of *Stylo*
#2) On the GUI select the following, if they are not already selected:
  
# * INPUT & LANGUAGE
#   - INPUT: `plain text` 
#   - LANGUAGE: `Latin (u/v > u)`
# * FEATURES
#   - FEATURES: `chars`, `ngram size: 4`
#   - MFW SETTING: `Minimum: 100`, `Maximum: 2000`, `Increment: 100`, `Start at freq. rank: 1`
#   - CULLING: `Delete pronouns: YES`
# * STATISTICS
#   - STATISTICS: `PCA (corr.)`
#   - DELTA DISTANCE: `Cosine Delta`
# * SAMPLING
#   - `No sampling`
# * OUTPUT
#   - GRAPHS: `Onscreen`, `PDF`

# -----------------------------------