# Laser 12 matriser i Sampers MatrixBin format 1979x1979
# Laser 6 matriser i emxformat 2100x2100
# Beraknar enligt RegionalMatrixAdjust
# Skriver ut 12 matriser i numpy formatet. 1979x1979
# Datavolym: 30x16MB = 480MB
# Tid: 1.8 sekunder

# Tid i Sampers gammal kod: 82 minuter. Orsak: laste 4000GB

import os
import time
import numpy as np

n = 1979
dt = np.float32

purposes = 'Work Business Other SpareTime Visit School'.split(' ')
cgs = 'Card Cash'.split(' ')

def show(name,res):
	#print(name)
	#print(res)
	print('R')
	return res

def readNumpyFile(name):
	return show(name, np.fromfile(name, dt).reshape(n, n))

def readEmma(name):
	nemma = 2100
	big = np.fromfile(name, dt).reshape(nemma, nemma)
	return show(name, big[0:n, 0:n])

def readMatrixBin(name):
	f = open(name, "rb")
	offset = 8014
	f.seek(offset, os.SEEK_SET)
	return show(name,np.fromfile(f, dt).reshape(n, n))

addMatrix = [np.zeros((n,n)), np.zeros((n,n)), np.zeros((n,n))]
#addMatrices = [readEmma(36), readEmma(37), readEmma(38)]
#mulMatrices = [readEmma(39), readEmma(40), readEmma(41)]
addMatrices = [np.ones((n,n)), np.ones((n,n)), np.ones((n,n))]
mulMatrices = [np.ones((n,n)), np.ones((n,n)), np.ones((n,n))]

inMatrices = [[readMatrixBin("R125 CashCard/Kollektivt" + p + ' ' + cg + ".bin") for cg in cgs] for p in purposes]

start = time.clock()

aggregate = [0, 1, 2, 2, 2, 2]
totDelCount = [2, 2, 8]
totDel = [np.zeros((n, n)), np.zeros((n, n)), np.zeros((n, n))]
for i in range(6):
	ai = aggregate[i]
	b = totDel[ai]
	for j in range(2):
		a = inMatrices[i][j]
		#b = ne.evaluate('b + a')
		b = b + a

for i, p in enumerate(purposes):
	ai = aggregate[i]
	b = mulMatrices[ai]
	c = totDel[ai]
	d = totDelCount[ai]
	e = addMatrices[ai]
	for j, cg in enumerate(cgs):
		a = inMatrices[i][j]
		#moutBin = ne.evaluate('a * b')
		#kvot = np.where(totDel[ai] > 0, inMatrices[i][j]/totDel[ai], 1.0 / totDelCount[ai])
		#kvot = ne.evaluate('where(c > 0, a/c, 1.0 / d)')
		#moutBin = ne.evaluate('a*b + e * where(c > 0, a/c, 1.0 / d)') # 0.93 secs
		print('W')
		moutBin = a*b + e * np.where(c > 0, a/c, 1.0 / d) # 1.37 secs
		moutBin.astype(dt).tofile("R125 CashCard/Kollektivt" + p + ' ' + cg + "_NewAdj.bin") # 0.50 secs

# f1 = readNumpyFile("R125 CashCard/KollektivtWork Card_NewAdj.bin")
# f2 = readMatrixBin("Add1Mul2/KollektivtWork Card_Adj.bin")
#
# diff = f2-f1
# for i in range(n):
# 	for j in range(n):
# 		if diff[i][j] != 0:
# 			print i, j, diff[i][j]

print(time.clock() - start)

def diff(fname,gname):
	f = readMatrixBin(fname)
	g = readMatrixBin(gname)
	return np.all(f == g)

def diffemx(fname,gname):
	f = readEmma(fname)
	g = readEmma(gname)
	return np.all(f == g)

def compare(dir1,dir2):
	for i, p in enumerate(purposes):
		for j, cg in enumerate(cgs):
			fname = dir1 + "/Kollektivt" + p + " " + cg + "_Adj.bin"
			gname = dir2 + "/Kollektivt" + p + " " + cg + "_Adj.bin"
			if not diff(fname, gname):
				print(False)
				# f = readMatrixBin(fname)
				# g = readMatrixBin(gname)
				# for i in range(n):
				# 	for j in range(n):
				# 		if f[i][j] != g[i][j]:
				# 			print i, j, f[i][j],g[i][j]
			else:
				print(True)

def compemx(dir1,dir2):
	for nr in '8 9 10 11 12 13 14 15 16 23 24 25 29 30 31'.split(' '):
		fname = dir1 + "/mf" + nr + ".emx"
		gname = dir2 + "/mf" + nr + ".emx"
		print(diffemx(fname, gname))

#compare('OldIdentityAfter','OldIdentityAfter')
#compemx('NewIdentityAfter','OldIdentityAfter')

#compare('OldMul2Add1Before','OldMul2Add1After')

#compare('OldMul2Add1After','NewMul2Add1After')
#compemx('OldMul2Add1After','NewMul2Add1After')
