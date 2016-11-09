# polyliners
commands = 'Home cHome sHome csHome End cEnd sEnd csEnd Left cLeft sLeft csLeft Right cRight sRight csRight Up cUp sUp csUp Down cDown sDown csDown cX cA cC cV Backspace cBackspace Del cDel sDel Enter Tab sTab c[ c]'.split()

# oneliners
commands = 'Home sHome End sEnd Left cLeft sLeft csLeft Right cRight sRight csRight cX cA cC cV Backspace cBackspace Del cDel sDel Tab sTab c[ c]'.split()

def find_word(index, delta, text):
    state = 0
    while True:
        if delta == 1:
            if index >= len(text):
                return index
            ch = text[index]
        else:
            if index <= 0:
                return 0
            ch = text[index - 1]
        if state == 0:
            if ch.isalpha():
                state = 2
            elif ch == ' ':
                state = 0
            else:
                state = 1
        elif state == 1:
            if ch.isalpha() or ch == ' ':
                return index
        elif state == 2:
            if ch.isalpha():
                state = 2
            else:
                return index
        index += delta
        if index < 0:
            return 0
        if index == len(text):
            return index


def perform(cmds, text, index=0, marker=-1, clipboard=''):
    # index tells where the cursor is. Starting with 0, ending with n, the text length.
    # mindex tells where the marker is. -1 == no marker

    digit = 0

    for command in cmds.split():

        if command == 'Home':
            index = 0
        elif command == 'sHome':
            marker = index
            index = 0

        elif command == 'cHome':
            pass
        elif command == 'csHome':
            pass

        elif command == 'End':
            index = len(text)
            marker = -1
        elif command == 'sEnd':
            marker = index
            index = len(text)

        elif command == 'cEnd':
            pass
        elif command == 'csEnd':
            pass

        elif command == 'Left':
            index -= 1
        elif command == 'sLeft':
            if marker == -1:
                marker = index
            index -= 1

        elif command == 'cLeft':
            index = find_word(index, -1, text)
        elif command == 'csLeft':
            pass

        elif command == 'Right':
            index += 1
        elif command == 'sRight':
            if marker == -1:
                marker = index
            index += 1

        elif command == 'cRight':
            index = find_word(index, 1, text)
        elif command == 'csRight':
            pass

        elif command == 'Up':
            pass
        # elif command=='cUp':
        elif command == 'sUp':
            pass
        elif command == 'csUp':
            pass

        elif command == 'Down':
            pass
        # elif command == 'cDown':
        elif command == 'sDown':
            pass
        elif command == 'csDown':
            pass

        # Clipboard
        elif command == 'cX':
            if marker == -1:
                clipboard = text
                text = ''
                index = 0
            elif index > marker:
                clipboard = text[marker:index - marker]
                text = text[:marker] + text[index:]
                marker = -1
            else:
                clipboard = text[index:marker - index]
                text = text[:index] + text[marker:]
                marker = - 1
        elif command == 'cA':
            marker = 0
            index = len(text)
        elif command == 'cC':
            if marker == -1:
                clipboard = text
            elif index > marker:
                clipboard = text[marker:index - marker]
            else:
                clipboard = text[index:marker - index]
        elif command == 'cV':
            if marker == -1:
                text = text[:index] + clipboard + text[index:]
                index += len(clipboard)
            elif marker < index:
                text = text[:marker] + text[index:]
                index = marker
                text = text[:marker] + clipboard + text[index:]
                index += len(clipboard)
                marker = -1
            else:
                text = text[:index] + text[marker:]
                text = text[:index] + clipboard + text[index:]
                index += len(clipboard)
                marker = -1

        elif command == 'Backspace':
            if index == 0:
                pass
            else:
                text = text[:index - 1] + text[index:]
                index -= 1
        elif command == 'cBackspace':  # delete word to left
            pass

        elif command == 'Del':
            if index == 0:
                text = text[1:]
            elif index < len(text):
                text = text[:index] + text[index + 1:]
        elif command == 'cDel':  # delete word to right
            pass
        elif command == 'sDel':
            pass

        elif command == 'Enter':
            pass
        elif command == 'sEnter':  # New line below current line
            pass

        elif command == 'Tab':
            pass
        elif command == 'sTab':
            pass

        elif command == 'c[':
            pass
        elif command == 'c]':
            pass

        elif command == 'Digit':
            text = text[:index] + str(digit) + text[index:]
            digit += 1
            index += 1

    # print [text, index, mindex, clipboard]
    return [text, index, marker, clipboard]


# def expand():
#     res = []
#     for command in commands:
#         res.append(perform(state, command))
#     return res

assert len(commands) == 25 # 38

# Exercises
assert find_word(0, 1, 'ab ab') == 2
assert find_word(1, 1, 'ab ab') == 2
assert find_word(2, 1, 'ab ab') == 5
assert find_word(3, 1, 'ab ab') == 5

assert find_word(0, 1, 'ab=cd') == 2
assert find_word(0, 1, ' ab = ab ') == 3
assert find_word(1, 1, ' ab = ab ') == 3
assert find_word(2, 1, ' ab = ab ') == 3
assert find_word(3, 1, ' ab = ab ') == 5
assert find_word(4, 1, ' ab = ab ') == 5
assert find_word(5, 1, ' ab = ab ') == 8
assert find_word(6, 1, ' ab = ab ') == 8

assert find_word(0, -1, 'ab ab') == 0
assert find_word(1, -1, 'ab ab') == 0
assert find_word(2, -1, 'ab ab') == 0
assert find_word(3, -1, 'ab ab') == 0
assert find_word(4, -1, 'ab cd') == 3

assert find_word(5, -1, 'ab=cd') == 3
assert find_word(0, -1, ' ab = ab ') == 0
assert find_word(1, -1, ' ab = ab ') == 0
assert find_word(2, -1, ' ab = ab ') == 1
assert find_word(3, -1, ' ab = ab ') == 1
assert find_word(4, -1, ' ab = ab ') == 1
assert find_word(5, -1, ' ab = ab ') == 4
assert find_word(6, -1, ' ab = ab ') == 4

assert perform('Digit', 'AdamBertil') == ['0AdamBertil', 1, -1, '']
assert perform('Digit', 'AdamBertil', 4) == ['Adam0Bertil', 5, -1, '']
assert perform('Del', 'AdamBertil') == ['damBertil', 0, -1, '']
assert perform('Del', 'AdamBertil', 4) == ['Adamertil', 4, -1, '']
assert perform('Del', 'AdamBertil', 10) == ['AdamBertil', 10, -1, '']
assert perform('Backspace', 'AdamBertil', 0) == ['AdamBertil', 0, -1, '']
assert perform('Backspace', 'AdamBertil', 4) == ['AdaBertil', 3, -1, '']
assert perform('Backspace', 'AdamBertil', 10) == ['AdamBerti', 9, -1, '']
assert perform('Del Digit', 'AdamBertil', 0) == ['0damBertil', 1, -1, '']
assert perform('End Backspace Digit', 'AdamBertil', 0) == ['AdamBerti0', 10, -1, '']
assert perform('Right Digit', 'AdamBertil') == ['A0damBertil', 2, -1, '']
assert perform('End Left Digit', 'AdamBertil') == ['AdamBerti0l', 10, -1, '']
assert perform('Right Right Right Right Digit End Digit', 'AdamBertil') == ['Adam0Bertil1', 12, -1, '']
assert perform('Home Right Right Right Right Digit End Digit', 'AdamBertil', 10) == ['Adam0Bertil1', 12, -1, '']

assert perform('sEnd', 'AdamBertil', 0) == ['AdamBertil', 10, 0, '']
assert perform('sEnd', 'AdamBertil', 4) == ['AdamBertil', 10, 4, '']
assert perform('sRight sRight', 'AdamBertil', 4) == ['AdamBertil', 6, 4, '']
assert perform('sLeft sLeft', 'AdamBertil', 4) == ['AdamBertil', 2, 4, '']

assert perform('sRight sRight sRight sRight', 'AdamBertil', 0) == ['AdamBertil', 4, 0, '']
assert perform('sRight sRight sRight sRight cC', 'AdamBertil') == ['AdamBertil', 4, 0, 'Adam']
assert perform('sRight sRight sRight sRight cC End', 'AdamBertil') == ['AdamBertil', 10, -1, 'Adam']
assert perform('sRight sRight sRight sRight cC End cV', 'AdamBertil') == ['AdamBertilAdam', 14, -1, 'Adam']

assert perform('sHome cC End cV', 'AdamBertil', 4) == ['AdamBertilAdam', 14, -1, 'Adam']
assert perform('sHome cC End cV cV', 'AdamBertil', 4) == ['AdamBertilAdamAdam', 18, -1, 'Adam']

assert perform('sHome cX', 'AdamBertil', 4) == ['Bertil', 0, -1, 'Adam']
assert perform('sHome cX End cV', 'AdamBertil', 4) == ['BertilAdam', 10, -1, 'Adam']
assert perform('cA', 'AdamBertil', 4) == ['AdamBertil', 10, 0, '']
assert perform('cA cC', 'AdamBertil', 4) == ['AdamBertil', 10, 0, 'AdamBertil']
assert perform('cA cC cV', 'AdamBertil', 4) == ['AdamBertil', 10, -1, 'AdamBertil']
assert perform('cA cC cV cV', 'AdamBertil', 4) == ['AdamBertilAdamBertil', 20, -1, 'AdamBertil']

assert perform('sLeft sLeft sLeft sLeft cC cV', 'AdamBertil', 4) == ['AdamBertil', 4, -1, 'Adam']

assert perform('cRight', 'ab = cd', 0) == ['ab = cd', 2, -1, '']
assert perform('cRight', 'ab = cd', 1) == ['ab = cd', 2, -1, '']
assert perform('cRight', 'ab = cd', 2) == ['ab = cd', 4, -1, '']
assert perform('cRight', 'ab = cd', 3) == ['ab = cd', 4, -1, '']
assert perform('cRight', 'ab = cd', 4) == ['ab = cd', 7, -1, '']
assert perform('cRight', 'ab = cd', 5) == ['ab = cd', 7, -1, '']
assert perform('cRight', 'ab = cd', 6) == ['ab = cd', 7, -1, '']
assert perform('cRight', 'ab = cd', 7) == ['ab = cd', 7, -1, '']

assert perform('cLeft', 'ab = cd', 0) == ['ab = cd', 0, -1, '']
assert perform('cLeft', 'ab = cd', 1) == ['ab = cd', 0, -1, '']
assert perform('cLeft', 'ab = cd', 2) == ['ab = cd', 0, -1, '']
assert perform('cLeft', 'ab = cd', 3) == ['ab = cd', 0, -1, '']
assert perform('cLeft', 'ab = cd', 4) == ['ab = cd', 3, -1, '']
assert perform('cLeft', 'ab = cd', 5) == ['ab = cd', 3, -1, '']
assert perform('cLeft', 'ab = cd', 6) == ['ab = cd', 5, -1, '']
assert perform('cLeft', 'ab = cd', 7) == ['ab = cd', 5, -1, '']
