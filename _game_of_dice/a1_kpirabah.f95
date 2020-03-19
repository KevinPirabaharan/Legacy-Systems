program Dice
    !Kevin Pirabaharan
    !kpirabah@mail.uoguelph.ca
    !Assignment 1
    !This assignment was a reeingineering of an older Fortran code to a newer standard. Allows user to play game of dice using monte carlo methods

    implicit none

    !variables
    integer :: totGames, wins = 0, losses = 0, numGames = 0, point = 0, countSum = 0
    integer :: i, j, sum, diceRoll

    !Prompts
    write(*,*) 'Please input parameters'
    write(*,*) 'In format: i j totalGames'
    write(*,*) '*Remember the spaces*'
    read(*,*)  i, j, totGames

    do
        !Call diceRoll() function
        sum = diceRoll(i,j)

        if (sum == 2 .OR. sum == 3 .OR. sum == 12) then
            losses = losses + 1
            numGames = numGames + 1

        else if (sum == 7 .OR. sum == 11) then
            wins = wins + 1
            numGames = numGames + 1

        else
             point = sum
            !This loop is when the previous cases arnt met, when this occurs keep going until point or 7 are found
            do

                 sum = diceRoll(i,j)

                 if(sum == 7) then
                     losses = losses + 1
                     numGames = numGames + 1

                 else if (sum == point ) then
                     wins = wins + 1
                     numGames = numGames + 1
                 end if

                 if(sum == point .OR. sum == 7) exit
            end do
        end if

        if(numGames == totGames) exit

    end do

    write (*,*) 'Here are the results'
    write (*,*) 'Wins =', wins, 'Losses = ', losses, 'I = ', i, 'J = ', j

end program Dice

!diceRoll function emulates two dice being rolled and their sum being added, uses i and j values to randomize
integer function diceRoll(i,j)

    !declaring and initializing variables
    integer :: k = 0, L = 947, M = 941
    integer, dimension(2) :: N, NN, NO

    k = 1

    do
        i = i * 2
        j = j * 2

        if( i >= L) then
            i = i - L
        end if

        if (j >= M) then
            j = j - M;
        end if

        N(k) = i + j

        if (N(k) >= 1000) then
            N(k) = N(k) - 1000
        end if

        NN(k) = N(k) / 6
        NO(k) = N(k) - 6 * NN(k) + 1

        if (k == 2) exit
        k = k + 1
    end do


    diceRoll = NO(1) + NO(2)

!return sum to program
end function diceRoll
