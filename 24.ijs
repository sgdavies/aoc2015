presents =: 1 2 3 5 7 13 17 19 23 29 31 37 41 43 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113

NB. all three groups add up to target
NB. only need to look at the smallest set in each division
NB. so can iterate up from set=1 to set = len/3
NB. stopping as soon as we find a set that adds up to target
NB. (plus checking QE for all other sets of the same length)

NB. x comb y gives all the x-sized groups from i. y
NB. From https://code.jsoftware.com/wiki/Essays/Combinations
comb=: 4 : 0
 k=. i.>:d=.y-x
 z=. (d$<i.0 0),<i.1 0
 for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
 ; z
)

NB. By experimentation: increase x until the nub is 0 1, not 0 
NB. ~. target= +/"1 (x comb #presents) { presents
c6 =. (6 comb #presents) { presents
echo <./ */"1 ((3 %~ +/presents)= +/"1 c6) #c6

NB. Part two - as above, this time we hit at 4
c4 =. (4 comb #presents) { presents
echo <./ */"1 ((4 %~ +/presents)= +/"1 c4) #c4

exit 0
