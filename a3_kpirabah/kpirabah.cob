NO-*Kevin Pirabaharan
*ID : 0946212
*kpirabah@mail.uoguelph.ca
*Saturday, March 26th 2017
*Assignment 3
*This assignments was to count various aspects of a string

identification division.
program-id. KPIRABAHA3.

environment division.
input-output section.
file-control.

select input-file assign to dynamic dataFile
              organization is line sequential
              file status is fileFS.
select output-file assign to dynamic results
              organization is line sequential.
              *>file status is outFS

data division.
file section.
fd input-file.
    01 sample-input      pic x(80).
fd output-file.
    01 output-line       pic x(80).

working-storage section.
77 dataFile                  pic x(30).
77 results                    pic x(30).
77 eof-switch                 pic 9      value 1.
77 exit-switch                pic 9.
77 fileFS                     pic xx.
77 outFS                      pic x.
01 k                          pic 9(2)   value 0.
77 space1                     pic 9     value 0.

77 NO-of-sentences           pic 9(7)   value 0.
77 NO-of-words               pic 9(7)   value 0.
77 NO-of-char                pic 9(7)   value 0.
77 NO-of-numbers             pic 9(7)   value 0.
77 avg-of-words-sentences     pic -(4)9.9(2).
77 avg-of-symbols-words       pic -(4)9.9(2).

01 input-area.
  02 lineNum            pic x     occurs 80 times.

01 output-title-line.
  02 filler          pic x(31)  value spaces.
  02 filler          pic x(19)  value "Input Text Analyzed".

01 output-underline.
  02 filler         pic x(41) value " ----------------------------------------".
  02  filler        pic x(40) value "----------------------------------------".

01 output-area.
   02  filler        pic x        value space.
   02  out-line      pic x(80).

01 output-statistics-line-1.
  02  filler        pic x(20)    value spaces.
  02  filler        pic x(20)    value "number of sentences=".
  02  out-no-senten pic -(7)9.

01 output-statistics-line-2.
  02  filler        pic x(19)    value spaces.
  02  filler        pic x(33)    value "number of words=".
  02  out-no-word  pic -(7)9.

01 output-statistics-line-3.
  02  filler        pic x(19)    value spaces.
  02  filler        pic x(33)    value "number of chars=".
  02  out-no-char  pic -(7)9.

01 output-statistics-line-4.
     02  filler        pic x(20)    value spaces.
     02  filler        pic x(31)    value "Number of numbers=".
     02  out-no-nums   pic -(4)9.9(2).

01 output-statistics-line-5.
  02  filler        pic x(20)    value spaces.
  02  filler        pic x(33)    value "average number of words/sentence=".
  02  avg-words-se pic -(4)9.9(2).

01 output-statistics-line-6.
  02  filler        pic x(20)    value spaces.
  02  filler        pic x(31)    value "average number of symbols/word=".
  02  avg-char-wor pic -(4)9.9(2).

procedure division.
    display "Please enter the file name: ".
    accept dataFile.

    open input input-file.
    if fileFS not = "00"
        if fileFS = "35"
            display "File not found: ", dataFile
            stop run
        end-if
    end-if.

    display "Please enter the output file: ".
    accept results.

    open output output-file.

    read input-file into input-area
        at end move zero to eof-switch
    end-read.

    move 1 to k

    perform proc-body
      until eof-switch is equal to zero.

    perform outputStat.

    close input-file.
    close output-file.

    stop run.

proc-body.

  move input-area to out-line.
  write output-line from output-area after advancing 1 line.

  perform until k is greater than 80

    if ((lineNum(k) >= 'A' and lineNum(k) <= 'Z') or (lineNum(k) >= 'a' and lineNum(k) <= 'z'))
      compute NO-of-char = NO-of-char  + 1
      add 1 to k

    else if lineNum(k) = space or lineNum(k) = "," or lineNum(k) = ';'
      compute NO-of-words = NO-of-words  + 1
      add 1 to k

    else if lineNum(k) = "." or lineNum(k) = "?" or lineNum(k) = "!"
      compute NO-of-sentences = NO-of-sentences + 1
      add 1 to k
    end-if
    add 1 to k

  end-perform
  move zero to k.

  read input-file into input-area
    at end move zero to eof-switch
  end-read.

outputStat.

  move NO-of-sentences to out-no-senten.
  move NO-of-words to out-no-word.
  move NO-of-char to out-no-char.
  move NO-of-numbers to out-no-nums


  divide NO-of-sentences into NO-of-words
    giving avg-of-words-sentences rounded.

  divide NO-of-words into NO-of-char
    giving avg-of-symbols-words rounded.

  move avg-of-words-sentences to avg-words-se.
  move avg-of-symbols-words to avg-char-wor.

  write output-line from output-underline after advancing 1 line.
  write output-line from output-statistics-line-1 after advancing 1 line.
  write output-line from output-statistics-line-2 after advancing 1 line.
  write output-line from output-statistics-line-3 after advancing 1 line.
  write output-line from output-statistics-line-4 after advancing 1 line.
  write output-line from output-statistics-line-5 after advancing 1 line.
  write output-line from output-statistics-line-6 after advancing 1 line.
  write output-line from output-underline after advancing 1 line.
