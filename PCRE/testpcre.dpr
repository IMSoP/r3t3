program testpcre;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  pcre;

var
  ax : pcre.IRegex;
  mystr : string = 'I''m yours uyouyl';

begin
  { TODO -oUser -cConsole Main : Insert code here }
  ax := pcre.RegexCreate('ur');
  if ax.IsMatch(mystr) then  writeln(ax.Match(mystr).Value);
end.
