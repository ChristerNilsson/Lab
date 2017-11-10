# -*- coding: utf-8 -*-

import json
import html5lib
from PIL import Image, ImageDraw, ImageFont, ImageFilter
import time

#[WIDTH,HEIGHT,SIZE,LPP] = [600,800,32,18]
#[WIDTH,HEIGHT,SIZE,LPP] = [360,640,30,18]
#[WIDTH,HEIGHT,SIZE,LPP] = [640,360,30,12]
#[WIDTH,HEIGHT,SIZE,LPP] = [1280,720,60,12]
[WIDTH,HEIGHT,SIZE,LPP] = [1280,720,40,18]

LEFT_MARGIN = 10
SPACE = 10
#COLOR = (255, 255, 0, 255)
COLOR = (0, 0, 0, 255)

class PageMaker:

	def makePage(self,htmlfile,width,height,fonts):
		self.width = width # client width
		self.height= height # client height
		self.fonts = fonts # font family
		self.lineNo = 0 # räknar alla rader i kapitlet
		self.init()

		with open(htmlfile+'.html', 'r', encoding="utf-8") as f:
			html = f.read()
			document = html5lib.parse(html)

		self.traverse(document)
		if len(self.rects) > 0:
			pageNo = int(self.lineNo / LPP)
			self.lineNo = LPP * (pageNo+1)
			self.produceFile()
		self.makeChapter()

	def makeChapter(self):
		chapterInfo = [SIZE, int(self.lineNo / LPP)]
		with open('chapter.json', 'w') as outfile:
			json.dump(chapterInfo, outfile)

	def init(self):
		self.img = Image.new('RGBA', (self.width, self.height), (255, 255, 255, 0))
		self.ctx = ImageDraw.Draw(self.img)
		self.x = LEFT_MARGIN  # hoppar
		self.y = self.lineNo * SIZE  # räknar upp hela tiden
		self.rects = []

	def produceFile(self):
		pageNo = int(self.lineNo/LPP)
		print('page',pageNo)
		#self.ctx.text((LEFT_MARGIN, HEIGHT-50), "Berget", font=self.fonts[0], fill=COLOR)
		#self.ctx.text((WIDTH-30, HEIGHT-30-5), str(pageNo), font=self.fonts[0], fill=COLOR)

		self.img = self.img.filter(ImageFilter.DETAIL)
		self.img = self.img.filter(ImageFilter.SHARPEN)
		self.img.save(f'page{pageNo}.png')
		with open(f'page{pageNo}.json', 'w') as outfile:
			json.dump(self.rects, outfile)
		self.init()

	def nextLine(self):
		self.lineNo += 1
		self.x = LEFT_MARGIN
		self.y += SIZE
		if self.lineNo % LPP == 0:
			self.produceFile()

	def appendWords(self,data,fontIndex):
		if data == '\n': return
		for word in data.split(' '):
			if word != '':
				(w, h) = self.ctx.textsize(word, self.fonts[fontIndex])
				if self.x + w > self.width-4 and word != ",":
					self.nextLine()

				y = -5 + (self.lineNo % LPP) * SIZE
				self.ctx.text((self.x, y), word, font=self.fonts[fontIndex], fill=COLOR)
				self.rects.append([self.x, y, w, SIZE])
				self.x += w + SPACE

	def traverse(self,node):
		tag = node.tag.split('}')[1]
		if tag == 'tail': self.appendWords(node.text,0)
		if tag == 'p':
			self.nextLine()
			self.x = LEFT_MARGIN * 5
			self.appendWords(node.text,0)
		if tag == 'i':
			self.appendWords(node.text,1)
			self.traverse(html5lib.parse("<tail>" + node.tail + "</tail>"))
		if tag == 'b':
			self.appendWords(node.text,2)
			self.traverse(html5lib.parse("<tail>" + node.tail + "</tail>"))
		for child in node.getchildren(): self.traverse(child)

start = time.clock()
fonts = [ImageFont.truetype(f'times{name}.ttf', SIZE) for name in ['','i','bd','bi']]
pm = PageMaker()
pm.makePage('berget',WIDTH,HEIGHT,fonts)
print(time.clock()-start)
