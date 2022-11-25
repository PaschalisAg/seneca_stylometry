# A Stylometric Analysis of Seneca’s disputed plays: Authorship Verification of Octavia and Hercules Oetaeus

## Description
This project investigates the disputed texts of Lucius Annaeus Seneca Minor (i.e, Seneca the Younger), *Octavia* and *Hercules Oetaeus*.
The code in this repository offers an stylometric analysis of the disputed texts. Contemporary literary scholars argue that both of these texts cannot be attributed to Seneca the Younger, because of a plethora of evidence that occurs from close reading approaches.
The nature of this problem is of an authorship verification since no name survives of a candidate author. To investigate this problem we apply widely-use computational methods, such as Principal Component Analysis, Bootstrap Consensus Network and the Imposters method (also know as o2 verification system) as described in:
```
Koppel, M. and Winter, Y. (2014) ‘Determining if two documents are written by the same author’, Journal of the Association for Information Science and Technology, 65(1), pp. 178–187. Available at: https://doi.org/10.1002/asi.22954 (accessed 31 October 2022).
```

The question we are trying to answer is whether Seneca the Younger can be verified as the author of one or both of the disputed texts, *Octavia* and *Hercules Oetaeus*.

## Datasets
Into the [`analysis`](analysis/) folder, you find the three datasets used in this study:
- [the Latin corpus of Kestemont](https://github.com/mikekestemont/ruzicka) ([`corpus_kestemont`](analysis/corpus_kestemont)) containing 1782 text samples of a plethora of authors.
- a corpus of thirty-two texts in verse, which contains the 10 plays written by Seneca the Younger, the 6 *Satires* by Persius, *Bellum Civile* by Lucan and *Achilleid* and *Silvae* by Statius (i.e., [`corpus`](analysis/corpus))
- a dataset that contains only the ten plays of Seneca the Younger (i.e., [`corpus_seneca`](analysis/corpus_seneca))

Moreover, someone can find the *Hercules Oetaeus* split into two parts inside the folder [`h_o_chunks`](analysis/h_o_chuncke). By replacing these two chunks with the *Hercules Oetaeus* —under the name [`sene_hero3.txt`](analysis/corpus_kestemont/sene_hero3.txt)— text in [`corpus_kestemont`](analysis/corpus_kestemont), someone can re-run the *General Imposters* with the size of all the Senecan plays similar to each other.

## Experiments
To run the experiments conducted for this study someoene has to run the following R notebooks in the following order from the [`analysis`](analysis/) folder:
+ For the Bootstrap Consenus Tree (BCA) and the Principal Components Analysis:
    - [`bct_pca.Rmd`](analysis/bct_pca.Rmd)
+ For the Imposters method:
    - using character tetra-grams run: [`imposters_sene_corpus_keste_4grams.Rmd`](analysis/imposters_sene_corpus_keste_4grams.Rmd)
    - using character penta-grams run: [`imposters_sene_corpus_keste_5grams.Rmd`](analysis/imposters_sene_corpus_keste_5grams.Rmd)

## Dependencies
To run this code, you need to have a version of Jupyter notebooks (either *Jupyter Notebook* or *Jupyter Lab*) installed in your computer and several third-party Python libraries. In addition to that you need to have installed RStudio in your computer.
A list of the dependencies is provided below:
+ Python dependencies:
    - pandas
    - striprtf
+ R dependencies:
    - the [*Stylo*](https://github.com/computationalstylistics/stylo) software
      + mac users should also install XQuartz
    - ggplots
    - pheatmap


All the experiments were run in a macOS Ventura 13.0 with an M1 2020 chip.
