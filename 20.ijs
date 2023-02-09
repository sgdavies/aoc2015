NB. All combinations of prime factors, and 1
factors =: 3 : 0
 divs =. 1
 for_x. q: y do.
  divs2 =. divs
  for_d. divs do.
   divs2 =. divs2, d*x
  end.
  divs =. ~. divs2
 end.
divs
)

target =: 3400000  NB. 10x less than input - we'll do 1 pres/elf instead of 10
NB. target is an upper bound - there are at least that many pressies at that
NB. house as it's visited by that elf (likely plus others)
NB. +1 as houses start at 1, not 0
NB. Note - quite slow!
NB. echo 1+ 1 i.~ target<: +/"1 factors"0 [1+i.1000000
NB. slight optimization - every 6th is large (has 1,2,3,6 as factors) so just check those
echo 6* 1+ 1 i.~ target<: +/"1 factors"0 [6* 1+i. <. target%6

NB. part two
filter_factors =: 3 : 0
 divs =. factors y
 ok =. (50*divs) >: y  NB. stop after 50
ok # divs
)

NB. 1_000_000 limit by experiment.  Answer was at ~800_000
echo 1+ 1 i.~ (target%1.1)<: +/"1 filter_factors"0 [1+i.1000000

exit 0
