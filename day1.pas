PROGRAM AdventOfCode2023_Day1;
USES StrUtils;

FUNCTION FirstAndLastNum(str: STRING) : integer;
VAR
        first, last, i, a: integer;
        first_pos: integer = -1;
        last_pos: integer  = -1;
        digits_text: ARRAY[1..18] of STRING = (
                '1','2','3','4','5','6','7','8','9',
                'one', 'two', 'three', 'four', 'five',
                'six', 'seven', 'eight', 'nine');
BEGIN
        FOR i := 1 to length(digits_text) do
        BEGIN
                a := pos(digits_text[i], str);
                IF (a>0) AND ((first_pos = -1) OR (first_pos > a)) THEN
                BEGIN
                        first_pos := a;
                        IF first > 9 THEN first := i -9 ELSE first := i;
                END;

                a := rpos(digits_text[i], str);
                IF (a>0) AND ((last_pos = -1) OR (last_pos < a)) THEN
                BEGIN
                        last_pos := a;
                        IF last > 9 THEN last := i -9 ELSE last := i;
                END;
        END;
        FirstAndLastNum := (first*10) + last;
END;

VAR
        inputFile: text;
        line: STRING;
        sum: longint = 0;

BEGIN
        Assign(inputFile, 'day1.input');
        Reset(inputFile);

        WHILE NOT eof(inputFile) DO
        BEGIN
                readln(inputFile, line);
                sum := sum + FirstAndLastNum(line);
        END;

        close(inputFile);
        writeln(sum);
END.
