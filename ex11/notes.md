# Tutorial 11

18.1.2024

## Exercise 1

```py
# Retreives number of nodes in the graph
nrNodes = graph.nrNodes ()

# iterates over all nodes in graph
for ( n : graph.nodes())
    # do something with n
for ( neigh : graph.out(n)) # iterates over the neighbors
for ( neigh : graph.in(n)) # iterates over the
# reverse neighbors ( incoming edges )
# Creates a property on the graph .
# A property stores information for every node .
pr = graph.makeProperty()
pr[n] = 5 # sets property pr for node n to 5
```

```py
def page_rank(g: Graph, d: int):
    # init
    nr = g.nrNodes()
    pr = g.makeProperty()
    pr_new = g.makeProperty()
    for n in g.nodes():
        pr[n] = 1/nr

    # iter
    for _ in range(20):
        for n in g.nodes():
            pr_new[n] = (1-d)/nr

        for n in g_nodes():
            for neigh in n.out():
                pr_new[neigh] += d*pr[n]/len(n.out())

        swap(pr, pr_new)
```

### 2

#### Problematic

`pr_new[neigh]` is a problematic part because we dont know which are our neighbours and we do random access every time.  
Prone to a lot of cache misses.

If we sort `pr_new` by degree of node, they get accessed more frequently and are together in the cache. The most popular cache line is most often going to stay in cache.

#### Good

`for n in g.nodes()` and `for neigh in n.out()` - we iterate over neighbours iteratively.

### 3

We write to the disk andhave to swap pages (?) when reading again from the disk.

### 4

Order nodes by poplarity and keep the most popular in memory, swap only the least popular ones.

### 5

```py
def page_rank(g: Graph, d: int):
    # init
    nr = g.nrNodes()
    pr = g.makeProperty()
    pr_new = g.makeProperty()

    # iter
    for _ in range(20):
        send(MachineId mId, Message m)
        for n in g.nodes():
            pr_new[n] = (1-d)/nr

        for n in g_nodes():
            for neigh in n.out():
                MachineId mId = getMachineIdForGraphNode(Node neigh)
                send(idM, d*frac)
                # pr_new[neigh] += d*pr[n]/len(n.out())

        for n in g.nodes():
            msgs : list(float) = []
            recv(msgs, n)
            pr_new[n] += sum(msgs)

        swap(pr, pr_new)
```

### 6

Less overhead if you just compute all leaf nodes with one machine and you send them at once (less headers).

system call - "hey, im gonna do something, prepare X (for example the connection)"

### 7

```py

key: node_id
val: node
def map(key, val):
    # "sending" the values to your neighbours
    n = val
    for neigh in n.out():
        emit(neigh, pr[n]/len(n.out()))

key: node_id
l: list of update values for that node
def reduce(key, l):
    # obtaining the values from your neighbours and summing them up
    pr[key] = (1-d)/nr + d*sum(l)
    emit(key, pr[key])


def main():
    nr = g.numberNodes()
    for n in g.nodes():
        pr[n] = 1/nr

    # for one step
    mapped = mapAll(map, g)
    reduceAll(reduce, mapped)


```

### 8

mapReduce takes care of swapping and full buffer, instead of OS. does not concern us (anymore).
