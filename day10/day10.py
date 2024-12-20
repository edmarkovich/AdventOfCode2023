import curses
import time
import sys
sys.setrecursionlimit(150*150)

steps = 0
realPipes = []
def sexy_char(char):
            if char == ".": char = "X"
            if char == "L": char = "╚"
            if char == "J": char = "╝"
            if char == "7": char = "╗"
            if char == "F": char = "╔"
            if char == "-": char = "═"
            if char == "|": char = "║"
            if char == "S": char = "S"
            return char


def read_into_array():
    data = []
    with open("day10.in", "r") as file:
        for line in file.readlines():
            data.append(list(map(sexy_char, line.strip())))
    return data

def find_start(data):
    for i in range (len(data)):
        for j in range (len(data[0])):
            if data[i][j]=="S": return (i,j)

def move_and_print(stdscr, data, row, col, clear = False, color=2):
    global steps
    global realPipes
    steps = steps + 1
    stdscr.move(row,col)
    if clear:
        stdscr.addstr(" ")
    else:
        stdscr.addstr(data[row][col], curses.color_pair(color))
    stdscr.refresh()
    if not clear and color == 2:
        realPipes.append((row,col))    

def go_up(stdscr, data, row, col):
    if row == 0 : return False
    row = row -1

    if data[row][col] not in "S║╔╗": return False

    move_and_print(stdscr, data, row, col, False)
    if data[row][col] == "S": return True
    if data[row][col] == "║" and go_up(stdscr, data, row, col): return True
    if data[row][col] == "╔" and go_right(stdscr, data, row, col): return True
    if data[row][col] == "╗" and go_left(stdscr, data, row, col): return True

    move_and_print(stdscr, data, row, col, True)

def go_down(stdscr, data, row, col):
    if row == len(data) : return False
    row = row +1

    if data[row][col] not in "S║╝╚": return False

    move_and_print(stdscr, data, row, col, False)
    if data[row][col] == "S": return True
    if data[row][col] == "║" and go_down(stdscr, data, row, col): return True
    if data[row][col] == "╚" and go_right(stdscr, data, row, col): return True
    if data[row][col] == "╝" and go_left(stdscr, data, row, col): return True


    move_and_print(stdscr, data, row, col, True)

def go_right(stdscr, data, row, col):
    if col == len(data[row]) : return False
    col = col +1

    if data[row][col] not in "S╝╗═": return False

    move_and_print(stdscr, data, row, col, False)
    if data[row][col] == "S": return True
    if data[row][col] == "╝" and go_up(stdscr, data, row, col): return True
    if data[row][col] == "═" and go_right(stdscr, data, row, col): return True
    if data[row][col] == "╗" and go_down(stdscr, data, row, col): return True

    move_and_print(stdscr, data, row, col, True)


def go_left(stdscr, data, row, col):
    if col == 0 : return False
    col = col -1

    if data[row][col] not in "S═╔╚": return False

    move_and_print(stdscr, data, row, col, False)
    if data[row][col] == "S": return True
    if data[row][col] == "╚" and go_up(stdscr, data, row, col): return True
    if data[row][col] == "═" and go_left(stdscr, data, row, col): return True
    if data[row][col] == "╔" and go_down(stdscr, data, row, col): return True

    move_and_print(stdscr, data, row, col, True)

def main(stdscr):
    data = read_into_array()
    curses.init_pair(1, curses.COLOR_BLUE, curses.COLOR_BLACK)
    for row in range(0, len(data)):
        for col in range (0, len(data[row])):
            move_and_print(stdscr, data, row, col, False, 1)

    curses.init_pair(2, curses.COLOR_RED, curses.COLOR_BLACK)
    (row,col) = find_start(data)

    global steps 
    steps = 0
    move_and_print(stdscr, data, row, col)
    go_down(stdscr, data, row, col)

    inner = 0
    curses.init_pair(3, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    for row in range(0, len(data)):
        inside = False
        last = ""
        for col in range (0, len(data[row])):
            if (row, col) in realPipes:
                if data[row][col] == "║":
                    inside = not inside
                elif data[row][col] in "╚╔":
                    last =  data[row][col] 
                elif data[row][col] == "╝" and last == "╔":
                    inside = not inside
                elif data[row][col] == "╗" and last == "╚":
                    inside = not inside
            if inside and (row,col) not in realPipes:
                move_and_print(stdscr, data, row, col, False, 3)
                inner = inner + 1




    steps = inner
    stdscr.getch()

curses.wrapper(main)
print(steps, steps /2)
