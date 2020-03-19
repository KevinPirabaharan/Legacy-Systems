# **Legacy Languages**
This is a repository of all the projects that I have created using the legacy languages: Fortran, Ada, Cobol. I have also coded some of the programs in C as well to see runtime differences.

In order to compile all the programs you will need the following packages:
- C: **gcc**
- Fortran: **gfortran**
- Ada: **gnatmake**
- Cobol: **cobc**
*****************
## **1. Game of Dice**
   ### This assignment was a reeingineering of an older Fortran code to a newer standard. Allows user to play game of dice using monte carlo methods

   Compile:  **make dice**

   Run Fortran:  **./bin/diceF95**

   Run C: **./bin/diceC**

## **2. A Knight's Tour**
   ### This program will use numbers inputted by the user and then rewrite them up until the sum is greater than 50.
   >Run command: **make numRewrite**

## **3. Text Analyzer**
   ### This program takes in a list of grades and stores them in an array. Have the program then calculate the grade point average, and then print each of the grades followed by the grade point average.
   >Run command: **make gpa**

## **4. Sieve of Atkin**
   ### This program takes in a word (ask the user how many letters first), changes every vowel in the word to an uppercase Z, and then prints the new word.
   >Run command: **make vowel**