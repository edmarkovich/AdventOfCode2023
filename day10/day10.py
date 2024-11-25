import curses

def sexy_char(char):
            if char == ".": char = " "
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

def move_and_print(stdscr, data, row, col):
    stdscr.move(row,col)
    stdscr.addstr(data[row][col])

def main(stdscr):
    data = read_into_array()
    (row,col) = find_start(data)
    move_and_print(stdscr, data, row, col)
    stdscr.refresh()
    stdscr.getch()

curses.wrapper(main)
