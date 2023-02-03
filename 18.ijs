s =. '#' = >, ;._2 freads '18.txt'
STEPS =. 100

NB. All shifts of s (including none) to get neighbour+self count
neighbours =: 3 : '+/ (>,{ ;~(1 0 _1)) |.!.0 y'

NB. Game Of Life!
gol =: 3 : 0
 neigh =. neighbours y
 (3 = neigh) +. (y *. 4 = neigh)
)

echo +/+/ gol^:STEPS s

NB. Part two - same but mask to have corners always-on
m =. 1 -~ #s
mask =. ($ s) $ 0
mask =. 1 (<0 0) } mask
mask =. 1 (<m, 0) } mask
mask =. 1 (<0, m) } mask
mask =. 1 (<m, m) } mask

gol2 =: 4 : 'x +. gol y'  NB. x is the mask
echo +/+/ mask gol2^:STEPS mask +. s

exit 0
