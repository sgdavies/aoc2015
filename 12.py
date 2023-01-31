with open('12.txt') as f:
    json = f.read()

def value(s: str, nored: bool, i=0):
    val=0
    num=""
    arrays = 0
    red_factor = 1
    red = ""

    while i < len(s):
        c = s[i]
        i+= 1

        if c in '-0123456789':
            num += c
        elif num:
            val += int(num)
            num = ""

        newred = red+c
        if '"red"'.startswith(newred):
            if newred=='"red"':
                if not arrays:
                    red_factor = 0 if nored else 1
                red=""
            else:
                red = newred
        else:
            red=""

        if c=='[':
            arrays += 1
        elif c ==']':
            arrays -= 1
        elif c=='{':
            i, valdelta = value(s, nored, i)
            val += valdelta
        elif c=='}':
            return i, red_factor * val

    return red_factor * val

print(value(json, False))
print(value(json, True))
