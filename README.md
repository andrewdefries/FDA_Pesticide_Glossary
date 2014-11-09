FDA_Pesticide_Glossary
======================

The FDA hosts a number of resources related to food related health. Source information for the pesticides approved in US are hosted here:

http://www.fda.gov/Food/FoodborneIllnessContaminants/Pesticides/ucm113891.htm

The data is provided in tables of a PDF file. The PDF format is problematic for downstream analysis using R. Full text was extracted to group pesticides by category and to perform an in-depth chemical analysis. Structure data files (SDF) were derived by uploading a list of compunds to chemicalize.org. SDF files were used in chemical similarity calculations.

A visual summary of similarity relationships is available as a nearest neighbor table here:

http://andrewdefries.github.io/FDA_Pesticide_Glossary/FDA_Pesticide_Glossary.html

Comparing FDA pesticides to DrugBank database
===================

Compounds in the FDA pesticide data set are diverse spanning different domains of chemical space. The DrugBank database (http://www.drugbank.ca) contains compound that are FDA approved, withdrawn, illicit, and experimental. 

Chemically similar domains between FDA approved pesticides and the DrugBank database were visualized by pooling the compounds in an all-against-all comparison using the atom-pair similarity method. Results are shown in the CompareToDrugBank folder. 

```
library(ChemmineR)
# load sdf file
sdfset<-read.SDFset("mysdfset.sdf")

# calculate atom pair from connection matrices
apset<-sdf2ap(sdfset)

# cluster compounds based on atom-pairs
 
clusters<-cmp.cluster(apset, cutoff=0.7)

coord<-cluster.visualize(clusters, dimensions=3)

#visualize using rgl
```

![Chemical space comparison](https://github.com/andrewdefries/FDA_Pesticide_Glossary/blob/master/CompareToDrugBank/ChemicalSpaceMontage/MontageLabels.png "Chemical space montage")

The figure above is a multi-dimensional scaling (MDS) plot derived by comparisons of atom-pairs. Figure A. Shows the complete dataset (both FDA approved and drugbank compounds). B. Shows compounds FDA approved pharmaceuticals in the DrugBank dataset. Shows C. Shows small molecule compounds from DrugBank D. Shows compounds listed in the FDA pesticide dataset.

```
library(rgl)

# provide coord file to rgl to plot spheres

# setup rgl view
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))

rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)

spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)

axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")

rgl.snapshot("Out.png")

rgl.close()
```

The drugbank dataset can be downloaded via:
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
