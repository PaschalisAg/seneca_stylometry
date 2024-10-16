# A Stylometric Analysis of Seneca’s disputed plays: Authorship Verification of Octavia and Hercules Oetaeus

## Description
### Purpose
This project delves into the authorship verification of Lucius Annaeus Seneca Minor's disputed plays, specifically *Octavia* and *Hercules Oetaeus*. To address this, we employ computational stylometric methods like Principal Component Analysis, Bootstrap Consensus Tree, and the Imposters method (o2 verification system) as outlined in:

```
Koppel, M. and Winter, Y. (2014), ‘Determining if two documents are written by the same author’, Journal of the Association for Information Science and Technology, 65(1), pp. 178–187. Available at: https://doi.org/10.1002/asi.22954 (accessed 31 October 2022).
```
### Structure
There are three main folders involved in the results presented in the paper (they will be presented in the same order as they appear on Github's repository):
* [`analysis`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis): it is the file used to perform the main analysis phase.
    - [`code`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/code): contains the code used in the main analysis phase split into subdirectories for each experiment performed.
    - [`corpora`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora): contains subdirectories of all the corpora used in the various experiments ran during the main analysis phase.
    - [`results`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results): contains in subdirectories the results generated during the various experiments grouped by the experiment and the method used.
* [`collection_data`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data): contains the code and the generated data that are used-with some variations- in the [validation](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation) and the main [analysis](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis) phase:
    - [`code`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data/code): contains two code files. One to convert TEI into raw text (`conv_tei_write_txt.py`)[https://github.com/PaschalisAg/seneca_stylometry/blob/main/collection_data/code/conv_tei_write_txt.py] and [`preparation_txt_files.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/collection_data/code/preparation_txt_files.ipynb) that processes the texts in order to prepare them for the validation and the main analysis phase.
    - [`data`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data/data): contais two different versions of the same data. One split into sub-books (i.e., [`corpus_perseus_txt`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data/data/corpus_perseus_txt)) and one by maintaining the raw conversion from TEI to txt (i.e., [`verse_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data/data/verse_corpus)).
    - [`dataset_perseus_xml](https://github.com/PaschalisAg/seneca_stylometry/tree/main/collection_data/dataset_perseus_xml): contains the texts extracted from Perseus in the raw TEI format. This version of the texts from Perseus is being preprocessed and converted to txt.
* [`validation`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation): contains the code, the data, and the results needed to replicate the results of the validation phase:
    - [`validation_PCA_BCT`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_PCA_BCT): contains the code and the results of the validation phase using both PCA and BCT.
    - [`validation_corpora`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora): contains all the different variations of the corpora used to validate the methods of PCA, BCE, and GI. Each method was validated using each own corpus, thus each method has its own validation corpora that can be found in the filename.
    - [`validation_imposters`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_imposters): contains the code to replicate the results for the GI method in the validation phase and its generated results for transparency.

## Code & Datasets
The section below will present which datasets were used in which cases. Main purpose of this section is to navigate the user in order to replicate the experiment of their choise, if not the entire study. 

The study is split into two phases: the validation phase (see [`validation`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation)), where we test the performance of the methods and the main analysis part (see [`analysis`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis)) where—using PCA, BCT, and GI- we proceed to the main analysis phase.

For the validation:

| **Script** | **Directory name** | **Description**   | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results**| 
|----------------------|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`valid_PCA.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/code/valid_PCA.Rmd). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/results/PCA/MFCs-4grams/PCA-corr/stylo_config.txt) | [`validation_corpus_PCA`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_PCA) | The dataset used to validate the PCA method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Amores* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. The code can be found in [`valid_PCA_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_PCA_BCT/code/valid_PCA_BCT.Rmd)| 4 | 44| Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*| [`PCA-corr`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_PCA_BCT/results/PCA/MFCs-4grams/PCA-corr)|
| [`valid_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/code/valid_BCT.Rmd). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/results/BCT/MFCs-4grams/stylo_config.txt) | [`validation_corpus_BCT`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_BCT)| The dataset used to validate the BCT method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Medicamina Faciei Femineae* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. | 4 | 44 | Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Thebaid*, *Achilleid*, *Silvae*| [`BCT/MFCs-4grams`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_PCA_BCT/results/BCT/MFCs-4grams)|
| [`valid_imposters_4grams_char.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_imposters/code/valid_imposters_4grams_char.R). | [`validation_imp_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_imp_corpus)| The corpus used to validate the GI method. It contains all the texts of impostors plus Seneca (excluding the two disputed plays under investigation). Each text becomes the test set and is compared against the others. Code can be found in [`valid_imposters_4grams_char.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_imposters/code/valid_imposters_4grams_char.Rmd)| 9| 88| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`validation_imposters/results`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_imposters/results)|

For the main analysis:

| **Script** | **Directory name** | **Description** | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results** |
|----------------------|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`pca_sen.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA_BCT/pca_sen.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen/stylo_config.txt) | [`corpus_seneca`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_seneca)| the corpus of Senecan plays used for the first experiment in the main analysis phase, where we compare the Senecan plays with each other.| 1| 10| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_sen`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/pca_sen)
| [`pca_hero_chunks.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA_BCT/pca_hero_chunks.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen_hero_chunks/stylo_config.txt) | [`corpus_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_sen_hero_chunks) | the corpus of the Senecan plays but Herc.Oetaeus is split into two halves. | 1| 11| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunk 1 & 2*, *Octavia*| [`pca_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/pca_sen_hero_chunks) |
| [`pca_sen_stat_ovid.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA/pca_sen_stat_ovid.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen_luc_stat/stylo_config.txt) | [`corpus_pca_bct`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_pca_bct)| The corpus used for the experiments of PCA and BCT with a sample of impostors used. | 3| 33| Lucan, Seneca the Younger, Statius| *Pharsalia*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/pca_bct_results/pca_sen_luc_stat) |
| [`bct_sen_stat_ovid.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/BCT/bct_sen_stat_ovid.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/bct_sen_luc_stat/stylo_config.txt) | [`corpus_pca_bct`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_pca_bct)| The corpus used for the experiments of PCA and BCT with a sample of impostors used. | 3| 33| Lucan, Seneca the Younger, Statius| *Pharsalia*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`bct_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/bct_sen_luc_stat) accordingly. |
| [`scenario_1_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_1_gi.R) | [`gi_scen_1_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_1_corpus) | The entire corpus of impostors (including the Senecan plays) with the texts untouched. **For each disputed play we exclude each other from the test set**. | 10 | 104 | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| *Octavia* = 1 & *Herc. O* = 1 |
| [`scenario_2_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_2_gi.R) | [`gi_scen_2_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_2_corpus) | The entire corpus of impostors (including the Senecan plays) but only **Herc. Oetaeus is split exactly in the middle**. | 10 | 105 | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| *Octavia* = 1 & *Herc. O* = 1 |
| [`scenario_3_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_3_gi.R). For the preparation of the corpus see [`cosine_simil.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/1_collecting_preprocessing/code/preprocessing/5_lines-similarity/cosine_simil.ipynb) | [`gi_scen_3_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_3_corpus) | The entire corpus of imposters (including the Senecan plays) but **from the disputed plays we have removed lines that returned similarity score above 0.6**. Code can be found in: [`cosine_simil.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/lines-similarity/cosine_simil.ipynb) and [`gi_scenario_3a.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_o_scenario_3a.R)| 10| 104| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| *Octavia* = 1 & *Herc. O* = 1|
| [`pca_sen.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA_BCT/pca_sen.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen/stylo_config.txt) [`corpus_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_chunks)| The entire corpus of imposters (including the Senecan plays) split into chunks of 500 tokens. Code can be found in: [`split_chunks.py`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/split_chunks/split_chunks.py) and [`gi_scenario_4.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_scenario_4.R)| 10| 1344 chunks| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/GI_results)|
| [`pca_sen.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA_BCT/pca_sen.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen/stylo_config.txt) [`corpus_kestemont`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_kestemont)| Corpus of Kestemont et al. (2016), *Authenticating Caesar's writings* augmented with our [`corpus_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_chunks). Code can be found in: [`gi_scenario_5.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_scenario_5.R)| 36 | 3090 chunks| Ammianus Marcellinus, Quintus Asconius Pedianus, Aulus Gellius, Calpurnius Flaccus, M. Tullius Cicero, Quintus Curtius Rufus, Eutropius, Rufius Festus, Florus, G. Julius Hyginus, Titus Livius, Lucius Ampelius, Macrobius, M. Minucius Felix, Nazarius, G. Plinius Caecilius Secundus, Pomponius Mela, Quintus Tullius Cicero, M. Fabius Quintillianus, G. Sallustius Crispus, Seneca the Younger, Seneca the Elder, Suetonius, Tacitus, Valerius Maximus, Varro, Velleius Paterculus, Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Silius Italicus, Statius, Valerius Flaccus| *Res Gestae A Fine Corneli Taciti*, *Orationum Ciceronis Quinque Enarratio*, *Noctes Atticae*, *Declamationes, Academica*, *Laelius de Amicitia*, *Pro Archia*, *Brutus*, *Pro Caecina*, *Pro Caelio*, *Cato Maior de Senectute*, *De Divinatione*, *De Fato*, *De Finibus*, *Pro Milone*, *De Natura Deorum*, *De Officiis*, *De Optimo Genere Oratorum*, *Orator*, *De Oratore*, *Paradoxa Stoicorum*,*In Pisonem*, *De Re Publica*, *Topica*, *Tusculanae Disputationes*, *Historiarum Alexandri Magni Libri Qui Supersunt*, *Breviarium Historiae Romanae*, *Festi Breviarium Rerum Gestarum Populi Romani*, *Epitome De T. Livio Bellorum Omnium Annorum DCC Libri Duo*, *Fabulae*, *Ab Urbe Condita Libri*, *Liber Memorialis*, *Commentarii in Somnium Scipionis*, *Octavius*, *Panegyricus Constantini*, *Epistularum Libri Decem*, *Panegyricus*, *De Chorographia*, *Commentariolum Petitionis*, *Declamationes Maiores*, *Institutiones*, *Bellum Catilinae*, *Epistola ad Caesarem I & II*, *Bellum Iugurthinum*, *De Beneficiis*, *De Brevitate Vitae*, *De Clementia*, *De Consolatione*, *Epistulae Morales Ad Lucilium*, *De Vita Beata*, *De Ira*, *Quaestiones Naturales*, *De Otio*, *De Providentia*, *De Tranquilitate Animi*, *Controversiae*, *De Vitis Caesarum-Augustus*, *De Vitis Caesarum-Gaius*, *De Vitis Caesarum-Divus Claudius*, *De Vitis Caesarum-Domotianus*, *De Vitis Caesarum-Galba*, *De Vitis Caesarum-Divus Iulius*, *De Vitis Caesarum-Nero*, *De Vitis Caesarum-Otho*, *De Vitis Caesarum-Tiberius*, *De Vitis Caesarum-Tiberius*, *De Vitis-Caesaris-Titus*, *De Vitis Caesarum-Divus Vespasianus*, *De Vitis Caesarum-Vitellius*, *Agricola*, *Annales*, *Historiae*, *Dialogus De Oratoribus*, *Factorum Et Dictorum Memorabilium Libri Novem*, *De Lingua Latina*, *Rerum Rusticarum De Agri Cultura*, *Historiae Romanae*, *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/GI_results)| 

[def]: https://github.com/PaschalisAg/seneca_stylometry/tree/main/verse_corpus