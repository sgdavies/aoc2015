import hashlib

x=1
part_one=True
while True:
    #if x%100000==0: print(x)
    h = hashlib.md5('iwrupvqb{}'.format(x).encode('utf-8')).hexdigest()
    if part_one:
        if h[:5] == '00000':
            print(x, h)
            part_one = False
    else:
        if h[:6] == '000000':
            print(x, h)
            break
    x += 1
