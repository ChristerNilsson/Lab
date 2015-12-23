good_team = []
good_team.append({'name': 'r2d2', 'force': 2})
good_team.append({'name': 'yoda', 'force': 6})
good_team.append({'name': 'darth', 'force': 8})
good_team.append({'name': 'c3p0', 'force': 4})

bad_team = []
bad_team.append({'name': 'stefan', 'force': 3})
bad_team.append({'name': 'jonas', 'force': 7})
bad_team.append({'name': 'lena', 'force': 1})
bad_team.append({'name': 'bengt', 'force': 5})

def match(gteam,bteam):
    score = 0
    for i in range(4):
        g = gteam[i]['force']
        b = bteam[i]['force']
        if g > b:
            score += 1
    return score

def sortera(team):
    return sorted(team, key=lambda figure: figure['force'])

figure = {'name': 'r2d2', 'force': 2}

assert figure['name'] == 'r2d2'
assert figure['force'] == 2

assert len(good_team) == 4
assert [figure['name'] for figure in good_team] == ['r2d2','yoda','darth','c3p0']
assert [figure['force'] for figure in good_team] == [2,6,8,4]

assert len(bad_team) == 4
assert [figure['name'] for figure in bad_team] == ['stefan','jonas','lena','bengt']
assert [figure['force'] for figure in bad_team] == [3,7,1,5]

assert match(good_team, bad_team) == 1

assert sortera(good_team) == [{'force': 2, 'name': 'r2d2'}, {'force': 4, 'name': 'c3p0'}, {'force': 6, 'name': 'yoda'}, {'force': 8, 'name': 'darth'}]
assert match(sortera(good_team), sortera(bad_team)) == 4


