# -*- coding: utf-8 -*-

from SnapGeometry import Calculator

calc = Calculator()

def ass(a,b):
    res = calc.calc(a)
    if res != b:
        print res
        print a
        print b
        assert res == b

def ex1(): # Cirkelproblemet från Mickes Mathjam
    ass('0 2','p0')
    ass('0 8','p1')
    ass('p0 2','c0')
    ass('c0 p1','p2 p3')
    ass('p1 p2','l0')
    ass('X l0','p4')
    ass('p4 p0','l1')
    ass('','')

    # Skapande av första cirkeln i serien:
    ass('l1 c0','p5 p6')
    ass('l1 p5','p7')
    ass('p5 p7','l2')
    ass('l2 l0','p8')
    ass('l2 X','p9')
    ass('p4 p8 p9','t0')
    ass('t0','p10 c1 c2 a0 a1 a2') # radien blir -4 + 2*sqrt(3)
    ass('','')

    # Skapande av andra cirkeln i serien:
    # ass('ea c2','l m')
    # ass('ea l','n')
    # ass('l n','ln')
    # ass('ln bc','o')
    # ass('ln X','p')
    # ass('e o p','eop')
    # ass('eop','q c4 c5') # radien blir:
    # (-104*sqrt(12*sqrt(3) + 21) - 32*sqrt(3) + 56 + 180*sqrt(4*sqrt(3) + 7)) /
    # (-5*sqrt(4*sqrt(3) + 7) - 3 + sqrt(3) + 3*sqrt(3)*sqrt(4*sqrt(3) + 7))

    calc.dumpToFile()
#ex1()

def ex2(): # Två trianglar med sex skärningspunkter
    calc.reset()
    ass('0 2','p0')
    ass('2 1','p1')
    ass('2 -1','p2')
    ass('0 -2','p3')
    ass('-2 -1','p4')
    ass('-2 1','p5')
    ass('p0 p2 p4','t0')
    ass('p1 p3 p5','t1')
    ass('t0 t1','p6 p7 p8 p9 p10 p11')
#ex2()

def ex3(): # Ellips 3 32:7
    calc.reset()
    ass('6 0','p0')
    ass('0 4','p1')
    ass('p0 p1 O','t0')
    ass('t0','p2 c0 c1 a0 a1 a2')
    ass('p0 p2','l0')
#ex3()

def ex_62_1(): # Ellips 62:1
    calc.reset()
    ass('1.2 0.4 1','t0')
    ass('t0','p0 c0 c1 a0 a1 a2')
#ex_62_1()

def ex_62_2(): # Ellips 62:2
    calc.reset()
    ass('1 0','p0')
    ass('O Angle(120)','l0')
    ass('O 0.8','c0')
    ass('l0 c0','p1 p2')
    ass('p0 p2','l1')
    assert calc.var('l1') == 'l1 = Line x=1.00 y=0 x=-0.400 y=0.693 length=1.56'
#ex_62_2()

def ex_62_3(): # Ellips 62:3
    calc.reset()
    ass('O Angle(30)','l0')
    ass('O 4','c0')
    ass('c0 l0','p0 p1')
    ass('7 0','p2')
    ass('O p2 p1','t0')
    ass('t0','p3 c1 c2 n0 a0 a1 a2')
    assert calc.var('n0') == 'n0 = Number 7.00'
#ex_62_3()

def ex_62_4(): # Ellips 62:4
    # Ej lösbar iom att area är indata och sidlängd är utdata
    calc.reset()
#ex_62_4()

def ex_62_5(): # Ellips 62:5
    calc.reset()
    ass('O Angle(60)','l0')
    ass('O 4','c0')
    ass('c0 l0','p0 p1')
    ass('p1 Angle(135)','l1')
    ass('X l1','p2')
    ass('p1 p2','l2')
    assert calc.var('l2') == 'l2 = Line x=2.00 y=3.46 x=5.46 y=0 length=4.90'
#ex_62_5()

def ex_62_6(): # Ellips 62:6
    calc.reset()
    ass('O Angle(50)','l0')
    ass('O 500','c0')
    ass('c0 l0','p0 p1')
    ass('p1 400','c1')
    ass('c1 X','p2 p3')
    ass('O p1 p2','t0')
    ass('O p1 p3','t1')
    ass('t0','p4 c2 c3 n0 a0 a1 a2')
    ass('t1','p5 c4 c5 n1 a3 a4 a5')
    calc.more()
    calc.more()
    print calc.var('a2') #== 'a2 = Angle 106.75'
    print calc.var('a5') #== 'a5 = Angle 73.247'
    calc.ready()
ex_62_6()

def ex_62_7(): # Ellips 62:7
    calc.reset()
    ass('O 350','c0')
    ass('O Angle(78)','l0')
    ass('c0 l0','p0 p1')
    ass('p1 650','c1')
    ass('c1 X','p2 p3')
    ass('p3 1200','c2')
    ass('c2 X','p4 p5')
    ass('p4 p1','l1')
    ass('p1 p3 O','t0')
    ass('t0','p6 c3 c4 a0 a1 a2')
    assert calc.var('a1') == 'a1 = Angle 31.8'
    assert calc.var('l1') == 'l1 = Line x=-575. y=0 x=72.8 y=342. length=732.'
#ex_62_7()

def ex_544(): # Ellips 3 544 EJ fullständig. Bågen måste beräknas med acos(0.4)
    calc.reset()
    ass('0 0','a')
    ass('100 0','b')
    ass('a 24','c1')
    ass('b 16','c2')
    ass('60 0','c')
    ass('c1 c','d e')
    ass('c2 c','f g')
    ass('c d','cd')
    ass('c e','ce')
    ass('c f','cf')
    ass('c g','cg')
#ex_544()

def ex_649(): #
    calc.reset()
    ass('500 700 1000','t0')
    ass('t0','p0 c0 c1 n0 a0 a1 a2')
    assert calc.var('c1') == 'c1 = Circle x=250. y=477. radius=539.'
#ex_649()

calc.run()

