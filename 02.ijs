lines =: ];._2 freads '02.txt'
nums =: 3 : '".;._1 ''x'',y'
data =: nums"1 lines
NB. data=. // split on 'x' and convert to numbers
I=:3 3 $ 0 1 1 1 0 1 1 1 0 NB. inverse identity matrix
sides=: 3 : '3}./:~ ,I * */~y' NB. *-table of y, remove a*a,b*b,c*c with I, sort, and drop the 3 zeroes
wrap=: 3 : '+/ (0{sides y),sides y' NB. repeat first (smallest) element and sum

echo +/ wrap"1 data

ribbon =: 3 : '2* +/ 2{. /:~y'
bow =: 3 : '*/ /:~y'

echo +/ (ribbon"1 data) + (bow"1 data)

exit 0
