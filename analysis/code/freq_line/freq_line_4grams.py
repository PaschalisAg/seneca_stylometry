import os
from sklearn.feature_extraction.text import CountVectorizer
import matplotlib.pyplot as plt
import seaborn as sns
import pprint



# define a function to read all text files in a directory 
# and combine them into a single string:
def read_corpus(directory):
    corpus = ""
    for filename in os.listdir(directory):
	# check for this condition, otherwise listdir takes into account binary files
        if filename.endswith(".txt"): 
            with open(os.path.join(directory, filename), 'r') as f:
           	# remove preceding and following whitespaces
                text = f.read().strip() 
                corpus += text # combine every text into one corpus
    return corpus

# call the read_corpus function to get a single string containing all the texts
corpus = read_corpus('../verse_corpus_imposters/')


# use CountVectorizer to transform the corpus into a matrix of charcter 4-gram counts:
vectorizer = CountVectorizer(analyzer='char', ngram_range=(4,4))
X = vectorizer.fit_transform([corpus])

# convert the matrix to a list of tuples containing the n-grams and their counts:
ngram_counts = list(zip(vectorizer.get_feature_names_out(), X.toarray()[0]))


# sort the list in descending order of the counts:
ngram_counts_sorted = sorted(ngram_counts, key=lambda x: x[1], reverse=True)
# extract the counts and plot them as a line graph:
counts = [count for _, count in ngram_counts_sorted]

sns.set_palette("colorblind")
sns.set_style("darkgrid")
# plot counts into a lineplot
sns.lineplot(counts)
# plt.plot(counts)
plt.xlim(0, 600)
plt.ylim(0, 28000)
plt.ylabel("Frequency")
plt.xlabel("Index")
plt.title("Frequency distribution among character 4grams\n9 authors - 90 texts")
plt.savefig("freq_dist_char_ngrams.png", dpi=300)  # save the plot high res - save must be before show
plt.show()

print("Top 100 MFC 4grams along with their overall frequency:\n")
pprint.pprint(ngram_counts_sorted[:100], width=110, compact=True)