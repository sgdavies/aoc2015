words =: ;:"1 ;._2 freads '16.txt'

mfcsam =: 'children: 3',LF,'cats: 7',LF,'samoyeds: 2',LF,'pomeranians: 3',LF,'akitas: 0',LF,'vizslas: 0',LF,'goldfish: 5',LF,'trees: 3',LF,'cars: 2',LF,'perfumes: 1',LF

NB. part one - just check if each string from Aunt is present in MFCSAM
NB. requires rejoining pairs of words in 'words'
first =: 3 : '+./ ((>2{y),'' '',(>3{y)) E. mfcsam'
second =: 3 : '+./ ((>5{y),'' '',(>6{y)) E. mfcsam'
third =: 3 : '+./ ((>8{y),'' '',(>9{y)) E. mfcsam'
match =: 3 : '*./ (first y),(second y),(third y)'

echo }:>1{,(match"1 words) # words

NB. cats & trees - greater than
NB. pomerians & goldfish - fewer than
NB. others - equal
mftable =: ;: ;._2 mfcsam
match =: 3 : 0  NB. y = object,count (each boxed)
 NB. find row in table
 object =. 0{y
 row =. ,(object -:"0 [0{"1 mftable) # mftable
 acount =. ".>1{y
 mcount =. ".>1{row
 object =. >object

 if. +./ object E. 'cats: trees:' do.
  acount > mcount
 elseif. +./ object E. 'pomeranians: goldfish:' do.
  acount < mcount
 else.
  acount = mcount
 end.
)

all_match =: 3 : '*./ (match (2{y),3{y),(match (5{y),6{y),(match (8{y),9{y)'
echo }:>1{,(all_match"1 words) # words

exit 0
