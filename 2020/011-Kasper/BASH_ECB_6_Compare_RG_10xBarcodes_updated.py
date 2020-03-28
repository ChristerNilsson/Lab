### Associates 10X cell barcode with ECB seq cell barcode

### Remove barcodes from ECB defined barcodes if they are:
# ham 1 from more than 1 10X defined cell barcode
# more than 1 ham from any 10X defined barcode

import numpy as np
import time

name = "ECB_data/Valid_cellBC_ECB_ham2_clean_RG"

def convertForw(str16): return ['ACGT'.index(ch) for ch in str16]
assert convertForw('ACGT') == [0,1,2,3]
assert convertForw('AAAA') == [0,0,0,0]
assert convertForw('TTTT') == [3,3,3,3]

def convertBack(lst):	return ''.join(['ACGT'[i] for i in lst])
assert convertBack([0,1,2,3]) == 'ACGT'
assert convertBack([0,0,0,0]) == 'AAAA'
assert convertBack([3,3,3,3]) == 'TTTT'

def make_bc10x():
	### Get all 10X defined cell barcodes
	with open("ECB_data/barcodes.tsv", "r") as fd:
		return [convertForw(line.split()[0][:-2]) for line in fd.readlines()]

def make_BCdic():
	### Get all ECB cell barcodes
	result = {}
	with open(name + ".txt", "r") as fd:
		for line in fd.readlines(): result[line[0:16]] = 0 ### 10X cell barcode
	return result

def hamming(bc,bc10x): # 'ACTGTGCACACTGTAC', list of list
	bc = convertForw(bc)
	bc = np.array(bc)
	diff = bc - bc10x
	return np.count_nonzero(diff, axis=1)

def countOnes(arr): return np.count_nonzero(arr == 1)

start = time.time()

bc10x = make_bc10x()
bc10x = np.array(bc10x)

BCdic = make_BCdic()

hamAssociated = BCdic # copy.deepcopy(BCdic)

for bc in BCdic: # {}
	arrHamming = hamming(bc,bc10x)
	mindex = np.argmin(arrHamming)
	minHam = arrHamming[mindex]
	b = convertBack(bc10x[mindex])
	if minHam == 0:
		hamAssociated[bc] = b
	elif minHam == 1:
		if countOnes(arrHamming) == 1:
			hamAssociated[bc] = b  # if unique
		else:
			hamAssociated[bc] = "Remove_multham1"
	else:
		hamAssociated[bc] = "Remove_Minham"

with open(name + "_compared_10X_barcodes_1.txt", "w") as fout:
	fout.write("ECB_barcode\tAssociated_10X_barcode\n")
	for h in hamAssociated:
		fout.write(f"{h}\t{hamAssociated[h]}\n")

print(time.time()-start)
