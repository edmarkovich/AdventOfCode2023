program Day2;
uses SysUtils, Math;


function parseGameNumber(line: ansistring) : integer;
var
        tokens: TStringArray;
begin
        tokens := line.split(' ');
        parseGameNumber := StrToInt(tokens[1]);
end;

type ColorArray = array[0..2] of integer ;

function checkColor(line: ansistring) : ColorArray;
var
        tokens: TStringArray;
        num, max: integer;
begin
        checkColor[0] := 0;
        checkColor[1] := 0;
        checkColor[2] := 0;

        tokens := trim(line).split(' ');
        num := StrToInt(tokens[0]);
        case tokens[1] of
                'red'  : checkColor[0] := num;
                'green': checkColor[1] := num;
                'blue' : checkColor[2] := num;
        end;
end;

function checkIteration(line: ansistring) : ColorArray;
var
        tokens: TStringArray;
        i,j: integer;
        ca_one : ColorArray;
begin
        // process the individual colors of this iteration
        checkIteration[0] := 0;
        checkIteration[1] := 0;
        checkIteration[2] := 0;
        tokens := trim(line).split(',');
        for i := 0 to length(tokens)-1 do
        begin
                ca_one :=  checkColor(tokens[i]) ;
                for j := 0 to 2 do
                begin
                        checkIteration[j] := max(checkIteration[j], ca_one[j]);
                end;
        end;
end;

function processGameLine(line: ansistring) : integer;
var
        tokens,tokens2: TStringArray;
        gameNum: integer;
        i,j: integer;
        ca : ColorArray  = (0,0,0);
        ca_iter: ColorArray;
begin
        // Get the game number
        tokens := line.split(':');
        gameNum := parseGameNumber(tokens[0]);

        // Break out the iterations of this game
        tokens2 := tokens[1].split(';');
        for i := 0 to length(tokens2)-1 do
        begin
                ca_iter := checkIteration(tokens2[i]) ;
                for j := 0 to 2 do
                begin
                        ca[j] := max(ca_iter[j], ca[j]);
                end;
        end;
        processGameLine := ca[0]*ca[1]*ca[2];
end;

var
        inputFile: text;
        line: ansistring;
        sum: longint = 0;
begin


        Assign(inputFile, 'day2.input');
        reset(inputFile);

        while not eof(inputFile) do
        begin
                readln(inputFile, line);
                sum := sum + processGameLine(line);
        end;
        writeln(sum);
end.