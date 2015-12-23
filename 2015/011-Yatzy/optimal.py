# -*- coding: utf-8 -*-

# http://www.csc.kth.se/utbildning/kth/kurser/DD143X/dkand12/Group89Michael/report/Larsson+Sjoberg.pdf
# https://github.com/ansjob/optimalt-yatzy

# Använder 1.5 GB binärfil med optimala beslut.

# [3][253][32768][64]  S = (t, D, C, u)

# [3] 0: tolka byten som mask som anger vilka tärningar som ska sparas
# [3] 1: tolka byten som mask som anger vilka tärningar som ska sparas
# [3] 2: tolka byten som vald kategori

# [253] 0:not used 1:11111 2:11112 ... 252:66666
# [64] 0..63 Summan av Upper six. 63 innebär >= 63.
# [32768] Mask som anger vilka kategorier som valts tidigare

#    0   1   2   3   4   5    6    7    8    9   10   11  12    13    14
# '1or 2or 3or 4or 5or 6or 1par 2par 3tal 4tal 1..5 2..6 hus chans yatzy'

# Observera att masken är omvänd. yatzy ligger t ex i bit 0.

def ass(a, b):
    if a == b:
        print "ok", a, '==', b
    else:
        print "assert failure", a, '!=', b
        assert a == b

class OptimizeYatzy():

    def __init__(self, filename='actions'):
        self.filename = filename
        self.hash = {}
        dice = range(1, 7)
        for i in dice:
            for j in dice:
                for k in dice:
                    for l in dice:
                        for m in dice:
                            arr = sorted([str(i), str(j), str(k), str(l), str(m)])
                            s = ''.join(arr)
                            self.hash[s] = 0
        keys = sorted(self.hash.keys())
        for i in range(len(keys)):
            self.hash[keys[i]] = i+1

    def storage(self, t, s, c, u):  # t=0..2 s=1..252 u=0..63 c=0..32767

        # patch pga trolig bug i fallet 14 kategorier valda.
        # Felet uppstod troligen i basecase och ligger i binärfilen
        # Styrker: bot.java playgame läser inte i filen vid val av sista kategori.
        if t == 2 and bin(c).count("1") == 14:
            for i in range(15):
                if c == 32767 - (1 << (14-i)):
                    return i

        d = self.hash[s]
        index = 32768 * (64 * (253*t + d) + u) + c
        f = file(self.filename, "rb")
        f.seek(index)
        byte = ord(f.read(1))
        f.close()
        return byte


def test_optimize_yatzy():

    def _(n):
        res = 1 << (14-n)
        return res
        # return 2**(14-n)

    oy = OptimizeYatzy()

    ass(oy.storage(0, '11111', 0, 0), 31)  # 11111
    ass(oy.storage(0, '11112', 0, 0), 30)  # 1111
    ass(oy.storage(0, '12222', 0, 0), 15)  # 2222
    ass(oy.storage(0, '13566', 0, 0), 3)   # 66
    ass(oy.storage(0, '13355', 0, 0), 2+1)  # 55
    ass(oy.storage(0, '33355', 0, 0), 16+8+4)  # 333
    ass(oy.storage(0, '33555', 0, 0), 4+2+1)   # 555

    ass(oy.storage(1, '11111', 0, 0), 31)  # 11111
    ass(oy.storage(1, '11112', 0, 0), 30)  # 1111
    ass(oy.storage(1, '12222', 0, 0), 15)  # 2222
    ass(oy.storage(1, '13566', 0, 0), 3)   # 66
    ass(oy.storage(1, '13355', 0, 0), 2+1)  # 55
    ass(oy.storage(1, '33355', 0, 0), 16+8+4)  # 333
    ass(oy.storage(1, '33555', 0, 0), 4+2+1)   # 555

    ass(oy.storage(2, '11112', 0, 0), 0)   # 1or
    ass(oy.storage(2, '11122', 0, 0), 0)   # 1or
    ass(oy.storage(2, '11223', 0, 0), 0)   # 1or
    ass(oy.storage(2, '12356', 0, 0), 10)   # 1..5

    assert oy.storage(2, '12234', 0, 0) == 1   # 2or
    assert oy.storage(2, '12334', 0, 0) == 10  # 1..5
    assert oy.storage(2, '13446', 0, 0) == 10  # 1..5
    assert oy.storage(2, '13556', 0, 0) == 6   # 1par
    assert oy.storage(2, '13566', 0, 0) == 6   # 1par
    assert oy.storage(2, '11111', 0, 0) == 14  # yatzy
    assert oy.storage(2, '33555', 0, 0) == 12  # Kåk

    ass(oy.storage(2, '11111', _(14), 0), 0)  # 1or
    ass(oy.storage(2, '22222', _(14), 0), 1)  # 2or
    ass(oy.storage(2, '33333', _(14), 0), 2)  # 3or
    ass(oy.storage(2, '44444', _(14), 0), 3)  # 4or
    ass(oy.storage(2, '55555', _(14), 0), 4)  # 5or
    ass(oy.storage(2, '66666', _(14), 0), 5)  # 6or
    ass(oy.storage(2, '66666', _(14)+_(5), 0), 9)                  # ej yatzy, ej 6or => 4tal
    ass(oy.storage(2, '66666', _(14)+_(5)+_(9), 0), 13)            # ej yatzy, ej 6or, ej 4tal => chans
    ass(oy.storage(2, '66666', _(14)+_(5)+_(9)+_(13), 0), 8)       # ej yatzy, ej 6or, ej 4tal, ej chans => 3tal
    ass(oy.storage(2, '66666', _(14)+_(5)+_(9)+_(13)+_(8), 0), 6)  # ej yatzy, ej 6or, ej 4tal, ej chans, ej 3tal => 1par

    ass(oy.storage(2, '12334', 0, 0), 10)     # stryk 1..5
    ass(oy.storage(2, '12334', _(10), 0), 0)  # 1or
    ass(oy.storage(2, '12333', 0, 0), 2)      # 3or

    ass(oy.storage(2, '22345', _(10), 0), 1)  # 2or
    ass(oy.storage(2, '12345', _(10), 0), 0)  # 1or
    ass(oy.storage(2, '23456', _(11), 0), 13)  # chans

    ass(oy.storage(2, '33355', _(12), 0), 2)  # 3or
    ass(oy.storage(2, '33555', _(12), 0), 4)  # 5or
    ass(oy.storage(2, '33355', _(12), 63), 2)  # 3or
    ass(oy.storage(2, '33555', _(12), 63), 4)  # 5or

    # tvinga fram ett undvikande av 6or
    ass(oy.storage(2, '12666', 0, 0), 8)  # 3tal
    ass(oy.storage(2, '16666', 0, 0), 5)  # 6or

    ass(oy.storage(2, '12666', _(0)+_(1)+_(2)+_(3)+_(4), 45), 5)  # 6or
    ass(oy.storage(2, '12666', _(0)+_(1)+_(2)+_(3),      45), 8)  # 3tal

    ass(oy.storage(2, '12666', _(0)+_(1)+_(2)+_(3)+_(4), 63), 5)  # 6or
    ass(oy.storage(2, '12666', _(0)+_(1)+_(2)+_(3),      63), 8)  # 3tal

    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 45), 5)  # 6or
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3),      45), 9)  # 4tal

    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 50), 5)  # 6or
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 51), 9)  # 4tal
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 52), 9)  # 4tal
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 53), 9)  # 4tal
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 62), 9)  # 4tal
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3)+_(4), 63), 9)  # 4tal  OBS 6or behövs ej. Alltså väljs 4tal.
    ass(oy.storage(2, '16666', _(0)+_(1)+_(2)+_(3),      50), 9)  # 4tal

    # Finns skillnader mellan t==0 och t==1 ? Svar ja!

    # yatzy redan taget, kåk intressant
    ass(oy.storage(0, '44456', _(5)+_(8)+_(9)+_(13)+_(14), 0), 28)  # ej 6or 3tal 4tal chans yatzy => 16+8+4+0+0
    ass(oy.storage(1, '44456', _(5)+_(8)+_(9)+_(13)+_(14), 0), 29)  # ej 6or 3tal 4tal chans yatzy => 16+8+4+0+1

    # yatzy ej taget, kåk ointressant
    ass(oy.storage(0, '44456', _(5)+_(8)+_(9)+_(13), 0), 28)        # ej 6or 3tal 4tal chans => 16+8+4+0+0
    ass(oy.storage(1, '44456', _(5)+_(8)+_(9)+_(13), 0), 28)        # ej 6or 3tal 4tal chans => 16+8+4+0+0

    mask = _(0) + _(1) + _(2) + _(4) + _(5) + _(6) + _(7) + _(8) + _(9) + _(10) + _(11) + _(12) + _(13) + _(14)
    ass(oy.storage(0, '12666', 32767 - _(3), 50), 0) # Behåll inget
    ass(oy.storage(1, '12666', 32767 - _(3), 50), 0)

    ass(oy.storage(0, '12666', 32767 - _(0), 50), 16) # Behåll ettan
    ass(oy.storage(1, '12666', 32767 - _(0), 50), 16)

    ass(oy.storage(2, '12666', 32767 - _(3), 60), 3)

    dices = '12666'
    mask = 32767
    # Testar patchen dår masken har 14 bitar
    ass(oy.storage(2, dices, mask - _(0), 60),0)
    ass(oy.storage(2, dices, mask - _(1), 60),1)
    ass(oy.storage(2, dices, mask - _(2), 60),2)
    ass(oy.storage(2, dices, mask - _(3), 60),3)
    ass(oy.storage(2, dices, mask - _(4), 60),4)
    ass(oy.storage(2, dices, mask - _(5), 60),5)
    ass(oy.storage(2, dices, mask - _(6), 60),6)
    ass(oy.storage(2, dices, mask - _(7), 60),7)
    ass(oy.storage(2, dices, mask - _(8), 60),8)
    ass(oy.storage(2, dices, mask - _(9), 60),9)
    ass(oy.storage(2, dices, mask - _(10), 60),10)
    ass(oy.storage(2, dices, mask - _(11), 60),11)
    ass(oy.storage(2, dices, mask - _(12), 60),12)
    ass(oy.storage(2, dices, mask - _(13), 60),13)
    ass(oy.storage(2, dices, mask - _(14), 60),14)

# test_optimize_yatzy()