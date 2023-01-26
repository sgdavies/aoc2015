NB. data=. // read from file
NB. data=. // split on 'x' and convert to numbers
I=:3 3 $ 0 1 1 1 0 1 1 1 0 NB. inverse identity matrix
sides=: 3 : '3}./:~ ,I * */~y' NB. *-table of y, remove a*a,b*b,c*c with I, sort, and drop the 3 zeroes
wrap=: 3 : '+/ (0{sides y),sides y' NB. repeat first (smallest) element and sum

echo +/ wrap"1 data
