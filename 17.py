containers = [33,14,18,20,45,35,16,35,1,13,18,13,50,44,48,6,24,41,30,42]

def solve(cans_left, target, cans, d):
    if target < 0:
        return 0
    elif target == 0: # Solution
        ncans = len(cans)
        if ncans not in d: d[ncans] = 0
        d[ncans] += 1
        return 1
    elif not cans_left: return 0
    
    # With & without using this can:
    s1 = solve(cans_left[1:], target, cans, d)
    s2 = solve(cans_left[1:], target-cans_left[0], cans + [cans_left[0]], d)
    return s1 + s2

def solve2(cans, target):
    d={}
    p1 = solve(cans, target, [], d)
    p2 = d[min(d.keys())]
    return p1, p2

#print(solve2([20,15,10,5,5], 25))
print(solve2(containers, 150))
