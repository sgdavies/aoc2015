NB. num/chars convert to/from numeric
NB. inc uses base 26 to increment an array of numeric values
NB. ok checks each of the 3 conditions for a given value
NB. solve is naive: try a value, if it's not OK then increment and try again.
NB. It would be more efficient to combine the increment & noilo functions -
NB. rather than incrementing one-by-one, skip straight past bad values
NB. (so e.g. iabcd -> kaaaa in one step instead of 26x26x26x26).
NB. However the naive approach works on the real data in <5s.

NB. convert chars to numbers, starting at a=0
nums =: 3 : '(a. i. y) - (a. i. ''a'')'
chars =: 3 : '(y + a. i. ''a'') { a.'  NB. and back again

NB. to increment a password: convert to a number (base 26) and back
inc =: 3 : '26 #.inv 1 + 26 #. y'
inc2 =: 3 : '(8 $ 26) #: 1 + 26 #. y' NB. zero-pad to 8 chars

noilo =: 3 : '0 = +/ (nums ''ilo'') e. y'

shift =: 3 : 'y - _1,}:y' NB. array minus itself offset-by-one

ok =: 3 : 0
  c1 =. noilo y
  s =. shift y
  NB. c2: is there a sequence? that means two successive increments of 1
  c2 =. (1 1) +./@:E. s  NB. sequence appears in s
  NB. c3: are there two pairs?
  NB. Assumption: aaxaa passes this check (2 separate pairs)
  NB. pair = 0 in s; but aaab->0 0 1.  So need to -1 for a double-0
  NB. more than one double-0 means more than one pair (aaaxaaa or aaaa)
 c3 =. 1< (+/ s e. 0) - ((0 0) +./@:E. s) 

 *./ c1,c2,c3
)

solve =: 3 : 0
  v =. nums y
  while. 1 do.
    if. ok v do. chars v return. end.
    v =. inc2 v  NB. This is inefficient - would be better to combine inc and noilo
  end.
)

echo solve 'abcdefgh'
NB. echo solve 'ghijklmn'  NB. slow - ~30s
part_one =. solve 'vzbxkghb'
echo part_one
echo solve chars inc2 nums part_one

exit 0
