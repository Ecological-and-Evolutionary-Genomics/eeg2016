# Workflow for classifying 12S ribosomal RNA sequences

# download mitochondrial genomes sequences from the Mitochondrial Genome Database of Fish
wget http://mitofish.aori.u-tokyo.ac.jp/files/mitogenomes.zip
unzip mitogenomes.zip
cat *.fa > fish_mito.fasta
rm *.fa

#how many sequences are in the database?

grep -c '>' fish_mito.fasta
#4987


# make oligos.txt file for mothur using forward and reverse primers

echo "reverse	TAGAACAGGCTCCTCTAG" > oligos.txt
echo "forward	TTAGATACCCCACTATGC" >> oligos.txt


# run pcr.seqs in mothur to trim fish mito sequences based on primers used for amplicon sequencing
./mothur "#pcr.seqs(fasta=fish_mito.fasta, oligos=oligos.txt, pdiffs=2)"

# how many sequences are in the trimmed database?
grep -c '>' fish_mito.pcr.fasta
2011

# align in clustalo
clustalo -i fish_mito.pcr.fasta -o fish_mito.pcr.aln

# open in seaview
# clean up alignment/remove bad sequences
# all sequences need to be the same length, including gaps

# use as reference database in mothur


