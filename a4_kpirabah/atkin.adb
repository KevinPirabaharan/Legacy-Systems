--Kevin Pirabaharan
--ID : 0946212
--kpirabah@mail.uoguelph.ca
--Saturday, April 4th 2017
--Assignment 4 | C- code
--This assignments is supposed to take an uppter limit from the user and then output
--all prime numbers less than or equal to said number in a ASCII file.

--Including the packages for Inputting and outputting text in addition to file detection
--and timing the program
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Directories;  use Ada.Directories;

procedure atkin is
    limit: Integer;
    My_File   : File_Type;
    File_Name : String := "primeAda_Output.txt";
    startTime, endTime : Time;
    milliS : Duration;

    --This function uses Sieve of Atkin to find primes
    procedure primeSolver(limit : integer) is
        x, y, n, r, i: integer;
        --types needed to be declared for arrays
        type verify is array (0 .. limit) of Boolean;
        sieve : verify;
    begin
        --Start timer
        startTime := Clock;

        --Create a boolean array that is as big as the upper limit and default val to false
        for i in 0 .. limit-1 loop
            sieve(i) := false;
        end loop;

        --This is the Sieve of Atkin
        --Multiple for loops that see the number of solutions for each value up to limit
        --If there is an odd amount of solutions (i.e. remainder with mod) then it is a prime
        --True = prime number
        x := 1;
        while (x*x < limit) loop
            y := 1;
            while (y*y < limit) loop
                n := (4*x*x) + (y*y);
                if n <= limit and then (n mod 12 = 1 or n mod 12 = 5) then
                    sieve(n) := true;
                end if;

                n := (3*x*x) + (y*y);
                if n <= limit and then n mod 12 = 7 then
                    sieve(n) := true;
                end if;

                n := (3*x*x) - (y*y);
                if x > y and then n <= limit and then n mod 12 = 11 then
                    sieve(n) := true;
                end if;
                y := y + 1;
            end loop;
            x := x + 1;
        end loop;

        --This makes every multiple of a square false because their composite
        r := 5;
        while (r*r < limit) loop
            if sieve(r) then
                i := r*r;
                while (i < limit) loop
                    sieve(r) := false;
                    i := i + (r*r);
                end loop;
            end if;
            r := r + 1;
        end loop;

        --Printing output to text files
        Create(File => My_File,
            Mode => Out_File,
            Name => File_Name);
        Put(File => My_File,
            Item => "Primes for: ");
        Put(File => My_File,
            Item => natural'image(limit));
        New_Line(File => My_File);
        if limit >= 2 then
            Put(File => My_File,
                Item => natural'image(2));
            New_Line(File => My_File);
        end if;
        if limit >= 3 then
        Put(File => My_File,
            Item => natural'image(3));
            New_Line(File => My_File);
            for a in 5 .. limit-1 loop
                if sieve(a) then
                    if a mod 5 > 0 then
                        Put(File => My_File,
                            Item => natural'image(a));
                        New_Line(File => My_File);
                    end if;
                end if;
            end loop;
        end if;

        --End timer
        endTime := Clock;

        --Multiple by 1000 to get millliseconds
        milliS := (endTime - startTime) * 1000;
        Put(File => My_File,
            Item => "Runtime = " & Duration'Image(milliS) & " milliseconds.");
        New_Line(File => My_File);
        Close(File => My_File);
        Put_Line("Results have been exported to primeAda_Output.txt located in the working direcorty of the program!");
        Put_line("Runtime = " & Duration'Image(milliS) & " milliseconds.");
    end primeSolver;

--The main function, this is where all the user input is taken in through numerous command loops.
--After that, the solving procedures/functions are called and input is passed through.
begin
  --Creates and deletes output file at start because no overwrite
  Create(File => My_File,
      Mode => Out_File,
      Name => File_Name);
  Close(File => My_File);
  Delete_File ("primeAda_Output.txt");
  --Takes Userinput
  Put_Line("Please insert a number up to which all primes are calculated: ");
  Ada.Integer_Text_IO.Get (limit);
  Skip_Line;
  --Calls function
  primeSolver(limit);
end atkin;
