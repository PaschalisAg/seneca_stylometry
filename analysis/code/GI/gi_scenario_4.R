# Scenario 4: GI applied on the main corpus split into 500-tokens chunks
# ----------------------------------------------------------------------

# devtools::install_github("thomasp85/patchwork")
# install.packages("stylo")
# install.packages("ggplot2")
# install.packages("RColorBrewer" )
library(stylo)
library(ggplot2)
library(RColorBrewer)
# library(patchwork)


# uncomment and run for the colorblind-friendle palettes of colours
display.brewer.all(colorblindFriendly=TRUE)

# change the working directory
setwd("../../../analysis/")
getwd()

# load the corpus
raw.corpus <- load.corpus(
  files = "all",
  corpus.dir = "corpora/corpus_chunks/",
  encoding = "UTF-8"
)

# tokenize corpus
tokenized.corpus <- txt.to.words.ext(
  raw.corpus,
  corpus.lang = "Latin.corr",
  preserve.case = F
)

# remove pronouns
corpus.no.pronouns <- delete.stop.words(
  tokenized.corpus,
  stop.words = stylo.pronouns(corpus.lang = "Latin.corr")
)

# extract the features - character 4grams
corpus.char.tetragrams <- txt.to.features(
  corpus.no.pronouns,
  features = "c",
  ngram.size = 4
)

# create a list with the features generated
features.char.tetragrams <-make.frequency.list(
  corpus.char.tetragrams,
  head = 2000,
  relative = T
)

# make the table for the frequencies and the features
data <- make.table.of.frequencies(
  corpus.char.tetragrams,
  features.char.tetragrams,
  relative = T
)

# print the name of the rows of the table
# we do that in order to find the exact row where the features
# of the disputed text(s) is/are.
options(max.print = 1350)
rownames(data)

# -------------
# simply to double-check whether we are focusing on the correct texts
# rows for Octavia
oct_chunks <- rownames(data)[832:842]
oct_chunks

# rows for Hercules Oetaeus
hero_chunks <- rownames(data)[797:819]
hero_chunks

# Senecan plays excluding the disputed ones
candidate.set.seneca <- data[c(770:796, 820:831, 843:905), 1:2000]
rownames(candidate.set.seneca)


reference.set <- data[-c(770:905), 1:2000]
rownames(reference.set)
# -------------

# Octavia
# initialize empty lists for the results
octavia_results <- list()

# Octavia's chunks start from the 740th row and go up to the 750th row
for (n in 832:842) {
  test <- data[n, 1:2000]
  reference.set <- reference.set
  candidate.set.seneca <- candidate.set.seneca
  octavia_result <- max(summary(imposters(
    reference.set = reference.set,
    test = test,
    candidate.set = candidate.set.seneca,
    iterations = 100,
    distance = "wurzburg"
  )))
  octavia_results[[n]] <- octavia_result
  print(paste("Octavia rowname", n , ": ", octavia_result))
}

# create a data frame of the results
octavia_df <- data.frame(
  chunk = 1:11,
  score = unlist(octavia_results)
)


# create a dot plot
p1 <- ggplot(octavia_df, aes(x = factor(chunk), y = score)) +
  geom_point(aes(color = score <= 0.9), size = 2.5) +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     labels = c("Above threshold", "Below threshold")) +
  geom_hline(yintercept = 0.9, linetype="dashed", color="blue") + 
  theme_minimal() + 
  labs(x = "Chunk", y = "GI method score") +
  ggtitle("Octavia Imposter Scores for each chunk") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = 0.9, label = "0.9", hjust =1, vjust = 0.5, color="black") +  
  scale_y_continuous(limits = c(0, 1))


p1
octavia_df
# Hercules Oetaeus

# create an empty list to save the results from the GI
ho_results <- list()

# apply GI to each chunk of HO
for (n in 797:819) {
  test <- data[n, 1:2000]
  reference.set <- reference.set
  candidate.set.seneca <- candidate.set.seneca
  ho_result <- max(summary(imposters(
    reference.set = reference.set,
    test = test,
    candidate.set = candidate.set.seneca,
    iterations = 100,
    distance = "wurzburg"
  )))
  ho_results[[n]] <- ho_result
  print(paste("Hercules Oetaeus rowname", n , ": ", ho_result))
}

# create a data frame of the results
ho_df <- data.frame(
  chunk = 1:23,
  score = unlist(ho_results)
)

# create a dot plot
p2 <- ggplot(ho_df, aes(x = factor(chunk), y = score)) +
  geom_point(aes(color = score < 0.9), size = 2.5) +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     labels = c("Above threshold", "Below threshold")) +
  geom_hline(yintercept = 0.9, linetype="dashed", color="blue") +
  theme_minimal() + 
  labs(x = "Chunk", y = "GI method score") +  
  ggtitle("Hercules Oetaeus Imposter Scores for each chunk") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = 0.9, label = "0.9", hjust =1, vjust = 0.5, color="black") +
  scale_y_continuous(limits = c(0, 1))

p2
ho_df
 