from pynput import keyboard
from time import sleep
from Board import Board

b = Board()

def main():
    b.shuffle()
    b.refresh()

    with keyboard.Listener(on_press=on_press) as listener:
            listener.join()

def on_press(key):
    if key == keyboard.Key.esc: return False
    elif key == keyboard.Key.up:      b.board, b.loc = b.move_up(b.board, b.loc)
    elif key == keyboard.Key.right:   b.board, b.loc = b.move_right(b.board, b.loc)
    elif key == keyboard.Key.down:    b.board, b.loc = b.move_down(b.board, b.loc)
    elif key == keyboard.Key.left:    b.board, b.loc = b.move_left(b.board, b.loc)
    elif key == keyboard.Key.shift:
        print("Thinking...")
        moves = b.solve()
        persist = True
        for m in moves:
            b.moves[m](b.board, b.loc)
            persist = b.refresh()
            sleep(1)
        return persist

    return b.refresh()

if __name__ == '__main__':
    main()
