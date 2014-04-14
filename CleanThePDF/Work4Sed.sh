#Extract the text from the pdf
pdftotext -raw PESTGLOS.pdf 
mv PESTGLOS.txt PESTGLOS_raw.txt

#split document into beef and index
#remove lines 1-231 then remove lines 16285-24639
sed '16285,24639d'  PESTGLOS_raw.txt | sed '1,231d' >  PESTGLOS_Part1

#preserve the index
sed '1,16286d' PESTGLOS_raw.txt  >  PESTGLOS_Index



#terms to remove


#########Remove unwanted text
#remove lines containing  "FDA Glossary"  # of Pesticide Chemicals
#remove lines containing "page"   #2 June 2005


#remove index and put into another file
#use line number 
