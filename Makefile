all: dice knights text sieve

dice: _game_of_dice/dice.c _game_of_dice/dice.f95
	gcc -Wall -std=c99 _game_of_dice/dice.c -o bin/diceC
	gfortran -Wall -fbounds-check _game_of_dice/dice.f95 -o bin/diceFortran

knights: _knights_tour/knightstour.adb
	gnatmake _knights_tour/knightstour.adb -o bin/knightADA

text: _text_analyzer/textAnalyzer.cob
	cobc -x -free -Wall _text_analyzer/textAnalyzer.cob -o bin/textAnalyzer

sieve: _sieve_of_atkin/sieve.c _sieve_of_atkin/sieve.adb _sieve_of_atkin/sieve.f95
	gcc -Wall -std=c99 _sieve_of_atkin/sieve.c -o bin/sieveC -lm
	gnatmake _sieve_of_atkin/sieve.adb -o bin/sieveAda
	gfortran -Wall -fbounds-check _sieve_of_atkin/sieve.f95 -o bin/sieveFortran

clean:
	rm bin/*
	rm *.txt
	rm *.o
	rm *.ali
