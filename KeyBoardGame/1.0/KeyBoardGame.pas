program Keyboard_Game;
uses crt;

type SpecialItem = (no, sSpeed, xPoint, ice);
     WordState = (none, fall, done);

const
        ScreenWidth = 60;
        ScreenHeight = 20;
        Area = 176;
        MaxWord = 20;
        MaxLength = 7;
        InfoX = ScreenWidth+3;
        InfoY = 2;
        TypeRow = ScreenHeight+2;
        Loop = 15;
        BufferX = InfoX;
        BufferY = InfoY+10;
        DefaultTimeWait = 200;
        DefaultTimeFall = 150;
        DefaultColor = 15;
        MenuX = 20;
        MenuY = 5;



var
        Wordd:array[1..MaxWord] of record
                                  x,y:byte;
                                  length:byte;
                                  symbol:string;
                                  speed:byte;
                                  state:WordState;
                                  item:SpecialItem;
                                  color:byte;
                                  end;

        Point:word;
        TypeWord:string;
        TimeWait,Tick:byte;
        TimeFall,fallTick:byte;
        lose:boolean;


procedure InitWord;
var i:byte;
begin
 for i:=1 to MaxWord do
 begin
  Wordd[i].speed:=1;
  Wordd[i].state:=none;
  Wordd[i].item:=no;
  Wordd[i].symbol:='';
 end;
end;

procedure InitInfoTable;
begin
 gotoxy(InfoX,InfoY);
 write('Your Point: ',Point);
end;

procedure WriteInfo(x,y:byte; info:string; c:byte);
begin
 textcolor(c);
 gotoxy(x,y);
 write(info);
 textcolor(DefaultColor);
end;

procedure DeleteInfo(x,y:byte; length:byte);
var i:byte;
begin
 for i:=0 to length do
 begin
  gotoxy(x+i,y);write(' ');
 end;
end;


procedure Initialize;
begin
 InitWord;
 InitInfoTable;
 Point:=0;
 TypeWord:='';
 TimeWait:=DefaultTimeWait;
 Tick:=TimeWait;
 TimeFall:=DefaultTimeFall;
 fallTick:=TimeFall;
end;

procedure DrawScreen;
var i,j:byte;
begin
 for i:=1 to ScreenWidth do
 begin
  gotoxy(i,1);write(chr(Area));
  gotoxy(i,ScreenHeight);write(chr(Area));
 end;
 for j:=2 to ScreenHeight-1 do
 begin
  gotoxy(1,j);write(chr(Area));
  gotoxy(ScreenWidth,j);write(chr(Area));
 end;
end;

procedure DrawWord(x,y:byte; wWord:string; c:byte);
begin
 textcolor(c);
 gotoxy(x,y);
 write(wWord);
 textcolor(DefaultColor);
end;

procedure DeleteWord(x,y:byte; wWord:string);
var i:byte;
begin
 for i:=0 to length(wWord) do
 begin
  gotoxy(x+i,y);
  write(' ');
 end;
end;

procedure ResetWord(i:byte);
begin
 DeleteWord(Wordd[i].x,Wordd[i].y,Wordd[i].symbol);
 Wordd[i].speed:=1;
 Wordd[i].state:=none;
 Wordd[i].item:=no;
 Wordd[i].symbol:='';
 Wordd[i].length:=2;
 Wordd[i].y:=2;
end;

procedure StartWord;
var i,j:byte;
begin
 randomize;
 for i:=1 to MaxWord do
  if(Wordd[i].state = none) then
  begin
   Wordd[i].state:=fall;
   {Khoi tao cac gia tri}
   Wordd[i].y:= 2;
   Wordd[i].x:= random(ScreenWidth-MaxLength-2)+2;
   Wordd[i].color:= random(13)+2;
   Wordd[i].length:=random(MaxLength-2)+2;
   for j:=1 to Wordd[i].length do
   begin
    Wordd[i].symbol:=Wordd[i].symbol+chr(random(122-97)+97);
   end;
   {Draw Word ra man hinh}
   DrawWord(Wordd[i].x,Wordd[i].y,Wordd[i].symbol, Wordd[i].color);
   break;
  end;
end;

procedure WordFall;
var i:byte;
begin
 for i:=1 to MaxWord do
  if(Wordd[i].state = fall) then
  begin
   DeleteWord(Wordd[i].x,Wordd[i].y,Wordd[i].symbol);
   Wordd[i].y:=Wordd[i].y+Wordd[i].speed;
   DrawWord(Wordd[i].x,Wordd[i].y,Wordd[i].symbol, Wordd[i].color);
  end;
end;


procedure CheckPoint;
var i:byte;
begin
 (*
 {Thong bao}
 WriteInfo(BufferX,BufferY,'Ban vua nhap: ');
 WriteInfo(BufferX+1,BufferY+1,TypeWord);
 delay(1000);
 DeleteInfo(BufferX,BufferY,15);
 DeleteInfo(BufferX+1,BufferY+1,MaxLength);
 *)
 gotoxy(2,TypeRow);write('                       ');

 {Kiem tra}
 for i:=1 to MaxWord do
  if(Wordd[i].state = fall)and(TypeWord = Wordd[i].symbol) then
  begin
   {Tang diem}
   Inc(Point);
   gotoxy(InfoX+12,InfoY);
   write(Point);

   {Xoa word va thiet lap lai}
   ResetWord(i);
  end;


 {Xoa TypeWord}
 TypeWord:='';
end;

procedure PlayerType;
var p:char;
begin
  p:=readkey;
  if(ord(p) = 13) then
  begin
   CheckPoint;
  end
  else if(ord(p) = 8) then
  begin
   {Xoa ki tu}
   if(length(TypeWord) >0) then
   begin
    delete(TypeWord,length(TypeWord),1);
    gotoxy(2,TypeRow);
    write(TypeWord+' ');
   end;
  end
  else
  begin
   {Noi tu vao chuoi}
   if(length(TypeWord) <= MaxLength) then
   begin
    TypeWord:=TypeWord+p;
    gotoxy(2,TypeRow);
    write(TypeWord);
   end;
  end;
end;

procedure DrawMenu;
begin
 textcolor(yellow);
 gotoxy(MenuX,MenuY);write('A  Y KIOR W     O');
 gotoxy(MenuX,MenuY+1);write('B H  W     D   B');
 gotoxy(MenuX,MenuY+2);write('CH   DDGN   TDF');
 gotoxy(MenuX,MenuY+3);write('DJ   V       L');
 gotoxy(MenuX,MenuY+4);write('R E  B       F');
 gotoxy(MenuX,MenuY+5);write('H  C QXCB    M');
 gotoxy(MenuX,MenuY+6);write('              ');
 gotoxy(MenuX,MenuY+7);write('       BNN     RTE   DFD  DNM  DWE  ');
 gotoxy(MenuX,MenuY+8);write('       D  R   E   R D   F G  G H  E ');
 gotoxy(MenuX,MenuY+9);write('       HDG    T   T G   G E  J L   D');
 gotoxy(MenuX,MenuY+10);write('       C  DD  Y   Y HDFAJ OGH  O   F');
 gotoxy(MenuX,MenuY+11);write('       U    Y W   C Q   E P  F K  G ');
 gotoxy(MenuX,MenuY+12);write('       DUOOG   DFA  I   K K  J PRG  ');textcolor(13);
 gotoxy(MenuX,MenuY+15);write('  SPEED CHALLEGEN');
 textcolor(lightred);
 gotoxy(MenuX+3,MenuY+18);write('Press Enter Key to continue !');
 readln;
 clrscr; textcolor(lightgreen);
 gotoxy(MenuX+14,MenuY+6);write('!!! READY !!!');
 readln;
 clrscr;
 textcolor(15);
end;

procedure ResetInfo;
var i:byte;
begin
 Point:=0;
 for i:=1 to MaxWord do
 begin
  ResetWord(i);
 end;
end;

procedure YouLose;
var i:byte;
begin
 for i:=1 to MaxWord do
  if(Wordd[i].state = fall)and(Wordd[i].y>=ScreenHeight-1) then
  begin
   lose:=true;
   gotoxy(MenuX+6,MenuY+5);
   write('!!! LOSE !!! ');
   readln;
   clrscr;
   gotoxy(MenuX+6,MenuY+5);
   write('Your Point: ',Point);
   readln;
   clrscr;
   {Dua thong tin ra luu tru}

  end;
end;



BEGIN
repeat
 clrscr;
 lose:=false;
 {Ve Menu}
 DrawMenu;

 {Khoi tao }
 Initialize;
 DrawScreen;

 {Vong lap main loop}
 while (lose=false) do
 begin
  {Xu li cac su kien}



  {Su kien go phim -------------------------------------------}
  {Dat con tro ve noi go}
  gotoxy(2,TypeRow);
  {Kiem tra go phim}
  if(keypressed = true) then PlayerType;
  {-----------------------------------------------------------}

  {Su kien word fall}
  Dec(fallTick);
  if(fallTick<2) then
  begin
   fallTick:=TimeFall;
   WordFall;
  end;


  {Su kien word out}
  Dec(Tick);
  if(Tick<2) then
  begin
   Tick:=TimeWait;
   StartWord;
  end;

  YouLose;

  {Main Loop}
  delay(Loop);

 end;

until(1<>1);

 readln;
END.
