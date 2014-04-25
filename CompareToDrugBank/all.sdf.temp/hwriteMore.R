###############
library(ChemmineR)
library(hwriter)
###############
#data(apset)
#data(sdfsample)
#sdfset<-sdfsample
#smiset<-sdf2smiles(sdfset)
apset<-sdf2ap(sdfset)
#fpset<-desc2fp(apset)
##
naebors<-10
nnm <- nearestNeighbors(apset,numNbrs=naebors)
###############
png<-list.files(pattern="smi.png",recursive=F)
###############
#himg=hwriteImage(sort(png), table=FALSE)
#DrawList<-matrix(paste(nnm$names, ".smi.png", sep="")[matrix(nnm$index, byrow=T)])
#himg=hwriteImage(matrix(paste(nnm$names, ".smi.png", sep="")[matrix(nnm$index, byrow=T)]), table=FALSE)

#himg=hwriteImage(matrix(paste(nnm$names[matrix(nnm$index, byrow=F)], ".smi.png", sep="")), table=FALSE)
Draw<-cbind(paste(nnm$names[nnm$index[,1]], ".smi.png", sep=""), paste(nnm$names[nnm$index[,2]], ".smi.png", sep=""), paste(nnm$names[nnm$index[,3]], ".smi.png", sep=""), paste(nnm$names[nnm$index[,4]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,5]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,6]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,7]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,8]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,9]], ".smi.png", sep=""),paste(nnm$names[nnm$index[,10]], ".smi.png", sep=""))

himg=hwriteImage(Draw, table=FALSE)
##

#mat=cbind(1:length(png), substring(sort(names(as.list(as.character(smiset)))),1,25), himg, himg)# as.character(smiset))

mat=cbind(1:length(png), nnm$names, himg)
##
colnames(mat)=c('#', 'name', 'Query compound', 'nnm1', 'nnm2','nnm3', 'nnm4','nnm5', 'nnm6','nnm7','nnm8','nnm9')
##
hwrite(mat, 'test.html', br=TRUE, center=TRUE, row.bgcolor=list(Species=c('#ffaacc', '#ff88aa', '#ff6688')), col.bgcolor='#ffffaa', row.style=list(Species='text-align:center'))
##############
#Look at the html
##############

