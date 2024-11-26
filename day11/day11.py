



def read_input():
    galaxies = []
    with open("day11.in", "r") as file:
        row = -1
        for line in file.readlines():
            row = row + 1
            for col in range(0, len(line)):
                if line[col] == "#": galaxies.append( (row,col))
    return galaxies


def get_missing_rows(galaxies):
    rows = list(map (lambda x: x[0], galaxies))
    rows = set(range(0, max(rows))) - set(rows)
    cols = list(map (lambda x: x[1], galaxies))
    cols = set(range(0, max(cols))) - set(cols)
    return( (rows, cols) )

def get_distance(gal1, gal2, missing):
    row1 = min( gal1[0], gal2[0] )
    row2 = max( gal1[0], gal2[0] )
    col1 = min( gal1[1], gal2[1] )
    col2 = max( gal1[1], gal2[1] )

    dist = (row2-row1) + (col2-col1)

    time_factor = 1000000-1
    for row in missing[0]:
        if row1 < row < row2: dist = dist +time_factor
    for col in missing[1]:
        if col1 < col < col2: dist = dist +time_factor

    return dist

def sum_of_distances(galaxies, missing):
    sum_dist = 0
    for i in range(0, len(galaxies)-1):
        for j in range(i+1, len(galaxies)):
            sum_dist = sum_dist + get_distance(galaxies[i], galaxies[j], missing)
    return sum_dist


galaxies = read_input()
missing = get_missing_rows(galaxies)
sum_dist = sum_of_distances(galaxies,missing)

print(sum_dist)
