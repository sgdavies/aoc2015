NB. Returns array of zeros with a block of ones located by y
mask =: 4 : 0  NB. x = size, y = (x1 y1 x2 y2) mask location
  size=. x
  x1=. 0{y
  y1=. 1{y
  x2=. 2{y
  y2=. 3{y
  xs=. 1+x2-x1
  ys=. 1+y2-y1

  mrow =. (xs $ 1), ((size-xs) $ 0)  NB. 1 1 0 0 0
  marr =. (ys, size) $ mrow  NB. repeated rows
  zrows =. ((size - ys), size) $ 0
  marr =. marr,zrows

  marr =. (-y1) |. marr
  marr =. (-x1) |."1 marr
marr
)

NB. With mask = 1-in-0s, then:
NB. off is (-. mask) *. array
NB. on  is mask +. array
NB. toggle is (mask *. -.array) +. ((-.mask) *. array)

NB. x=array, y=box coords
on  =: 4 : 'x +. (#x) mask y'
off =: 4 : 'x *. -. (#x) mask y'
toggle =: 4 : 0
  m =. (#x) mask y
  (m *. -. x) +. ((-.m) *. x)
)

NB. parse line
NB. | 0    | 1 | 2 | 3 | 4     | 5     | 6 | 7 | 8 |
NB. │toggle│461│,  │550│through│564    │,  │900│
NB. │turn  │off│370│,  │39     │through│425│,  │839│
parse =: 3 : 0
 words =. ;: y
 offon =. (1{words) -:"0 ('off';'on')  NB. toggle: 0 0; on: 0 1; off: 1 0
 offset =. +/ offon  NB. 1 for either off or on, 0 for toggle
 opi =. #. offon  NB. op-index: 0, 1, 2 for toggle, on, off respectively
 opi, (".>(offset+1){words), (".>(offset+3){words), (".>(offset+5){words), (".>(offset+7){words) 
)

solve =: 4 : 0  NB. x=array, y=lines
  arr=.x
  for_line. y do.
    nums =. parse >line
    opi =. 0{nums
    box =. }.nums
    arr =. arr ((opi{ops)`:6) box
  end.
  +/+/arr
)

lines =. <;._2 freads '06.txt'
array =. 1000 1000 $ 0

ops =: toggle`on`off
echo array solve lines

NB. on -- +1
NB. toggle -- +2
NB. off -- -1, but to min 0
on2 =: 4 : 'x + (#x) mask y'
tog2 =: 4 : 'x + 2* (#x) mask y'
off2 =: 4 : 0
  a =. x - (#x) mask y
  a >. ($a) $ 0
)
ops =: tog2`on2`off2
echo array solve lines

exit 0
