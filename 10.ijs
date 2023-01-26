a='1113122113'

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
  echo v
  for. x do.
    v =. lookandsay v
    echo v
  end.
  echo v
  #v
)

5 partone '1'
NB. echo 40 partone a

exit 0
