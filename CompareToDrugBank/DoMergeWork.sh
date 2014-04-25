rm -r *.temp

for i in *.sdf

do
#######################
mkdir $i.temp
cp hide/Clean.chemicalize_PESTGLOS_pdf.sdf $i.temp/
cp $i $i.temp/
####
#rm ClickableArabidopsisActives.sdf
####
#mv $i.merge.sdf $i.temp/
######################


#cp $i $i.temp/
#merge here

cd $i.temp
######################
##babel $i $i.frag.sdf -m
##rm $i
#####
##find . -exec grep -q '\*' '{}' \; -delete
##find . -exec grep -q 'R#' '{}' \; -delete
##find . -exec grep -q 'A 0 0' '{}' \; -delete
##find . -exec grep -q 'R' '{}' \; -delete
##find . -exec grep -q 'n0 1' '{}' \; -delete
##find . -exec grep -q 'alkyl' '{}' \; -delete
##find . -exec grep -q 'aryl' '{}' \; -delete
##find . -exec grep -q 'Ca+2' '{}' \; -delete
#####
##babel $i.frag.sdf $i.clean.sdf
##rm $i.frag.sdf
#####################
babel $i Clean.chemicalize_PESTGLOS_pdf.sdf -O $i.merge.sdf
###
cd ..
cp *.R $i.temp/
cd $i.temp/
######################
#R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R
#####
cd ..
#######################
done

