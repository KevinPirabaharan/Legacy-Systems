#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <sys/time.h>
/*
Kevin Pirabaharan
ID : 0946212
kpirabah@mail.uoguelph.ca
April 4th, 2017
Assignment 4 | C- code
-This assignments is supposed to take an uppter limit from the user and then output
  all prime numbers less than or equal to said number in a ASCII file.
*/
int main(void)
{
    struct timeval stop, start; //This is struct for the timming variables.
    int limit;
    FILE *fp;
    //Prompt
    printf("Please insert a number up to which all primes are calculated: ");
    scanf("%d", &limit);
    fp = fopen("primeC_Output.txt", "w");
    gettimeofday(&start, NULL); //Start timer

    //Create a boolean array that is as big as the upper limit and default val to false
    bool sieve[limit];
    for (int i=0; i<limit; i++)
        sieve[i] = false;

    /*This is the Sieve of Atkin
    -Multiple for loops that see the number of solutions for each value up to limit
    -If there is an odd amount of solutions (i.e. remainder with mod) then it is a prime
    -True = prime number*/
    for (int x = 1; x*x < limit; x++)
    {
        for (int y = 1; y*y < limit; y++)
        {
            int n = (4*x*x)+(y*y);
            if (n <= limit && (n % 12 == 1 || n % 12 == 5))
                sieve[n] = true;

            n = (3*x*x)+(y*y);
            if (n <= limit && n % 12 == 7)
                sieve[n] = true;

            n = (3*x*x)-(y*y);
            if (x > y && n <= limit && n % 12 == 11)
                sieve[n] = true;
        }
    }

    //This makes every multiple of a square false because their composite
    for (int r = 5; r*r < limit; r++)
    {
        if (sieve[r])
        {
            for (int i = r*r; i < limit; i += r*r)
                sieve[i] = false;
         }
    }

    //Print to file
    fprintf(fp,"Primes up to %d:\n", limit);
    if (limit >= 2)
    {
        fprintf(fp,"2\n");
    }
    if (limit >= 3)
    {
        fprintf(fp,"3\n");
        for (int a = 5; a < limit; a++)
        {
            if (sieve[a])
            {
                if ((a % 5) > 0)
                {
                    fprintf(fp,"%d\n", a);
                }
            }
        }
    }
    //Stop timer and print execution time
    gettimeofday(&stop, NULL);
    double milliSecs = (double)(stop.tv_sec - start.tv_sec) * 1000.0f + (double)(stop.tv_usec - start.tv_usec) / 1000.0f;
    fprintf(fp,"Exectuion time: %.4f millliseconds\n",milliSecs);
    printf("Numbers printed to output file\nExectuion time: %.4f millliseconds\n",milliSecs);
    return 0;
}
