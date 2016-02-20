def part1():
    total = len(line)
    up = total - len(line.replace('(',''))
    dn = total - len(line.replace(')',''))
    return up-dn

def part2():
    level=0
    pos = 0
    for ch in line:
        pos += 1
        if ch=='(':
            level+=1
        if ch==')':
            level-=1
        if level==-1:
            return pos

with open("data/1.txt", "r") as f:
    line = f.readlines()[0]

assert part1() == 232
assert part2() == 1783