# adjust the directory according to your system
# with file.path there is no need to worry about the different operating systems, it'll handle them automatically
setwd(file.path("~", "Documents", "projects", "seneca_paper", "seneca_stylometry", "2_validation", "validation_imposters", "results"))
# verify directory
getwd()

set.seed(100) # random seed for reproducibility

# in case they are not installed or need to be update, uncomment and run
# install.packages("stylo")
# install.packages("writexl")

library(stylo)
library(writexl)

# step 1 - load the corpus
raw.corpus <- load.corpus(file.path("..", "..", "validation_corpora", "validation_imp_corpus"),
  files = "all",
  corpus.dir = ,
  encoding = "UTF-8"
)

# step 2 - tokenize the coprpus
tokenized.corpus <- txt.to.words.ext(
  raw.corpus,
  corpus.lang = "Latin.corr", # use extensive latin
  preserve.case = F, # lowercase
)

# step 3 - remove the pronouns using the extensive lati
corpus.no.pronouns <- delete.stop.words(
  tokenized.corpus,
  stop.words = stylo.pronouns(corpus.lang = "Latin.corr")
)

# step 4 - convert tokens into features
corpus.char.tetragrams <- txt.to.features(
  tokenized.text = corpus.no.pronouns,
  features = "c", # character
  ngram.size = 4 # 4-grams
)

# step 5 - create the frequency list of the character 4-grams
features_char_tetragrams <- make.frequency.list(
  corpus.char.tetragrams,
  head = 2000
)

# step 6 - create a table storing the relative frequency
data = make.table.of.frequencies(
  corpus = corpus.char.tetragrams,
  features = features_char_tetragrams,
  relative = T
)

options(max.print=105)
rownames(data)

# help("imposters.optimize")
optimized_parameters <- imposters.optimize(data)

# the results come back in a vector, thus access by indexing
p1 <- optimized_parameters[1]
p2 <- optimized_parameters[2]

# create an empty dataframe where we are going to save the results
results.imposters <- data.frame()

# define the test text as the current row
# apply the imposters method to compare the test text against the reference set
# every time imposters is applied to a different text in the corpus
# the disputed Senecan plays (i.e., Octavia and Hercules Oetaeus have been manually removed)
for (n in 1:nrow(data)) {
  
  test <- data[n, 1:2000]
  
  # define the reference set as all rows except for the current row
  reference.set <- data[-n, 1:2000]
  
  # extract the real author from the filename
  filename <- rownames(data)[n]
  real_author <- strsplit(filename, "_")[[1]][1]
  
  # set a random seed
  set.seed(n)
  
  # apply the imposters method to compare the test text against the reference set
  results <- imposters(reference.set = reference.set,
                       test = test,
                       iterations = 100,
                       distance = 'wurzburg')
  
  # find the attributed author (the one with the highest score)
  max_score <- max(results)
  attributed_author <- names(results)[which.max(results)]
  
  # append the result to the results dataframe
  results.imposters <- rbind(results.imposters,
                             data.frame(document = filename,
                                        real_author = real_author,
                                        attributed_author = attributed_author,
                                        score = max_score,
                                        p1_value = p1,
                                        p2_value = p2))
}

# check if the dataframe is empty
if (nrow(results.imposters) == 0) {
  print("No results found.")
} else {
  # view the results data frame
  print(results.imposters)
}

# write the data frame into an excel spreadsheet
write_xlsx(results.imposters, file.path("..", "results", "results_imposters_valid_cosine.xlsx"))