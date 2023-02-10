reg = [0,0]
ip = 0

p = [line for line in open('23.txt')]

def run(a,b):
  reg = [a,b]
  ip = 0
  while 0 <= ip < len(p):
    ins = p[ip].split(" ")
    #print(ip, ins, reg, end=" -> ")

    if ins[0]=='hlf':
        r = 0 if ins[1][0]=='a' else 1
        reg[r] /= 2
        ip += 1
    elif ins[0]=='tpl':
        r = 0 if ins[1][0]=='a' else 1
        reg[r] *= 3
        ip += 1
    elif ins[0]=='inc':
        r = 0 if ins[1][0]=='a' else 1
        reg[r] += 1
        ip += 1
    elif ins[0]=='jmp':
        offset = int(ins[1])
        ip += offset
    elif ins[0]=='jie':
        r = 0 if ins[1][0]=='a' else 1
        offset = int(ins[2])
        if reg[r]%2==0: ip += offset
        else: ip += 1
    elif ins[0]=='jio':
        r = 0 if ins[1][0]=='a' else 1
        offset = int(ins[2])
        if reg[r]==1: ip += offset # ==1, not 'is odd'
        else: ip += 1
    else:
        print("Invalid:", ins)
        exit(1)

    #print(ip, reg)
  print(reg[1])

run(0,0)
run(1,0)
