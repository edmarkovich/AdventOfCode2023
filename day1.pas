program Day1_1;
uses Crt;

function firstAndLastNum(str: string) : integer;
var
        first: integer;
        last:  integer;
        i: integer;

begin
        first := -1;

        for i := 1 to length(str) do
        begin
                if str[i] in ['0' .. '9'] then
                begin
                        if first = -1 then
                                first := ord(str[i]) - ord('0');
                        last := ord(str[i]) - ord('0');
                end
        end ;
        firstAndLastNum := (first*10) + last;
end;

var
        inputFile: text;
        line: string;
        sum: longint;
        temp: integer;

begin
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
