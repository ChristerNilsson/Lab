# 23:59:50 111111100010101111111100000101010101000001101110101011001011101101110100000101011101101110101111101011101100000101110001000001111111101010101111111000000001000000000000110100110011101110110110110010001010011001111111111111011001011110100000100111000010111010110001001111001000000001010011001111111111101101101011000100000100100001111010101110100100111011010101110101010011011011101110100101011011101100000101111100011000111111101110010000010

def convert(filename):
	data = []
	with open(filename+'.txt','r') as f:
		with open(filename+'.csv','w') as g:
			for line in f.readlines():
				timestamp,bits = line.rstrip().split(' ')
				data = [bit for bit in bits]
				for i in [0,1,3,4,6,7]:
				    data.append(timestamp[i])
				g.write(','.join(data)+'\n')

convert('data\qrcode_1h')
convert('data\qrcode_1m')
convert('data\qrcode_2h')
convert('data\qrcode_4h')
convert('data\qrcode_22h')
convert('data\qrcode_24h')
convert('data\qrcode_300')
convert('data\qrcode_test_1h')
convert('data\qrcode_test_10')
convert('data\qrcode_test_100')
