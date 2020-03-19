--Kevin Pirabaharan
--kpirabah@mail.uoguelph.ca
--This assignments was to create a program that solves the knights tour while taking user input on the size of the board and that starting position.

--Including the packages for Inputting and outputting text
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure knightsTour is
    boardSize, xStart, yStart : Integer;
    --types needed to be declared for arrays so that they may be able to be used as paramaeters
    type dimensions is array (0 .. 8,0 .. 8) of Integer;
    type legalMoves is array (0..7) of Integer;

    --This function prints out the solution (if there is one) to the screen and to a file named tour.txt
    procedure solution (boardArray : dimensions; tempBoardSize : Integer) is
    My_File   : File_Type;
    File_Name : String := "_output/tour.txt";
    begin
        Create(File => My_File,
              Mode => Out_File,
              Name => File_Name);
        for p in 0 .. tempBoardSize loop
            for s in 0 .. tempBoardSize loop
                Put(boardArray(p,s) + 1);
                Put(File => My_File,
                    Item => boardArray(p,s) + 1);
            end loop;
            New_Line(1);
            New_Line(File => My_File);
        end loop;
        Close(File => My_File);
        Put_Line("Results have been exported to tour.txt located in the _output folder!");
    end solution;

    --Checks if the knight can land on this position and also to see if the knights hasn't already landed on square already
    function possibleMoves(x, y : Integer; boardArray : dimensions) return Boolean is
    begin
        if x >= 0 and then x < boardSize and then y >= 0 and then y < boardSize and then boardArray(x,y) = -1 then
            return true;
        else
            return false;
        end if;
    end possibleMoves;

    --This function is the one that does all the solving, it uses recursion to test all possibilities
    function recursiveSolving(x, y, moveNum : Integer; boardArray : in out dimensions; xMove, yMove : legalMoves) return Boolean is
        dest_y, dest_x : Integer;
    begin
        if moveNum = (boardSize * boardSize) then
            return true;
        end if;
        --try all possible moves
        for k in 0 .. 7 loop
            dest_x := x + xMove(k);
            dest_y := y + yMove(k);
            if possibleMoves(dest_x, dest_y, boardArray) = true then
                boardArray(dest_x, dest_y) := moveNum;
                if recursiveSolving(dest_x, dest_y, moveNum+1, boardArray, xMove, yMove) = true then
                    return true;
                else
                    --Backtrack to the last move since it was valid
                    boardArray(dest_x, dest_y) := -1;
                end if;
            end if;
        end loop;
        return false;

    end recursiveSolving;

    --This function uses backtracking to solve the problem. Calls all the other functions related to solving the data
    procedure tourSolver(boardSize, xStart, yStart : integer) is
        tempBoardSize : Integer := boardSize - 1;               --Arrays are structured differently so this variable is used
        boardArray : dimensions;
        --Below are all 8 possible moves that the knight can make on a chess board
        xMove : legalMoves := (2, 1, -1, -2, -2, -1, 1, 2);
        yMove : legalMoves := (1, 2,  2,  1, -1, -2, -2, -1);
    begin
        for i in 0 .. tempboardSize loop
            for j in 0 .. tempboardSize loop
                boardArray(i,j) := -1;
            end loop;
        end loop;
        boardArray(xStart, yStart) := 0;
        if recursiveSolving(xStart, yStart, 1, boardArray, xMove, yMove) = false then
            Put("Solution does not exist for inputted values");
        else
            Put_Line("Here is the solution for the Knight's tour with inputted values:");
            solution(boardArray, tempBoardSize);
        end if;
    end tourSolver;

--The main function, this is where all the user input is taken in through numerous command loops. After that, the solving procedures/functions are called and input is passed through.
begin
  --Takes board size
  Put_Line("Welcome to the Knight's Tour Program. Please enter a board size:");
  Ada.Integer_Text_IO.Get (boardSize);
  Skip_Line;
  --Loops like this are used till the accepted values are taken. If a character or symbol is entered the program will crash
  while boardSize /= 5 or boardSize /=6 or boardSize /=7 or boardSize /=8 loop
      if boardSize = 5 or boardSize = 6 or boardSize = 7 or boardSize = 8 then
        exit;
      else
          Put_Line("Incorrect Choice, please enter a supported board size (from 5 to 8):");
          Ada.Integer_Text_IO.Get (boardSize);
          Skip_Line;
      end if;
      end loop;
  --X Starting Value of Knight
  Put_Line("Please enter the x value for the starting position of the knight (between 1 and board size):");
  Ada.Integer_Text_IO.Get (xStart);
  Skip_Line;
  while xStart < 1 or xStart > boardSize loop
      if xStart >= 1 and then xStart <= boardSize then
        exit;
      else
          Put_Line("Error! Please enter the x value for the starting position (between 1 and Board Size):");
          Ada.Integer_Text_IO.Get (xStart);
          Skip_Line;
      end if;
      end loop;
  --Y Starting Value of Knight
  Put_Line("Please enter the y value for the starting position of the knight (between 1 and board size):");
  Ada.Integer_Text_IO.Get (yStart);
  Skip_Line;
  while yStart < 1 or yStart > boardSize loop
      if yStart >= 1 and then yStart <= boardSize then
        exit;
      else
          Put_Line("Error! Please enter the y value for the starting position (between 1 and Board Size):");
          Ada.Integer_Text_IO.Get (yStart);
          Skip_Line;
      end if;
      end loop;
  tourSolver(boardSize, xStart - 1 , yStart - 1);
end knightsTour;
