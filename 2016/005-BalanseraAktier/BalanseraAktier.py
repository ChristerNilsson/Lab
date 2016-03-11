# -*- coding: utf-8 -*-

# Format:

# Fondbolag,Fondnummer,Fondnamn,Datum,Valutakurs sälj,Valutakurs köp,Fondkurs sälj,Fondkurs köp,Fondkurs i SEK köp,Fondkurs i SEK sälj
# ,,,,,,,,,
# Aberdeen International Fund Managers Limited,112631,Aberdeen Global - Sterling Corporate Bond Fund,2009-01-02,11.3685,11.3835,0.8992,0.8992,10.23604320,10.22255520
# Aberdeen International Fund Managers Limited,112631,Aberdeen Global - Sterling Corporate Bond Fund,2009-01-05,11.2837,11.2987,0.8984,0.8984,10.15075208,10.13727608

import csv
import datetime
from dateutil.parser import parse

PATH = 'C:\\Users\\christer\\Desktop\\ppm\\'

def ppm_to_shares(path):
    hash = {}
    names = {}
    for year in range(2009,2016):
        for quarter in range(1,5):
            filename = path + str(year) + "-" + str(quarter) + ".csv"
            print filename
            with open(filename, "r") as f:
                header = f.readline()
                header = f.readline()
                for arr in csv.reader(f, delimiter=',', quotechar='"'):
                    fund = arr[1]
                    date = arr[3]
                    buy = arr[8].replace(' ','')
                    sell = arr[9].replace(' ','')
                    if fund not in hash.keys():
                        hash[fund] = {}
                        name = arr[2]
                        names[name] = fund
                    hash[fund][date] = [buy,sell]
    for key in hash.keys():
        fund = key
        with open(path + fund + ".txt", "w") as f:
            for key2 in sorted(hash[fund].keys()):
                date = key2
                buy,sell = hash[fund][date]
                f.write(date + ',' + buy + ',' + sell + "\n")

    with open(path + "names.txt", "w") as f:
        for key in sorted(names.keys()):
            name = key
            nr = names[key]
            f.write(nr + ' ' + name + "\n")

# ppm_to_shares(PATH)

def read_share(nr):
    hash = {}
    with open(PATH + str(nr) + '.txt', "r") as f:
        for day,buy,sell in csv.reader(f, delimiter=','):
            hash[parse(day)] = [float(buy), float(sell)]
    return hash

share1 = read_share(338590)
share2 = read_share(522581)
#share2 = read_share(658997)

def balansera(share1,share2):

    # hitta gemensamt startdatum
    dates1 = sorted(share1.keys())
    dates2 = sorted(share2.keys())
    day = min([dates1[0],dates2[0]])
    while True:
        if day in dates1 and day in dates2:
            break
        day += datetime.timedelta(days=1)

    # köp hälften av varje
    antal1 = 100000 / share1[day][0]
    antal2 = 100000 / share2[day][0]
    print "Bought " + str(antal1) + " at " + str(share1[day][0])
    print "Bought " + str(antal2) + " at " + str(share2[day][0])

    while True:
        day += datetime.timedelta(days=1)
        if day in dates1 and day in dates2:
            # skriv ut diff
            value1 = antal1 * share1[day][1]
            value2 = antal2 * share2[day][1]
            diff = value1 - value2
            total = value1 + value2
            kvot = diff/total
            if abs(kvot) >= 0.10:
                belopp = diff/2
                print day, value1, value2, diff, total,kvot, "Balansera ", belopp,kvot
                antal1 -= belopp / share1[day][1]
                antal2 += belopp / share2[day][0]
                value1 = antal1 * share1[day][1]
                value2 = antal2 * share2[day][1]
                diff = value1 - value2
                total = value1 + value2
                kvot = diff/total
            print day, value1, value2, diff, total,kvot
            final = str(day) + " " + str(value1 + value2)
        if day.year >= 2016:
            print final
            break



balansera(share1,share2)