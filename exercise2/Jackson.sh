#chmod +x fastq2fasta.sh

# run as ./fastq2fasta.sh SRR1145846_S1_L001_R1_001.fastq

 file=SRR1145846_S1_L001_R1_001.fastq    
 
 outfile=`basename -s fastq $file`
 
 outfile=$outfile"fastafake" 
 
 grep '^\+$' -B 2 $file | grep -v '^\+$' | grep -v '^\-\-$' | tr '[@: ]' '[>__]' | paste - - > $outfile

 wc *.fastq 
 
 sort -n SRR1145846_S1_L001_R1_001.fastafake > assignment2.fasta

 while read myline; do                        
  echo "$myline" >> assignment2.dup.fasta
  echo "" >> assignment2.dup.fasta
  echo "$myline" >> assignment2.dup.fasta
  echo "" >> assignment2.dup.fasta
done < assignment2.fasta

sort -u assignment2.dup.fasta > assignment2.uniq.fasta

grep . assignment2.uniq.fasta > assignment2final.uniq.fasta

cut -f2 assignment2final.uniq.fasta | sort -u | grep '[ATGC]' | uniq | wc -l > ex2-answer.txt
 
savefile=`basename -s fake $outfile`

cat $outfile | tr '\t' '\n' > $savefile

head -n 100 $savefile > Jackson.fa
  
rm $outfile
