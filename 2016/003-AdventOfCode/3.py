def part1():
    hash = {}
    x,y = 0,0
    hash['0,0'] = 1
    for line in lines:
        for ch in line:
            if ch=='^':
                y+=1
            if ch=='>':
                x+=1
            if ch=='v':
                y-=1
            if ch=='<':
                x-=1
            key = str(x)+','+str(y)
            if key not in hash.keys():
                hash[key] = 0
            hash[key] += 1
    return len(hash)

def part2():
    hash = {}
    a = [0,0]
    b = [0,0]
    hash['0,0'] = 2
    i = 0
    for line in lines:
        for ch in line:
            if i % 2 == 0:
                pos = a
            else:
                pos = b

            if ch=='^':
                pos[1]+=1
            if ch=='>':
                pos[0]+=1
            if ch=='v':
                pos[1]-=1
            if ch=='<':
                pos[0]-=1

            x, y = pos
            key = str(x)+','+str(y)
            if key not in hash.keys():
                hash[key] = 0
            hash[key] += 1

            i += 1
    return len(hash)

with open("data/3.txt", "r") as f:
    lines = f.readlines()

assert part1() == 2081
assert part2() == 2341