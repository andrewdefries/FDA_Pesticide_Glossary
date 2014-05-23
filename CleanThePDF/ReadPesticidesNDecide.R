#be sure to ./FieldLish.sh before running this

SliceNDecide<-read.table("TableDraft", fill=T, row.names=NULL)

Groups<-gsub(" ", "", unique(SliceNDecide$V2)[-33])

Groups<-gsub(",","", Groups)


#This is how you get access to the compounds by group
#write a function to cycle through groups and spit out lists

ShowCompoundByGroup<-function(p){
###############################

ListbyGroup<-subset(SliceNDecide, SliceNDecide$V2%in%Groups[p])

write.table(ListbyGroup, file=paste(gsub("/", "", Groups[p]), ".txt", sep=""))

###############################
}
p<-1:length(SliceNDecide$V1)
lapply(p, ShowCompoundByGroup)



