# Documentation

Author: Paschalis Agapitos

---
## Collection and preparation of the data (`collection_data`)
The chapter below provides the code and information related to the first preprocessing of the data.

### `conv_tei_write_txt.py`

This script processes `.xml` files from the Perseus repository, converts them to text, and writes the content into individual `.txt` files. The script requires the following tools:

- `wget`
- `dwdiff` (https://os.ghalkes.nl/dwdiff.html)
- `ansi2html`

#### Import Libraries

```python
import os
import re
import html
from glob import glob
```

#### Regular Expression Patterns

```python
# Trim whitespace, but re-insert linebreaks after </p> and <lb/>
ENDPARPATTERN = re.compile(r'</(?:p|l|q|head)>')
PARATEXT = re.compile(r'<cf>.*?</cf>')
TAGPATTERN = re.compile(r'^.*?<body>|-<pb.*?>|<.*?>', flags=re.DOTALL)
# Ensure that an em-dash ("gedachtenstreepje") at the end of a page
# is surrounded by spaces, such that it is not interpreted as
# hyphen ("afbreekstreepje").
DASHPATTERN = re.compile(r' -(<pb.*?>)')
SPACEPATTERN = re.compile(r'[\n\xa0]+')
SPACEPATTERN2 = re.compile(r'(?:\n *)+')
HNOTEPATTERN = re.compile(r'<note>.*?</note>')  # match the hypernotes pattern
```

#### Functions

##### `striptei`

Convert a string with (a fragment of) TEI to plain text.

- **Args**:
  - `tei` (str): Input TEI string.
- **Returns**:
  - str: Plain text string.

```python
def striptei(tei):
    unescaped = html.unescape(tei)
    ignore_hnotes = HNOTEPATTERN.sub(' ', unescaped)
    fixdash = DASHPATTERN.sub(r' - \1', ignore_hnotes)
    fixlinebreaks = ENDPARPATTERN.sub('\g<0>\n',
                                      SPACEPATTERN.sub(' ', fixdash))
    result = SPACEPATTERN2.sub('\n', TAGPATTERN.sub('', fixlinebreaks))
    return result
```

##### `read_conv_tei`

Read TEI, strip XML, trim whitespace, and return plain text string.

- **Args**:
  - `fname` (str): Path to the TEI file.
- **Returns**:
  - str: Plain text string.

```python
def read_conv_tei(fname):
    with open(fname, encoding='utf8') as inp:
        tei = inp.read()
    trimpara = PARATEXT.sub('', tei)  # Remove paratext not by author
    return striptei(trimpara)
```

##### `metadata`

Extract metadata from filenames.

- **Returns**:
  - tuple: (list of authors, list of titles)

```python
def metadata():
    filenames = [filename.split('/')[2]
                 for filename in glob("../dataset_perseus_xml/*.xml")]
    authors = [str(filename.split('.')[0]) for filename in filenames]
    titles = [str(filename.split('.')[1][:-4]) for filename in filenames]
    return authors, titles
```

##### `write_txt`

Write the processed TEI content into text files.

- **Args**:
  - `path_to_xml` (str): Path to the directory containing the XML files.

```python
def write_txt(path_to_xml):
    path_ = '../data/corpus_perseus_txt/'
    try:
        if not os.path.exists(path_):
            os.makedirs(path_)
            print(f'New directory created in "{path_}". You will find your txt files there!')
        else:
            print(f'Directory "{path_}" already exists. You will find your txt files there!')
    except:
        pass
    authors, titles = metadata()
    for n, filename in enumerate(glob(path_to_xml)):
        text = read_conv_tei(filename)
        filename = f'{path_}{authors[n]}_{titles[n]}.txt'
        with open(filename, 'w', encoding='utf-8') as out:
            out.write(text)
```

#### Main Function

The main function that executes the script.

```python
def main():
    write_txt('../dataset_perseus_xml/*.xml')
```

#### Script Entry Point

```python
if __name__ == '__main__':
    main()
```

---

### `preparation_txt_files.ipynb`

#### Overview

This notebook provides scripts for preprocessing text files in order to prepare them for the authorship attribution experiments.

#### Import Libraries

```python
import os
import re
from glob import glob
from os.path import basename, splitext
```

#### Define functions

##### `read_file`

Reads the content of a file.

- **Args**:
  - `filepath` (str): Path to the file.
- **Returns**:
  - str: Content of the file.

```python
def read_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as inp:
        return inp.read()
```

##### `remove_digits`

Removes digits from the given text.

- **Args**:
  - `text` (str): Input text.
- **Returns**:
  - str: Text without digits.

```python
def remove_digits(text):
    if re.search(r'\d', text):
        return re.sub(r'\d', '', text)
    return text
```

##### `check_dir_exists`

Checks if a directory exists and creates it if it does not.

- **Args**:
  - `directory_path` (str): Path to the directory.
- **Returns**:
  - str: Directory path.

```python
def check_dir_exists(directory_path):
    if not os.path.exists(directory_path):
        os.makedirs(directory_path, exist_ok=True)
        print("New directory created!")
    else:
        print("Directory already exists.")
    return directory_path
```

##### `write_txt`

Writes each text in the list to a separate file.

- **Args**:
  - `text_list` (list): List of texts.
  - `author` (str): Author of the texts.
  - `title` (str): Title of the text.

```python
def write_txt(text_list, author, title):
    directory_path = check_dir_exists('../data/verse_corpus/')
    for i, book in enumerate(text_list, start=1):
        filename = f'{directory_path}{author}_{title}_{i}.txt'
        with open(filename, 'w', encoding='utf-8') as out:
            out.write(book.strip())
    print("Text files written to the directory.")
```

##### `write_txt_no_loop`

Writes the entire text to a single file.

- **Args**:
  - `text` (str): Text content.
  - `author` (str): Author of the text.
  - `title` (str): Title of the text.

```python
def write_txt_no_loop(text, author, title):
    directory_path = check_dir_exists('../data/verse_corpus/')
    filename = f'{directory_path}{author}_{title}.txt'
    with open(filename, 'w', encoding='utf-8') as out:
        out.write(text.strip())
    print("Text file written to the directory.")
```

---

#### Text Processing for Specific Authors

##### Statius, *Silvae*

Read and process *Silvae* by Statius:

```python
silvae = remove_digits(read_file("../data/corpus_perseus_txt/stat_silvae.txt")).strip().split("\n\n\n")
write_txt(silvae, author="stat", title="silv")
```

##### Statius, *Thebais*

Read and process *Thebais* by Statius:

```python
thebais = remove_digits(read_file("../data/corpus_perseus_txt/stat_theb.txt")).strip().split("\n\n")
write_txt(thebais, author="stat", title="theb")
```

#### Valerius Flaccus, *Argonautica*

Read and process *Argonautica* by Valerius Flaccus:

```python
argonautica = remove_digits(read_file("../data/corpus_perseus_txt/valflac_argo.txt")).strip().split("\n\n\n")
write_txt(argonautica, author="valflac", title="argon")
```

##### Phaedrus, *Fables*

Read and process *Fables* by Phaedrus:

```python
clean_fables = remove_titles('../data/corpus_perseus_txt/phaed_fables.txt').split('\n\n')
write_txt(clean_fables, author='phaed', title='fables')
```

##### Manilius, *Astronomica*

Read and process *Astronomica* by Manilius:

```python
for filename in glob("../data/corpus_perseus_txt/manil.astro_*.txt"):
    astronomica = remove_digits(read_file(filename)).splitlines()[11:-11]
    astronomica = "\n".join(astronomica)
    author = os.path.splitext(basename(filename))[0].split(".", 1)[0]
    title = os.path.splitext(basename(filename))[0].split(".", 1)[1]
    write_txt_no_loop(astronomica, author=author, title=title)
```