#include <stdio.h> //Used for printf
#include <stdlib.h>

int diceRoll (int * iPointer, int * jPointer)
{
	int N[2], NN[2], NO[2], l = 947, m = 941, NSum, k = 0, i = iPointer[0], j = jPointer[0];
	for (k = 0; k < 2; k++)
	{
		i = 2 * i;
		j = 2 * j;
		if (i >= l)
		{
			i = i - l;
		}
		if (j >= m)
		{
			j = j - m;
		}
		N[k] = i + j;
		if (N[k] >= 1000)
		{
			N[k] = N[k] - 1000;
		}
		NN[k] = N[k]/6;
		NO[k] = N[k] - (6*NN[k]) + 1;
	}
	iPointer[0] = i;
	jPointer[0] = j;
	NSum = NO[0] + NO[1];
	return NSum;
}

int main (void)
{
	int sum = 0, wins = 0, losses = 0, playedGames = 0, point = 0, totalGames;
	int i[1];
	int j[1];
	printf("==========================\nWelcome to a Game of Dice\n--------------------------\n");
    printf("Please input parameters\nIn format: i j totalGames\n==========================\n"); //Requests the highscore then stores it in maxScore

	scanf("%d %d %d", &i[0], &j[0], &totalGames);
    while (playedGames != totalGames)
    {
		sum = diceRoll(i, j);
		if ((sum == 7) || (sum == 11))
		{
			wins++;
			playedGames++;
		}
		else if ((sum == 2) || (sum == 3) || (sum == 12))
		{
			losses++;
			playedGames++;
		}
		else
		{
			point = sum;
			do
			{
				sum = diceRoll(i, j);
				if (sum == point)
				{
					wins++;
					playedGames++;
				}
				else if (sum == 7)
				{
					losses++;
					playedGames++;
				}
			} while((sum != point) && (sum != 7));
		}
	}
	printf("WINS:\t%d\tLOSSES:\t%d\tI:\t%d\tJ:\t%d\n", wins, losses, i[0], j[0]);
	return 0;
}
