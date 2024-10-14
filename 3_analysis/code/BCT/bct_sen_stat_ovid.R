# uncomment and run if not installed
# install.packages("stylo")

# set the working directory for PCA
# with file.path there is no need to worry about the different operating systems, it'll handle them automatically
setwd(file.path("~", "Documents", "projects", "seneca_paper", "seneca_stylometry", 
                "3_analysis", "pca_bct_results", "bct_sen_luc_stat"))
# if there is an error in the previous command, then "Session" > "Set Working Directory", "Choose Directory...", 
# "seneca_stylometry/3_analysis/pca_bct_results/bct_sen_luc_stat"

# verify directory
getwd()

library(stylo)

# load the corpus that contains the works of Lucan, Seneca, and Statius
raw.corpus <- load.corpus(files = "all", 
                          corpus.dir = file.path("..", "..", "..",
                                                 "corpora", "corpus_pca_bct"),
                          encoding = "UTF-8")

# tokenise using the extended version of latin
tokenized.corpus <- txt.to.words.ext(raw.corpus, 
                                     corpus.lang = "Latin.corr", 
                                     preserve.case = F) # break texts into tokens

# remove pronouns using the extended latin version
corpus.no.pronouns <- delete.stop.words(tokenized.corpus, 
                                        stop.words = stylo.pronouns(corpus.lang = "Latin.corr"))

# create the features (i.e., character 4-grams)
corpus.char.4.grams <- txt.to.features(corpus.no.pronouns, 
                                       features = "c", 
                                       ngram.size = 4) # break the text into character 4-grams

# create a list of their features and their raw frequency
frequent.features.4grams <- make.frequency.list(corpus.char.4.grams, 
                                                head = 2000) # extract the features

# create a table of documents, features, and relative frequencies
freqs.4grams <- make.table.of.frequencies(corpus.char.4.grams,
                                          features = frequent.features.4grams, 
                                          relative = T) # relative=True to compute the relative frequency

# BCT 4grams - top 100-2000-100 MFC 4 grams - consensus strength 0.5
bct.results.4grams_100_2000MFC = stylo(frequencies = freqs.4grams, # MFCs char 4grams
                                       distance.measure="wurzburg", # Cosine Delta
                                       analysis.type = "BCT", # Bootstrap Consensus Tree
                                       mfw.min = 100, mfw.max = 2000, increment = 100, # frequency band used
                                       custom.graph.title="Seneca (plays), versus Lucan and Statius", # title of the graph
                                       write.pdf.file=T, # write results into png files
                                       gui = T) # graphic user interface

# REPLICATION STEPS ON STYLO'S GUI

# Note: `stylo_config.txt` provides a detailed version of the parameters used throughout this experiment. 
# It can be found in `seneca_stylometry/3_analysis/results/pca_bct_results/bct_sen_luc_stat/stylo_config.txt`.

# -----------------------------------

# 1) Run the script in the cell below, which will opent the Graphic User Interface (GUI) of *Stylo*
# 2) On the GUI select the following, if they are not already selected:

# * INPUT & LANGUAGE
# - INPUT: `plain text` 
# - LANGUAGE: `Latin (u/v > u)`
# * FEATURES
# - FEATURES: `chars`, `ngram size: 4`
# - MFW SETTING: `Minimum: 100`, `Maximum: 2000`, `Increment: 100`, `Start at freq. rank: 1`
# - CULLING: `Delete pronouns: YES`
# * STATISTICS
# - STATISTICS: `BCT`
# - DELTA DISTANCE: `Cosine Delta`
# * SAMPLING
# - `No sampling`
# * OUTPUT
# - GRAPHS: `Onscreen`, `PDF`

# -----------------------------------