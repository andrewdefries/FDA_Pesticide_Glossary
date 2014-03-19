##################
#system("rm *.sdf")
#system("rm *.smi")
#system("rm CLK*")
system("gzip *.png")
system("rm *.png")
#system("unzip YAWYE_clean.sdf.gz")
#system("cp /home/waynebrain/Desktop/YAWYE/YAWYE_clean.sdf .")
#################
library(ChemmineR)
#################
##data(sdfsample)
##cid(sdfsample)<-sdfid(sdfsample)
##sdfset<-sdfsample
files<-list.files(pattern=".sdf", recursive=F)
t<-1
sdfset<-read.SDFset(files[t])
###############
cid(sdfset)<-substring(gsub(" ","_",sdfid(sdfset)), 1, 20)
cid(sdfset)<-gsub("\\=", "_", cid(sdfset))
cid(sdfset)<-gsub("\\/", "_", cid(sdfset))
cid(sdfset)<-gsub("\\?", "_", cid(sdfset))
cid(sdfset)<-gsub(" ","_",cid(sdfset))
#cid(sdfset)<-gsub("\\s__\\s","",sdfid(sdfset))
#cid(sdfset)<-sdfid(sdfset)
apset<-sdf2ap(sdfset)
sdfset<-sdfset[!sapply(as(apset,"list"),length)==1]
#############
##############
#blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

#blockmatrix[,4]<-gsub("\\s__\\s","",blockmatrix[,4])

#blockmatrix[,4]<-gsub("_","",blockmatrix[,4])

#datablock(sdfset)<-blockmatrix

#cid(sdfset)<-datablocktag(sdfset,tag="Click_ID")

#cid(sdfset)<-datablocktag(sdfset, tag="Click_ID")
#cid(sdfset)<-sdfid(sdfset)
#write.SDF(sdfset,file="load_me.sdf", sig=T)
###############
################
smiset<-sdf2smiles(sdfset) #(sdfset[1:2])
################
WriteSdfOut<-function(a){
write.SDF(sdfset[[a]], file=paste(cid(sdfset[a]), ".sdf", sep=""), sig=T, cid=T)
}
a<-1:length(smiset) #change to 2 for testing
lapply(a,WriteSdfOut)
################
WriteSmiOut<-function(a){
#cid(smiset)<-gsub(" ","_",cid(smiset))
write.SMI(smi=smiset[a], file=paste(cid(sdfset[a]), ".smi", sep=""), cid=T)
}
a<-1:length(smiset) #change to 2 for testing
lapply(a,WriteSmiOut)
###############
system("for i in *.smi
do babel $i -O $i.png 
done")
###############
#source("hwriteMoreTable.R") #works
source("hwriteMore.R") #fixed
###############
#system("firefox test.html")
###############
#to do
#add smiles field
#add links to wikipedia page from chembrain repo
#fix ChemmineR problem to export cid of smiset
#use trimNeihbors of nnm to print each clid with min members in rgl space
#highlight compounds in cluster and print cid in webGL out

