from sortedcontainers import SortedSet
start_hp = 50
start_mana = 500
start_shield = 0
boss_start_hp = 71
boss_damage = 10


moves = [3, 0, 9, 9]
moves = [4, 2, 1, 3, 0, 9, 9]
moves = False

def solve(part_two):
    states = SortedSet( [(0, start_hp, start_mana, start_shield, boss_start_hp, 0,0,0)] )
    while states:
        state = states.pop(0)
        total_mana, hp, mana, shield, boss_hp, es, ep, er = state
        if moves:
            print("Player's turn")
            print(state)
        # Apply effects
        if es:
            es -= 1
            shield = 7
        else: shield = 0

        if ep:
            ep -= 1
            boss_hp -= 3
        if er:
            er -= 1
            mana += 101

        if moves:
            print("~effects~")
            print(total_mana, hp, mana, shield, boss_hp, es, ep, er)

        # My turn
        if part_two:
            hp -= 1
            if hp <= 0: continue
        if mana < 53: continue  # loss - don't add the new state
        # Try spells in order - lowest mana first
        new_states = []
        if not moves:
         new_states.append( [total_mana+53, hp, mana-53, shield, boss_hp-4, es, ep, er] )
         new_states.append( [total_mana+73, hp+2, mana-73, shield, boss_hp-2, es, ep, er] )
         if es==0: new_states.append( [total_mana+113, hp, mana-113, shield, boss_hp, 6, ep, er] )
         if ep==0: new_states.append( [total_mana+173, hp, mana-173, shield, boss_hp, es, 6, er] )
         if er==0: new_states.append( [total_mana+229, hp, mana-229, shield, boss_hp, es, ep, 5] )
        else:
         move = moves.pop(0)
         print("Player casts", ['magic missile', 'drain', 'shield', 'poison', 'recharge'][move])
         if move==0:
          new_states.append( [total_mana+53, hp, mana-53, shield, boss_hp-4, es, ep, er] )
         elif move==1:
          new_states.append( [total_mana+73, hp+2, mana-73, shield, boss_hp-2, es, ep, er] )
         elif move==2:
          if es==0: new_states.append( [total_mana+113, hp, mana-113, shield, boss_hp, 6, ep, er] )
         elif move==3:
          if ep==0: new_states.append( [total_mana+173, hp, mana-173, shield, boss_hp, es, 6, er] )
         elif move==4:
          if er==0: new_states.append( [total_mana+229, hp, mana-229, shield, boss_hp, es, ep, 5] )
         else:
             print("invalid move:", move)
         print(new_states[0])
    
        # boss' turn
        if moves: print("Boss' turn")
        for state in new_states:
            # Apply effects
            if state[5]:
                state[5] -= 1
                state[3] = 7
            else: state[3] = 0

            if state[6]:
                state[6] -= 1
                state[4] -= 3
            if state[7]:
                state[7] -= 1
                state[2] += 101

            if moves:
                print("~effects~")
                print(state)
            if state[4] <= 0:  # boss hp
                print(state[0])
                return

            state[1] -= max(1, boss_damage-state[3]) # Apply damage-shield

            if state[1] > 0: # I'm not dead
                states.add( tuple(state) )

    print("Error: Ran out of states")

solve(False)
solve(True)
