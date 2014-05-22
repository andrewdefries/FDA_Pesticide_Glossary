awk -F":" -v n=4 \
'BEGIN { x=1; c=0;} 
 ++c <= n && x == 1 {print $1; buf = buf $2 "\n";
     if(c == n) {x = 2; printf buf} next;}
 !/./{c=0;next}
 c <=n {printf "%s\n", $2}' SoFar | \
 paste - - - - | \
 column -t -s "$(printf "\t")"
