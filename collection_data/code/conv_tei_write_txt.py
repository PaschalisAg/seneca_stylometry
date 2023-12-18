"""Given the repository with `.xml` files from Perseus convert them to text and write them into new individual `.txt` files

Requirements:
	- wget
	- dwdiff https://os.ghalkes.nl/dwdiff.html
	- ansi2html
"""
import os
import re
import html
from glob import glob

# trim whitespace, but re-insert linebreaks after </p> and <lb/>
ENDPARPATTERN = re.compile(r'</(?:p|l|q|head)>')
PARATEXT = re.compile(r'<cf>.*?</cf>')
TAGPATTERN = re.compile(r'^.*?<body>|-<pb.*?>|<.*?>', flags=re.DOTALL)
# Ensure that an em-dash ("gedachtenstreepje") at the end of a page
# is surrounded by spaces, such that it is not interpreted as
# hyphen ("afbreekstreepje").
DASHPATTERN = re.compile(r' -(<pb.*?>)')
SPACEPATTERN = re.compile(r'[\n\xa0]+')
SPACEPATTERN2 = re.compile(r'(?:\n *)+')
HNOTEPATTERN = re.compile(r'<note>.*?<\/note>')  # match the hypernotes pattern


def striptei(tei):
    """Convert a string with (a fragment of) TEI to plain text.
    Avoids lxml overhead. Use at your own risk; may summon the ancient ones:
    https://stackoverflow.com/a/1732454/338811
    Hyphenated words at end of page are dehyphenated.
    Linebreaks are removed, except for paragraph ends and <lb/> elements."""
    unescaped = html.unescape(tei)
    ignore_hnotes = HNOTEPATTERN.sub(' ', unescaped)
    # Ensure that an em-dash ("gedachtenstreepje) at the end of a page
    # is surrounded by spaces, such that it is not interpreted as
    # hypen ("afbreekstreepje").
    fixdash = DASHPATTERN.sub(r' - \1', ignore_hnotes)
    # trim whitespace, but re-insert linebreaks at paragraph ends
    fixlinebreaks = ENDPARPATTERN.sub('\\g<0>\n',
                                      SPACEPATTERN.sub(' ', fixdash))
    result = SPACEPATTERN2.sub('\n', TAGPATTERN.sub('', fixlinebreaks))
    return result


def read_conv_tei(fname):
    """Read TEI, strip XML, trim whitespace, and return plain text string."""
    with open(fname, encoding='utf8') as inp:
        tei = inp.read()
    trimpara = PARATEXT.sub('', tei)  # Remove paratext not by author
    return striptei(trimpara)


def metadata():
    # remove ext and other unecessary information
    filenames = [filename.split('/')[2]
                 for filename in glob("../dataset_perseus_xml/*.xml")]
    # extract the authors from the path (small manual changes to the paths to make them more readable)
    authors = [str(filename.split('.')[0]) for filename in filenames]
    # extract the titles (her fur and her o name was manually changed to her_f and her_o respectively)
    titles = [str(filename.split('.')[1][:-4]) for filename in filenames]
    return authors, titles


def write_txt(path_to_xml):
    path_ = '../data/corpus_perseus_txt/'
    try:
        if not os.path.exists(path_):  # check if directory exists
            os.makedirs(path_)  # if it doesn't exist create a new one
            print(
                f'New directory created in "{path_}". You will find your txt files there!')
        else:
            print(
                f'Directory "{path_}" already exists. You will find your txt files there!')
    except:
        pass
    authors, titles = metadata()
    for n, filename in enumerate(glob(path_to_xml)):
        text = read_conv_tei(filename)
        filename = f'{path_}{authors[n]}_{titles[n]}.txt'
        with open(filename, 'w', encoding='utf-8') as out:
            out.write(text)


def main():
    write_txt('../dataset_perseus_xml/*.xml')


if __name__ == '__main__':
    main()


