import os
from glob import glob

directory = "../analysis/corpus_kestemont/"
for filename in os.listdir():
    if filename.startswith("sene"):
        new_filename = "sen" + filename[4:]
        os.rename(os.path.join(directory, filename), os.path.join(directory, new_filename))

# +
import os
import shutil

directory = "../analysis/corpus_kestemont/"

for filename in os.listdir(directory):
    if filename.startswith("sene"):
        new_filename = "sen" + filename[4:]
        shutil.move(os.path.join(directory, filename), os.path.join(directory, new_filename))
