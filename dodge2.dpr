program dodge2;

uses
  Forms,
  dodge in 'dodge.pas' {Terrain},
  DodgeClass in 'DodgeClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Dodge';
  Application.CreateForm(TTerrain, Terrain);
  Application.Run;
end.
