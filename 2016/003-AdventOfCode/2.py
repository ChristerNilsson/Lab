def part1():
    res = 0
    for line in lines:
        arr = [int(d) for d in line.split('x')]
        areas = [arr[0]*arr[1], arr[0]*arr[2], arr[1]*arr[2]]
        res += 2 * sum(areas) + min(areas)
    return res

def part2():
    res = 0
    for line in lines:
        arr = [int(d) for d in line.split('x')]
        a,b,c = sorted(arr)
        res += 2*(a+b) + a*b*c
    return res


with open("data/2.txt", "r") as f:
    lines = f.readlines()

assert part1() == 1606483
assert part2() == 3842356