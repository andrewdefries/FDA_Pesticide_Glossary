##################
library(ChemmineR)
#################
files<-list.files(pattern=".sdf")
################organize work vector
WorkVector<-c("all.sdf","approved.sdf","Clean.chemicalize_PESTGLOS_pdf.sdf", "experimental.sdf","illicit.sdf", "nutraceutical.sdf","small_molecule.sdf","withdrawn.sdf")
#################
all_drugbank<-read.SDFset(files[1])

cid(all_drugbank)<-datablocktag(all_drugbank,tag="DRUGBANK_ID")
#################
pestglos<-read.SDFset(files[3])

cid(pestglos)<-sdfid(pestglos)
#################
all_drugbank_w_pestglos <-c(all_drugbank,pestglos)
#################
sdfset<-all_drugbank_w_pestglos

valid <- validSDF(sdfset)

sdfset <- sdfset[valid]

apset<-sdf2ap(sdfset)

sdfset<-sdfset[!sapply(as(apset, "list"), length)==1]

save(apset, file="all_durgbank_w_pestglos_apset.rda", compress=T)

#apset<-sdf2ap(sdfset)
####
#cluster apset
##clusters <- cmp.cluster(apset, cutoff = c(0.7))
##save(clusters, file="all_drugbank_w_pestglos_clusters.rda", compress=T)
#embed clusters in a 3-dimensional space based on apset
load("all_drugbank_w_pestglos_clusters.rda")
coord <- cluster.visualize(apset, clusters, size.cutoff=1, dimensions=3, quiet=TRUE)
###
save(coord, file="all_drugbank_w_pestglos_coord.rda", compress=T)
###

sdfset<-read.SDFset("all.sdf")
cid(sdfset)<-datablocktag(sdfset,tag="DRUGBANK_ID")

sdfset_approved<-read.SDFset("approved.sdf")
cid(sdfset_approved)<-datablocktag(sdfset_approved,tag="DRUGBANK_ID")

sdfset_small_molecule<-read.SDFset("small_molecule.sdf")
cid(sdfset_small_molecule)<-datablocktag(sdfset_small_molecule,tag="DRUGBANK_ID")

sdfset_experimental<-read.SDFset("experimental.sdf")
cid(sdfset_experimental)<-datablocktag(sdfset_experimental,tag="DRUGBANK_ID")

sdfset_nutraceutical<-read.SDFset("nutraceutical.sdf")
cid(sdfset_nutraceutical)<-datablocktag(sdfset_nutraceutical,tag="DRUGBANK_ID")

sdfset_illicit<-read.SDFset("illicit.sdf")
cid(sdfset_illicit)<-datablocktag(sdfset_illicit,tag="DRUGBANK_ID")

sdfset_withdrawn<-read.SDFset("withdrawn.sdf")
cid(sdfset_withdrawn)<-datablocktag(sdfset_withdrawn,tag="DRUGBANK_ID")


###

approved_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_approved, tag="DRUGBANK_ID")]

small_molecule_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_small_molecule, tag="DRUGBANK_ID")]

experimental_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_experimental, tag="DRUGBANK_ID")]

nutraceutical_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_nutraceutical, tag="DRUGBANK_ID")]

illicit_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_illicit, tag="DRUGBANK_ID")]

withdrawn_subset<-sdfset[datablocktag(sdfset, tag="DRUGBANK_ID")%in%datablocktag(sdfset_withdrawn, tag="DRUGBANK_ID")]


####
#############
library(rgl)
#############

CoordSwitch<-c("coord_all.png","coord_approved.png", "coord_small_molecule.png","coord_experimental.png", "coord_nutraceutical.png", "coord_illicit.png", "coord_withdrawn.png")

##########
###rglThat<-function(a){
###########
###########
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
#
###coord<-CoordSwitch[a]
#
coord_all <- coord[,1:3]
coord<-coord_all
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[1])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
############
coord_approved <-coord[rownames(coord)%in%cid(approved_subset), 1:3]
coord<-coord_approved
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="blue", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[2])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
###########
coord_small_molecule <- coord[rownames(coord)%in%cid(small_molecule_subset), 1:3]
coord<-coord_small_molecule
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="yellow", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[3])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
############
coord_experimental <- coord[rownames(coord)%in%cid(experimental_subset), 1:3]
coord<-coord_experimental
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="green", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[4])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
###########
coord_nutraceutical<- coord[rownames(coord)%in%cid(nutraceutical_subset), 1:3]
coord<-coord_nutraceutical
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[5])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
############
coord_illicit <- coord[rownames(coord)%in%cid(illicit_subset), 1:3]
coord<-coord_illicit
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="brown", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[6])
rgl.close()
############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
###########
coord_withdrawn <- coord[rownames(coord)%in%cid(withdrawn_subset), 1:3]
coord<-coord_withdrawn
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="brown", alpha=1, shininess=20); aspect3d(1, 1, 1)
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
rgl.snapshot(CoordSwitch[7])
rgl.close()
############
