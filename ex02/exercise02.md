# Sheet 2

## Exercise 1

1. For the following SQL keywords, which GNU tools are useful to implement a similar functionality?

• FROM - cat  
• LIMIT - head/tail  
• SELECT - cut  
• WHERE - grep?  
• ORDER BY - sort  
• GROUP BY -

## Exercise 2

Answer the following queries for the Linux Kernel Mailing List data set using GNU utils
and bash functionality:

a) Of how many lines does the longest mail consist?
cut : like select in SQL
`cat gmane.linux.kernel | grep -E '^Lines: [0-9]+' | cut -d ' ' -f 2 | sort -n -r | head -n 1`  
b) Which mail received most (direct) replies?
`cat gmane.linux.kernel | grep -E '^In-Reply-To:' | cut -d ' ' -f 2 | sort | uniq -c | sort -n -r | head -n 
1`

## Exercise 3.

Answer the following queries for the TPC-H data set using GNU utils and bash function- ality. You can download the data set using the links provided in the Moodle course and this link contains the schema

a)
`tpch % join -t '|' -1 3 -2 1 <(sort -t '|' -k 3 nation.tbl) <(sort -t '|' -k 1 region.tbl | grep 'EUROPE') | cut -d '|' -f 3`

b)
`jakobudovic@w213-t-v4 tpch % wc -l lineitem.tbl
 6001215 lineitem.tbl`  
This number +1, because this command (wc -l) counts newlines not lines

c)
`sort -n -t '|' -k 2 lineitem.tbl | awk -F '|' 'BEGIN{part_key=0;sum=0;} {if ($2 != part_key) {print part_key, sum; sum=0; part_key=$2;} sum+=$5} END{print part_key, sum;}'`  
awk -F - delimiter
3 parts: begin end and execute part

d)
`sort -t '|' -k 2 lineitem.tbl 83.57s user 1.36s system 85% cpu 1:38.91 total
awk -F '|' 19.60s user 0.78s system 20% cpu 1:38.91 total`

if we add `> /dev/null`:  
`sort -t '|' -k 2 lineitem.tbl 83.26s user 1.28s system 86% cpu 1:37.76 total
awk -F '|' > /dev/null 19.49s user 0.10s system 20% cpu 1:37.76 total`

if we have `| head`:  
sort -t '|' -k 2 lineitem.tbl 76.39s user 1.02s system 99% cpu 1:17.66 total
awk -F '|' 0.29s user 0.00s system 0% cpu 1:17.59 total
head 0.00s user 0.00s system 0% cpu 1:17.44 total

## Exercise 4

`perv stat <program...>`
