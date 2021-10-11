unit dodge;

interface

uses
  sysutils, Windows, Classes, ExtCtrls, Graphics, Contnrs, Forms, Controls,
  Messages, Dialogs, Dodgeclass, StdCtrls;

type
  TTerrain = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Label1: TLabel;
    procedure init;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  end;

var
  Terrain: TTerrain;
  r: visu_entree;
  ee: ennemi;
  aa: ami;
  decc, temps,nb: integer;
  listpion, listami: tobjectlist;

implementation

{$R *.dfm}

procedure TTerrain.FormCreate(Sender: TObject);
begin
  init;
end;

procedure TTerrain.Timer1Timer(Sender: TObject);
var
  i: integer;
  temp: ennemi;
  temp1: ami;
begin
  for i := listpion.count - 1 downto 0 do
    begin
      temp := ennemi(listpion[i]);
      temp.bouge(self, 0,listpion);
      if temp.gettouch(r) then
        begin
          timer2.Enabled := false;
          timer1.Enabled := false;
          timer3.Enabled := false;
          if application.messagebox('Restart game?', 'Dodge', MB_OKCANCEL) = 1
          then
            begin
              init; timer1.Enabled := true; break;
            end;
        end;
    end;
  for i := listami.count - 1 downto 0 do
    begin
      temp1 := ami(listami[i]);
      temp1.bouge(self, 0,listami);
      if temp1.gettouch(r) then
        begin
          temps := temp1.Height * temp1.Width + temps;
          listami.remove(temp1);
          inc(nb);
          label1.Caption:='Score '+inttostr(temps)+#13+inttostr(nb)+' Carrés touchés';

        end;
    end;

end;

procedure TTerrain.init;
begin
  temps := 0;
  nb:=0;
  if not Assigned(listami) then listami := TObjectList.Create
  else
    listami.Clear;
  if not Assigned(listpion) then listpion := TObjectList.Create
  else
    listpion.Clear;
  if not assigned(r) then
    begin
      r := visu_entree.create(self); r.parent := self;
    end;
  r.Top := self.Height div 2;
  r.left := self.Width div 2;
  timer3.Enabled := true;
  timer2.Enabled := true;
  timer1.Enabled := true;
end;

procedure TTerrain.Timer2Timer(Sender: TObject);
begin
  randomize;
  ee := ennemi.create(self, random(4), random(10));
  ee.parent := self;
  listpion.Add(ee);
end;

procedure TTerrain.Timer3Timer(Sender: TObject);

begin
  randomize;
  aa := ami.create(self, random(4), random(10));
  aa.parent := self;
  listami.Add(aa);
end;

end.

