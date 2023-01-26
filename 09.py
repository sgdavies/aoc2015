inp="""London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141""".split('\n')
inp="""Faerun to Tristram = 65
Faerun to Tambi = 129
Faerun to Norrath = 144
Faerun to Snowdin = 71
Faerun to Straylight = 137
Faerun to AlphaCentauri = 3
Faerun to Arbre = 149
Tristram to Tambi = 63
Tristram to Norrath = 4
Tristram to Snowdin = 105
Tristram to Straylight = 125
Tristram to AlphaCentauri = 55
Tristram to Arbre = 14
Tambi to Norrath = 68
Tambi to Snowdin = 52
Tambi to Straylight = 65
Tambi to AlphaCentauri = 22
Tambi to Arbre = 143
Norrath to Snowdin = 8
Norrath to Straylight = 23
Norrath to AlphaCentauri = 136
Norrath to Arbre = 115
Snowdin to Straylight = 101
Snowdin to AlphaCentauri = 84
Snowdin to Arbre = 96
Straylight to AlphaCentauri = 107
Straylight to Arbre = 14
AlphaCentauri to Arbre = 46""".split('\n')

dists={}
for line in inp:
    words = line.split(' ')
    f = words[0]
    t = words[2]
    d = int(words[4])
    if f not in dists: dists[f]={}
    if t not in dists: dists[t]={}

    dists[f][t] = d
    dists[t][f] = d

def solve(remaining, dist, here=None, short=True):
    #print(dist, here, remaining)
    if not remaining: return dist

    best = None
    for star in remaining:
        new_rem = set(remaining)
        new_rem.remove(star)
        if here is not None: new_dist = dist+dists[here][star]
        else: new_dist = dist
        attempt = solve(new_rem, new_dist, star, short)

        if best is None or (short and attempt<best) or (not short and attempt>best): best = attempt

    return best

print(solve(set(dists.keys()), 0))
print(solve(set(dists.keys()), 0, short=False))
