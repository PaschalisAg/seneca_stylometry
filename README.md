# A Stylometric Analysis of Seneca’s disputed plays: Authorship Verification of Octavia and Hercules Oetaeus

## Description
### Purpose
This project delves into the authorship verification of Lucius Annaeus Seneca Minor's disputed plays, specifically *Octavia* and *Hercules Oetaeus*. To address this, we employ computational stylometric methods like Principal Component Analysis, Bootstrap Consensus Tree, and the Imposters method (o2 verification system) as outlined in:

```
Koppel, M. and Winter, Y. (2014) ‘Determining if two documents are written by the same author’, Journal of the Association for Information Science and Technology, 65(1), pp. 178–187. Available at: https://doi.org/10.1002/asi.22954 (accessed 31 October 2022).
```
### Structure
There are three main folders involved in the results presented in the paper:
* [`analysis`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis): it is the file used to perform the main analysis phase.
    - [`code`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/code): contains the code used in the main analysis phase split into subdirectories for each experiment performed.
    - [`corpora`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora): contains subdirectories of all the corpora used in the various experiments ran during the main analysis phase.
    - [`results`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results): contains in subdirectories the results generated during the various experiments grouped by the experiment and the method used.
## Datasets
The section below will present which datasets were used in which cases. The study is split into two phases: the validation phase (see [`validation`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation)), where we test the performance of the methods and the main analysis part (see [`analysis`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis)) where—using PCA, BCT, and GI- we proceed to the main analysis phase.

For the validation:

| **Directory name** | **Description**   | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results**| 
|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`validation_corpus_PCA`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_PCA) | The dataset used to validate the PCA method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Amores* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. The code can be found in [`valid_PCA_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_PCA_BCT/code/valid_PCA_BCT.Rmd)| 4 | 44| Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*| [`PCA-corr`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_PCA_BCT/results/PCA/MFCs-4grams/PCA-corr)|
| [`validation_corpus_BCT`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_corpus_BCT)| The dataset used to validate the BCT method (does not contain Seneca's plays). It is a subset of the works of Lucan, Ovid, Persius, and Statius. The filenames for *Medicamina Faciei Femineae* by Ovid, the fourth *Satire* by Persius, and the first book of *Thebaid* by Statius are being renamed using the following format: `unknown_{work}.txt`. The code can be found in [`valid_PCA_BCT.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_PCA_BCT/code/valid_PCA_BCT.Rmd)| 4 | 44 | Lucan, Ovid, Persius, Statius| *Pharsalia*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Thebaid*, *Achilleid*, *Silvae*| [`BCT/MFCs-4grams`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_PCA_BCT/results/BCT/MFCs-4grams)|
| [`validation_imp_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_corpora/validation_imp_corpus)| The corpus used to validate the GI method. It contains all the texts of impostors plus Seneca (excluding the two disputed plays under investigation). Each text becomes the test set and is compared against the others. Code can be found in [`valid_imposters_4grams_char.Rmd`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/validation/validation_imposters/code/valid_imposters_4grams_char.Rmd)| 9| 88| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`validation_imposters/results`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/validation/validation_imposters/results)|

For the main analysis:

| **Directory name** | **Description** | **Number of distinct authors** | **Number of texts** | **Name of distinct authors**| **Name of distinct work**| **Results** |
|----------------------|-------------------|-------------------|-------------------|-------------------|-------------------|-------------------|
| [`corpus_pca_bct`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_pca_bct)| The corpus used for the experiments of PCA and BCT with a sample of impostors used. Code can be found in [`pca_bct_sen_stat_ovid.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/PCA_BCT/pca_bct_sen_stat_ovid.R)| 3| 33| Lucan, Seneca the Younger, Statius| *Pharsalia*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/pca_bct_results/pca_sen_luc_stat) and [`bct_sen_luc_stat`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/pca_bct_results/bct_sen_luc_stat) accordingly.|
| [`corpus_seneca`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_seneca)| the corpus of Senecan plays used for the first experiment in the main analysis phase, where we compare the Senecan plays with each other.| 1| 10| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*| [`pca_seneca_corpus`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/pca_bct_results/pca_seneca_corpus)|
| [`corpus_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_sen_hero_chunks)| the corpus of the Senecan plays but Herc.Oetaeus is split into two halves. Code can be found in: [`pca_hero_chunks.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/PCA_BCT/pca_hero_chunks.R)| 1| 11| Seneca the Younger| *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunk 1 & 2*, *Octavia*| [`pca_sen_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/pca_bct_results/pca_sen_hero_chunks)|
| [`corpus_imposters`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_imposters)| The entire corpus of impostors (including the Senecan plays) with the texts untouched. Code can be found in: [`gi_scenario_1a.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_o_scenario_1a.R). For each disputed play we exclude each other from the test set.| 10| 104| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| Octavia = 1 & Herc. O = 1 |
| [`corpus_imp_hero_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_imp_hero_chunks)| The entire corpus of impostors (including the Senecan plays) but only Herc. Oetaeus is split exactly in the middle. Code can be found in: [`gi_ho_scenario_2.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_ho_scenario_2.R)|10| 105|Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| Octavia = 1 & Herc. O = 1 |
| [`corpus_imposters_cento`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_imposters_cento)| The entire corpus of imposters (including the Senecan plays) but from the disputed plays we have removed lines that returned similarity score above 0.6. Code can be found in: [`cosine_simil.ipynb`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/lines-similarity/cosine_simil.ipynb) and [`gi_scenario_3a.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_o_scenario_3a.R)| 10| 104| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| Octavia = 1 & Herc. O = 1|
| [`corpus_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_chunks)| The entire corpus of imposters (including the Senecan plays) split into chunks of 500 tokens. Code can be found in: [`split_chunks.py`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/split_chunks/split_chunks.py) and [`gi_scenario_4.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_scenario_4.R)| 10| 1344 chunks| Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Seneca the Younger, Silius Italicus, Statius, Valerius Flaccus| *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/GI_results)|
| [`corpus_kestemont`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_kestemont)| Corpus of Kestemont et al. (2016), *Authenticating Caesar's writings* augmented with our [`corpus_chunks`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/corpora/corpus_chunks). Code can be found in: [`gi_scenario_5.R`](https://github.com/PaschalisAg/seneca_stylometry/blob/main/analysis/code/GI/gi_scenario_5.R)| 36 | 3090 chunks| Ammianus Marcellinus, Quintus Asconius Pedianus, Aulus Gellius, Calpurnius Flaccus, M. Tullius Cicero, Quintus Curtius Rufus, Eutropius, Rufius Festus, Florus, G. Julius Hyginus, Titus Livius, Lucius Ampelius, Macrobius, M. Minucius Felix, Nazarius, G. Plinius Caecilius Secundus, Pomponius Mela, Quintus Tullius Cicero, M. Fabius Quintillianus, G. Sallustius Crispus, Seneca the Younger, Seneca the Elder, Suetonius, Tacitus, Valerius Maximus, Varro, Velleius Paterculus, Lucan, Manilius, Martial, Ovid, Persius, Phaedrus, Silius Italicus, Statius, Valerius Flaccus| *Res Gestae A Fine Corneli Taciti*, *Orationum Ciceronis Quinque Enarratio*, *Noctes Atticae*, *Declamationes, Academica*, *Laelius de Amicitia*, *Pro Archia*, *Brutus*, *Pro Caecina*, *Pro Caelio*, *Cato Maior de Senectute*, *De Divinatione*, *De Fato*, *De Finibus*, *Pro Milone*, *De Natura Deorum*, *De Officiis*, *De Optimo Genere Oratorum*, *Orator*, *De Oratore*, *Paradoxa Stoicorum*,*In Pisonem*, *De Re Publica*, *Topica*, *Tusculanae Disputationes*, *Historiarum Alexandri Magni Libri Qui Supersunt*, *Breviarium Historiae Romanae*, *Festi Breviarium Rerum Gestarum Populi Romani*, *Epitome De T. Livio Bellorum Omnium Annorum DCC Libri Duo*, *Fabulae*, *Ab Urbe Condita Libri*, *Liber Memorialis*, *Commentarii in Somnium Scipionis*, *Octavius*, *Panegyricus Constantini*, *Epistularum Libri Decem*, *Panegyricus*, *De Chorographia*, *Commentariolum Petitionis*, *Declamationes Maiores*, *Institutiones*, *Bellum Catilinae*, *Epistola ad Caesarem I & II*, *Bellum Iugurthinum*, *De Beneficiis*, *De Brevitate Vitae*, *De Clementia*, *De Consolatione*, *Epistulae Morales Ad Lucilium*, *De Vita Beata*, *De Ira*, *Quaestiones Naturales*, *De Otio*, *De Providentia*, *De Tranquilitate Animi*, *Controversiae*, *De Vitis Caesarum-Augustus*, *De Vitis Caesarum-Gaius*, *De Vitis Caesarum-Divus Claudius*, *De Vitis Caesarum-Domotianus*, *De Vitis Caesarum-Galba*, *De Vitis Caesarum-Divus Iulius*, *De Vitis Caesarum-Nero*, *De Vitis Caesarum-Otho*, *De Vitis Caesarum-Tiberius*, *De Vitis Caesarum-Tiberius*, *De Vitis-Caesaris-Titus*, *De Vitis Caesarum-Divus Vespasianus*, *De Vitis Caesarum-Vitellius*, *Agricola*, *Annales*, *Historiae*, *Dialogus De Oratoribus*, *Factorum Et Dictorum Memorabilium Libri Novem*, *De Lingua Latina*, *Rerum Rusticarum De Agri Cultura*, *Historiae Romanae*, *Pharsalia*, *Astronomica*, *Epigrammata*, *Ars Amatoria*, *Epistulae or Heroides*, *Fasti*, *Ibis*. *Medicamina Faciei Femineae*, *Metamorphoses*, *Epistulae ex Ponto*, *Remedia Amoris*, *Tristia*, *Satires*, *Fabulae*, *Agamemnon*, *Hercules Furens*, *Medea*, *Oedipus*, *Phaedra*, *Phoenissae*, *Thyestes*, *Troades*, *Hercules Oetaeus chunks 1 & 2*, *Octavia*, *Punica*, *Achilleid*, *Silvae*, *Thebaid*, *Argonautica*| [`GI_results/`](https://github.com/PaschalisAg/seneca_stylometry/tree/main/analysis/results/GI_results)| 

[def]: https://github.com/PaschalisAg/seneca_stylometry/tree/main/verse_corpus