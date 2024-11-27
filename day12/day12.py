



def does_pattern_match(string, checksum):
    pattern = []
    counting = 0

    for i in range(0, len(string)):
        if string[i] == ".":
            if counting > 0:
                pattern.append(counting)
                counting = 0
            continue
        counting = counting+1
    if counting > 0:
        pattern.append(counting)
    return pattern == checksum


def gen_permutations(pattern):

    if not "?" in pattern:
        return [pattern]


    return gen_permutations(pattern.replace("?",".",1))+ gen_permutations(pattern.replace("?","#",1))



def process_file():
    total = 0
    with open("day12.in", "r") as file:
        for line in file.readlines():
            toks = line.split(" ")
            string = toks[0]
            checksum = [int(num) for num in toks[1].split(",")]

            perms = gen_permutations(string)
            perms = list(filter(lambda x: does_pattern_match(x, checksum), perms))
            total = total + len(perms)
    print(total)

process_file()
