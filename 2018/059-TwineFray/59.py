from random import randint, choice

nodes = {}
page = 'Town'

class Person:
	def __init__(self):
		self.health = 100
		self.sword = 0
		self.coins = 100
		self.points = 0
		self.ax = 0

	def inventory(self):
		return self.__dict__

class Enemy:
	def __init__(self):
		self.name = choice(["Giant Spider","Zombie","Ghost","Pizza Rat"])
		self.punch = randint(1,9)
		self.kick = 10 - self.punch
		self.health = randint(20,40) + person.points * 0.1

	def attack(self):
		if self.health > 0:
			hit = randint(1,3) + randint(1,3)
			print(f'The {self.name} attacks You!')
			person.health -= hit
			person.points += hit
		else:
			print(f'You have defeated the {self.name}!')
			person.points += 10
			person.coins += randint(25,50)

class Node:
	def __init__(self,name,commands):
		self.name = name
		self.commands = commands

	def buy(self,name,p1,p2): pass
	def enter(self): pass

	def execute(self,command):
		global page
		page = command
		nodes[page].enter()

class Market(Node):
	def buy(self,name,p1,p2):
		if person.coins >= p1:
			person.coins -= p1
			person.inventory()[name] += p2
		else:
			print(f'You cant afford a {name}')

	def execute(self,command):
		if command == 'Medicine':
			self.buy('health', 10, 10)
		elif command == 'Sword':
			self.buy('sword', 50, 1)
		elif command == 'Ax':
			self.buy('ax', 100, 1)
		else:
			super().execute(command)

class Place(Node):
	def execute(self,command):
		if command == 'Punch':
			self.punch()
		elif command == 'Kick':
			self.kick()
		elif command == 'Slash':
			self.slash()
		elif command == 'Ax':
			self.ax()
		else:
			super().execute(command)

	def enter(self):
		if randint(0, 1) == 0:
			self.enemy = Enemy()
			print(f'There is an {self.enemy.name} here')
		else:
			print('There is nothing here')
			self.enemy = None

	def punch(self):
		self.attack('punch',8,self.enemy.punch + randint(1, 6))

	def kick(self):
		self.attack('kick',6, self.enemy.kick + randint(1, 6))

	def slash(self):
		if person.sword > 0:
			self.attack('slash',10, 10 + person.sword * (randint(1, 6) + randint(1, 6)))
		else:
			print('You have no sword')

	def ax(self):
		if person.ax > 0:
			self.attack('ax',5, 10 + person.ax * (randint(4, 6) + randint(4, 6) + randint(4, 6)))
		else:
			print('You have no ax')

	def attack(self,weapon,n,hit):
		if self.enemy == None:
			print('There is nothing to attack!')
			return
		self.enemy.attack()
		if randint(1,n)==1:
			print(f"Your {weapon} missed the {self.enemy.name}!")
		else:
			self.enemy.health -= hit
			person.points += hit
			print(f"You hit with your {weapon}!")
			if self.enemy.health <= 0:
				print(f"The {self.enemy.name} dies")
				self.enemy = None

person = Person()

nodes['Town'] = Node('Town','Market Castle Graveyard Farm')
nodes['Market'] = Market('Market','Medicine Sword Ax Town')
nodes['Castle'] = Place('Castle','Punch Kick Slash Ax Town')
nodes['Graveyard'] = Place('Graveyard','Punch Kick Slash Ax Town')
nodes['Farm'] = Place('Farm','Punch Kick Slash Ax Town')

while True:
	node = nodes[page]
	commands = node.commands
	print('You are in', node.name)
	print('Inventory', person.inventory())
	print('Commands:',commands)
	cmd = input('Command: ')
	print('')
	if len(cmd) == 0: continue
	for command in commands.split(' '):
		if command.lower().startswith(cmd):
			node.execute(command)
