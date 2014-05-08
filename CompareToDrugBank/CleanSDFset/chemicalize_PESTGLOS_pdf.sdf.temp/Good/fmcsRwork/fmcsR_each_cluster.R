library(ChemmineR)
library(fmcsR)
#######################
data(sdfsample)
sdfset<-sdfsample
apset<-sdf2ap(sdfset)
cluster<-cmp.cluster(apset, cutoff=c(0.5,0.6,0.7,0.8))

#cid(sdfset)<-substring(gsub(" ","_",sdfid(sdfset)), 1, 20)
#cid(sdfset)<-gsub("\\=", "_", cid(sdfset))
#cid(sdfset)<-gsub("\\/", "_", cid(sdfset))
#cid(sdfset)<-gsub("\\?", "_", cid(sdfset))
#cid(sdfset)<-gsub(" ","_",cid(sdfset))
#######################
Work<-sort(unique(cluster$CLID_0.7))
cluster$ids<-seq_along(cluster$ids)
#######################
DoTheWork<-function(d){
#######################
load("fmcsR_space.rda")
#######################
sdfset<-sdfset[subset(cluster, cluster$CLID_0.7==Work[d])$ids]
######################
#fmcsR the sdfset
################
Name<-paste("fmcsR_cluster_", Work[d], ".png", sep="")
png(file=Name, width=2400, height=2400, units="px")
##################
d <- sapply(cid(sdfset), function(x)
fmcsBatch(sdfset[x], sdfset, au=0, bu=0,matching.mode="aromatic")[,"Overlap_Coefficient"])
##################
##################
##################
hc <- hclust(as.dist(1-d), method="complete")
hc[["labels"]] <- cid(sdfset)
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE, main="hclust of fmcsR tanimoto distances")
dev.off()
##################

#######################
}
d<-1:seq_along(Work)
lapply(d, DoTheWork)
