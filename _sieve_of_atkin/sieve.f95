program Atkin
    !Kevin Pirabaharan
    !kpirabah@mail.uoguelph.ca
    !This assignments is supposed to take an uppter limit from the user and then output
    !all prime numbers less than or equal to said number in a ASCII file.

    implicit none

    integer :: intLimit
    real :: limit, startT, endT, execTime
    !millliseconds of timer
    integer :: values(8)

    !Prompts
    write(*,*) 'Please insert a limit up to which all primes are calculated'
    read(*,*)  limit

    !turns real input into an integer
    intLimit = floor(limit)
    ! opening the output file
    open(1,file='primeFor_Output.txt', action="write", status='replace')

    ! starting timer
    call date_and_time(values=values)
    startT = values(8)

    write (1,*) "Primes up to :", intLimit
    !Hardcode 2 and 3 because no calculations can find them
    if (limit >= 2) then
        write(1,*) 2
    else
        write (1,*) "No primes were found. Try a bigger number"
    end if
    if (limit >= 3) then
        write(1,*) 3
    end if
    if (limit >= 5) then
        write (1,*) 5
        !Call function to solve
        call primeSolver()
    end if

    !End timer
    call date_and_time(values=values)
    endT = values(8)
    execTime = (endT - startT)

    !Finish outputting and close file
    write (*,*) 'Output written in primeFor_Output.txt'
    write (1,*) ''
    write (1,*) 'Execution time in seconds: ', execTime
    print '(" Execution time: ",F10.6," millliseconds.")', endT-startT
    close(1)

    contains
    ! A function which uses sieve of Atkins to find root
        subroutine primeSolver()
            integer :: rootOfLimit, intLimit
            logical, allocatable :: sieve(:)
            integer :: x = 0, y = 0, z = 0

            intLimit = floor(limit)

            ! Allocate memory to array to avoid going out of bounds or seg faults
            !Create a boolean array that is as big as the upper limit
            allocate (sieve(intLimit + 1))

            rootOfLimit = floor(SQRT(limit));

            !Hardcode these values because calculations cant find them
            sieve(1) = .false.
            sieve(2) = .true.
            sieve(3) = .true.
            sieve(4) = .false.
            sieve(5) = .true.

            !default val to false for rest of the array
            do z = 6, intLimit, 1
                sieve(z) = .false.
            end do

            !Multiple loops that see the number of solutions for each value up to limit
            !If there is an odd amount of solutions (i.e. remainder with mod) then it is a prime
            !True = prime number
            do x = 1, rootOfLimit, 1
                do y = 1, rootOfLimit, 1
                    z = 4 * x * x + y * y
                    if (z <= intLimit) then
                        if (modulo(z, 12) == 1 .or. modulo(z, 12) == 5) then
                            if (sieve(z)) then
                                sieve(z) = .false.
                            else
                                sieve(z) = .true.
                            end if
                        end if
                    end if

                    z = 3 * x * x + y * y

                    if (z <= intLimit) then
                        if (modulo(z,12) == 7) then
                            if (sieve(z)) then
                                sieve(z) = .false.
                            else
                                sieve(z) = .true.
                            end if
                        end if
                    end if

                    z = 3 * x * x - y * y

                    if (z <= intLimit .and. x > y .and. modulo(z,12) == 11) then
                        if (sieve(z)) then
                            sieve(z) = .false.
                        else
                            sieve(z) = .true.
                        end if
                    end if
                end do
            end do

            !This makes every multiple of a square false because their composite
            do z = 6, rootOfLimit, 1
                if (sieve(z)) then
                    x = 1
                    y = z * z
                    do while (y <= intLimit)
                        sieve(y) = .false.
                        x = x + 1
                        y = x * z * z
                    end do
                end if
            end do

            !Output Primes to textfile
            do x = 6, intLimit, 1
                if (sieve(x)) then
                    if (modulo(x,5) > 0) then
                        write(1,*) x
                    end if
                end if
            end do

            !Free memory
            deallocate (sieve)
    end subroutine primeSolver

end
