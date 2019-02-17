#from pynput import keyboard
from time import perf_counter
from Board import Board,SHUFFLE_MAGNITUDE
from Board import Fifteen,ALFA

#                             max solve millis
PROBLEMA = 'ABCGDIEFHJNKL_MO' # 10   10     4 ms
PROBLEMB = 'DABFHJC_LENGMIOK' # 20   20    21 ms
PROBLEMC = 'DABCJKGOHEMNL_IF' # 30   28   473 ms
PROBLEMD = 'DAMBG_HCEFLKINJO' # 40   34  5286 ms
PROBLEME = '' #
PROBLEMF = '' #
PROBLEMG = '' #
PROBLEMH = '' #
PROBLEMI = '' #
PROBLEMJ = '' #
PROBLEMK = '' #
PROBLEML = '' #
PROBLEMM = 'ONHLJKIMBFEACGD_' # 80 moves needed [Gasser]

P1 = 'AMBCDF_GEHLKINJO' # 348 ms
P2 = 'AMBCD_GKEFHLINJO' # 15 ms
P3 = 'AMBCDGH_EFLKINJO' # 1 ms
P4 = 'AM_BDGHCEFLKINJO' # 1 ms
P5 = 'A_MBDGHCEFLKINJO' # 0.47 ms
P6 = 'DAMB_GHCEFLKINJO' # 0.41 ms
#P7 = 'A_MBDGHCEFLKINJO' # 0.21 ms

def main():

	searched = {}
	# fifteen0 = Fifteen(P3,P4,searched,0)
	# fifteen1 = Fifteen(P4,P3,searched,1)
	#
	# start = perf_counter()
	#
	# key0=''
	# key1=''
	#
	# while True:
	# 	if key0 == '': key0 = fifteen0.step()
	# 	if key0 != '': break
	# 	if key1 == '': key1 = fifteen1.step()
	# 	if key1 != '': break
	#
	# print(perf_counter() - start)
	#
	# print(key0)
	# print(key1)


# a = Board(PROBLEMA,ALFA)
	# print(a.display())
	# for m in path0:
	# 	a.move("URDL".index(m))
	# 	print(a.display())

	# b = Board(ALFA,PROBLEMA)
	# print(b.display())
	# for m in path1:
	# 	b.move("URDL".index(m))
	# 	print(b.display())

	b = Fifteen(ALFA,PROBLEMA,searched,0)

	#while b.value() < SHUFFLE_MAGNITUDE + 20:
	b.shuffle()
	print(b.key)

	print(b.display())
#	with keyboard.Listener(on_press=on_press) as listener: listener.join()

# def on_press(key):
# 	if key == keyboard.Key.esc: return False
# 	elif key == keyboard.Key.up:      b.move(0)
# 	elif key == keyboard.Key.right:   b.move(1)
# 	elif key == keyboard.Key.down:    b.move(2)
# 	elif key == keyboard.Key.left:    b.move(3)
# 	elif key == keyboard.Key.shift:
# 		print("\nThinking...")
# 		start = perf_counter()
# 		path = b.solve()
# 		print(perf_counter() - start)
#
# 		for m in path:
# 			print(b.display())
# 			b.move("URDL".index(m))
#
# 	print(b.display())
# 	return True

#if __name__ == '__main__':
main()
