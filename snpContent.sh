vcffile=$1	#have one line header included sample names
class=$2	#sample name and class
#grep -P 'missense_variant|#CHROM' $vcffile | sed 's/AC.*\(ANN\)/\1/' | sed -e 's/0\/0:[^\t]*/Ref/g' -e 's/0\/1:[^\t]*/Het/g' -e 's/1\/1:[^\t]*/Hom/g' -e 's/\.\/\.:[^\t]*/Mis/g' > ${vcffile%.vcf}.targetSNPcontent.txt
#numf=`head -n1 ${vcffile%.vcf}.targetSNPcontent.txt | awk '{print NF}'`
numf=`head -n1 $vcffile | awk '{print NF}'`
echo "you have column "$numf
for i in `seq 1 $numf`;do cut -f $i $vcffile | paste -s; done > ${vcffile%.txt}.tr.txt
awk 'NR==FNR{a[$1]=$0;next}a[$1]{print a[$1]"\t"$2}' ${vcffile%.txt}.tr.txt $class > ${vcffile%.txt}.tr.class.txt
cut -f 1-2,4 $vcffile | sed -e '1d' -e 's/\t/_/g' > ${vcffile%.txt}_snpName.txt
n=2
cat ${vcffile%.txt}_snpName.txt | while read snp; do awk '{print "'$snp'\t"$NF"\t"$'$n'}' ${vcffile%.txt}.tr.class.txt; let n++; done > ${vcffile%.txt}.tr.class.plot.txt
