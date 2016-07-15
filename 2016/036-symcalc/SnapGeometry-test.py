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
    ass('0 2','P0')
    ass('0 8','P1')
    ass('p0 2','C0')
    ass('c0 p1','L0 L1')
    ass('X l0','P2')
    ass('p2 p0','L2')

    # Skapande av första cirkeln i serien:
    ass('l2 c0','P3 P4')
    ass('l2 p3','L3')
    #ass('p2 p4','L4')
    ass('l3 l0','P5')
    ass('l3 X','P6')
    ass('p2 p5 p6','T0')
    ass('t0.ic','C1')
    ass('c1.r','N0') # radien blir -4 + 2*sqrt(3)

    # Skapande av andra cirkeln i serien:
    ass('l2 c1','P7 P3')
    ass('l2 p7','L4')
    ass('l4 l0','P8')
    ass('l4 x','P9')
    ass('p2 p8 p9','T1')
    ass('t1.ic','C2')
    ass('c2.r','N1')
    # radien blir:
    # (-104*sqrt(12*sqrt(3) + 21) - 32*sqrt(3) + 56 + 180*sqrt(4*sqrt(3) + 7)) /
    # (-5*sqrt(4*sqrt(3) + 7) - 3 + sqrt(3) + 3*sqrt(3)*sqrt(4*sqrt(3) + 7))

    calc.dumpToFile()
#ex1()

def ex2(): # Två trianglar med sex skärningspunkter
    calc.reset()
    ass('0 2','P0')
    ass('2 1','P1')
    ass('2 -1','P2')
    ass('0 -2','P3')
    ass('-2 -1','P4')
    ass('-2 1','P5')
    ass('p0 p2 p4','T0')
    ass('p1 p3 p5','T1')
    ass('t0 t1','P6 P7 P8 P9 P10 P11')
#ex2()

def ex3(): # Ellips 3 32:7
    calc.reset()
    ass('6 0','P0')
    ass('0 4','P1')
    ass('p0 p1 O','T0')
    ass('t0.m','P2')
    ass('p0 p2','L0')
    ass('l0.l','N0')
#ex3()

def ex_62_1(): # Ellips 62:1
    calc.reset()
    ass('1.2 0.4 1','T0')
    ass('t0.a1','A0')
#ex_62_1()

def ex_62_2(): # Ellips 62:2
    calc.reset()
    ass('1 0','P0')
    ass('O Angle(120)','L0')
    ass('O 0.8','C0')
    ass('l0 c0','P1 P2')
    ass('p0 p1','L1')
    ass('l1.l','N0')  # 1.56
#ex_62_2()

def ex_62_3(): # Ellips 62:3
    calc.reset()
    ass('O Angle(30)','L0')
    ass('O 4','C0')
    ass('c0 l0','P0 P1')
    ass('7 0','P2')
    ass('O p2 p1','T0')
    ass('t0.area','N0')  # 7
#ex_62_3()

def ex_62_4(): # Ellips 62:4
    # Ej lösbar iom att area är indata och sidlängd är utdata
    calc.reset()
#ex_62_4()

def ex_62_5(): # Ellips 62:5
    calc.reset()
    ass('O Angle(60)','L0')
    ass('O 4','C0')
    ass('c0 l0','P0 P1')
    ass('p1 Angle(135)','L1')
    ass('X l1','P2')
    ass('p1 p2','L2')
    ass('l2.l','N0')  # 4.90
#ex_62_5()

def ex_62_6(): # Ellips 62:6
    calc.reset()
    ass('5','')  # 5 värdesiffror
    ass('O Angle(50)','L0')
    ass('O 500','C0')
    ass('c0 l0','P0 P1')
    ass('p1 400','C1')
    ass('c1 X','P2 P3')
    ass('O p1 p2','T0')
    ass('O p1 p3','T1')
    ass('t0.a2','A0') # Angle 106.75
    ass('t1.a2','A1') # Angle 73.247
    calc.ready()
#ex_62_6()

def ex_62_7(): # Ellips 62:7
    calc.reset()
    ass('O 350','C0')
    ass('O Angle(78)','L0')
    ass('c0 l0','P0 P1')
    ass('p1 650','C1')
    ass('c1 X','P2 P3')
    ass('p3 1200','C2')
    ass('c2 X','P4 P5')
    ass('p4 p1','L1')
    ass('p1 p3 O','T0')
    ass('t0.a1','A0') # 31.8 grader
    ass('l1.l','N0') # 732 meter
#ex_62_7()

def ex_544(): # Ellips 3 544 EJ fullständig. Bågen måste beräknas med acos(0.4)
    # Dessutom måste CC skapa fyra tangentlinjer
    calc.reset()
    ass('0 0','o')
    ass('100 0','P0')
    ass('o 24','C0')
    ass('p0 16','C1')
    ass('60 0','P1')
    ass('p1 c','d e')
    ass('c2 c','f g')
    ass('c d','cd')
    ass('c e','ce')
    ass('c f','cf')
    ass('c g','cg')
#ex_544()

def ex_649(): #
    calc.reset()
    ass('500 700 1000','T0')
    ass('t0.oc.r','N0')  # 539 meter
#ex_649()

calc.run()

