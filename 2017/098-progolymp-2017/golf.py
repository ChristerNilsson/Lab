def f(slag):
    totalt = 0
    for i,s in enumerate(slag):
        par = 2 + i % 2
        totalt += s - par
    return totalt

assert f([5,3,1]), 2
assert f([1,9,1,1,1,1]), -3


