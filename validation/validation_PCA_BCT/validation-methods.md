# Validation of the methods

A different version of the main anaysis dataset will be used to validate. The dataset is contained in a folder called `validation_corpus`. It contains 28 texts in verse written by three authors (in total 287138 tokens).
The authors used in this corpus are:

- Publius Ovidius Naso (henceforward: **Ovid**)
  - Ars Amatoria
  - Epistulae
  - Fasti
  - Ibis
  - Medicamina Faciei femineae
  - Metamorphoses
  - Ex Ponto
  - Remedia Amoris
  - Tristia
  
- Aulus Persius Flaccus (henceforward: **Persius**
  - The six books of *Satires*
  
- Publius Papinius Statius (henceforward: **Statius**)
  - The 12 books of *Thebaid*
  

To validate the methods we selected one text from each author (i.e., in total three texts) and we renamed them with the following format: `unknown{n}.txt`. The authors to validate the methods are the following ones:

- *Amores* by Ovid (i.e., `unknown0.txt`)
- *Thebaid* book 1 by Statius (i.e., `unknown1.txt`)
- *Satire* 4 by Persius (i.e., `unknown2.txt`)

The first two texts were randomly chosen to be tested. However, the last one is the trickiest one because it consists of only 342 tokens, thus the uncertainty that is being mirrored in the distance from the other texts in the corpus.
