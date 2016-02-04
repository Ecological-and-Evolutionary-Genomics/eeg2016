# Brian Ulaski | eeg2016 | exercise 2

#####################################

# This script is to be used following Eric's fastq2fasta.sh script.

# This script sorts and dereplicates fasta

sed 'N;s/\n/\t/' SRR1145846_S1_L001_R1_001.fasta >> SRR1145846_S1_L001_R1_001.fasta_fake

sort -n SRR1145846_S1_L001_R1_001.fasta_fake >> SRR1145846_S1_L001_R1_001.fasta

# while read myline; do
# 	echo "" >> SRR1145846_S1_L001_R1_001.fasta_fake_dup
# 	echo $myline >> SRR1145846_S1_L001_R1_001.fasta_fake_dup
# 	echo "" >> SRR1145846_S1_L001_R1_001.fasta_fake_dup
# 	echo $myline >> SRR1145846_S1_L001_R1_001.fasta_fake_dup
# done < SRR1145846_S1_L001_R1_001.fasta_sort

# while read myline; do
# 	grep -v "^$" SRR1145846_S1_L001_R1_001.fasta_fake_dup >> SRR1145846_S1_L001_R1_001.fasta_fake_nonblank
# done < SRR1145846_S1_L001_R1_001.fasta_fake_dup

# while read myline; do
# 	uniq >> SRR1145846_S1_L001_R1_001.fasta_fake_uniq
# done < SRR1145846_S1_L001_R1_001.fasta_fake_nonblank

