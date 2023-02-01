NB. read just the numbers from file
words =. ;:"1 ;._2 freads '13.txt'
N =. #~.0{"1 words

NB. alice=0, bob=1, .... , mallory=8
NB. build table of (from,to)->cost
NB.     to 0 1 ... 8
NB. from 0 x a ... b
NB.      1 c x ... d
NB.      ...........
NB.      8 e f ... x
a =. (('gain' -:"1 >2{"1 words){(_1 1)) * ("."1 > 3{"1 words)
M =: (N,N-1) $ a

NB. To read from M: do (<r,c){M
NB. The table is missing the diagonal (r=c), so for all c>r we need to shift left by 1
NB. That's achieved by taking (0 0) or (0 1) from y=(r c) depending on if r>c
fromM =: 3 : '(<y - 0,(1{y)>0{y){M'

NB. Slice row into pairs, and get happiness value for each
NB. Repeate for |. (opposite) since happiness values are not symmetric
scoreForRow =: 3 : '+/ (fromM"1[2[\y), fromM"1 |."1[2[\y'

NB. Then build all possible sitting orders
NB. Start and end with the last entry (it's a loop, so it doesn't matter)

perms =. (i. !(N-1)) A. i. (N-1)  NB. All possible permutations of N-1 items
sitting_orders =. (N-1),"1 perms,"1 (N-1)  NB. e.g. 30123, 30213, 31023, ... 

echo >./ scoreForRow"1 sitting_orders

NB. Part two - add yourself and run again
N =. N+1
M =: (M,"1 [0),0  NB. append 0 to each row and then row of 0 (autofill)

perms =. (i. !(N-1)) A. i. (N-1)
sitting_orders =. (N-1),"1 perms,"1 (N-1)

fromM2 =: 4 : '(<y - 0,(1{y)>0{y){x'
scoreForRow2 =: 4 : '+/ (x fromM2"(_ 1) 2[\y), x fromM2"(_ 1) |."1[2[\y'
echo >./ M scoreForRow2"(_ 1) sitting_orders

exit 0
