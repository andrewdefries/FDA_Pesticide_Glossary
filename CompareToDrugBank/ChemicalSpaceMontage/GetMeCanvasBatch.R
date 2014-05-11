############
library(rgl)
library(ChemmineR)
#############
#files<-list.files(pattern="_coord.rda", recursive=F)
files<-list.files(pattern=".sdf", recursive=F)
#############
rgl4Me<-function(t){
#############
sdfset<-read.SDFset(files[t])
#############
sdfsetname<-gsub(".sdf", "_sdfset.rda", files[t])
coordname<-gsub(".sdf", "_coord.rda", files[t])
clustername<-gsub(".sdf", "_clusters.rda", files[t])
apsetname<-gsub(".sdf", "_apset.rda", files[t])
#############
valid <- validSDF(sdfset)
sdfset <- sdfset[valid]
#cid(sdfset)<-sdfid(sdfset)
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset, "list"), length)==1]
save(apset, file=apsetname, compress=T)
#cluster apset
clusters <- cmp.cluster(apset, cutoff = c(0.7))
save(clusters, file=clustername, compress=T)
#embed clusters in a 3-dimensional space based on apset
#load("all_drugbank_w_pestglos_clusters.rda")
coord <- cluster.visualize(apset, clusters, size.cutoff=1, dimensions=3, quiet=TRUE)
save(coord, file=coordname, compress=T)
#############
load(files[t])
#############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset,
640+offset))
#############
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
#############
colorZ<-as.vector(coord[,4])
#############
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.00125, color=coord[,4], alpha=1, shininess=20); aspect3d(1, 1, 1)
############
x<-coord[,1]
y<-coord[,2]
z<-coord[,3]
splt <- split(seq_along(x), ceiling(seq_along(x)/100))
for(i in splt)
text3d(x[i], y[i], z[i], text=seq_along(x)[i], color="black") #rownames(coord)[i])
############
#text3d(coord[,1], coord[,2], coord[,3], text=rownames(coord))
############
axes3d(col="black"); title3d("", "", "", "", "", col="black"); bg3d("white")
############
############
pngName<-paste(files[t],"rglSpacesWColorZ", sep="")
############
rgl.snapshot(pngName)
############
writeWebGL(dir=file.path(getwd(), t), width=2800)
############
rgl.close()
############
}
###################
t<-3:length(files) 
lapply(t, rgl4Me)
#############
############
###########
##########
#########
########
#######
######
#####
####
###
##
#

