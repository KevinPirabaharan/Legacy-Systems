all: atkinC atkinAda atkinFortran

atkinC:
	gcc -Wall -std=c99 atkin.c -o atkinC -lm

atkinAda:
	gnatmake atkin.adb -o atkinAda

atkinFortran:
	gfortran -Wall -fbounds-check atkin.f95 -o atkinFortran

clean:
	rm atkinC
	rm atkinAda
	rm atkinFortran
	rm *.txt
	rm *.o
	rm *.ali
