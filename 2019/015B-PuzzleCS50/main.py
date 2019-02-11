from pynput import keyboard
from time import perf_counter
from Board import Board

b = Board()

def main():
	b.shuffle()
	print(b.display())
	with keyboard.Listener(on_press=on_press) as listener: listener.join()

def on_press(key):
	if key == keyboard.Key.esc: return False
	elif key == keyboard.Key.up:      b.move(0)
	elif key == keyboard.Key.right:   b.move(1)
	elif key == keyboard.Key.down:    b.move(2)
	elif key == keyboard.Key.left:    b.move(3)
	elif key == keyboard.Key.shift:
		print("\nThinking...")
		start = perf_counter()
		path = b.solve()
		print(perf_counter() - start)

		for m in path:
			print(b.display())
			b.move("URDL".index(m))

	print(b.display())
	return True

if __name__ == '__main__':
	main()
