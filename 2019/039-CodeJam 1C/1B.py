t = int(input())
for i in range(t):
    n = int(input())
    q = list(input() for _ in range(n))
    a = ""
    x = 0
    while q:
        letters = set()
        for s in q:
            letters.add(s[x % len(s)])
        if len(letters) == 3:
            a = "IMPOSSIBLE"
            break
        if len(letters) == 1:
            if "S" in letters:
                c = "R"
            if "R" in letters:
                c = "P"
            if "P" in letters:
                c = "S"
        else:
            if "S" not in letters:
                c = "P"
            if "R" not in letters:
                c = "S"
            if "P" not in letters:
                c = "R"
        a += c

        def todel(y):
            if "S" in y:
                return c == "R"
            if "R" in y:
                return c == "P"
            if "P" in y:
                return c == "S"
        q = list(y for y in q if not todel(y[x % len(y)]))
        x += 1


    print("Case #{}: {}".format(i+1, a))
