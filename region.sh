#!/bin/sh
#Region1=mm10.exon.sort1.bed
#R2=UTR3.sort.bed

#bedtools map -a $Region1  -b cell2.combined.2.bed  -c 4,5 -o sum,sum  > Exon.2cell.meth.bed
#bedtools map -a $R2  -b  cell2.combined.1.bed  -c 4,5 -o sum,sum  > UTR3_2cell.meth.bed
dir=/nfs3/panpan/scWGBS/embryo_liu/
cd ${dir}
#cat GSM1386021_2cell_mc_CG_maternal_plus.bed GSM1386021_2cell_mc_CG_paternal_plus.bed | sort -k1,1V -k2,2n|bedtools merge   -c 5,6 -o sum,sum > merge.E2.bed

#zcat GSM1386022_4cell_mc_CG_maternal_plus.bed.gz GSM1386022_4cell_mc_CG_paternal_plus.bed.gz | sort -k1,1V -k2,2n|bedtools merge   -c 5,6 -o sum,sum > merge.E4.bed
#cat GSM1386023_ICM_mc_CG_maternal_plus.bed GSM1386023_ICM_mc_CG_paternal_plus.bed | sort -k1,1V -k2,2n|bedtools merge   -c 5,6 -o sum,sum > merge.EICM.bed
#zcat GSM1386025_E75_mc_CG_maternal_plus.bed.gz GSM1386025_E75_mc_CG_paternal_plus.bed.gz | sort -k1,1V -k2,2n|bedtools merge   -c 5,6 -o sum,sum > merge.E7.5.bed

region=("exon" "UTR_3" "promoter" "island")
list=("merge.E2" "merge.E4" "merge.EICM" "merge.E7.5")

#for i in "${list[@]}";do
       #  base=$(echo "$i" | sed 's/_3$/.bed/')
	# mv "$i" "$base"
#	for n in ${region[@]};do	
 #      		 sort -k1,1V -k2,2n ${n}.bed > ${n}.sort.bed
	  #       sort -k1,1V -k2,2n ${i} > ${i}.sort	
  #      	bedtools intersect -a ${n}.sort.bed  -b  ${i}.bed  -wo   > ${n}_$i
#		echo "${n}_$i"
#		bedtools merge -i ${n}_$i -c 7,8 -o sum,sum >sum.${n}_$i
#                awk -v OFS="\t"  '{if ($4+$5 !=0 )  print $1,$2,$3,$4/($4+$5)}'  sum.${n}_$i > ${n}.rate.$i.bed
               # rm ${n}_$i sum.${n}_$i  $i                 

#	done
#done

for i in *rate*;do
#	 awk '{if ($4 >= 0||$5 >= 0 && $4+$5 !=0 ) {$6=$4/($4+$5)} else {$6=0} print $0}'

	awk '{sum += $4; count++} END {print sum/count}' $i  >>sum.txt
	echo "${i}_level" >>sum.txt
done




#		awk '{if ($4 >= 0||$5 >= 0 && $4+$5 !=0 ) {$6=$4/($4+$5)} else {$6=0} print $0}' Exon.2cell.meth.bed  | awk '{sum += $6; count++} END {print sum/count}'  > sum2.txt
#awk '{if ($4>=0||$5>=0 && $4+$5 !=0) {$6=$4/($4+$5)} else {$6="NA"} print $0}' UTR3_2cell.meth.bed|awk '{if ($6 != "NA") print $0}' - | awk '{sum += $6; count++} END {print sum/count}'  >>sum.txt

#awk '{if ($4 >= 0||$5 >= 0 && $4+$5 !=0 ) {$6=$4/($4+$5)} else {$6=0} print $0}' ICM.exon.1.bed | awk '{sum += $6; count++} END {print sum/count}'  >>sum2.txt


#awk '{if ($4>=0||$5>=0 && $4+$5 !=0) {$6=$4/($4+$5)} else {$6="NA"} print $0}' ICM.utr.1.bed|awk '{if ($6 != "NA") print $0}' - | awk '{sum += $6; count++} END {print sum/count}'  >>sum.txt
