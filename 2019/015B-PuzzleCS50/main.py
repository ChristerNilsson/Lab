from pynput import keyboard
from time import perf_counter
from Board import Board,pretty

b = Board()

def main():
	b.shuffle()
	print(pretty(b.path))
	b.refresh()
	with keyboard.Listener(on_press=on_press) as listener:
		listener.join()

def on_press(key):
	if key == keyboard.Key.esc: return False
	elif key == keyboard.Key.up:      b.move(0)
	elif key == keyboard.Key.right:   b.move(1)
	elif key == keyboard.Key.down:    b.move(2)
	elif key == keyboard.Key.left:    b.move(3)
	elif key == keyboard.Key.shift:
		print("Thinking...")
		start = perf_counter()
		moves = b.solve()
		print(pretty(moves),len(moves))
		print(perf_counter() - start)

		for m in moves:
			print(b)
			b.move(m)

	return b.refresh()

if __name__ == '__main__':
	main()
