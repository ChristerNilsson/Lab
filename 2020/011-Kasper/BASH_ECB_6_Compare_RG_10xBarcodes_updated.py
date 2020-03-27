### Associates 10X cell barcode with ECB seq cell barcode

import os
import sys
import copy

sys.path.append("/usr/lib/python2.7/lib-dynload/")
from itertools import izip, imap
import operator


curdir = sys.argv[1]
os.chdir(curdir)

name = "ECB_data/Valid_cellBC_ECB_ham2_clean_RG"

fout = open(name+"_compared_10X_barcodes_1.txt","w")

def hamming(str1, str2):
    assert len(str1) == len(str2)
    ne = operator.ne
    return sum(imap(ne, str1, str2))

### Get all 10X defined cell barcodes
fd = open("ECB_data/barcodes.tsv", "r")
line = fd.readline()
bc10x = []
while line:
    line = line.split()
    bctemp = line[0][:-2]
    bc10x.append(bctemp)
    line = fd.readline()
fd.close()

fd = open(name + ".txt", "r")
line = fd.readline()
line = fd.readline()


### Get all ECB cell barcodes
BCdic = {}
while line:
    line = line.split()
    bc = line[0]  ### 10X cell barcode
    if bc not in BCdic:
        BCdic[bc] = "0"
    line = fd.readline()
fd.close()
print len(BCdic)

n=0

### Remove barcodes from ECB defined barcodes if they are:
# ham 1 from more than 1 10X defined cell barcode
# more than 1 ham from any 10X defined barcode
#BCdic_copy = copy.deepcopy(BCdic)

hamAssociated= copy.deepcopy(BCdic)
for bc in BCdic:
    minham = 100
    hamCountDic = {}
    for b in bc10x:
        ham = hamming(b,bc)
        if ham == 0:
            hamAssociated[bc] = b
        if ham == 1: ### If ham == 1 add ecb bc to hamcountdic, on such occassion ok, two, remove from ham associated
            if bc in hamCountDic:
                hamAssociated[bc] = "Remove_multham1"
                print bc
            if bc not in hamCountDic:
                hamCountDic[bc] = 1
                hamAssociated[bc] = b
        if ham < minham:
            minham = ham
    if minham > 1:
        hamAssociated[bc] = "Remove_Minham"
    n+=1
    if n%1000 == 0:
        print n, bc

print len(hamAssociated)

fout.write("ECB_barcode")
fout.write("\t")
fout.write("Associated_10X_barcode")
fout.write("\n")

for h in hamAssociated:
    fout.write(str(h))
    fout.write("\t")
    fout.write(str(hamAssociated[h]))
    fout.write("\n")
