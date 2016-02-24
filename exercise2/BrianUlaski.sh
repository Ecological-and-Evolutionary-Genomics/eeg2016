# Brian Ulaski | eeg2016 | exercise 2

#####################################

# This script includes a few additional lines of code to Eric's fastq2fasta.sh script - it includes additional lines for sorting and identifying unique sequences.

# the first argument to the command line ($1) and saves it into a variable called 'file', which can be accessed at '$file'
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
less $outfile

# while read line; do
# uniq > seqs.uniq.fa
# done < $outfile

# grep -c ">' seqs.uniq.fa 

# define new variable 
savefile=`basename -s fake $outfile`

# to separate fake-fasta files back into real-fasta files use tr to replace tab characters with newline characters
cat $outfile | tr '\t' '\n' > $savefile

# count the number of unique sequences and write to a new file ending in "_uniq_seqs"
savefile2=$savefile"_uniq_seqs" 
cut -f2 $outfile | sort | grep '[ATGC]' | uniq | wc -l > $savefile2

# after you run this then write the top 100 lines to a new file and post to GitHub
head -n 100 $savefile > BrianUlaski.fa



