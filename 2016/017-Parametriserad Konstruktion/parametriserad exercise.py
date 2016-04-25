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
        a = 00
        b = 00
        c = 00
        d = 00
        self.brada_bitar = 00
        self.regel_bitar = 00

        # 1 Beräkna antal brädor på höjden
        brada_h = 0
        # 2 Beräkna antal brädor på djupet
        brada_d = 0
        # 3 Beräkna antal reglar
        n = 00

        self.verklig_hojd = 00
        self.verkligt_djup = 00

        for i in 00:
            self.brada_bitar.append(00)
        for i in 00:
            self.regel_bitar.append(00)
            self.regel_bitar.append(00)
            self.regel_bitar.append(00)
            self.regel_bitar.append(00)

        self.brada_bitar.sort()
        self.regel_bitar.sort()

        self.material = {}
        self.material['brada'] = 00
        self.material['regel'] = 00

    def kapa_bitar(self, bitar, langd):
        bits = bitar[:]
        anvant = 00
        kvar = 00
        spill = 00
        while 00:
            if 00:
                00
            elif 00:
                00
            else:
                if 00:
                    00
                00
                00
        00
        return 00,00

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
