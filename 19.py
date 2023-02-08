with open('19.txt') as f:
    lines = f.readlines()

slines = """e => H
e => O
H => HO
H => OH
O => HH

HOHOHO""".split('\n')
molecule = lines.pop().strip()
lines.pop()
maps = {}
for line in lines:
    f,t = line.strip().split(' => ')
    if f not in maps: maps[f] = []
    maps[f].append(t)

# Part one
potentials = set()
i=0
j=0
while j<len(molecule):
    j+=1
    if j<len(molecule) and molecule[j].islower(): j+=1
    element = molecule[i:j]
    if element in maps:
        for mol in maps[element]:
            potentials.add(molecule[:i]+mol+molecule[j:])
    i=j

print(len(potentials))

# Part two
import re
def to_elems(s):
    return re.sub('([A-Z])',',\g<1>',s).split(',')[1:]
# Randomized searching backward (by trying all possible substitutions)
# takes infeasibly long.  Need to try another approach.
# Each rule changes the number of elements in the output by a fixed amount,
# and we have a fixed target to aim for - so a different framing of the problem
# is to find combinations of rules that sum up to the correct number of elements
# in the output.  We may then need to worry if they can be assembled in the 
# right order...
target_molecule = to_elems(molecule)
e2m = {}  # element : [molecules, it, can, make, ... ]
for recipe in lines:
    e, m = recipe.strip().split(" => ")
    if e not in e2m: e2m[e] = []
    mm = to_elems(m)
    e2m[e].append(mm)

all_e = sorted(set(target_molecule + list(e2m.keys()) ))
target = [target_molecule.count(p) for p in all_e]
rules = []  # One row for each rule - how many of each element are produced by this rule
for e in sorted(e2m):
    for m in e2m[e]:
        counts = [m.count(p) for p in all_e]
        counts[all_e.index(e)] -= 1  # The source element is consumed
        rules.append(counts)

target[-1] = -1 # Last element is e - we want to remove it

from ortools.sat.python import cp_model
model = cp_model.CpModel()
amounts = []
for m in range(len(rules)):
    amounts.append(model.NewIntVar(0,sum(target), "a%d"%m))

for ix in range(len(target)):
    # Tedious - can't use 'sum()' with ortools
     model.Add(amounts[0]*rules[0][ix] + \
              amounts[1]*rules[1][ix] + \
              amounts[2]*rules[2][ix] + \
              amounts[3]*rules[3][ix] + \
              amounts[4]*rules[4][ix] + \
              amounts[5]*rules[5][ix] + \
              amounts[6]*rules[6][ix] + \
              amounts[7]*rules[7][ix] + \
              amounts[8]*rules[8][ix] + \
              amounts[9]*rules[9][ix] + \
              amounts[10]*rules[10][ix] + \
              amounts[11]*rules[11][ix] + \
              amounts[12]*rules[12][ix] + \
              amounts[13]*rules[13][ix] + \
              amounts[14]*rules[14][ix] + \
              amounts[15]*rules[15][ix] + \
              amounts[16]*rules[16][ix] + \
              amounts[17]*rules[17][ix] + \
              amounts[18]*rules[18][ix] + \
              amounts[19]*rules[19][ix] + \
              amounts[20]*rules[20][ix] + \
              amounts[21]*rules[21][ix] + \
              amounts[22]*rules[22][ix] + \
              amounts[23]*rules[23][ix] + \
              amounts[24]*rules[24][ix] + \
              amounts[25]*rules[25][ix] + \
              amounts[26]*rules[26][ix] + \
              amounts[27]*rules[27][ix] + \
              amounts[28]*rules[28][ix] + \
              amounts[29]*rules[29][ix] + \
              amounts[30]*rules[30][ix] + \
              amounts[31]*rules[31][ix] + \
              amounts[32]*rules[32][ix] + \
              amounts[33]*rules[33][ix] + \
              amounts[34]*rules[34][ix] + \
              amounts[35]*rules[35][ix] + \
              amounts[36]*rules[36][ix] + \
              amounts[37]*rules[37][ix] + \
              amounts[38]*rules[38][ix] + \
              amounts[39]*rules[39][ix] + \
              amounts[40]*rules[40][ix] + \
              amounts[41]*rules[41][ix] + \
              amounts[42]*rules[42][ix] == target[ix])

fun = model.Minimize
fun(sum(amounts))
solver = cp_model.CpSolver()
status = solver.Solve(model)
vals = [solver.Value(m) for m in amounts]

print(sum(vals))
