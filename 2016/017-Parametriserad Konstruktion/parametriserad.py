# -*- coding: utf-8 -*-

# Uppgift: Bygg en bänk med olika storlekar.
# Ange bredd, höjd och djup i mm för bänken
# Bräda axb = 22x95 mm
# Regel cxd = 45x70 mm
# Dessutom anges dessas längd vid köp
# Maximalt 1000 mm mellan reglarna

brada = {'bredd':95, 'hojd':22, 'langd': 4000}
regel = {'bredd':45, 'hojd':70, 'langd': 1000}


class Bank():
    def __init__(self, bredd, hojd, djup, brada, regel):
        a = brada['hojd'] # 22
        b = brada['bredd']  # 95
        c = regel['bredd']  # 45
        d = regel['hojd'] # 70
        self.brada_bitar = []
        self.regel_bitar = []

        # 1 Beräkna antal brädor på höjden
        brada_h = 1 + (hojd-a) / b
        # 2 Beräkna antal brädor på djupet
        brada_d = 1 + djup / b
        # 3 Beräkna antal reglar
        n = 2 + bredd/1000

        self.verklig_hojd = brada_h * b
        self.verkligt_djup = brada_d * b + a

        for i in range(brada_h + brada_d):
            self.brada_bitar.append(bredd)
        for i in range(n):
            self.regel_bitar.append(djup-a-a)
            self.regel_bitar.append(djup-a-a)
            self.regel_bitar.append(hojd-a-c-c)
            self.regel_bitar.append(hojd-a-c-c)

        self.brada_bitar.sort()
        self.regel_bitar.sort()

        self.material = {}
        self.material['brada'] = self.kapa_bitar(self.brada_bitar, brada['langd'])
        self.material['regel'] = self.kapa_bitar(self.regel_bitar, regel['langd'])

    def kapa_bitar(self, bitar, langd):
        bits = bitar[:]
        anvant = 0
        kvar = 0
        spill = []
        while len(bits) > 0:
            if bits[-1] <= kvar:
                kvar -= bits.pop()
            elif bits[0] <= kvar:
                kvar -= bits.pop(0)
            else:
                if kvar > 0:
                    spill.append(kvar)
                kvar = langd
                anvant += 1
        spill.append(kvar)
        return anvant,spill

bank = Bank(1500,500,550,brada,regel)
assert bank.verklig_hojd == 570
assert bank.verkligt_djup == 592
assert bank.brada_bitar == [1500,1500,1500,1500,1500,1500,1500,1500,1500,1500,1500,1500]
assert bank.material['brada'] == (6,[1000,1000,1000,1000,1000,1000]) # antal hela längder samt spillbitar
assert bank.regel_bitar == [388,388,388,388,388,388,506,506,506,506,506,506]
assert bank.material['regel'] == (6,[106,106,106,106,106,106])

bank2 = Bank(2500,450,350,brada,regel)
assert bank2.verklig_hojd == 475
assert bank2.verkligt_djup == 402
assert bank2.brada_bitar == [2500,2500,2500,2500,2500,2500,2500,2500,2500]
assert bank2.material['brada'] == (9,[1500,1500,1500,1500,1500,1500,1500,1500,1500])
assert bank2.regel_bitar == [306,306,306,306,306,306,306,306,338,338,338,338,338,338,338,338]
assert bank2.material['regel'] == (6,[18,18,18,18,82,694])
