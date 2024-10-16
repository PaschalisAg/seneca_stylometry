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
# display.brewer.all(colorblindFriendly=TRUE)

# change the working directory

# load the corpus
raw.corpus <- load.corpus(
  files = "all",
  corpus.dir = "3_analysis/corpora/gi_scen_4_corpus/",
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

# Perform multiple runs and calculate average and standard deviation for each chunk

# Number of runs
num_runs <- 10

# Octavia
# Initialize empty lists for storing results from each run
octavia_results_all <- vector("list", num_runs)

# Loop over the number of runs
for (run in 1:num_runs) {
  octavia_results <- list()
  for (n in 832:842) {
    test <- data[n, 1:2000]
    octavia_result <- max(summary(imposters(
      reference.set = reference.set,
      test = test,
      candidate.set = candidate.set.seneca,
      iterations = 100,
      distance = "wurzburg"
    )))
    octavia_results[[n]] <- octavia_result
  }
  octavia_results_all[[run]] <- unlist(octavia_results)
}

# Convert the results into a data frame where each column represents a run
octavia_matrix <- do.call(cbind, octavia_results_all)

# Calculate the mean and standard deviation for each chunk across runs
octavia_mean <- apply(octavia_matrix, 1, mean)
octavia_sd <- apply(octavia_matrix, 1, sd)

# Create a data frame with the mean and standard deviation
octavia_df <- data.frame(
  chunk = 1:11,
  average_score = octavia_mean,
  score_sd = octavia_sd
)

# Plot the average score with error bars representing the standard deviation
p1 <- ggplot(octavia_df, aes(x = factor(chunk), y = average_score)) +
  # Conditional coloring based on whether score_mean is below 0.9
  geom_point(aes(color = average_score < 0.9), size = 2.5, shape = 21, stroke = .7) +
  geom_errorbar(aes(ymin = average_score - score_sd, ymax = average_score + score_sd), width = 0.2) +
  geom_hline(yintercept = 0.9, linetype="dashed", color="blue") + 
  theme_minimal() + 
  labs(x = "Chunk", y = "Average GI method score") +
  ggtitle("Scenario 4 - Octavia Imposter Scores (10 runs)") +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"), guide = "legend") + 
  scale_y_continuous(limits = c(0, 1))
p1


# Similarly, you can modify the code for Hercules Oetaeus

# Hercules Oetaeus
ho_results_all <- vector("list", num_runs)

for (run in 1:num_runs) {
  ho_results <- list()
  for (n in 797:819) {
    test <- data[n, 1:2000]
    ho_result <- max(summary(imposters(
      reference.set = reference.set,
      test = test,
      candidate.set = candidate.set.seneca,
      iterations = 100,
      distance = "wurzburg"
    )))
    ho_results[[n]] <- ho_result
  }
  ho_results_all[[run]] <- unlist(ho_results)
}

# Convert results into a data frame for Hercules Oetaeus
ho_matrix <- do.call(cbind, ho_results_all)

# Calculate the mean and standard deviation
ho_mean <- apply(ho_matrix, 1, mean)
ho_sd <- apply(ho_matrix, 1, sd)

# Create a data frame with the mean and standard deviation
ho_df <- data.frame(
  chunk = 1:23,
  average_score = ho_mean,
  score_sd = ho_sd
)

# Plot the average score with error bars for Hercules Oetaeus
p2 <- ggplot(ho_df, aes(x = factor(chunk), y = average_score)) +
  geom_point(aes(color = average_score < 0.9), size = 2.5, shape = 21, stroke = .7) +
  geom_errorbar(aes(ymin = average_score - score_sd, ymax = average_score + score_sd), width = 0.2) +
  geom_hline(yintercept = 0.9, linetype="dashed", color="blue") + 
  theme_minimal() + 
  labs(x = "Chunk", y = "Average GI method score") +  
  ggtitle("Scenario 4 - Hercules Oetaeus Imposter Scores (10 runs)") +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "black"), guide = "legend") + 
  scale_y_continuous(limits = c(0, 1))

p2

# save Octavia plot - GI scenario 4
ggsave(p1, 
       filename = file.path("3_analysis", "results", "GI_results", "scenario_4", "scen_4_o_chunks_gi_m_std_10runs.pdf"),
       device = "pdf",
       dpi = 500)
# save Octavia results - GI scenario 4
write.csv(octavia_df, 
          file.path("3_analysis", "results", "GI_results", "scenario_4", "scen_4_o_chunks_gi_m_std_10runs_results.csv"), 
          row.names = FALSE)

# save Hercules Oetaeus plot - GI scenario 4
ggsave(p2, 
       filename = file.path("3_analysis", "results", "GI_results", "scenario_4", "scen_4_ho_chunks_gi_m_std_10_runs.pdf"),
       device = "pdf",
       dpi = 500)
# save Hercules Oetaeus results - GI scenario 4
write.csv(ho_df, 
          file.path("3_analysis", "results", "GI_results", "scenario_4", "scen_4_ho_chunks_gi_m_std_10runs_results.csv"),
          row.names = FALSE)
