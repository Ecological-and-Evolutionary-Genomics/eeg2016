##messy and probably wrong example##
#sed -n '1~4s/^@/>/p;2~4p' SRR1145846_S1_L001_R1_001.fastq > seqs.fasta  ##creates a fasta from a fastq 
# sort by ID (every other line): first add special characters around the fasta header, remove new line symbols, sort numerically on the second part of the fasta header, put back new line characters, remove the empty line created during the process.
#sed -e '/>/s/^/@/' -e '/>/s/$/#/' seqs.fasta | tr -d "\n" | tr "@" "\n" | sort -t "_" -k2n | tr "#" "\n" | sed -e '/^$/d' > orderedseqs.fasta 

# count unique (every other line)
#grep '[ATGC]' orderedseqs.fasta  | uniq | wc -l > ../ex2-answer.txt
	##answer: 105242- I think this is acutally wrong##

##Example From Eric's Coding##MCL Addition at the end##
#!/bin/bash ### 
# takes the first argument to the command line ($1) and saves it into a variable called 'file', which can be accessed at '$file'
file=$1

# runs the command 'basename' to remove the suffix 'fastq' from $file and save the result to a variable called 'outfile'
outfile=`basename -s fastq $file`

# appends the new suffix "fastafake" to the output file name
outfile=$outfile"fastafake"

# match the single plus sign on a line by itself plus the two lines before it
# ^ matches the beginning of a line
# \+ matches a literal plus because a plus sign is also a wildcard regular expression character
# $ matches the end of a line
# -B2 prints the two lines Before the match
# then pipe it into the next command
# the \ at the end is used be used to break one command over several lines
grep '^\+$' -B 2 $file | \

# takes the output from the previous grep and removes the single plus sign (i.e. matches everything but)
# -v inverts the match
grep -v '^\+$' | \

# takes the output from the previous grep and removes the dashes added by the first grep '--'
grep -v '^\-\-$' | \

# tr is the transliterate command, it takes the characters from the first block and replaces each instance with the characters in the second block, one by one, and outputs the result to a new file
tr '[@: ]' '[>__]' | \

# paste takes the input and concatenates the corresponding lines of the given input files with a tab character by default
# then we output the text to $outfile
paste - - > $outfile

# insert script from exercise1 to sort and count uniq

# define new variable 
savefile=`basename -s fake $outfile`

# to separate fake-fasta files back into real-fasta files use tr to replace tab characters with newline characters
cat $outfile | tr '\t' '\n' > $savefile

# remove outfile ### comment this out so can keep to sort and count uniques
#rm $outfile

######count the number of unique sequences and write to a new file ###pico/nano
savefile2=$savefile"_NumUniq" 
cut -f2 $outfile | sort | grep '[ATGC]' | uniq | wc -l > $savefile2
  ##answer=45324#

####### after you run this then write the top 100 lines to a new file
head -n 100 $savefile > Mary-Cathrine.fa
