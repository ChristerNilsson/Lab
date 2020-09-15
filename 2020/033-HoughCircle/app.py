# https://www.youtube.com/watch?v=dp1r9oT_h9k&t=414s&ab_channel=ProgrammingKnowledge
# https://pypi.org/project/opencv-python/

import numpy as np
import cv2 as cv

NAME = 'images/1.jpg'

input = cv.imread(NAME)
output = input.copy()
input = cv.cvtColor(input,cv.COLOR_BGR2GRAY)
input = cv.medianBlur(input,5)
circles = cv.HoughCircles(input, cv.HOUGH_GRADIENT,1.3,20,param1=55,param2=40,minRadius=1,maxRadius=40)
circles = np.uint16(np.around(circles))
print(len(circles[0]))

with open(NAME + '.csv','w') as f:
	f.write(str(circles[0]))

i=0
font = cv.FONT_HERSHEY_SIMPLEX
for x,y,r in circles[0]:
	cv.circle(output,(x,y),r,(0,255,0),2)
	cv.circle(output,(x,y),2,(0,255,255),2)
	if i>60: cv.putText(output, str(i), (x,y), font, 1, (255,255,255), 2)
	i+=1

cv.imwrite(NAME+'.png',output)
cv.imshow('output',output)
cv.waitKey(0)
cv.destroyAllWindows()
