# Exercise 2

1. For the following SQL keywords, which GNU tools are useful to implement a similar functionality?

• FROM - cat  
• LIMIT - head/tail  
• SELECT - cut  
• WHERE - grep?  
• ORDER BY - sort  
• GROUP BY -

2. Answer the following queries for the Linux Kernel Mailing List data set using GNU utils
   and bash functionality:

a) Of how many lines does the longest mail consist?
cut : like select in SQL
`cat gmane.linux.kernel | grep -E '^Lines[0-9]+' | cut -d ' ' -f 2 | sort -n -r | head -n 1`
b) Which mail received most (direct) replies?
