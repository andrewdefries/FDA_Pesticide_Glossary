#try to replace each line element with tab and no header: 
###
#everything before CAS > cmp

#everything after "Use" > use
cat PESTGLOS_Part1 | sed -n 's/Use: //p' | sed 's/^/\"/' | sed 's/$/\"/' > Use

#everything after "Category:" > category
cat PESTGLOS_Part1 | sed -n 's/Category: //p' > Category

#everything after "Mol. Form.:" > mf
cat PESTGLOS_Part1 | sed -n 's/Mol.Form.: //p' > MF

#everything after "LMS Code:" > lms
cat PESTGLOS_Part1 | sed -n 's/LMS Code: //p' > LMS

#everything after "Tolerances:" > tolerances
cat PESTGLOS_Part1 | sed -n 's/Tolerances: //p' > Tolerances

#remove "Alternate Names:" 	sed 's/Alternate Names://g'
cat PESTGLOS_Part1 | sed -n 's/Alternate Names //p' > Alternate

#everything after "9CI [ \t]" > 9CI
cat PESTGLOS_Part1 | sed -n 's/9CI //p' | sed 's/^/\"/' | sed 's/$/\"/' > 9CI

#everything after "IUPAC [ \t] > IUPAC
cat PESTGLOS_Part1 | sed -n 's/IUPAC //p' > IUPAC

#everything after "Trade [ \t]> tradename
cat PESTGLOS_Part1 | sed -n 's/Trade //p' | sed 's/^/\"/' | sed 's/$/\"/' > Trade

#everyting after "ISO [ \t]" > ISO
cat PESTGLOS_Part1 | sed -n 's/ISO //p' > ISO

#everything after "ANSI [ \t]" > ANSI
cat PESTGLOS_Part1 | sed -n 's/ANSI //p' > ANSI

##paste IUPAC Alternate Use Trade  > TableDraft  # to fix this fill the blank space made by missing IUPAC entries at the least with empty occurance of IUPAC: dso that the transpose step works 

#paste MF IUPAC ANSI ISO 9CI LMS Trade Category Use  > TableDraft

#paste 9CI Trade  Use  > TableDraft

paste 9CI Use  > TableDraft


###
#
#get each target and paste A B C D E F G

#cmp_name	CAS	Use	Category	MolForm	LMS	Tolernances	AlternateNames


#

cat PESTGLOS_Part1 | sed 's/\=//g' | sed ':a;N;$!ba;s/\n/ /g' | sed 's/Use:/\nUse:/g'| sed 's/Tolerances:/\nTolerances:/g' | sed 's/Names:/\nNames:/g'| sed 's/Mol. Form.:/\nMol_Form:/g' | sed 's/Use:/Use:/g' | sed 's/Category:/\nCategory:/g' | sed 's/LMS Code:/\nLMS_Code:/g' | sed 's/Alternate/\nAlternate_Names:/g'| sed 's/foreign use/\nforeign_use:/g' | sed 's/IUPAC/\nIUPAC:/g' | sed 's/ISO/\nISO:/g' | sed 's/Other/\nOther:/g' | sed 's/9CI/\n9CI:/g' | sed 's/ANSI/\nANSI:/g' | sed 's/.*\([0-9]\{2\}\).*-.*\([0-9]\{2\}\).*-.*\([0-9]\{1\}\).*/\nCAS:\1-\2-\3/g'  | sed 's/- /-/g' > SoFar

#to use this pipe as a model repurpose to dump to files to make a table fix name issue or use CAS for index

#Lost the first name and three digits of the CAS code


