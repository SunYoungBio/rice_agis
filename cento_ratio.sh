#PBS -q agis_shang
#PBS -l nodes=1:ppn=10
cd $PBS_O_WORKDIR
genome0=`ls NH*.fa CW*.fa`
genome="NH*/*.fa CW*/*.fa"
blastdir=/public/home/lixiaoX/software/yes/envs/blast/bin/
seqkitdir=/public/home/shangLG/yangyang/software/
bedtools=/public/home/lixiaoX/software/bedtools2/bin/bedtools
#creat genome dir and moved
#ls $genome0 | while read i; do mkdir -p ${i%%.fa*}; mv $i ${i%%.fa*};done
#makeblastdb
ls $genome | while read i; do $blastdir/makeblastdb -in $i -dbtype nucl;done
#blastn
#ls $genome | while read i; do echo -e "#PBS -q agis_shang\n#PBS -l nodes=1:ppn=10\ncd \$PBS_WORKDIR\n$blast/blastn -db $i -query centO.155nucl -out ${i%%.fa*}_outfmt6 -outfmt 6 \
#-num_threads 10\nsleep 1" > ${i%%/*.fa*}_blast.sh;done
#ls $genome | while read i; do qsub ${i%%/*.fa*}_blast.sh;done
ls $genome | while read i; do $blastdir/blastn -db $i -query centO.155nucl -out ${i%%.fa*}_outfmt6 -outfmt 6 -num_threads 10;done

#80 80 filter
ls $genome | while read i; do  awk '$3>80&&$4>123' ${i%%.fa*}_outfmt6 > ${i%%.fa*}_outfmt6_80.80;done
#creat .bed
ls $genome | while read i; do awk '{if($9<$10) print $2"\t"$9-1"\t"$10;else print $2"\t"$10-1"\t"$9}' ${i%%.fa*}_outfmt6_80.80 > \
${i%%.fa*}_outfmt6_80.80.bed;done
#sort
ls $genome | while read i; do sort -k1,1V -k2,2n ${i%%.fa*}_outfmt6_80.80.bed > ${i%%.fa*}_outfmt6_80.80.sorted.bed;done
#cal genomo length
ls $genome | while read i; do $seqkitdir/seqkit fx2tab -l -n -j 10 $i > ${i%%.fa*}.chrLength.txt;done

#######creat chr1-12
ls $genome | while read i; do sed 's/[^0-9]*\([0-9]*\).*/\1/' ${i%%.fa*}.chrLength.txt | paste ${i%%.fa*}.chrLength.txt - | sed 's/\t\t\t/\t/' > ${i%%.fa*}.chr1-12.txt;done
#######

#creat genome.bed
#ls $genome | while read i; do awk 'BEGIN{FS=OFS="\t"}{print $1"\t0\t"$NF}' ${i%%.fa*}.chrLength.txt > ${i%%.fa*}.chrLength.bed;done
#creat genome_chrID.bed,not full names
#ls $genome | while read i; do awk '{print $1"\t0\t"$NF}' ${i%%.fa*}.chrLength.txt > ${i%%.fa*}.chrLength.chrID.bed;done
#about 10kb to merge
ls $genome | while read i; do $bedtools merge -i ${i%%.fa*}_outfmt6_80.80.sorted.bed -d 10000 -c 1 -o count > \
${i%%.fa*}_outfmt6_80.80.merged10k.count.txt; done
#cal percent
ls $genome | while read i; do \
awk 'NR==FNR{a[$1]=$0;next}{print $0"\t"a[$1]}' \
${i%%.fa*}.chr1-12.txt ${i%%.fa*}_outfmt6_80.80.merged10k.count.txt | awk 'BEGIN{FS=OFS="\t"}{print $0"\t"$2/$(NF-1)"\t"($(NF-1)-$3)/$(NF-1)}' \
> ${i%%.fa*}_outfmt6_80.80.merged10k.count.centrPerc.txt;done
#cal ratio and add sample names
ls $genome | while read i; do awk '{print $0"\t"$(NF-1)/$NF"\t'${i%%/*.fa*}'"}' ${i%%.fa*}_outfmt6_80.80.merged10k.count.centrPerc.txt > \
${i%%.fa*}_outfmt6_80.80.merged10k.count.centrPerc.ratio.txt;done
