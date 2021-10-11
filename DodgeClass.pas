unit DodgeClass;

interface

uses
  sysutils, Windows, Classes, ExtCtrls, Graphics, Contnrs, Forms, Controls,
  Messages, Dialogs;

type
  visu_entree = class(tpanel)
  public
    nom: string;
    ox: integer;
    oy: integer;
    procedure Panel1Mousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    constructor create(AOwner: TComponent);
  end;
  
  ennemi = class(tpanel)
  public
    direction: integer;
    vitesse: integer;
    function gettouch(tutu: visu_entree): boolean;
    procedure bouge(AOwner: TComponent; deca: integer;listpion:tobjectlist);
    constructor create(AOwner: TComponent; direction: integer; vitesse: integer); reintroduce;
  end;

  ami = class(tpanel)
  public
    direction: integer;
    vitesse: integer;
    function gettouch(tutu: visu_entree): boolean;
    procedure bouge(AOwner: TComponent; deca: integer;listpion:tobjectlist);
    constructor create(AOwner: TComponent; direction: integer; vitesse: integer); reintroduce;
  end;

implementation

constructor ennemi.create(AOwner: TComponent; direction: integer; vitesse: integer);
begin
  inherited create(aowner);
  self.direction := direction;
  self.vitesse := vitesse;
  randomize;
  top := random(776);
  randomize;
  left := random(953);

  case direction of
    0: begin self.Top := 775; end;
    1: begin self.Top := 1; end;
    2: begin self.left := 952; end;
    3: begin self.left := 1; end;
  end;
  randomize;
  height := 20 + random(20);
  randomize;
  width := 20 + random(20);
  color := clred;
  Visible := true;
end;

constructor ami.create(AOwner: TComponent; direction: integer; vitesse: integer);
begin
  inherited create(aowner);
  self.direction := direction;
  self.vitesse := vitesse;
  randomize;
  top := random(776);
  randomize;
  left := random(953);

  case direction of
    0: begin self.Top := 775; end;
    1: begin self.Top := 1; end;
    2: begin self.left := 952; end;
    3: begin self.left := 1; end;
  end;
  randomize;
  height := 20 + random(20);
  randomize;
  width := 20 + random(20);
  color := clblack;
  Visible := true;
end;

procedure ennemi.bouge(AOwner: TComponent; deca: integer;listpion:tobjectlist);
begin
  if self.vitesse = 0 then vitesse := 1;
  case self.direction of
    0: self.Top := self.Top - vitesse;
    1: self.Top := self.Top + vitesse;
    2: self.left := self.left - vitesse;
    3: self.left := self.left + vitesse;
  end;
  if (self.top + height < 0) or (self.top > 776) or (self.left + width < 0) or (self.left > 953) then
    listpion.remove(self);
end;

procedure ami.bouge(AOwner: TComponent; deca: integer;listpion:tobjectlist);
begin
  if self.vitesse = 0 then vitesse := 1;
  case self.direction of
    0: self.Top := self.Top - vitesse;
    1: self.Top := self.Top + vitesse;
    2: self.left := self.left - vitesse;
    3: self.left := self.left + vitesse;
  end;
  if (self.top + height < 0) or (self.top > 776) or (self.left + width < 0) or (self.left > 953) then
    listpion.remove(self);
end;

constructor visu_entree.Create(AOwner: TComponent);
begin
  inherited create(aowner);
  height := 40; width := 40;
  color := clblue;
  onmousemove := Panel1MouseMove;
  onmousedown := Panel1Mousedown;
end;

procedure visu_entree.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if shift = [ssLeft] then
    begin
      if (top + y - oy > 0) and (top + height + y < tform(self.owner).Height - 5) then
        Top := top + y - oy;
      if (left + x - ox > 0) and (left + width - ox + x < tform(self.owner).width - 5) then
        left := left + x - ox;
    end;
end;

procedure visu_entree.Panel1Mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ox := x;
  oy := y;
end;

function ennemi.gettouch(tutu: visu_entree): boolean;
begin
  result := false;
  if ((top + Height >= tutu.Top) and (top < tutu.top)) or ((top <= tutu.Top + tutu.Height) and (top > tutu.Top))
    then
    if ((left + width >= tutu.left) and (left < tutu.left)) or ((left <= tutu.left + tutu.width) and (left > tutu.left))
      then
      result := true;
end;

function ami.gettouch(tutu: visu_entree): boolean;
begin
  result := false;
  if ((top + Height >= tutu.Top) and (top < tutu.top)) or ((top <= tutu.Top + tutu.Height) and (top > tutu.Top))
    then
    if ((left + width >= tutu.left) and (left < tutu.left)) or ((left <= tutu.left + tutu.width) and (left > tutu.left))
      then
      result := true;
end;

end.

