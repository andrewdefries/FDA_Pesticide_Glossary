##################
library(ChemmineR)
##################
files<-list.files(pattern=".sdf", recursive=F)
##################
sdfset<-read.SDFset(files[1])
##################
#valid<-validSDF(sdfset)
#sdfset<-sdfset[valid]
#cid(sdfset)<-gsub("_","", sdfid(sdfset))
cid(sdfset)<-gsub(" ", "_", sdfid(sdfset))
apset<-sdf2ap(sdfset)
#sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
#cid(sdfset)<-sdfid(sdfset)
###########################
#
#blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

#blockmatrix[,4]<-gsub("\\s__\\s","",blockmatrix[,4])

#blockmatrix[,4]<-gsub("_","",blockmatrix[,4])

#datablock(sdfset)<-blockmatrix

cid(sdfset)<-datablocktag(sdfset,tag="Click_ID")

##################
cluster<-cmp.cluster(apset, cutoff=c(0.5,0.6,0.7,0.8))

#pdf(file="ClidNeighbors.pdf")
png(file="ClidNeighbors.png")

par(mfrow = c(2,2))

plot.default(x=rownames(cluster), y=cluster$CLID_0.5, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.6, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.7, ylim=c(0,160))
plot.default(x=rownames(cluster), y=cluster$CLID_0.8, ylim=c(0,160))
################
dev.off()
################
library(fmcsR)
################
##png(file="hclust_fmcsR_cladogram.png", width=6400, height=6400, units="px")
##################
##d <- sapply(cid(sdfset), function(x)
##fmcsBatch(sdfset[x], sdfset, au=0, bu=0,
##matching.mode="aromatic")[,"Overlap_Coefficient"])
##################
##################
##################
##hc <- hclust(as.dist(1-d), method="complete")
##hc[["labels"]] <- cid(sdfset)
##plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE, main="hclust of fmcsR tanimoto distances")
##dev.off()
##################
save.image("fmcsR_space.rda", compress=T)
