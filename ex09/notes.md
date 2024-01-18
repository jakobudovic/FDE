# Sheet 09

21.12.2023

## Exercise 1

Order the following workloads by how well they are suited for cluster computing.
Assume a cluster of machines which are connected via ethernet and that the dataset is
distributed onto the machines when the workload starts. A workload that is well suited
for cluster computing decreases in execution time proportional to the number of machines
in the cluster.
• Search in text documents  
• The toy example from the lecture (Basic Building Blocks, slide 26-35)  
• Sorting records  
You dont know the amount of data that will be needed to join (?)  
Each record will jump at least once  
• Breadth-first search  
• Join of two relations (both relations to big for one machine)  
• Shuffling a dataset
