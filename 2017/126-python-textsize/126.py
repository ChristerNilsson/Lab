# -*- coding: utf-8 -*-

from PIL import Image, ImageDraw, ImageFont
import random
import datetime
import json

txt = """
- Tom!
Inget svar.
- Tom!
Inget svar.
- Var håller pojken hus nu igen? Hör du - Tom!
Den gamla damen petade ned sina glasögon och tittade över dem runt rummet. Därefter sköt hon upp dem och tittade under dem. Sällan eller aldrig tittade hon genom dem efter något så obetydligt som en pojke, ty de var ju hennes finglasögon och hennes själs stolthet. De var gjorda för att få henne att verka fin dam och inte för att tjänstgöra som glasögon - hon kunde lika gärna ha försökt titta genom ett par ugnsluckor. Nu såg hon sig rådvill omkring och sa, inte så särskilt högt, men ändå högt nog för att möblerna skulle höra det:
"""

t = '{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now())
txt = t + txt
data = ''
for i in range(1):
	data += txt
print(len(data),'tecken')
data = data.split("\n")

SIZE = 32 # ver pixlar
LINE_SPACE = 8 # ver pixlar

WIDTH = 1000 # hor pixlar
LEFT_MARGIN = 10 # hor pixlar
SPACE = 10 # hor pixlar

img = Image.new('RGBA', (WIDTH,600), (255, 255, 255,0))

fonts = []
fonts.append(ImageFont.truetype('times.ttf', SIZE))
fonts.append(ImageFont.truetype('timesbd.ttf', SIZE))
fonts.append(ImageFont.truetype('timesbi.ttf', SIZE))
fonts.append(ImageFont.truetype('timesi.ttf', SIZE))

ctx = ImageDraw.Draw(img)

x = LEFT_MARGIN
y = SIZE
rects = []
for words in data:
	for word in words.split(' '):

		index = random.choice([0, 0, 0, 0, 0, 0, 0, 1, 2, 3])
		fnt = fonts[index]
		if word != '':
			(w, h) = ctx.textsize(word, fnt)
			if x + w > WIDTH:
				y += SIZE + LINE_SPACE
				x = LEFT_MARGIN
			ctx.text((x, y), word, font=fnt, fill=(0,0,0, 255))
			rects.append([x, y, w, h,word])
			x += w + SPACE
	y += SIZE + LINE_SPACE
	x = LEFT_MARGIN

with open('data.json', 'w') as outfile:
	json.dump(rects, outfile)

# img = img.filter(ImageFilter.DETAIL)
# img = img.filter(ImageFilter.SHARPEN)
# print(time.time() - start,'tecken ritas')
img.save('data.png')
