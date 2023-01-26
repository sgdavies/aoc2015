a=.'1113122113'

NB. indices where y is not equal to its offset
changeindices =: 3 : '((-.y='' '',}:y) #i.#y)'
join =: 4 : '(":x),y' NB. join a digit to a string

lookandsay =: 3 : 0
  ci =. changeindices y
  values =. ci{y
  counts =. (}.ci,#y)-ci

  ,counts join"0 values
)

partone =: 4 : 0
  v =. y
  for. i. x do.
    v =. lookandsay v
  end.
  v
)

NB. echo 5 partone '1'
echo # 40 partone a
echo # 50 partone a

exit 0
