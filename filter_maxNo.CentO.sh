centroDF=$1
#LLChr4_RaGOO	10331782	10364168	47	LLChr4_RaGOO	36346242	4	0.28426	0.714849	0.39765	CW06
#LLChr4_RaGOO	10375804	10378839	15	LLChr4_RaGOO	36346242	4	0.285471	0.714445	0.39957	CW06
#LLChr4_RaGOO	10393362	10423360	64	LLChr4_RaGOO	36346242	4	0.285954	0.71322	0.400934	CW06
#LLChr4_RaGOO	10444825	10460618	42	LLChr4_RaGOO	36346242	4	0.28737	0.712195	0.403499	CW06
#
cat $centroDF | awk 'BEGIN{FS=OFS="\t"}{max[$11"\t"$7]=0}{a[$11"\t"$7]=$4}{if (a[$11"\t"$7]+0>max[$11"\t"$7]+0)max[$11"\t"$7]=a[$11"\t"$7] fi}END{for(i in max){print i"\t"max[i]}}' \
| sort -k1,1V > maxNo.CentO.txt
awk 'BEGIN{FS=OFS="\t"}NR==FNR{a[$11"\t"$7"\t"$4]=$0;next}{if (a[$1"\t"$2"\t"$3]) print a[$1"\t"$2"\t"$3]}' $centroDF maxNo.CentO.txt > ${centroDF%%.txt}_maxNo.CentO.txt


#cat data|awk 'BEGIN {max = 0} {if ($1+0>max+0) max=$1 fi} END {print "Max=", max}'
#awk '{s[$1] += $2}END{ for(i in s){  print i, s[i] } }' 