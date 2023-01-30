NB. Finite state machine for parsing input
NB. For part one: simply drop anything that's not a number.
NB. Need to handle '-' for -ve numbers.
NB. See https://www.jsoftware.com/help/dictionary/d332.htm
NB. We'll use classes: 0=any ; 1=digit ; 2=-
m =. a. e. '0123456789'  NB. 1 for each digit
m =. m + 2* a. e. '-'    NB. 2 for '-'

NB. State transition table. Actions are 0=nothing, 1=start word, 3=emit word
NB. State | Comment       | Col 0 other | Col 1 digit | Col 2 -
NB. 0  | wait for -/digit | 0 0         | 1 1         | 1 1
NB. 1  | wait for non-dig | 0 3         | 1 0         | 1 6
NB. Start: wait for either - or digit, the start the word and move to row 1
NB. On getting a non-digit, emit the word and return to 0. Otherwise, do nothing
NB. and stay on the same row.  Note (1 2) =. 1 6 is a duff state anyway (- in the
NB. middle of a number).
sq =. 2 3 2 $ 0 0 1 1 1 1  0 3 1 0 1 0

NB. f: 0 (emit boxed words); set d (from ijrd) to 0 to close word if end of string is digits
text =. freads '12.txt'

echo +/ ".> (0;sq;m;0 _1 0 0) ;: text
exit 0
