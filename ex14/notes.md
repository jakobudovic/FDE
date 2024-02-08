# Exercise 14

(prob not in the exam)

8.2.2024

## Exercise 1

a)
Sc(Catch me if you can) = {publication date, IMDb ID}
Sc(Leo DiCaprio) = {starred in, award received}
Sc(Grace Hopper) = {award received}
Sc(Tom Hanks) = {starred in, award received, member of political party}
Sc(Nathalie Baye) = {starred in, award received}

Sc = {{publication date, IMDb ID}^1, {starred in, award received}^2,...}

b)
check, which occurences have "starred in" AND "award received" in their set:
Leo DiCaprio, Tom Hanks and Nathalie Baye

## Exercise 2

**Basic syntax**
Match direct children:
doc('uni3')/university/faculties/faculty/facultyName

Match any child with name:
doc('uni3')//facultyName

### a) Return all professors who give one or more lectures

```
Filtering:
doc('uni3')//professor[.//lecture]/name
.//lecture - in "this node" find any child "lecture"

Negating the condition:
doc('uni3')//professor[not(.//lecture)]/name
```

### b) Find all students who attend all lectures

```
Student who attends more classes:
<student xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ID="M1337" matrNr="M1337">
  <name>1337</name>
  <semester>9</semester>
  <attends lectures="V5022 V5041 V5049 V4052 V5043 V5052 V5259 V5001 V5216 V4630"/>
</student>

@lectures - access attribute lectures
tokenize() - aka split() in python
distinct-values(expression) - get distinct values

doc('uni3')//student[count(tokenize(attends/@lectures," "))=count(//lecture)]/name
```

### c) Return students with the highest number of semesters, use aggregate functions

```
let $maxsem:=max(data(doc("uni3)//student/semester))

data(doc("uni3")//student/semester)
=
doc("uni3")//student/semester/data()

Result:
let $maxsem:=max(data(doc("uni3")//student/semester))
return doc("uni3")//student[semester=$maxsem]


```

### d) Calculate the sum of semester periods per week (sws) for each professor. Include professors without any lecture in your results

```
for $p in doc("uni3")//professor
return <prof>{$p/name}<sum>{sum(data($p//sws))}</sum></prof>
```

### e) Find all students attending all four-hour lectures.

### f) Return the name of all students who never had a grade better than 3.0 in any exam.

```
doc("uni3")//student[not(.//exam/@grade < 3)]
```

### g) Calculate the examination material’s extent for each student. Therefore, return the name of the student and the sum of semester periods per week of all lectures in which the student wrote an exam

### h) Some of the students’ names contain the name of a professor. Return all such students

```
Doesnt work!
for $s in doc("uni3")//student
where doc("uni3")//professor[contains($s/name,name)]
return $s/name
```

### i) Determine the level of awareness of each professor among students. We assume students only get to know professors by attending their lectures or writing an exam.

Union returns non-duplicate values

### How to use contains?

contains(\<where\>, \<what\>)
