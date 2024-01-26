# Sheet 09

21.12.2023

## Exercise 1

Order the following workloads by how well they are suited for cluster computing.
Assume a cluster of machines which are connected via ethernet and that the dataset is
distributed onto the machines when the workload starts. A workload that is well suited
for cluster computing decreases in execution time proportional to the number of machines
in the cluster.

### Good

• Search in text documents  
• The toy example from the lecture (Basic Building Blocks, slide 26-35)

### Medium

• Join of two relations (both relations to big for one machine)  
• Shuffling a dataset

### Not good

• Breadth-first search (cant keep everything in memory)  
• Sorting records  
You dont know the amount of data that will be needed to join (?)  
Each record will jump at least once

## Exercise 2

Formulate map-reduce programs to handle the following tasks:

1. For the multi-sets X : [(a, b)], Y : [(c, d)] ﬁnd all combinations where b = c.

```py
# X = (a, b)
# Y = (c, d)
def mapX(X):
    emit(x.b, ("X", x.a, x.b))

def mapY(X):
    emit(y.c, ("Y", y.c, y.d))

k = 1
l = {("X", 5, 1), ("X", 6, 1), ("y", 1, 7)}

def reduce(t, counts):
    lX = l.filter(_1 == "X")
    lY = l.filter(_1 == "Y")
    for t in cross(lX, lY):
        emit("result", t)

main():
    mX = mapAll(map, X)
    mY = mapAll(map, Y)
    return reduceAll(reduce, mX + mY)["result"]
```

2. For the documents D : [(name, [w])] (where D is a list of documents, in which each
   document is a list of words w), ﬁnd the words which all documents have in common.

```python
# D : [(name, [w])]

def mapCount(x):
    emit("count", 1)

k = "count"
l = {1, 1, 1, ..., 1}
def reduceCount(k, l):
    emit("resCount", sum(l))

def mapWords(d):
    for w in unique(d.words):
        emit(w, 1)

k = word
l = {1, 1, 1...}
def reduceWords(k, l):
    emit(k, sum(l))


def main(D):
    mCount = mapAll(mapCount, D)
    resCount = reduceAll(reduceCount, mCount)["resCount]
    mWords = mapAll(mapWords, D)
    resWords = reduceAll(reduceWords, mWords) # distributed dictionary

D: {(name, [w])}
```

3. Compute AB for the two matrices A and B.

```py
# https://www.geeksforgeeks.org/matrix-multiplication-with-1-mapreduce-step/

A - nxm
B - mxp

A = {(i, j, val)}
def mapA(A):
    for k in range(p):
        emit((i, k, j), val)

def mapA(B):
    for k in range(n):
        emit((k, j, i), val)

k = (2, 1, 1)
def reduceProd(k, l):
    emit((k._1, k._2), l[0] * l[1])

k = (2, 1)
l = {p1, p2, p3...}
def reduceSum(k, l):
    emit(k, sum(l))
```

## Exercise 4

```spark
spark.read
    .format("csv")
    .option("header", "true")
    .option("inferSchema", "true")
    .load("songs.csv")
    .cache()

val songs = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("songs.csv").cache()

songs.filter($"year" === 2000).show()
songs.as("a").join(songs.as("b"), $"a.artist_familiarity" === $"b.artist_familiarity").count()

Diff:
songs.as("a").join(songs.as("b"), abs($"a.artist_familiarity" - $"b.artist_familiarity") < 0.001).count()
```
