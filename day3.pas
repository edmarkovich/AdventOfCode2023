PROGRAM AdventOfCode2023_Day3;
USES Crt, Character, SysUtils;

TYPE
        SymbolArray = array of array of boolean;
VAR
        inputFile: text;
        symbols:   SymbolArray;


(* This block loads the symbol locations into 'symbols' *)
PROCEDURE processInputLine(line: shortstring);
VAR
        line_len: integer;
        arr_len : integer;
        i       : integer;
        is_sym  : boolean;
BEGIN
        arr_len  := length(symbols);
        line_len := length(line);
        SetLength(symbols, arr_len+1, line_len);

        FOR i:=1 TO line_len DO
        BEGIN
                is_sym := not (isDigit(line[i]) or (line[i] = '.'));
                symbols[arr_len][i-1] := is_sym;
        END;
END;

PROCEDURE loadSymbolLocations();
VAR
        line:      shortstring;
BEGIN
        reset(inputFile);
        WHILE NOT eof(inputFile) DO
        BEGIN
                readln(inputFile, line);
                processInputLine(line);
        END;
END;

FUNCTION isAdjacentToSymbol(row, colStart, colEnd: integer) : boolean;
VAR
        i: integer;
BEGIN
        isAdjacentToSymbol:= false;

        // If we're not at the very start of the line, check for adjacency and consider
        // Diagonals later on
        IF colStart >0 THEN
        BEGIN
                colStart := colStart - 1;
                if symbols[row][colStart] THEN isAdjacentToSymbol := true;
        END;

        // If we're not at the very END of the line, check for adjacency and consider
        // Diagonals later on
        IF colEnd < length(symbols[0])-1 THEN
        BEGIN
                colEnd := colEnd+ 1;
                if symbols[row][colEnd] THEN isAdjacentToSymbol := true;
        END;

        // Check adjacencies above
        IF row>0 THEN
        BEGIN
                for i := colStart TO colEnd DO
                BEGIN
                        IF symbols[row-1][i] THEN isAdjacentToSymbol := true;
                        //writeln(row-1, ' ', i,' ', symbols[row-1][i] );
                END
        END;

        // Check adjacencies bellow
        IF row<length(symbols)-1 THEN
        BEGIN
                for i := colStart TO colEnd DO
                BEGIN
                        IF symbols[row+1][i] THEN isAdjacentToSymbol := true;
                        //writeln(row+1, ' ', i,' ', symbols[row+1][i] );
                END
        END;

END;

FUNCTION sumOfPartNums() : longint;
VAR
        row : integer =-1;
        i   : integer;
        line: shortstring;
        accum: shortstring = '';
        num:  integer;
        numStart: integer;

BEGIN
        sumOfPartNums := 0;
        reset(inputFile);
        WHILE NOT eof(inputFile) DO
        BEGIN
                row := row +1;
                readln(inputFile, line);
                FOR i := 1 TO length(line) DO
                BEGIN
                        IF isDigit(line[i]) THEN
                        BEGIN
                                if accum = '' THEN numStart := i;
                                accum := accum + line[i]
                        END
                        ELSE
                                IF accum <> '' THEN
                                BEGIN
                                        num := StrToInt(accum);
                                        accum := '';
                                        if isAdjacentToSymbol(row, numStart-1, i-2) THEN
                                        BEGIN
                                                sumOfPartNums := sumOfPartNums + num;
                                        END;
                                END
                END;

                IF (accum <> '') AND isAdjacentToSymbol(row, numStart-1, length(line)-1) THEN
                BEGIN
                        num := StrToInt(accum);
                        sumOfPartNums := sumOfPartNums + num;
                        accum := '';
                END
        END;
END;



(* MAIN *)
BEGIN
        ClrScr;

        Assign(inputFile, 'day3.input');

        loadSymbolLocations();
        writeln(sumOfPartNums());

        close(inputFile);

END.
