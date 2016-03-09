#pulled scripts from: 
#http://stackoverflow.com/questions/25980012/cat-fastq-to-cat-fasta-file-conversion-problems
#https://www.gnu.org/software/sed/manual/sed.html
#sed '/^@/!d;s//>/;s/1_N_0_1//g;s/:/_/g;N' SRR1145846_S1_L001_R1_001.fastq > SRR1145846_S1_L001_R1_001.fasta #Convert fastq to real fasta
sed '/^@/!d' SRR1145846_S1_L001_R1_001.fastq > SRR1145846_S1_L001_R1_001.txt #includes all of the lines that begin with @
#^ lists only lines with @
#!d = still trying to figure out what this is doing
#s//>/ = replace all empty spaces with >
#N = Add a newline to the pattern space, then append the next line of input to the pattern space. If there is no more input then sed exits without processing any more commands. 


sed 's/@/>/;s/:/_/g;N;s/\n/ /;/+/d;s/1_N_0_1//g' SRR1145846_S1_L001_R1_001.fastq > SRR1145846_S1_L001_R1_001.fake.fasta #Convert FASTQ text into fake-FASTA text
# s/@/>/ = replace all @ with >
# s/:/_/g find and replace all : with _
# N;s/\n/ / = merge two lines into one based on a space (merge the + and letters strings)
# /+/d = remove all lines with +
# s/1_N_0_1//g = Remove all 1_N_0_1 with nothing
#there is no \t  for tab on mac
# to replace blank spacew with tab you can use's/ \+ /\t/g', but in the second space you have to control+V before you press tab in the terminal ... gross
#so you can add it to big script above or do separately:
sed 's/  /control+v (press tab)/g' SRR1145846_S1_L001_R1_001.fake.fasta > SRR1145846_S1_L001_R1_001.faketab.fasta #(first /  / = two spaces)

# Or you can do this:
sed 's/  */\'$'\t/g' SRR1145846_S1_L001_R1_001.fake.fasta > SRR1145846_S1_L001_R1_001.fake_tab.fasta
#\'$'\t = workaround for tab issues in mac descirbed above

#tried this next one for the newline and didn't work so I used the transliterate code below
#sed 's/\'$'t/'$'\n/g' SRR1145846_S1_L001_R1_001.fake_tab.fasta > SRR1145846_S1_L001_R1_001A.fasta

#yay convert fake fasta to fasta by adding newline where tab is 
tr ''$'\t' ''$'\n' < SRR1145846_S1_L001_R1_001.fake_tab.fasta > SRR1145846_S1_L001_R1_001A.fasta
