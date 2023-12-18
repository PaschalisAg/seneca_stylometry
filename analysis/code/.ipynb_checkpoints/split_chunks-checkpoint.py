import cltk
from cltk.tokenize.word import WordTokenizer
from glob import glob
import re
import os
import pandas as pd
import numpy as np


def extract_chunks(directory_to_read, directory_to_write, threshold_to_slice, chunk_size):
    """
    Help on function extract_chunks:


    The function `extract_chunks` slices in non-overlapping chunks the texts 
    with respect to the indicated chunk size.
    Before the extraction of the non-overlapping chunks there is a brief preprocessing, 
    such as removing the arabic numbers
    from the texts, lowering, and tokenizing the texts.

    One mandatory requirement is for the texts to be in Latin because it uses CLTK's tokenizer for Latin.

    It takes three argument:

        1) `directory_to_read`: the directory where you want the function to check for the texts to slice.
        This might be the same directory as the one where you are writing the results or a different location.

        2) `threshold_to_slice`: this threshold is translated as the limit after which the function
        will start splitting the text into chunks. For instance, if it is set to 1500, 
        then it will start splitting texts that are longer than 1500 tokens, 
        otherwise it won't do anything to them.

        3) `chunk_size`: the size of the chunk you want to write in a txt file. 
        The chunks will be non-overlapping to each other 

        4) `directory_to_write`: the directory where you want to write the results. 
        If the directory does not exist, then the function will create a new directory 
        to the appointed location. 
        If it exists already, then the function won't do anything.

    """

    def count_files_dir(directory_to_read):
        count = 0
    # iterate through every filepath in a directory
        for path in os.scandir(directory_to_read):
            # include only txt files
            if os.path.isfile(os.path.join(directory_to_read, path)) and path.name.endswith(".txt"):
                count += 1  # incerement the counter every time the condition is satisfied
        return count

    def read_file(directory):  # read the file
        with open(directory, 'r', encoding='utf-8') as inp:
            text = inp.read()
        return text

    # function to remove the arabic numbers that may exist as number lines within the text
    def preprocess(text):
        # keeps only words and whitespaces
        text = re.sub(r'[^\w\s]', '', read_file(text))
        return text  # returns the text without the numbers

    # function to tokenize latin texts
    def tokenize_latin_text(text):
        latin_tokenizer = WordTokenizer("latin")  # initialize CLTK tokenizer
        text = latin_tokenizer.tokenize(preprocess(
            text.lower()))  # lowers and tokenizes the text
        return text  # return a list class

    # check if the directory already exists
    if not os.path.exists(directory_to_write):
        os.mkdir(directory_to_write)  # if not, then create
        print("Directory successfully created!")  # print message
    else:  # if yes, then say that it already exists and return the path
        print(f"Directory in {directory_to_write} already exists!")

    # loop through each file in the directory
    for file_name in os.listdir(directory_to_read):
        # check if files is a txt file (ignore binary files or system files)
        if file_name.endswith(".txt"):
            tokens = tokenize_latin_text(
                directory_to_read + file_name)  # tokenize every text

            # check if the text is longer than the appointed limit to slice
            # texts above this limit will be split into chunks of chunk_size size
            # satire 5 has 1327 tokens, thus the slice will be set to 1350
            if len(tokens) > threshold_to_slice:
                # split the text into non-overlapping chunks of 1000 tokens each
                chunks = [tokens[i:i+chunk_size]
                          for i in range(0, len(tokens), chunk_size)]
                # write each chunk to a new file with "_chunk#" added to the file name
                for i, chunk in enumerate(chunks):
                    chunk_text = " ".join(chunk)
                    chunk_file_name = f"{file_name[:-4]}_chunk{i+1}.txt"
                    with open(os.path.join(directory_to_write, chunk_file_name), "w") as f:
                        f.write(chunk_text)

            # if the length is less than 1350 tokens, then write as it is by preserving its current filename
            else:
                text = " ".join(tokens)  # text as a string
            # write the text to a new file
                with open(os.path.join(directory_to_write, file_name), "w") as f:
                    f.write(text)

    # do some checking to see where your files have been written and how many text sample have been generated
    print(f"""
    Every file has been written successfully. 
    Your new directory (path={directory_to_write}) contains {count_files_dir(directory_to_write)} text samples.""")
