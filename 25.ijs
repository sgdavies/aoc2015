index =: 3 : 0  NB. y = r,c
 r =. 0{y
 c =. 1{y
(c*(r-1)) + (2%~ (r-1)*(r-2)) + (2%~ c*(c+1))
)

nextcode =: 3 : '33554393 | 252533*y'

echo nextcode^:(1 -~ index 2981 3075) 20151125

exit 0
