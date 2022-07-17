---
theme: apple-basic
highlighter: shiki
lineNumbers: false
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
layout: intro
title: Unit 1 - Exam Structure
---

# Unit 1 - Exam Structure

Get familiar with the AP CS A exam

<div class="absolute bottom-10">
  <span class="font-light opacity-70">
    UnoCS Club @ 2022-07-17
  </span>
</div>

<!--
Slide notes
-->

---

# Two sections:

<br>
<br>

<div class="flex justify-around">
<div class="w-1/3 h-full rounded-20px bg-gray-500 p-40px text-2xl" v-click>
<h1 class="text-center text-5xl">Multiple-Choice</h1>
<ul>
<li>Time: <b>90min</b></li>
<li>Questions: <b>40</b></li>
</ul>
</div>
<div class="w-1/3 h-full rounded-20px bg-gray-500 p-40px text-2xl" v-click>
<h1 class="text-center text-5xl">Free-Response</h1>
<ul>
<li>Time: <b>90min</b></li>
<li>Questions: <b>4</b></li>
</ul>
</div>
</div>



---

# Multiple-Choice

<br>

**Example:** 

Evaluate the following expression: `4 + 6 % 12 / 4`

   	(A) 1
   	
   	(B) 2
   	
   	(C) 4
   	
   	(D) 4.5
   	
   	(E) 5

<br>

- 1 point for correct answer, no points for wrong answer or no answer.
- Guessing is **encouraged**
- If you finish early, you **cannot** start the next section early

---

# Free-Response

<br>

**Example:**

This question involves the implementation of a simulation of rolling two dice. A client program will specify the number of rolls of a sample size and the number of faces on each of the two dice. A method will return the percentage of times the roll results in a double. Double in this case means when two dice match or have the same value (not a data type).

You will write two of the methods in this class.

```java
public class DiceSimulation {
    /** Sample size of simulation */
    private int numSampleSize;
    
    /** Numbers of faces on each die */
    private int numFaces;
    
    public DiceSimuation(int numSamples, int faces) {
        numSampleSize = numSamples;
        numFaces = faces;
    }
    
```

---

```java
    // Returns an integer from 1 to the number of faces to simulate a die roll
	public int roll() {
        // to be implemented in part (a)
    }
    
	/** Simulates rolling two dice with the number faces given, 
	* for the number of sample size rolls. Returns the percentage
	* of matches that were rolled as an integer (eg. 0.50 would be 50)
	*/
    public int runSimulation() {
        // to be implemented in part (b)
    }
    
}
```

The following table contains sample code and the expected results.

| Statements and Expressions                      | Value Returned / Comment                                     |
| :---------------------------------------------- | ------------------------------------------------------------ |
| `DiceSimulation sl = new DiceSimulation(10, 6)` | (no value returned)                                          |
| `sl.runSimulation()`                            | 10 rolls are simulated; only the percentage of matches is displayed. |

---

(a) Write the `roll` method to simulate the roll of one die

```java
public int roll()
    
    
    
```

(b) Write the `runSimulation` method.

```java





```

<br>

- Answers will be judged by humans for 9 points for one major question
- Some mistakes can be forgiven. The principle is to keep the code simple and easy to understand.

---
layout: quote
---

# Next
[Unit 1 - AP CS A vs AP CS Principles](https://pre.unocs.club/1.2-vs-cs-principles)
