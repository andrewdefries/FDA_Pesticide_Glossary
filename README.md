FDA_Pesticide_Glossary
======================

The FDA hosts a number of resources related to food related health. Source information for the pesticides approved in US are hosted here:

http://www.fda.gov/Food/FoodborneIllnessContaminants/Pesticides/ucm113891.htm

The data is provided in tables of a PDF file. The PDF format is problematic for downstream analysis using R. Full text was extracted to group pesticides by category and to perform an in-depth chemical analysis.

A visual summary of similarity relationships is available as a nearest neighbor table here:

http://andrewdefries.github.io/FDA_Pesticide_Glossary/FDA_Pesticide_Glossary.html

Comparing FDA pesticides to compounds listed in teh DrugBank database
===================

```
wget http://www.drugbank.ca/system/downloads/current/structures/all.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/approved.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/small_molecule.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/experimental.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/nutraceutical.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/illicit.sdf.zip

wget http://www.drugbank.ca/system/downloads/current/structures/withdrawn.sdf.zip

unzip '*.zip'
```
