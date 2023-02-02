ingreds =: 4 5 $ 3 0 0 _3 2  _3 3 0 0 9  _1 0 4 0 1  0 0 _2 2 8

make_amounts =: 3 : 0
arr =. 0 4 $ 0
for_i. i. y+1 do.
 for_j. i. y+1-i do.
  for_k. i. y+1-(i+j) do.
   arr =. arr, i,j,k,y-i+j+k
  end.
 end.
end.
arr
)

recipes =: make_amounts 100

NB. each row in recipes * the whole ingredients table
NB. then sum by table, and cap -ve numbers to 0
properties =: 0 0 0 0 0 >."1 +/"2 (recipes) *"(1 _) ingreds

score =: 3 : '*/ |: }:"1 y'
echo >./ score properties
echo >./ score (500 = 4{"1 properties) # properties

exit 0
