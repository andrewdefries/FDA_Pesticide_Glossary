##################
library(ChemmineR)
##################
files<-list.files(pattern=".pdf.sdf", recursive=F)

outnames<-gsub("_pdf.sdf", "_clean.sdf", files)

LoadCleanSpit<-function(a){
############################
sdfset<-read.SDFset(files[a])
#
valid <- validSDF(sdfset)
sdfset <- sdfset[valid]
#
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset, "list"), length)==1]
#
#

#
cid(sdfset)<-sdfid(sdfset)
#
write.SDF(sdfset, file=outnames[a], sig=T, cid=T)
############################
}
a<-1:length(files)
lapply(a, LoadCleanSpit)
