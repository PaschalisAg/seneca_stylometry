# devtools::install_github("thomasp85/patchwork")

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
  corpus.dir = "../analysis/corpora/corpus_chunks/",
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
  head = 5000,
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
options(max.print = 1300)
# rows for Octavia
rownames(data)[740:750]
# rows for Hercules Oetaeus
rownames(data)[704:727]


# Octavia

# initialize empty lists for the results
octavia_results <- list()

# Octavia's chunks start from the 740th row and go up to the 750th row
for (n in 740:750) {
  test <- data[n, 1:2000]
  reference.set <- data[-c(n, 676:703, 728:739, 751:814), 1:2000]
  candidate.set.seneca <- data[c(676:703, 728:739, 751:814), 1:2000]
  octavia_result <- max(summary(imposters(
    reference.set = reference.set,
    test = test,
    candidate.set = candidate.set.seneca,
    iterations = 1000,
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
  geom_point(aes(color = score < mean(score)), size = 2) +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     labels = c("Below mean", "Above mean")) +  #
  geom_hline(yintercept = mean(octavia_df$score), linetype="dashed") +
  theme_minimal() + 
  labs(x = "Chunk", y = "GI method score") +
  ggtitle("Octavia Imposter Scores for each chunk") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = mean(octavia_df$score), label = "Mean", hjust = 1, vjust = 0.5)

p1
octavia_df
# Hercules Oetaeus

# create an empty list to save the results from the GI
ho_results <- list()

# apply GI to each chunk of HO
for (n in 704:727) {
  test <- data[n, 1:2000]
  reference.set <- data[-c(n, 676:703, 728:739, 751:814), 1:2000] 
  candidate.set.seneca <- data[c(676:703, 728:739, 751:814), 1:2000]
  ho_result <- max(summary(imposters(
    reference.set = reference.set,
    test = test,
    candidate.set = candidate.set.seneca,
    iterations = 1000,
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
  geom_point(aes(color = score < mean(score)), size = 2) +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"),
                     labels = c("Below mean", "Above mean")) +
  geom_hline(yintercept = mean(ho_df$score), linetype = "dashed") +
  theme_minimal() + 
  labs(x = "Chunk") +  # Removed the y-axis label
  ggtitle("Hercules Oetaeus Imposter Scores for each chunk") +
  scale_fill_brewer(palette = "Reds") +
  guides(color = guide_legend(title = "Legend", override.aes = list(shape = 16, size = 3))) +
  annotate("text", x = Inf, y = mean(ho_df$score), label = "Mean", hjust = 1, vjust = 0.5)

ho_df
p2
# plot the two plots next to each other sharing the same x-axis
# jpeg(file="../imposters_results/imposters_chunks_oct_ho.jpeg")
# combined_plot <- p1 + p2 + plot_layout(ncol = 2, heights = c(1, 1))
# dev.off()
