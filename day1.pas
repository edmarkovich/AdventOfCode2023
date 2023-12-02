program Day1_2;
uses Crt, StrUtils;

function firstAndLastNum(str: string) : integer;
var
        first, last, i, a: integer;
        first_pos: integer = -1;
        last_pos: integer  = -1;
        digits_text: array[1..18] of string = (
                '1','2','3','4','5','6','7','8','9',
                'one', 'two', 'three', 'four', 'five',
                'six', 'seven', 'eight', 'nine');
begin
        for i := 1 to length(digits_text) do
        begin
                a := pos(digits_text[i], str);

                if a>0 then
                begin
                     if (first_pos = -1) or (first_pos > a) then
                     begin
                        first_pos := a;
                        first := i;
                        if first > 9 then first := first -9;
                     end;
                end;

                a := rpos(digits_text[i], str);
                if a>0 then
                begin
                     if (last_pos = -1) or (last_pos < a) then
                     begin
                        last_pos := a;
                        last := i;
                        if last > 9 then last := last -9;
                     end;
                end;

        end;
        firstAndLastNum := (first*10) + last;
        writeln(firstAndLastNum,'     ', str);
end;

var
        inputFile: text;
        line: string;
        sum: longint;
        temp: integer;

begin
        //writeln(firstAndLastNum('sxoneightoneckk9ldctxxnffqnzmjqvj'));
        //Exit;


        ClrScr();
        sum :=0;
        Assign(inputFile, 'day1.input');
        Reset(inputFile);

        while not eof(inputFile) do
        begin
                readln(inputFile, line);
                sum := sum + firstAndLastNum(line);
        end;

        close(inputFile);
        writeln(sum);

end.
