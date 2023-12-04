PROGRAM ADventOfCode2023_Day2;
USES SysUtils, Math;


FUNCTION parseGameNumber(line: ansistring) : integer;
VAR
        tokens: TStringArray;
BEGIN
        tokens := line.split(' ');
        parseGameNumber := StrToInt(tokens[1]);
END;

TYPE ColorArray = array[0..2] of integer ;

FUNCTION checkColor(line: ansistring) : ColorArray;
VAR
        tokens: TStringArray;
        num, max: integer;
BEGIN
        checkColor[0] := 0;
        checkColor[1] := 0;
        checkColor[2] := 0;

        tokens := trim(line).split(' ');
        num := StrToInt(tokens[0]);
        CASE tokens[1] OF
                'red'  : checkColor[0] := num;
                'green': checkColor[1] := num;
                'blue' : checkColor[2] := num;
        END;
END;

FUNCTION checkIteration(line: ansistring) : ColorArray;
VAR
        tokens: TStringArray;
        i,j: integer;
        ca_one : ColorArray;
BEGIN
        // process the individual colors OF this iteration
        checkIteration[0] := 0;
        checkIteration[1] := 0;
        checkIteration[2] := 0;
        tokens := trim(line).split(',');
        FOR i := 0 TO length(tokens)-1 DO
        BEGIN
                ca_one :=  checkColor(tokens[i]) ;
                FOR j := 0 TO 2 DO
                BEGIN
                        checkIteration[j] := max(checkIteration[j], ca_one[j]);
                END;
        END;
END;

FUNCTION processGameLine(line: ansistring) : integer;
VAR
        tokens,tokens2: TStringArray;
        gameNum: integer;
        i,j: integer;
        ca : ColorArray  = (0,0,0);
        ca_iter: ColorArray;
BEGIN
        // Get the game number
        tokens := line.split(':');
        gameNum := parseGameNumber(tokens[0]);

        // Break out the iterations OF this game
        tokens2 := tokens[1].split(';');
        FOR i := 0 to length(tokens2)-1 DO
        BEGIN
                ca_iter := checkIteration(tokens2[i]) ;
                FOR j := 0 TO 2 DO
                BEGIN
                        ca[j] := max(ca_iter[j], ca[j]);
                END;
        END;
        processGameLine := ca[0]*ca[1]*ca[2];
END;

VAR
        inputFile: text;
        line: ansistring;
        sum: longint = 0;
BEGIN


        Assign(inputFile, 'day2.input');
        reset(inputFile);

        WHILE NOT eof(inputFile) DO
        BEGIN
                readln(inputFile, line);
                sum := sum + processGameLine(line);
        END;
        close(inputFile);
        writeln(sum);
END.
