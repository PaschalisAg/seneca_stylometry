# A Stylometric Analysis of Seneca’s disputed plays: Authorship Verification of Octavia and Hercules Oetaeus

## Description
This project delves into the authorship verification of Lucius Annaeus Seneca Minor's disputed plays, specifically *Octavia* and *Hercules Oetaeus*.
To address this, we employ computational methods like Principal Component Analysis, Bootstrap Consensus Network, and the Imposters method (o2 verification system) as outlined in:

```
Koppel, M. and Winter, Y. (2014) ‘Determining if two documents are written by the same author’, Journal of the Association for Information Science and Technology, 65(1), pp. 178–187. Available at: https://doi.org/10.1002/asi.22954 (accessed 31 October 2022).
```
Throughout the study we use several datasets to test different scenarios. Most of the variations are centered around the dataset [`verse_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/verse_corpus). However, in one of the scenarios we also augment the aforementioned corpus with the corpus used by Kestemont *et al.* (2016), *Authenticating the writings of Julius Caesar*, Expert Systems with Applications, 63, pp. 86-96.



## Datasets
The section below will present which datasets were used in which cases. The study is split into two phases: the validation phase (see [`validation`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation)), where we test the performance of the methods and the main analysis part (see [`analysis`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis)) where—using PCA, BCT, and GI- we proceed to the main analysis phase.

| **Validation phase** | **Description**   | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| 
|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`validation_corpus_PCA`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_PCA) | The dataset used to validate the PCA method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Amores* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. The code can be found in [`valid_PCA_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_PCA_BCT/code/valid_PCA_BCT.Rmd)| 4 | 44| Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*|
| [`validation_corpus_BCT`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_BCT)| The dataset used to validate the BCT method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Medicamina Faciei Femineae* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. The code can be found in [`valid_PCA_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_PCA_BCT/code/valid_PCA_BCT.Rmd)| 4 | 44 | Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Thebaid*, *Achilleid*, *Silvae*|
| [`validation_imp_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_imp_corpus)| The corpus used to validate the GI method. It contains all the texts of impostors plus Seneca (excluding the two disputed plays under investigation). Each text becomes the test set and is compared against the others. Code can be found in [`valid_imposters_4grams_char.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_imposters/code/valid_imposters_4grams_char.Rmd)| 9| 88| Lucan, Manilius, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*|


| **Main analysis phase** | | | |
|----------------------|-------------------|-------------------|-------------------|
| | | | |

+ For the **main analysis** phase (the order follows how GitHub presents the datasets):
    - [`corpus_chunks`](analysis/corpora/corpus_chunks): the entire corpus of impostors (including the Senecan plays) split into chunks of 500 tokens
    - [`corpus_imp_hero_chunks`](analysis/corpora/corpus_imp_hero_chunks): the entire corpus of impostors (including the Senecan plays) but only Herc. Oetaeus is split exactly in the middle.
    - [`corpus_imposters`](analysis/corpora/corpus_imposters): the entire corpus of impostors (including the Senecan plays) with the texts untouched.
    - [`corpus_imposters_cento`](analysis/corpora/corpus_imposters_cento): the entire corpus of impostors (including the Senecan plays) but from the disputed plays we have removed lines that returned similarity score above 0.6 (see [line similarity code](analysis/code/lines-similarity/cosine_simil.ipynb)).
    - [`corpus_pca_bct`](analysis/corpora/corpus_pca_bct/): the corpus used for the experiments of PCA and BCT with a sample of impostors used.
    - [`corpus_sen_hero_chunks`](analysis/corpora/corpus_sen_hero_chunks): the corpus of the Senecan plays but Herc.Oetaeus is split into two halves.
    - [`corpus_seneca`](analysis/corpora/corpus_seneca): the corpus of Senecan plays used for the first experiment in the main analysis phase.

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


[def]: https://github.com/PaschalisAg/seneca_stylometry/tree/main/verse_corpus