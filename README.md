# **Legacy Languages**
This is a repository of all the projects that I have created using the legacy languages: Fortran, Ada, Cobol. I have also coded some of the programs in C as well to see runtime differences. Outputted files will be outputted to the working directory.

In order to compile all the programs you will need the following packages:
- C: **gcc**
- Fortran: **gfortran**
- Ada: **gnat**
- Cobol: **open-cobol**
*****************
## **1. Game of Dice**
   ### This program was a re-engineering of an older Fortran code to a newer standard. Allows user to play game of dice using monte carlo methods

   Compile:  **make dice**

   Run Fortran:  **./bin/diceFortran**

   Run C: **./bin/diceC**

## **2. A Knight's Tour**
   ### This program was to create a program that solves the knights tour while taking user input on the size of the board and that starting position.

   Compile:  **make knights**

   Run ADA:  **./bin/knightADA**

## **3. Text Analyzer**
   ### This program was to count various aspects (number/avg of sentences, words, characters, numbers) in a string. The program takes an input file and output file as user input.

   Compile:  **make text**

   Run Cobol:  **./bin/textAnalyzer**

## **4. Sieve of Atkin**
   ### This assignments is supposed to take an upper limit from the user and then output all prime numbers less than or equal to said number in a ASCII file. The programs return runtimes and outputs prime numbers in text files in the working directory.

   Compile:  **make sieve**

   Run ADA:  **./bin/sieveADA**

   Run Fortran:  **./bin/sieveFortran**

   Run C: **./bin/sieveC**

**********
**make all** command will compile all files
