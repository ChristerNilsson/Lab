# -*- coding: utf-8 -*-

# INSTABILT LÄGE!
# Tanken var att skapa en bitmap med alla ord.
# Lämpligen skickas in index.html med tal istf ord till klienten som där producerar slutliga bitmappen.
# Avbrutet

DIR = 'berget'
#DIR = 'kallocain'

import json
import time

import html5lib
from PIL import Image, ImageDraw, ImageFont, ImageFilter

#[WIDTH,HEIGHT,SIZE,LPP] = [600,800,32,18]
#[WIDTH,HEIGHT,SIZE,LPP] = [360,640,30,18]
#[WIDTH,HEIGHT,SIZE,LPP] = [640,360,30,12]
#[WIDTH,HEIGHT,SIZE,LPP] = [1280,720,60,12]
[WIDTH,HEIGHT,SIZE,LPP] = [1280,720,40,18]

LEFT_MARGIN = 10
SPACE = 10
BG = (0, 0, 0, 0)
WHITE = (255, 255, 255, 255)

class PageMaker:

	def step1(self,fonts):
		# self.width = width # client width
		# self.height= height # client height
		self.fonts = fonts # font family
		self.lineNo = 0 # räknar alla rader i boken

		self.words = [] # unika ord. parallell med widths.
		self.widths = [] # ordets bredd i pixel
		self.index = [] # ordets index i words och widths. Ett index for varje ord i kapitlet/boken

		self.init()

		with open(DIR + '/index.html', 'r', encoding="utf-8") as f:
			html = f.read()
			document = html5lib.parse(html)

		self.traverse(document)
		if len(self.rects) > 0:
			pageNo = int(self.lineNo / LPP)
			self.lineNo = LPP * (pageNo+1)
			self.produceFile()
		self.makeChapter()

		self.makeWords()

	def keyWithMaxVal(self,d):
		v = list(d.values())
		k = list(d.keys())
		maxWidth = max(v)
		return [k[v.index(maxWidth)],maxWidth]

	def indexWithMaxVal(self,widths,words):
		maxWidth = max(widths)
		ix = widths.index(maxWidth)
		return [maxWidth, words[ix]]

	def makeWords(self):
		print(len(self.words),'of',len(self.index))
		[maxWidth,word] = self.indexWithMaxVal(self.widths,self.words)
		print(word,maxWidth)

		with open(DIR + '/words.json', 'w') as outfile:
			json.dump(self.words, outfile)

		with open(DIR + '/widths.json', 'w') as outfile:
			json.dump(self.widths, outfile)

		with open(DIR + '/index.json', 'w') as outfile:
			json.dump(self.index, outfile)

		n = len(self.words)
		img = Image.new('RGBA', (maxWidth, 40 * n), BG)
		ctx = ImageDraw.Draw(img)
		for i,word in enumerate(self.words):
			ctx.text((0, i*40), word, font=self.fonts[0], fill=WHITE)
		img.save(DIR + '/words.png')

	def makeChapter(self):
		chapterInfo = [SIZE, int(self.lineNo / LPP)]
		with open(DIR + '/chapter.json', 'w') as outfile:
			json.dump(chapterInfo, outfile)

	def init(self):
		self.img = Image.new('RGBA', (self.width, self.height), BG)
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
		self.img.save(DIR + f'/page{pageNo}.png')
		with open(DIR + f'/page{pageNo}.json', 'w') as outfile:
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
		print(data)
		for word in data.split(' '):
			if word != '':
				try:
					index = self.words.index(word)
					self.index.append(index)
					w = self.widths[index]
				except:
					(w, h) = self.ctx.textsize(word, self.fonts[fontIndex])
					self.words.append(word)
					self.widths.append(w)
					self.index.append(len(self.words)-1)

				if self.x + w > self.width-4 and word != ",":
					self.nextLine()

				y = -5 + (self.lineNo % LPP) * SIZE
				self.ctx.text((self.x, y), word, font=self.fonts[fontIndex], fill=WHITE)
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

# Forsta steget kors offline, i klienten for att få snygga fonter. Pillow kan skrotas
# Kors i forväg for alla fonter. parsa fram orden forsta gången
# in: index.html font fontSize
# ut: index.json words.png words.json widths.json
pm.step1(fonts)

# skapar rektanglar for alla sidor. parsar på servern.
# INDEX.HTML WORDS.JSON verboten i klienten!
# in: screenWidth screenHeight words.png index.html font fontSize
# ut: rects.json [index,x,y,w,h] per sida
pm.step2(WIDTH,HEIGHT)

# skapar bitmap for en viss sida
# in: pageIndex rects.json index.json words.png
# ut: page.png
pm.step3()

print(time.clock()-start)
