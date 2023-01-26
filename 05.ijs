lines =. ];._2 freads '05.txt'

vowels =: 3 : '2<+/+/ ''aeiou''=/y'
tonum =: 3 : 'a. i. y'
doubles =: 3 : '0< +/ 0= (tonum y) - 0,}:tonum y'
nobads =: 3 : ' 0= +/+/ (''ab'',''cd'',''pq'',:''xy'') E."1 y'
nice =: 3 : '3 = (vowels y)+(doubles y)+(nobads y)'

echo +/ nice"1 lines

NB. (~.2]\y) E."1 y  -- where each unique pair in y appears in y
NB.                     Gives one row per pair, like 0 1 0 0 1
NB.  ... # i. #y   -- Converts that to pairs of indices.
NB.                   If it appears once, gives (x 0)
NB.                   If twice, and separated gives (a b) where b-a >1
NB.                   If twice but adjacent (e.g. for 'aaa') then b-a=1
NB.  Then count how many b-a is -2 or lower to catch the separated pairs.
pairs =: 3 :'0<+/_1>-/"1 ((~.2]\y) E."1 y) # i. #y'

double2 =: 3 : '0< +/ 0= (tonum y) - 0,0,}:}:tonum y'
nice2 =: 3 : '2 = (pairs y)+(double2 y)'

echo +/ nice2"1 lines

exit 0
