program Day2;
uses SysUtils;


function parseGameNumber(line: ansistring) : integer;
var
        tokens: TStringArray;
begin
        tokens := line.split(' ');
        parseGameNumber := StrToInt(tokens[1]);
        writeln('Game number ', parseGameNumber);
end;

function checkColor(line: ansistring) : boolean;
var
        tokens: TStringArray;
        num, max: integer;
begin
    tokens := trim(line).split(' ');
    num := StrToInt(tokens[0]);
    case tokens[1] of
        'red'  : max := 12;
        'green': max := 13;
        'blue' : max := 14;
    else
        writeln('WTF color ', tokens[1]);
    end;

    writeln(tokens[1],' ',num, ' ', max);
    checkColor := num <= max;
end;

function checkIteration(line: ansistring) : boolean;
var
        tokens: TStringArray;
        i: integer;
begin
        // process the individual colors of this iteration
        tokens := trim(line).split(',');
        for i := 0 to length(tokens)-1 do
        begin
                if not checkColor(tokens[i]) then
                begin
                        checkIteration := false;
                        Exit
                end
        end;
        checkIteration := true;
end;

function processGameLine(line: ansistring) : integer;
var
        tokens,tokens2: TStringArray;
        gameNum: integer;
        i: integer;
begin
        // Get the game number
        tokens := line.split(':');
        gameNum := parseGameNumber(tokens[0]);

        // Break out the iterations of this game
        writeln('Iterations before split by ;', tokens[1]);
        tokens2 := tokens[1].split(';');
        writeln('Iterations.... ', length(tokens2));
        for i := 0 to length(tokens2)-1 do
        begin
                writeln('Iteration ', i, ' ', tokens2[i]);
                if not checkIteration(tokens2[i]) then
                begin
                        processGameLine := 0;
                        Exit
                end
        end;
        processGameLine := gameNum;
end;

var
        line1: ansistring = 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green' ;
        line2: ansistring = 'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue'  ;
        line3: ansistring = 'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red' ;
        line4: ansistring = 'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red';
        line5: ansistring = 'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'        ;
        inputFile: text;
        line: ansistring;
        sum: integer = 0;
begin
        Assign(inputFile, 'day2.input');
        reset(inputFile);

        while not eof(inputFile) do
        begin
                readld(inputFile, line);
                sum := sum + processGameLine(line);
        end;
        writeln(sum);
end.