# A Stylometric Analysis of Seneca’s Disputed Plays: Authorship Verification of Octavia and Hercules Oetaeus

## Description
### Purpose

This repository contains the code and data required to replicate the results published in the paper *A Stylometric Analysis of Seneca's Disputed Plays: Authorship Verification of Octavia and Hercules Oetaeus*. You can access the preprint [here](https://tuprints.ulb.tu-darmstadt.de/27394/1/3919_StylometrySeneca_Conference_Version.pdf).

In this study, we apply **stylometry**—a computational approach to analyzing writing style—to examine the authorship of two disputed plays attributed to Lucius Annaeus Seneca Minor: *Octavia* and *Hercules Oetaeus*. By employing methods such as **Principal Component Analysis (PCA)**, **Bootstrap Consensus Tree (BCT)**, and the **Imposters method (o2 verification system)**, we investigate whether these plays align stylistically with Seneca's undisputed works.

Our aim is to make the study fully reproducible, so this README will guide you step-by-step through the process, from data collection and preprocessing to analysis and validation.

### Citation

```
Paschalis Agapitos and Andreas van Cranenburgh (2024). “A Stylometric Analysis of Seneca’s Disputed Plays. Authorship Verification of Octavia and Hercules Oetaeus”. In: CCLS2024 Conference Preprints 3 (1). 10.2 6083/tuprints-00027394
```

### Structure

This repository is organized into the following directories:

```
📦 project-root/
├── 📁 1_collecting_preprocessing
│   ├──📁 code/preprocessing           # code to preprocess and prepare the data
│   ├──📁 data                         # preprocessed data
│   ├──📁 dataset_perseus_xml          # raw data
├── 📁 2_validation/              
│   ├──📁 validation_PCA_BCT           # code & results for and of the validation of PCA & BCT
│   ├──📁 validation_corpora           # data to perform the validation
│   └──📁 validation_imposters         # code & results for and of the validation of GI
├── 📁 3_analysis/                   
│   ├──📁 code                        # code to perform the analysis using PCA, BCT and GI
│   └──📁 corpora                     # data needed to perform the analysis
│   └──📁 results                     # results of the analysis
├── 📁 docs/                         # Documentation and additional resources
│   └──📄 paper.pdf                    # Preprint of the paper and requirements
│   └──📄 requirements,txt             # libraries and software that need to be installed to prepare the running environment
├── 📄 .gitignore                    # Git ignore file for unnecessary files
├── 📄 LICENSE                       # Project license
├── 📄 LICENSE.md                    # Markdown version of the license
├── 📄 README.md                     # Main documentation file for the project
├── 📄 seneca_stylometry.Rproj       # R project file for Seneca Stylometry
```

Each directory contains either code or data relevant to a specific step of the analysis process, from preprocessing to validation and final analysis. 
Follow the sections below to understand how to use each script and dataset.


## Code & Datasets

This section provides an overview of the scripts, datasets, and results for replicating our study. The process is divided into two key phases: **Validation** and **Main Analysis**.

### Validation Phase:
In this phase, we evaluate the effectiveness of the stylometric methods we employ—Principal Component Analysis (PCA), Bootstrap Consensus Tree (BCT), and the Imposters method (GI). We use various corpora of ancient authors to assess the accuracy of these techniques before applying them to Seneca's disputed works.

Here are the scripts, datasets, and results related to the validation phase:


| **Script** | **Directory name** | **Description**   | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results**| 
|----------------------|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`valid_PCA.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/code/valid_PCA.Rmd). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/results/PCA/MFCs-4grams/PCA-corr/stylo_config.txt) | [`validation_corpus_PCA`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_corpora/validation_corpus_PCA) | The dataset used to validate the PCA method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Amores* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. | 4 | 44| Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*| [`PCA-corr`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_PCA_BCT/results/PCA/MFCs-4grams/PCA-corr) |
| [`valid_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/code/valid_BCT.Rmd). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_PCA_BCT/results/BCT/MFCs-4grams/stylo_config.txt) | [`validation_corpus_BCT`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_corpora/validation_corpus_BCT) | The dataset used to validate the BCT method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Medicamina Faciei Femineae* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. | 4 | 44 | Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Thebaid*, *Achilleid*, *Silvae*| [`BCT/MFCs-4grams`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_PCA_BCT/results/BCT/MFCs-4grams)|
| [`valid_imposters_4grams_char.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/2_validation/validation_imposters/code/valid_imposters_4grams_char.R). | [`validation_imp_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_corpora/validation_imp_corpus) | The corpus used to validate the GI method. It contains all the texts of impostors plus Seneca (excluding the two disputed plays under investigation). Each text becomes the test set and is compared against the others. | 9| 88| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`validation_imposters/results`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/2_validation/validation_imposters/results) |

### Main Analysis Phase:
Once the methods are validated, we apply them to the corpus of Senecan plays, with a particular focus on the disputed plays *Octavia* and *Hercules Oetaeus*. Here are the details for each analysis scenario:

| **Script** | **Directory name** | **Description** | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results** |
|----------------------|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`pca_sen.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA/pca_sen.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen/stylo_config.txt) | [`corpus_seneca`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_seneca)| the corpus of Senecan plays used for the first experiment in the main analysis phase, where we compare the Senecan plays with each other.| 1| 10| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_sen`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/pca_sen) |
| [`pca_hero_chunks.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA/pca_hero_chunks.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen_hero_chunks/stylo_config.txt) | [`corpus_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_sen_hero_chunks) | the corpus of the Senecan plays but Herc.Oetaeus is split into two halves. | 1| 11| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunk 1 & 2*, *Octavia*| [`pca_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/pca_sen_hero_chunks) |
| [`pca_sen_stat_ovid.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/PCA/pca_sen_stat_ovid.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/pca_sen_luc_stat/stylo_config.txt) | [`corpus_pca_bct`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_pca_bct)| The corpus used for the experiments of PCA and BCT with a sample of impostors used. | 3| 33| Lucan, Seneca the Younger, Statius| *Pharsalia*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/pca_sen_luc_stat) |
| [`bct_sen_stat_ovid.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/BCT/bct_sen_stat_ovid.R). A detailed list of the parameters used for this experiment can be found in [stylo_config.txt](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/results/pca_bct_results/bct_sen_luc_stat/stylo_config.txt) | [`corpus_pca_bct`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/corpus_pca_bct)| The corpus used for the experiments of PCA and BCT with a sample of impostors used. | 3| 33| Lucan, Seneca the Younger, Statius| *Pharsalia*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`bct_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/pca_bct_results/bct_sen_luc_stat) |
| [`scenario_1_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_1_gi.R) | [`gi_scen_1_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_1_corpus) | The entire corpus of impostors (including the Senecan plays) with the texts untouched. **For each disputed play we exclude each other from the test set**. | 10 | 104 | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| *Octavia* = 1 & *Herc. O* = 1 |
| [`scenario_2_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_2_gi.R) | [`gi_scen_2_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_2_corpus) | The entire corpus of impostors (including the Senecan plays) but only **Herc. Oetaeus is split exactly in the middle**. | 10 | 105 | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| *Octavia* = 1 & *Herc. O* = 1 |
| [`scenario_3_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_3_gi.R). For the preparation of the corpus see [`cosine_simil.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/1_collecting_preprocessing/code/preprocessing/5_lines-similarity/cosine_simil.ipynb) | [`gi_scen_3_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_3_corpus) | The entire corpus of imposters (including the Senecan plays) but **from the disputed plays we have removed lines that returned similarity score above 0.6**. | 10 | 104 | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica* | *Octavia* = 1 & *Herc. O* = 1 |
| [`scenario_4_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_4_gi.R). For the preparation of the corpus see [`4_split_corpus_chunks.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/1_collecting_preprocessing/code/preprocessing/4_split_corpus_chunks.ipynb). | [`gi_scen_4_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_4_corpus) | The entire corpus of imposters (including the Senecan plays) **split into chunks of 500 tokens**. | 10 | 1344 chunks | Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/scenario_4`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/GI_results/scenario_4) |
| [`scenario_5_gi.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/3_analysis/code/GI/scenario_5_gi.R) | [`gi_scen_5_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_5_corpus) | Corpus of Kestemont et al. (2016), *Authenticating Caesar's writings* augmented with our [`gi_scen_4_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/corpora/gi_scen_4_corpus). | 36 | 3090 chunks | Ammianus Marcellinus, Quintus Asconius Pedianus, Aulus Gellius, Calpurnius Flaccus, M. Tullius Cicero, Quintus Curtius Rufus, Eutropius, Rufius Festus, Florus, G. Julius Hyginus, Titus Livius, Lucius Ampelius, Macrobius, M. Minucius Felix, Nazarius, G. Plinius Caecilius Secundus, Pomponius Mela, Quintus Tullius Cicero, M. Fabius Quintillianus, G. Sallustius Crispus, Seneca the Younger, Seneca the Elder, Suetonius, Tacitus, Valerius Maximus, Varro, Velleius Paterculus, Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Silius Italicus, Statius, Valerius Flaccus| *Res Gestae A Fine Corneli Taciti*, *Orationum Ciceronis Quinque Enarratio*, *Noctes Atticae*, *Declamationes, Academica*, *Laelius de Amicitia*, *Pro Archia*, *Brutus*, *Pro Caecina*, *Pro Caelio*, *Cato Maior de Senectute*, *De Divinatione*, *De Fato*, *De Finibus*, *Pro Milone*, *De Natura Deorum*, *De Officiis*, *De Optimo Genere Oratorum*, *Orator*, *De Oratore*, *Paradoxa Stoicorum*,*In Pisonem*, *De Re Publica*, *Topica*, *Tusculanae Disputationes*, *Historiarum Alexandri Magni Libri Qui Supersunt*, *Breviarium Historiae Romanae*, *Festi Breviarium Rerum Gestarum Populi Romani*, *Epitome De T. Livio Bellorum Omnium Annorum DCC Libri Duo*, *Fabulae*, *Ab Urbe Condita Libri*, *Liber Memorialis*, *Commentarii in Somnium Scipionis*, *Octavius*, *Panegyricus Constantini*, *Epistularum Libri Decem*, *Panegyricus*, *De Chorographia*, *Commentariolum Petitionis*, *Declamationes Maiores*, *Institutiones*, *Bellum Catilinae*, *Epistola ad Caesarem I & II*, *Bellum Iugurthinum*, *De Beneficiis*, *De Brevitate Vitae*, *De Clementia*, *De Consolatione*, *Epistulae Morales Ad Lucilium*, *De Vita Beata*, *De Ira*, *Quaestiones Naturales*, *De Otio*, *De Providentia*, *De Tranquilitate Animi*, *Controversiae*, *De Vitis Caesarum-Augustus*, *De Vitis Caesarum-Gaius*, *De Vitis Caesarum-Divus Claudius*, *De Vitis Caesarum-Domotianus*, *De Vitis Caesarum-Galba*, *De Vitis Caesarum-Divus Iulius*, *De Vitis Caesarum-Nero*, *De Vitis Caesarum-Otho*, *De Vitis Caesarum-Tiberius*, *De Vitis Caesarum-Tiberius*, *De Vitis-Caesaris-Titus*, *De Vitis Caesarum-Divus Vespasianus*, *De Vitis Caesarum-Vitellius*, *Agricola*, *Annales*, *Historiae*, *Dialogus De Oratoribus*, *Factorum Et Dictorum Memorabilium Libri Novem*, *De Lingua Latina*, *Rerum Rusticarum De Agri Cultura*, *Historiae Romanae*, *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/scenario_5`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/3_analysis/results/GI_results/scenario_5) |