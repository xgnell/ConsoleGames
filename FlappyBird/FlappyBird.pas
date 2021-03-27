program Flappy_Bird;
uses crt;
var x,y,xcot,ycot,cscot,select,tuychon,dsdiem,xch,ych:byte;
   diem:integer;
   dch,map:char;
   ten,nhanvat:string;
   bangdiem:array[1..5] of record ten:string;diem:integer;end;
   move:boolean;
  { score:text; }
const bd=1;csdai=2;
label start;

procedure vecot;
var i:byte;
begin
{Chuong trinh con ve cac cot}
textcolor(lightgreen);
for i:=0 to cscot-1 do
begin
 gotoxy(xcot,ycot+i);write(chr(219));
 {gotoxy(xcot+1,ycot+i);write(chr(219)); }
end;
for i:=(cscot+csdai)+2 to 24 do
begin
 gotoxy(xcot,i);write(chr(219));
{ gotoxy(xcot+1,i);write(chr(219)); }
end;
end;

procedure xoacot;
var i:byte;
begin
{Chuong trinh con xoa cac cot}
for i:=0 to cscot-1 do
begin
 gotoxy(xcot,ycot+i);write(' ');
 {gotoxy(xcot+1,ycot+i);write(' '); }
end;
for i:=(cscot+csdai)+2 to 24 do
begin
 gotoxy(xcot,i);write(' ');
 {gotoxy(xcot+1,i);write(' ');}
end;
end;

procedure venvat;
begin
gotoxy(x,y);textcolor(yellow);write(chr(175));             {Ve nhan vat}
end;

procedure xoanvat;
begin
gotoxy(x,y);write(' ');             {Xoa nhan vat}
end;

procedure vekhungcanh;
var i:byte;
begin
textcolor(lightblue);
gotoxy(1,25);for i:=1 to 40 do write(chr(177));
{gotoxy(1,1);for i:=1 to 79 do write('=');   }
for i:=1 to 25 do begin gotoxy(40,i);write(chr(186)); end;
end;

procedure lost;
var i:byte;
begin
    vecot;
    venvat;
    delay(500);
    clrscr;
    gotoxy(30,10);write('Sorry! You died');
    gotoxy(33,12);write('Diem : ',diem);
    gotoxy(28,14);write('Nhap ten ban: ');readln(ten);
    {Ham quet va luu diem}
    {-------------------}
     for i:=1 to 5 do
     begin
      if (bangdiem[i].ten='') then begin bangdiem[i].ten:=ten; bangdiem[i].diem:=diem; clrscr;exit; end
      else
       begin
        if (bangdiem[i].ten<>ten) then
         begin
          if bangdiem[i].diem<diem then begin bangdiem[i].ten:=ten; bangdiem[i].diem:=diem; clrscr;exit; end

         end
        else
         begin
          if bangdiem[i].diem<diem then bangdiem[i].diem:=diem;
          clrscr;exit;
         end;
       end;
     end;      {het vong lap for}

    {-------------------}
    clrscr;
end;

procedure chonchucnang;
begin
 select:=1;{gotoxy(xch,ych);write(chr(12)); }
 dch:=readkey;
 while (dch <> chr(13)) do
 begin
 textcolor(white);
 gotoxy(xch,ych);write(chr(175));gotoxy(30,22);
 dch:=readkey;
 case dch of
  's':begin  gotoxy(xch,ych);write('  ');ych:=ych+2;select:=select+1; end;
  'w':begin  gotoxy(xch,ych);write('  ');ych:=ych-2;select:=select-1; end;
 end;
 if select=0 then begin select:=5;ych:=18;end;
 if select=6 then begin select:=1;ych:=10;end;
 end;

 dch:=' ';
end;

procedure huongdan;
begin
 clrscr;gotoxy(36,8);textcolor(lightred);
 write('HUONG DAN');textcolor(yellow);
 gotoxy(35,10);write('Nhan W de nhay'); textcolor(white);
 gotoxy(30,15);write('Nhan Enter de ve Menu');readln;
end;

procedure character;
begin
clrscr;
textcolor(white);
gotoxy(27,8);write('Chon nhan vat');
gotoxy(25,10);write(chr(1),' - Smile');
textcolor(yellow);gotoxy(25,11);write(chr(175),' - FBird');
textcolor(green);gotoxy(25,12);write(chr(64),' - Spike');
textcolor(red);gotoxy(25,13);write(chr(145),' - Cheeper');
textcolor(lightblue);gotoxy(25,14);write(chr(170),' - Iron Pilot');
gotoxy(24,16);write('Chon nhan vat cua ban : ');readln(nhanvat);
gotoxy(30,10);write('Ve : ');read(char);
readln; exit;
end;

procedure Map;
begin
clrscr;
textcolor(yellow);
gotoxy(29,8);write('Chon ban do');

gotoxy(30,10);write('Ve : ');read(maptype);
readln; exit;
end;


BEGIN       {Chuong tinh chinh ----------------------------------------}
clrscr;
{Khoi tao}
{assign(score,'FlappyBird_Package\score.out');
reset(score);
read(score,diem);
if diem=0 then rewrite(score)
else
 begin
  for dsdiem:=1 to 5 do
   while not eof(score) do
    begin
     read(score,bangdiem[dsdiem].diem)
    end;
 end;  }

{Phan cai dat mac dinh}
{---------------------}
diem:=0;
for dsdiem:=1 to 5 do begin bangdiem[dsdiem].ten:='';bangdiem[dsdiem].diem:=0; end;

case nhanvat of
 'Smile':nhanvat:=chr(1);
 'Spike':nhanvat:=chr(64);
 'Cheeper':nhanvat:=chr(145);
 'Iron Pilot':nhanvat:=chr(170)
 else nhanvat:=chr(175);
end;

textcolor(green);map:=chr(176);  {color la mau tuong trung cho map}
move:=true;{dat di chuyen mac dinh cua cot la up}
{---------------------}


{Phan gioi thieu Game}
{--------------------}
textcolor(yellow);
gotoxy(34,12);write('Loading...');       {Phan loading game}
gotoxy(36,13);write('1%');delay(200);
gotoxy(36,13);write('5%');delay(200);
gotoxy(36,13);write('10%');delay(200);
gotoxy(36,13);write('16%');delay(200);
gotoxy(36,13);write('21%');delay(200);
gotoxy(36,13);write('38%');delay(200);
gotoxy(36,13);write('45%');delay(200);
gotoxy(36,13);write('57%');delay(200);
gotoxy(36,13);write('70%');delay(200);
gotoxy(36,13);write('85%');delay(200);
gotoxy(36,13);write('99%');delay(200);
gotoxy(36,13);write('100%');delay(1000);
clrscr;
delay(50);                                   {Phan gioi thieu}
gotoxy(30,13);write('@ - GAME PROGRAMING');delay(1300);
clrscr;
delay(100);
gotoxy(35,13);write('F');delay(50);
gotoxy(36,13);write('L');delay(50);
gotoxy(37,13);write('A');delay(50);
gotoxy(38,13);write('P');delay(50);
gotoxy(39,13);write('P');delay(50);
gotoxy(40,13);write('Y');delay(50);
gotoxy(41,13);write(' ');delay(50);
gotoxy(42,13);write('B');delay(50);
gotoxy(43,13);write('I');delay(50);
gotoxy(44,13);write('R');delay(50);
gotoxy(45,13);write('D');delay(900);
gotoxy(30,14);textcolor(lightred);write('Computer Console Game');delay(700);
clrscr;
{--------------------}



{Phan menu tuy chon}
{---------------------------}
start: delay(100);textcolor(lightred);
gotoxy(30,8);write('Plappy ~ ~ ~ Bird');
 textcolor(lightgreen);
                 gotoxy(35,10);write('CHOI ');
                 gotoxy(35,12);write('TUY CHON');
                 gotoxy(35,14);write('DIEM CAO');
                 gotoxy(35,16);write('THONG TIN');
                 gotoxy(35,18);write('THOAT');
                 gotoxy(30,22);write('Chon chuc nang : Enter');
 textbackground(lightblue);textcolor(yellow); gotoxy(22,12);write('w - len');gotoxy(22,14);write('s - xuong');
  textbackground(black);
 {kiem tra chon chuc nang}
 xch:=33;ych:=10;
 chonchucnang;
{---------------------------}
if select=1 then                   {Select 1 - choi game}
begin
clrscr;
randomize;
{Khoi tao cac gia tri}
x:=15;y:=2;
xcot:=38;ycot:=1;
{csdai:=random(4)+4};cscot:=random(18)+2;
diem:=0;
{Ve cac thong so man hinh}
vekhungcanh;
gotoxy(42,2);textcolor(lightcyan);write('Diem cua ban : ',diem);
gotoxy(42,4);textcolor(yellow);write('Nhan vat : ',nhanvat);
gotoxy(42,6);textcolor(green);write('Background : ',map);   {sau nay map se la 1 block dai dien}
while (bd=1) do
 begin
  venvat;

  if diem>=50 then             {Kiem tra su di chuyen cua cot}
   begin
    if move=true then cscot:=cscot-1;          {Kiem tra huong di chuyen}
    if move=false then cscot:=cscot+1;

    if cscot=1 then move:=false;       {Kiem tra cot va tuong tren, duoi}
    if cscot=20 then move:=true;
  end;

  vecot;
 textcolor(white);
  delay(100);
  xoanvat;
  xoacot;
  if keypressed then
   begin
    dch:=readkey;
    {Kiem tra di chuyen}
    if dch='w' then y:=y-3;
    if dch=chr(9) then begin diem:=diem+10;textcolor(lightcyan);gotoxy(57,2);write(diem); end;

   end;



  {kiem tra va tuong}
  {--------------}
   if y>23 then
   begin
    lost;goto start;
   end;
  {--------------}
  {Kiem tra va cot va an diem}
  {--------------}
   if ((x=xcot)or(x=xcot+1))and((y<cscot)or(y>cscot+csdai)) then   {if(1) kiem tra va cot}
   begin
    lost;goto start;
   end
   else if (x=xcot) then                {else(2) kiem tra an diem}
   begin
    diem:=diem+1;
    { gotoxy(57,1);write('      ');}
    textcolor(lightcyan);gotoxy(57,2);write(diem);
   end;
  {--------------}
  y:=y+1;{Cho nhan vat roi}
  xcot:=xcot-1; {Cho cot di chuyen}
  {Kiem tra cot va tuong}
  if xcot<1 then
   begin
    xcot:=38;
    {csdai:=random(4)+4;}cscot:=random(18)+2;
   end;
 end;
end;                 {Het select 1}



{phan tuy chon cho cac select khac

if select=? then
begin
end;

}

if select=2 then
begin
 clrscr;
   gotoxy(33,6);write('TUY CHON');
   textcolor(lightgreen);
   gotoxy(33,8);write('Am thanh');
   gotoxy(33,10);write('Do kho');
   gotoxy(33,12);write('Ngon ngu');
   gotoxy(33,14);write('Nhan vat');
   gotoxy(33,16);write('Background');
   gotoxy(33,18);write('Huong dan');
   gotoxy(33,20);write('Che do choi');textcolor(lightred);
   gotoxy(33,22);write('Quay ve Menu');

 tuychon:=1;xch:=30;ych:=8;{gotoxy(xch,ych);write(chr(12)); }
 dch:=readkey;
 while (dch <> chr(13)) do
 begin
 textcolor(white);
 gotoxy(xch,ych);write(chr(175));gotoxy(30,24);
 dch:=readkey;
 case dch of
  's':begin  gotoxy(xch,ych);write('  ');ych:=ych+2;tuychon:=tuychon+1; end;
  'w':begin  gotoxy(xch,ych);write('  ');ych:=ych-2;tuychon:=tuychon-1; end;
 end;
 if tuychon=0 then begin tuychon:=8;ych:=22;end;
 if tuychon=9 then begin tuychon:=1;ych:=8;end;
 end;
 dch:=' ';
 {Kiem tra tuy chon}
 {-----------------}
 case tuychon of
  6:huongdan;
  8:begin clrscr;goto start end;
 end;
 {-----------------}

 clrscr;goto start;
end;

if select=4 then
begin
clrscr;
textcolor(lightcyan);
gotoxy(33,8);write('THONG TIN');
textcolor(green);
gotoxy(27,10);write('Ten tro choi : ');textcolor(yellow);gotoxy(45,10);write('FLAPPY BIRD');
textcolor(green);
gotoxy(27,11);write('Phien ban : 1.0');
gotoxy(27,12);write('Nha phat trien : Hoang Quoc An'); textcolor(lightred);
gotoxy(27,14);write('Dua tren phien ban Flappy Bird cua');
gotoxy(28,15);write('tac gia Nguyen Ha Dong.');textcolor(green);
gotoxy(25,20);write('Nhan phim ENTER de tro ve Menu chinh');
readln;clrscr;goto start;
end;

if select=3 then
begin
clrscr; textcolor(yellow);
gotoxy(37,8);write('BANG DIEM');textcolor(lightred);
for dsdiem:=1 to 4 do
 begin
  gotoxy(32,9+dsdiem);write(bangdiem[dsdiem].ten);gotoxy(50,9+dsdiem);write(bangdiem[dsdiem].diem);
 end;
gotoxy(30,18);write('Nhan Enter de tro ve Menu');readln;clrscr;goto start;
end;

if select=5 then
begin
 clrscr;textcolor(yellow);
{ for dsdiem:=1 to 5 do
  write(score,bangdiem[dsdiem].diem);
 close(score);   }
 gotoxy(20,10);write('! Cam on vi ban da trai nghiem tro choi !');
 delay(1000);halt;
end;




END.
