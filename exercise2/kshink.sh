# file=SRR1145846_S1_L001_R1_001.fastq

# backticks (`) can be used to run a command. here we save the output of the command in a new variable called 'outfile'
# the command 'basename' removes the suffix 'fastq' from $file
outfile=`basename -s fastq $file`

# now we appends the new suffix "fastafake" to the output file name
# we need to use quotation marks to separate the variable name from the new suffix
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

#output from ex1
less $outfile

### REC/ THIS ISN'T GOING TO DO WHAT YOU WANT IT TO DO, UNIQ OPERATES ON THE WHOLE FILE, NOT ONE LINE AT A TIME
### REC/ DO THIS INSTEAD
 uniq $outfile > seqs.uniq.fa
 
#while read line; do
#uniq > seqs.uniq.fa
#done < $outfile

### REC/ MISMATCHED QUOTES -- SINGLE VERSUS DOUBLE
### REC/ DOUBLE QUOTES ARE USED IF SOMETHING INSIDE THEM NEEDS 'EXPANDING' LIKE A VARIABLE
grep -c '>' seqs.uniq.fa 

# define new variable 
savefile=`basename -s fake $outfile`

# to separate fake-fasta files back into real-fasta files use tr to replace tab characters with newline characters
cat $outfile | tr '\t' '\n' > $savefile

# remove outfile
rm $outfile

### REC/ NO OUTPUT FILE
