NB. Each line like 'Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds'
NB. maps to _ _ _ 14 _ _ _ 10 _ _ _ _ _ _ _ 127 _
nums =. _". > ;: ;._2 freads '14.txt'

NB. List of positions at each second.  E.g. for Comet
NB. this would be 14 28 ... 140 140 140 .... 140 154 etc.
NB. x is number of seconds, y is list of nums
pos =: 4 : '+/\ x $ ((8{y) $ (3{y)), (16{y)$0'

positions =. 2503 pos"1 nums

NB. Part one - tail of each is final postion of each reindeer.
echo >./ {:"1 positions

NB. Part two
NB. one point in each column if that reindeer's position is
NB. equal to the maximum in that column.
NB. Then sum over each reindeer.
NB. |: is necessary to get the row (reindeer) totals rather
NB. than column totals.
echo >./ +/|: (>."1/ positions) ="1 positions

exit 0
