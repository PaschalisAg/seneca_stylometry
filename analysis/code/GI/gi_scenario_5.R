# Scenario 5: GI on Kestemont's corpus augmented with our main dataset
install.packages("stylo")
install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("patchwork")

library(stylo)
library(ggplot2)
library(RColorBrewer)
library(patchwork)


# uncomment and run for the colorblind-friendle palettes of colours
# display.brewer.all(colorblindFriendly=TRUE)

# change the working director
setwd("../../../analysis/")
getwd()

# load the corpus
raw.corpus <- load.corpus(
  files = "all",
  corpus.dir = "corpora/corpus_kestemont/",
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


# ----------------------------------------
# the following lines are simply to double-check whether we are focusing on the correct texts

# print the name of the rows of the table
# we do that in order to find the exact row where the features
# of the disputed text(s) is/are.
options(max.print = 3060)
rownames(data)

# rows for Octavia
rownames(data)[2059:2069]
# rows for Hercules Oetaeus
rownames(data)[1954:1977]

# candidate author: Seneca
candidate.set.seneca <- data[c(1717:1953, 1978:2058, 2070:2146), 1:2000]
rownames(candidate.set.seneca)

# impostors
reference.set <- data[-c(1717:2146), 1:2000]
rownames(reference_set)
# ------------------------------------------


# Octavia
# initialize empty lists for the results
octavia_results <- list()
# help("imposters")
# Octavia's chunks start from the 740th row and go up to the 750th row
for (n in 2059:2069) {
  test <- data[n, 1:2000] # octavia's chunks
  # all the texts of seneca (verse & prose) excluding the two disputed plays
  candidate.set.seneca <- data[c(1717:1953, 1978:2058, 2070:2146), 1:2000]
  # all the texts of all the impostors
  reference.set <- data[-c(1717:2146), 1:2000]
  octavia_result <- max(summary(imposters(
    test = test,
    reference.set = reference.set,
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
  geom_point(aes(color = score < 0.9), size = 2.5) +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     labels = c("Above threshold", "Below threshold")) +
  geom_hline(yintercept = 0.9, linetype="dashed", color="blue") +
  theme_minimal() + 
  labs(x = "Chunk", y = "GI method score") +
  ggtitle("Octavia Imposter Scores for each chunk using in-prose and in-verse texts") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = 0.9, label = "0.9", hjust =1, vjust = 0.5, color="black") +
  scale_y_continuous(limits = c(0, 1))

p1
octavia_df


# Hercules Oetaeus

# create an empty list to save the results from the GI
ho_results <- list()

# apply GI to each chunk of HO
for (n in 1954:1977) {
  test <- data[n, 1:2000] # hercules oetaeus's chunks
  # all the texts of seneca (verse & prose) excluding the two disputed plays
  candidate.set.seneca <- data[c(1717:1953, 1978:2058, 2070:2146), 1:2000]
  # all the texts of all the impostors
  reference.set <- data[-c(1717:2146), 1:2000]
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
  chunk = 1:24,
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
  ggtitle("Hercules Oetaeus Imposter Scores for each chunk using in-prose and in-verse texts") +
  scale_fill_brewer(palette = "Reds") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = 0.9, label = "0.9", hjust =1, vjust = 0.5, color="black") +
  scale_y_continuous(limits = c(0,1))

ho_df
p2


# plot the two plots next to each other sharing the same x-axis
# jpeg(file="../imposters_results/imposters_chunks_oct_ho.jpeg")
# combined_plot <- p1 + p2 + plot_layout(ncol = 2, heights = c(1, 1))
# dev.off()
