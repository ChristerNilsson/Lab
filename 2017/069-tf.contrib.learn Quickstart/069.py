'''
Building a neural network for decoding QR-codes with Tensorflow.
I generated 86400 QR-codes with Javascript, one for each second in 24 hours.

Labels: 12:34:56
Bitmap: 21x21 = 441
Neuron Count: 100+100+10 = 210 (times 6)
Total Matrix Size: 441*100 + 100*100 + 100*10 = 55K (times 6)

Setting up a target for each digit and building a separate network for each.
Maybe Tensorflow can handle this better.
All in all seven minutes to construct all networks with no CPU or GPU support.
About one second to predict unknown bitmap

Magic Settings used:
target hidden    rows steps accuracy time
h1 441 [100,100] 3600 1000  1.000    68s
h0 442 [100,100] 3600 1000  1.000    68s
m1 443 [100,100] 3600 1000  0.997    70s
m0 444 [100,100] 3600 1000  0.999    68s
s1 445 [100,100] 3600 1000  0.999    68s
s0 446 [100,100] 3600 1000  0.999    69s

FAQ:
Memory Overflow : make sure tmp/model is empty
Memory Overflow : reduce hidden and/or rows
Exit Code 3 => Delete the model directory.

Todo: Reinstall TensorFlow GPU-version
Todo: Analyze Memory usage to avoid Out Of Memory.
Todo: write log file with settings, accuracy and time used.
'''

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import time
from random import shuffle

import numpy as np
import tensorflow as tf

#####################
FILENAME = "data\qrcode_24h.csv"
DATA_COLS = 249 # 21x21 - 3x8x8 Three squares are not used for data in the QR code
CLASSES = 10 # digits 0..9
HEADER = False

TARGET_COL = 446 # [hhmmss] == [441,442,443,444,445,446]
HIDDEN = [100,100]
ROWS = 3600 # for training
STEPS = 1000
#####################

def getList(lines):
	data = []
	target = []
	for line in lines:
		arr = line.rstrip().split(',')
		row = []
		for i in range(441):
			x = i%21
			y = i//21
			if            x<=7 and            y<=7: continue
			if 13<=x and x<=20 and            y<=7: continue
			if            x<=7 and 13<=y and y<=20: continue
			row.append(int(arr[i]))
		data.append(row)
		target.append(int(arr[TARGET_COL]))
	return [np.array(data, dtype=np.int32), np.array(target, dtype=np.int32)]

def load_csv (filename,t1,t2,t3):
	with open(filename,'r') as f:
		if HEADER: f.readline()
		lines = f.readlines()
	shuffle(lines)
	train=getList(lines[    0:t1])
	test =getList(lines[   t1:t1+t2])
	valid=getList(lines[t1+t2:t1+t2+t3])
	return train,test,valid

start = time.time()

train,test,valid = load_csv(FILENAME,ROWS,1000,10)
feature_columns = [tf.contrib.layers.real_valued_column("", dimension=DATA_COLS)]
classifier = tf.contrib.learn.DNNClassifier(feature_columns=feature_columns,hidden_units=HIDDEN,n_classes=CLASSES,model_dir="/tmp/model")

print('reading',time.time()-start)
start = time.time()

def get_train_inputs(): return tf.constant(train[0]), tf.constant(train[1])
def get_test_inputs():  return tf.constant(test[0]),  tf.constant(test[1])

classifier.fit(input_fn = get_train_inputs, steps=STEPS)
print('classification',time.time() - start)
start = time.time()

evaluation = classifier.evaluate(input_fn = get_test_inputs, steps=1)
print("\nTest Accuracy:", evaluation["accuracy"])
print('evaluation',time.time() - start)
start = time.time()

print("Predicted:", list(classifier.predict(input_fn = lambda : valid[0])))
print("Expected: ", list(valid[1]))
print('prediction',time.time() - start)
