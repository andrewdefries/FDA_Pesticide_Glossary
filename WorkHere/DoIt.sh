rm -r *.temp

for i in *.sdf

do

mkdir $i.temp
cp $i $i.temp
cd $i.temp 
babel $i $i.frag.sdf -m 
rm $i

find . -exec grep -q '\*' '{}' \; -delete
find . -exec grep -q 'R#' '{}' \; -delete
find . -exec grep -q 'A   0  0' '{}' \; -delete
find . -exec grep -q 'R' '{}' \; -delete
find . -exec grep -q 'n0 1' '{}' \; -delete
find . -exec grep -q 'alkyl' '{}' \; -delete
find . -exec grep -q 'aryl' '{}' \; -delete
find . -exec grep -q 'Ca+2' '{}' \; -delete




mkdir Good
mv *.sdf Good
cd Good
babel *.sdf $i.good.sdf
mv $i.good.sdf Clean.$i




rm $i.frag*

cd ..
cd ..

cp *.R $i.temp/Good/

cd $i.temp/Good

R CMD BATCH CleanSDF.R
#R CMD BATCH fmcsRthis.R
R CMD BATCH hwriteMoreNow.R

######################################
cd ..
cd ..
######################################
done
