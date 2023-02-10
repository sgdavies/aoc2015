import math
from ortools.sat.python import cp_model

costs = [8,10,25,40,74, 13,31,53,75,102, 25,50,100, 20,40,80]
damage = [4,5,6,7,8, 0,0,0,0,0, 1,2,3, 0,0,0]
armor =  [0,0,0,0,0, 1,2,3,4,5, 0,0,0, 1,2,3]

def solve(part_one = True):
    model = cp_model.CpModel()
    mvars = []
    for iw in range(5): mvars.append(model.NewIntVar(0,1, "w%d"%iw)) # weapons
    for ia in range(5): mvars.append(model.NewIntVar(0,1, "a%d"%ia)) # armor
    for idr in range(3): mvars.append(model.NewIntVar(0,1, "dr%d"%idr)) # damage rings
    for iar in range(3): mvars.append(model.NewIntVar(0,1, "ar%d"%iar)) # armor rings

    model.Add(mvars[0]+mvars[1]+mvars[2]+mvars[3]+mvars[4] == 1) # Exactly one weapon
    model.Add(mvars[5]+mvars[6]+mvars[7]+mvars[8]+mvars[9] <= 1) # At most one armor item
    model.Add(mvars[10]+mvars[11]+mvars[12]+mvars[13]+mvars[14]+mvars[15] <= 2) # At most 2 rings

    mydamage = model.NewIntVar(0,20, "mydamage")
    model.Add(mydamage == damage[0]*mvars[0] + damage[1]*mvars[1] + \
              damage[2]*mvars[2] + damage[3]*mvars[3] + damage[4]*mvars[4] + \
              damage[10]*mvars[10] + damage[11]*mvars[11] + damage[12]*mvars[12])
    myarmor = model.NewIntVar(0,20, "myarmor")
    model.Add(myarmor == armor[5]*mvars[5] + armor[6]*mvars[6] + \
              armor[7]*mvars[7] + armor[8]*mvars[8] + armor[9]*mvars[9] + \
              armor[13]*mvars[13] + armor[14]*mvars[14] + armor[15]*mvars[15])
    myloss = model.NewIntVar(1,20, "myloss") # minimum of 1
    bossloss = model.NewIntVar(1,20, "bossloss")
    model.Add(myloss == 8 - myarmor) # boss damage is 8
    model.Add(bossloss == mydamage - 2) # boss armor is 2
    #model.Add(math.ceil(100 / myloss) <= math.ceil(100 / bossloss))
    if part_one:
        model.Add(myloss <= bossloss)
        fun = model.Minimize
    else:
        model.Add(bossloss < myloss) # Not equal - then I still win
        fun = model.Maximize

    fun(sum([costs[i]*mvars[i] for i in range(len(costs))]))
    solver = cp_model.CpSolver()
    status = solver.Solve(model)
    vals = [solver.Value(m) for m in mvars]

    print(sum([costs[i]*vals[i] for i in range(len(costs))]))

solve(True)
solve(False)
