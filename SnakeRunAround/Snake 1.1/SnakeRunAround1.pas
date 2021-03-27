uses crt;
type thanran = record x,y:byte; end;
var  ran:array[1..1000] of thanran;
     bomb:array[1..31] of record x,y:byte; end;
     x,y,i,j,diem,x1,y1,x2,y2,dairan,tocdo:integer;
     dch,tan,tloi,hdtan,hdran:char;
     chedo,tuychon,lchonn,mran,camthanh,cngonngu,gamemode,cbando,xch,ych,quaman:byte;
     time,demtgian,soluongbomb:byte;
label batdau,playgame;
const aba = 1;

procedure mauran;
begin
clrscr;
textcolor(cyan);

if cngonngu=1 then begin
gotoxy(30,8);write('CHON MAU RAN');
textcolor(lightblue);gotoxy(31,10);write('1 - Xanh lam');
textcolor(lightgreen);gotoxy(31,11);write('2 - Xanh luc');
textcolor(lightcyan);gotoxy(31,12);write('3 - Xanh lo');
textcolor(red);gotoxy(31,13);write('4 - Do');
textcolor(magenta);gotoxy(31,14);write('5 - Tim');
textcolor(yellow);gotoxy(31,15);write('6 - Vang');
textcolor(white);gotoxy(31,16);write('7 - Trang');
textcolor(white);gotoxy(31,17);write('8 - Tang hinh');
textcolor(white);gotoxy(31,18);write('9 - Bay sac');
textcolor(green);gotoxy(31,20);write('Chon mau : ');read(mran);
end
else begin
gotoxy(30,8);write('SNAKE COLOR');
textcolor(lightblue);gotoxy(31,10);write('1 - Blue');
textcolor(lightgreen);gotoxy(31,11);write('2 - Green');
textcolor(lightcyan);gotoxy(31,12);write('3 - Cyan');
textcolor(red);gotoxy(31,13);write('4 - Red');
textcolor(magenta);gotoxy(31,14);write('5 - Magenta');
textcolor(yellow);gotoxy(31,15);write('6 - Yellow');
textcolor(white);gotoxy(31,16);write('7 - White');
textcolor(white);gotoxy(31,17);write('8 - Tang hinh');
textcolor(white);gotoxy(31,18);write('9 - Bay sac');
textcolor(green);gotoxy(31,20);write('Choose color : ');read(mran);
end;

readln;  exit;
end;

procedure veran;
begin
case mran of
  1:textcolor(lightblue);
  2:textcolor(lightgreen);
  3:textcolor(lightcyan);
  4:textcolor(red);
  5:textcolor(magenta);
  6:textcolor(yellow);
  7:textcolor(white);
  9:begin
     textcolor(random(14)+1);
    end;
  else textcolor(cyan);
end;
{for i:=1 to dairan do
begin
gotoxy(ran[i].x,ran[i].y);write(hdran);
end; }
gotoxy(ran[1].x,ran[1].y);write(hdran);
if mran=8 then begin gotoxy(ran[dairan].x,ran[dairan].y);write(hdran); end;
end;

procedure xoaran;
begin
{for i:=1 to dairan do
begin
gotoxy(ran[i].x,ran[i].y);write(' ');
end;}
if mran=8 then begin gotoxy(ran[1].x,ran[1].y);write(' '); end;
gotoxy(ran[dairan].x,ran[dairan].y);write(' ');
end;

procedure vekhung;
var j:integer;
begin
textcolor(white);
gotoxy(1,1);
for j:=1 to 65 do write(#177);
gotoxy(1,25);
for j:=1 to 65 do write(#177);
for j:=2 to 24 do
begin
gotoxy(1,j);write(#177);
gotoxy(65,j);write(#177);
end;
end;

procedure vekhung2;
var j:integer;
begin
textcolor(white);
gotoxy(1,1);
for j:=1 to 65 do write('_');
gotoxy(1,25);
for j:=1 to 65 do write(#196);
for j:=2 to 24 do
begin
gotoxy(1,j);write(#179);
gotoxy(65,j);write(#179);
end;
end;

procedure ctocdo;
begin
clrscr;
textcolor(yellow);
gotoxy(34,8);if cngonngu=1 then write('DO KHO') else write('LEVEL'); textcolor(green);
gotoxy(30,10);write('<1> Beginner');
gotoxy(30,11);write('<2> Easy');
gotoxy(30,12);write('<3> Medium');
gotoxy(30,13);write('<4> Hard');
gotoxy(30,14);write('<5> Super hard');
gotoxy(30,20);if cngonngu=1 then write('Chon do kho : ') else write('Choose level : ');readln(lchonn);
if lchonn=1 then tocdo:=160;
if lchonn=2 then tocdo:=130;
if lchonn=3 then tocdo:=97;
if lchonn=4 then tocdo:=50;
if lchonn=5 then tocdo:=15;
exit;
end;

procedure hinhdangthucan;
begin
clrscr;
textcolor(yellow);
if cngonngu=1 then begin
gotoxy(27,8);write('HINH DANG THUC AN');
gotoxy(30,10);write('Ve : ');read(hdtan);
end
else begin
gotoxy(29,8);write('FOOD SHAPE');
gotoxy(30,10);write('Draw : ');read(hdtan);
end;
readln; exit;
end;

procedure hinhdangran;
begin
clrscr;
textcolor(yellow);
if cngonngu=1 then begin
gotoxy(29,8);write('HINH DANG RAN');
gotoxy(30,10);write('Ve : ');read(hdran);
end
else begin
gotoxy(29,8);write('SNAKE SHAPE');
gotoxy(30,10);write('Draw : ');read(hdran);
end;
readln; exit;
end;

procedure chonamthanh;
begin
repeat
clrscr;
textcolor(lightcyan);
if cngonngu=1 then begin
gotoxy(36,8);write('AM THANH');textcolor(green);
gotoxy(37,10);write('1 - Bat');
gotoxy(37,11);write('2 - Tat');
gotoxy(36,20);write('Chon : ');
end
else begin
gotoxy(37,8);write('SOUND');textcolor(green);
gotoxy(37,10);write('1 - On');
gotoxy(37,11);write('2 - Off');
gotoxy(36,20);write('Choose : ');
end;
read(camthanh);
until (camthanh=1)or(camthanh=2); exit;
end;

procedure amthanh;
begin
if camthanh=1 then
begin
sound(512);nosound;
end;
end;

procedure huongdan;
begin
clrscr;
textcolor(yellow);
if cngonngu=1 then begin
gotoxy(36,8);
write('HUONG DAN');textcolor(white);
gotoxy(35,10);write('Di chuyen : ');
gotoxy(37,14);write('   W  ');
gotoxy(37,15);write('A     D');
gotoxy(37,16);write('   S');textcolor(green);
gotoxy(27,20);write('Nhan ENTER de tro ve menu chinh');
end
else begin
gotoxy(32,8);
write('GAME INTRUCTIONS');textcolor(white);
gotoxy(35,10);write('Move : ');
gotoxy(37,14);write('   W  ');
gotoxy(37,15);write('A     D');
gotoxy(37,16);write('   S');textcolor(green);
gotoxy(27,20);write('Press ENTER to return Menu');
end;
readln;exit;
end;

procedure ngonngu;
begin
repeat
clrscr;
textcolor(yellow);gotoxy(36,8);if cngonngu=1 then write('NGON NGU') else write('LANGUAGE');textcolor(white);
gotoxy(33,10);write('<1> - Tieng Viet');
gotoxy(33,11);write('<2> - English'); textcolor(green);
gotoxy(36,20);if cngonngu=1 then write('Chon : ') else write('Choose : ');readln(cngonngu);
until (cngonngu=1)or(cngonngu=2);
exit;
end;

procedure chedogame;
begin
repeat
clrscr;textcolor(yellow);
if cngonngu=1 then begin
gotoxy(36,8);write('CHE DO GAME');
textcolor(white);
gotoxy(33,10);write('<1> - Kinh dien');
gotoxy(33,11);write('<2> - Chien dich');
gotoxy(33,12);write('<3> - Thoi gian');
gotoxy(33,13);write('<4> - Mua bom');
gotoxy(35,20);write('Chon che do : ');
end
else begin
gotoxy(36,8);write(' GAME MODE');
textcolor(white);
gotoxy(33,10);write('<1> - Classic');
gotoxy(33,11);write('<2> - Campaign');
gotoxy(33,12);write('<3> - Time down');
gotoxy(33,13);write('<4> - Bomb rain');
gotoxy(35,20);write('Select mode : ');
end;
readln(gamemode);
until (gamemode=1)or(gamemode=2)or(gamemode=3)or(gamemode=4);
exit;
end;

procedure bandogame;
begin
clrscr;textcolor(yellow);
if cngonngu=1 then begin
gotoxy(37,8);write('BAN DO');textcolor(white);
gotoxy(33,10);write('<1> - Trong');
gotoxy(33,11);write('<2> - Tuyet');
gotoxy(33,12);write('<3> - Song bac');
gotoxy(33,13);write('<4> - Nha hat');
gotoxy(33,14);write('<5> - Long dat');
gotoxy(33,15);write('<6> - Biet thu');
gotoxy(33,16);write('<7> - Vu tru');
gotoxy(30,20);write('Chon ban do : ');
end
else begin
gotoxy(37,8);write(' MAP');textcolor(white);
gotoxy(33,10);write('<1> - Empty');
gotoxy(33,11);write('<2> - Snow');
gotoxy(33,12);write('<3> - Casino');
gotoxy(33,13);write('<4> - Opera house');
gotoxy(33,14);write('<5> - Earth');
gotoxy(33,15);write('<6> - Mansion');
gotoxy(33,16);write('<7> - Universe');
gotoxy(30,20);write('Choose map : ');
end;
readln(cbando);exit;
end;

procedure vemap(kitu:char;chon:byte);
var i:byte;
begin
randomize;
for i:=1 to 60 do
begin
  if chon=1 then begin
     gotoxy(random(60)+5,random(22)+2);
     write(kitu);end;
  if chon=2 then begin
     gotoxy(random(60)+5,random(22)+2);
          if random(3)=0 then write(#3);
          if random(3)=1 then write(#4);
          if random(3)=2 then write(#5);
          if random(3)=3 then write(#6);
     end;
  if chon=3 then begin
     gotoxy(random(60)+5,random(22)+2);
          if random(3)=0 then write(#36);
          if random(3)=1 then write('D');
          if random(3)=2 then write(#156);
          if random(3)=3 then write(#157);
     end;
end;
end;

procedure Lost;
begin
 veran;delay(500);
     clrscr;amthanh;
     textcolor(lightgreen);

     if cngonngu=1 then begin
     gotoxy(32,10);write('BAN DA THUA');
     gotoxy(30,11);write('DIEM CUA BAN : ',diem);
     gotoxy(12,13);write('Nhan ESC de thoat - Nhan phim bat ki de ve Menu chinh');
     end
     else begin
     gotoxy(32,10);write('YOU LOSE');
     gotoxy(30,11);write('YOUR SCORE : ',diem);
     gotoxy(12,13);write('Press ESC to exit - Press any key to return Menu');
     end;

     textcolor(white);
     dch:=readkey;
     if dch=#27 then
      begin
       clrscr;
       textcolor(yellow);
       gotoxy(23,10);if cngonngu=1 then write('Cam on ban da trai nghiem tro choi !') else write('    Thanks for playing my Game');
       delay(800);
       halt(1);
      end else clrscr;
       { goto batdau;}
end;

{Ham tao bomb cho mode 4: bombrain}
procedure setbomb;
var j:byte;
begin
 for j:=1 to soluongbomb do
 begin
  textcolor(lightgreen);gotoxy(bomb[j].x,bomb[j].y);write(chr(173));
 end;
end;

procedure xoabomb;
var j:byte;
begin
 for j:=1 to soluongbomb do
 begin
  if bomb[j].y>23 then begin gotoxy(bomb[j].x,bomb[j].y);write(' ');bomb[j].x:=random(62)+2;bomb[j].y:=2;  end;
   gotoxy(bomb[j].x,bomb[j].y);write(' ');
 end;
end;






BEGIN {------------------------------------------------------}
clrscr;
if cngonngu=0 then cngonngu:=1;       {Cai dat mac dinh}
if camthanh=0 then camthanh:=2;
if gamemode=0 then gamemode:=1;
if cbando=0 then cbando:=1;
if lchonn=0 then tocdo:=90;
if hdran=#0 then hdran:=chr(219);

textcolor(green);
gotoxy(34,12);write('Loading...');       {Phan loading de vao game}
gotoxy(36,13);write('1%');delay(200);
gotoxy(36,13);write('5%');delay(200);
gotoxy(36,13);write('10%');delay(200);
gotoxy(36,13);write('21%');delay(200);
gotoxy(36,13);write('38%');delay(200);
gotoxy(36,13);write('45%');delay(200);
gotoxy(36,13);write('60%');delay(200);
gotoxy(36,13);write('85%');delay(200);
gotoxy(36,13);write('100%');delay(900);
clrscr;
textcolor(yellow);
gotoxy(30,10);write('@ - GAME PROGRAMING');delay(1200);clrscr;delay(100);
textcolor(lightgreen);
gotoxy(20,5);write('  ___    _     _      _      _    _   _______ ');delay(100);
gotoxy(20,6);write(' / _ \  | \   | |    / \    | |  / | | ______|');delay(100);
gotoxy(20,7);write('| / \_| |  \  | |   / _ \   | | / /  | |      ');delay(100);
gotoxy(20,8);write('| |     |   \ | |  / / \ \  | |/ /   | |_____ ');delay(100);
gotoxy(20,9);write(' \ \    | |\ \| | | /___\ | |   /    | ______|');delay(100);
gotoxy(20,10);write('  \ \   | | \   | |  ___  | |   \    | |      ');delay(100);
gotoxy(20,11);write('   | \  | |  \  | | |   | | | |\ \   | |      ');delay(100);
gotoxy(20,12);write('|\__\ | | |   | | | |   | | | | \ \  | |_____ ');delay(100);
gotoxy(20,13);write('|_____/ |_|   |_| |_|   |_| |_|  \_\ |_______|');delay(400);textcolor(lightred);
gotoxy(37,16);write('RUN AROUND');
delay(1400);
batdau: repeat
clrscr;
amthanh;
xch:=32;ych:=10;
x:=30;y:=6;
textcolor(green);
        if cngonngu=1 then begin
                 gotoxy(35,10);write('  Choi');
                 gotoxy(35,11);write('  Tuy chon');
                 gotoxy(35,12);write('  Diem cao');
                 gotoxy(35,13);write('  Thong tin');
                 gotoxy(35,14);write('  Thoat');
                 gotoxy(32,20);write('Chon chuc nang : Enter');end
          else
               begin
                 gotoxy(35,10);write('  Play');
                 gotoxy(35,11);write('  Select');
                 gotoxy(35,12);write('  High Score');
                 gotoxy(35,13);write('  About');
                 gotoxy(35,14);write('  Exit');
                 gotoxy(32,20);write('Choose function : Enter');
               end;
dch:='a';
textcolor(lightcyan);
gotoxy(x,y);write('GAME SNAKE RUN AROUND');
while (not keypressed) do
begin
gotoxy(x,y);write('                     ');
if dch='d' then x:=x+1;
if dch='a' then x:=x-1;
if x>58 then dch:='a';
if x<2 then dch:='d';
gotoxy(x,y);write('GAME SNAKE RUN AROUND'); gotoxy(32,20);
delay(100);
end;

gotoxy(x,y);write('                     ');textcolor(lightcyan);gotoxy(30,6);write('GAME SNAKE RUN AROUND');
chedo:=1;
dch:=readkey;
while (dch <> chr(13)) do
begin
textcolor(white);
gotoxy(xch,ych);write(chr(16));gotoxy(32,20);
dch:=readkey;
case dch of
  's':begin  gotoxy(xch,ych);write('  ');ych:=ych+1;chedo:=chedo+1; end;
  'w':begin  gotoxy(xch,ych);write('  ');ych:=ych-1;chedo:=chedo-1; end;
end;
if chedo=0 then begin chedo:=5;ych:=14;end;
if chedo=6 then begin chedo:=1;ych:=10;end;
end;

if chedo=1 then
begin
 quaman:=0;
 diem:=0;
 playgame: clrscr;
 randomize;

                                               {khai bao cac thong so}
 x:=10;y:=10;

 if (gamemode=1)or((gamemode=4)and(lchonn<4)) then vekhung2 else vekhung;
 if gamemode=4 then begin soluongbomb:=1;bomb[1].x:=random(62)+2;bomb[1].y:=2; end;


 x1:=random(30)+5;
 y1:=random(20)+2;
 dairan:=4;
 if hdtan=#0 then hdtan:='*';
 dch:=chr(100);
 if cbando <> 1 then                         {Hieu ung cua map}
    begin
    case cbando of
      2:vemap(#15,1);
      3:vemap(#0,2);
      4:vemap(#14,1);
      5:vemap(#126,1);
      6:vemap(#0,3);
      7:vemap(#249,1);
    end;
    end;
     if gamemode=3 then begin time:=50;demtgian:=0;gotoxy(78,10);write(time);end;
     {so time duoc coi la do kho}

     case lchonn of
     1:begin gotoxy(68,7);write('Beginner'); end;
     2:begin gotoxy(68,7);write('Easy'); end;
     3:begin gotoxy(68,7);write('Medium'); end;
     4:begin gotoxy(68,7);write('Hard'); end;
     5:begin gotoxy(68,7);write('Super hard'); end
     else gotoxy(68,7);write('Medium');
   end;

   case gamemode of
     1:begin gotoxy(68,9);write('Mode 1'); end;
     2:begin gotoxy(68,9);write('Mode 2'); end;
     3:begin gotoxy(68,9);write('Mode 3'); end;
     4:begin gotoxy(68,9);write('Mode 4'); end;
   end;

while (aba = 1) do
  begin
   textcolor(yellow);gotoxy(80,25);

   if cngonngu=1 then begin
   gotoxy(67,2);write('DIEM : ',diem);        {Viet cac thong tin len man hinh}
   gotoxy(67,4);write('P: Tam dung');
   gotoxy(67,6);write('Do kho :');
   gotoxy(67,8);write('Che do game :');
     if gamemode=3 then begin gotoxy(67,10);write('Thoi gian: '); end;
   end
   else begin
   gotoxy(67,2);write('SCORE : ',diem);
   gotoxy(67,4);write('P: Pause');
   gotoxy(67,6);write('Level :');
   gotoxy(67,8);write('Game mode :');
     if gamemode=3 then begin gotoxy(67,10);write('     Time: '); end;
   end;

   ran[1].x:=x;
   ran[1].y:=y;
   for i:= dairan downto 2 do
    begin
     ran[i].x:=ran[i-1].x;ran[i].y:=ran[i-1].y;
    end;

                                              {thiet lap thong so cho ran}
   veran;                                      {ve ran}
    if gamemode=4 then setbomb;
   delay(tocdo);                                {toc do ran}
   xoaran;
    if gamemode=4 then
     begin
      xoabomb;
      for i:=1 to soluongbomb do bomb[i].y:=bomb[i].y+1;
     end;

   if (gamemode=1)or((gamemode=4)and(lchonn<4)) then
   begin
    for i:=2 to dairan do
    if (ran[1].x<3) then x:=64;
    if (ran[1].x>63) then x:=2;              {Tuy chinh vuot map trong mode 1}
    if (ran[1].y<3) then y:=24;
    if (ran[1].y>23) then y:=2;
   end;

   textcolor(lightred);
   gotoxy(x1,y1);write(hdtan);                 {Ve thuc an}
   textcolor(white);
                                              {doc chuyen dong}
   if keypressed then dch:=readkey;
   if dch=chr(97) then x:=x-1;
   if dch=chr(100) then x:=x+1;
   if dch=chr(115) then y:=y+1;
   if dch=chr(119) then y:=y-1;
   if (dch=#27) then goto batdau;                 {tro ve menu}

   if gamemode<>2 then                          {Kiem tra ran an}
   if (x=x1)and(y=y1) then
    begin
     amthanh;
     diem:=diem+1;
     dairan:=dairan+1;
     if gamemode=3 then begin time:=time+1;gotoxy(78,10);write('  '); gotoxy(78,10);write(time);end;
     repeat
     x1:=random(60)+5;
     y1:=random(22)+2;
     until (x1>2)and(x1<64)and(y1>2)and(y1<24);
    end;

   if gamemode=3 then
   begin
   demtgian:=demtgian+1;
   if demtgian>15 then                           {so dem tgian duoc coi la do kho}
   begin
    time:=time-1;
    gotoxy(78,10);write('  '); gotoxy(78,10);write(time);
    demtgian:=0;
   end;
    if (time<1) then begin lost; goto batdau; end;
   end;

   if gamemode=2 then
   begin
   if (x=x2)and(y=y2) then
    begin
     quaman:=quaman+1;
     if (quaman<5) then
      begin
       clrscr;textcolor(yellow);gotoxy(35,8);if cngonngu=1 then write('! QUA ~ ~ ~ MAN !') else write('! NEXT - - LEVEL ->');delay(1000);clrscr;
       if (random(7)=1) then cbando:=1;
       if (random(7)=2) then cbando:=2;
       if (random(7)=3) then cbando:=3;
       if (random(7)=4) then cbando:=4;
       if (random(7)=5) then cbando:=5;       {Dat ngau nhien map cho mode 2}
       if (random(7)=6) then cbando:=6;
       if (random(7)=7) then cbando:=7;
       goto playgame;
       end;
      if (quaman>=5) then
      begin
       amthanh;
       diem:=diem+1;
       cbando:=1;
       delay(200);
        {Ban chien thang}
       clrscr;textcolor(white);gotoxy(32,10);amthanh;if cngonngu=1 then write('BAN DA THANG !') else write(' ! YOU WIN !');
       delay(800);goto batdau;
      end;

     end;
     if (x=x1)and(y=y1) then
     begin
     amthanh;
     diem:=diem+1;
     dairan:=dairan+1;
        if (diem=20)or(diem=30)or(diem=45)or(diem=60)or(diem=85)or(diem=100) then              {So sau demcua<... la so diem toi da de qua man}
       begin
         x2:=random(60)+5;
         y2:=random(22)+2;               {Kiem tra ki tu qua man mode 2}
         gotoxy(x2,y2);write(#176);
       end
       else
       begin
         x1:=random(60)+5;
         y1:=random(22)+2;
       end;
    end;
   end;

    if gamemode=4 then           {Kiem tra va bomb trong mode 4}
    begin


     for j:=1 to dairan do
      for i:=1 to soluongbomb do
       if (ran[j].x=bomb[i].x)and(ran[j].y=bomb[i].y) then
        begin
         setbomb;                                   {Kiem tra ran va bomb}
         lost;goto batdau;
        end;

      if diem>100then soluongbomb:=30;
      if diem>90 then soluongbomb:=20;
      if diem>80 then soluongbomb:=18;
      if diem>70 then soluongbomb:=13;
      if diem>60 then soluongbomb:=10;
      if diem>50 then soluongbomb:=8;             {Kiem tra so luong bomb}
      if diem>40 then soluongbomb:=6;
      if diem>30 then soluongbomb:=5;
      if diem>20 then soluongbomb:=4;
      if diem>10 then soluongbomb:=2;

     for i:=1 to soluongbomb do
      if bomb[i].y=0 then                {Kiem tra dat toa do cho bomb moi}
       begin
        bomb[i].x:=random(62)+2;bomb[i].y:=2;
       end;

    end;


    for i:=4 to dairan do                        {kiem tra va vao ran}
    if (ran[1].x=ran[i].x)and(ran[1].y=ran[i].y) then
      begin
      amthanh;veran;delay(500);textcolor(white);
      delay(500);clrscr;gotoxy(32,10);if cngonngu=1 then write('BAN DA THUA') else write('YOU LOSE');
      gotoxy(30,11);if cngonngu=1 then write('DIEM CUA BAN : ',diem) else write('YOUR SCORE : ',diem);readln;goto batdau;
      end;

    if (dch=chr(80))or(dch=chr(112)) then       {tam dung tro choi}
    begin
    veran;
    dch:=readkey;
    xoaran;
    end;
    read;

                                                 {Kiem tra va tuong}
   {vatuong; }
   if (gamemode<>1) then
   begin
   if (x<2)or(x>64)or(y<2)or(y>24) then
    begin
     veran;delay(500);
     clrscr;amthanh;
     textcolor(lightgreen);

     if cngonngu=1 then begin
     gotoxy(32,10);write('BAN DA THUA');
     gotoxy(30,11);write('DIEM CUA BAN : ',diem);
     gotoxy(12,13);write('Nhan ESC de thoat - Nhan phim bat ki de ve Menu chinh');
     end
     else begin
     gotoxy(32,10);write('YOU LOSE');
     gotoxy(30,11);write('YOUR SCORE : ',diem);
     gotoxy(12,13);write('Press ESC to exit - Press any key to return Menu');
     end;

     textcolor(white);
     dch:=readkey;
     if dch=#27 then
      begin
       clrscr;
       textcolor(yellow);
       gotoxy(23,10);if cngonngu=1 then write('Cam on ban da trai nghiem tro choi !') else write('    Thanks for playing my Game');
       delay(800);
       halt(1);
      end else
       begin
        clrscr;
        goto batdau;
       end;
    end;

    end;

   end;

  end; {het che do 1}

if chedo=2 then
  begin
   clrscr;
   textcolor(lightcyan);

   if cngonngu=1 then begin
   gotoxy(33,8);write('TUY CHON');
   textcolor(green);
   gotoxy(30,10);write('1 - Am thanh');
   gotoxy(30,11);write('2 - Do kho');
   gotoxy(30,12);write('3 - Ngon ngu');
   gotoxy(30,13);write('4 - Ban do');
   gotoxy(30,14);write('5 - Hinh dang thuc an');
   gotoxy(30,15);write('6 - Mau ran');
   gotoxy(30,16);write('7 - Hinh dang ran');
   gotoxy(30,17);write('8 - Huong dan');
   gotoxy(30,18);write('9 - Chon che do choi');textcolor(lightred);
   gotoxy(35,20);write('Chon : ');
   end
   else begin
   gotoxy(33,8);write('SELECT');
   textcolor(green);
   gotoxy(30,10);write('1 - Sound');
   gotoxy(30,11);write('2 - Level');
   gotoxy(30,12);write('3 - Language');
   gotoxy(30,13);write('4 - Map');
   gotoxy(30,14);write('5 - Food shape');
   gotoxy(30,15);write('6 - Snake color');
   gotoxy(30,16);write('7 - Snake shape');
   gotoxy(30,17);write('8 - Game instructions');
   gotoxy(30,18);write('9 - Select game modes');textcolor(lightred);
   gotoxy(35,20);write('Choose : ');
   end;

   readln(tuychon);
   case tuychon of
      1:chonamthanh;
      2:ctocdo;
      3:ngonngu;
      4:bandogame;
      5:hinhdangthucan;
      6:mauran;
      7:hinhdangran;
      8:huongdan;
      9:chedogame;
   else goto batdau;
   end;
   goto batdau;
  end;

if chedo=3 then
begin
clrscr;
textcolor(yellow);
gotoxy(30,10);if cngonngu=1 then write('DIEM CUA BAN : ',diem) else write('YOUR SCORE : ',diem);readln;
goto batdau;
end;

if chedo=4 then
begin
clrscr;
textcolor(lightcyan);

if cngonngu=1 then begin
gotoxy(33,8);write('THONG TIN');
textcolor(green);
gotoxy(27,10);write('Ten tro choi : ');textcolor(lightred);gotoxy(45,10);write('SNAKE RUN AROUND');
textcolor(green);
gotoxy(27,11);write('Phien ban : ');gotoxy(40,11);textcolor(white);write('1.1');textcolor(green);
gotoxy(27,12);write('Nha phat trien : Hoang Quoc An');
gotoxy(27,13);write('Thuoc : @ - GAME PROGRAMMING');
gotoxy(25,20);write('Nhan phim ENTER de ve Menu chinh');
end
else begin
gotoxy(33,8);write('INFORMATIONS');
textcolor(green);
gotoxy(27,10);write('Name : ');textcolor(lightred);gotoxy(34,10);write('SNAKE RUN AROUND');
textcolor(green);
gotoxy(27,11);write('Version : ');gotoxy(39,11);textcolor(white);write('1.1');textcolor(green);
gotoxy(27,12);write('Developer : Hoang Quoc An');
gotoxy(27,13);write('By : @ - GAME PROGRAMMING');
gotoxy(25,20);write('Press ENTER to return Menu');
end;
readln;
goto batdau;
end;


until chedo=5;
clrscr;
textcolor(lightcyan);

if cngonngu=1 then begin
gotoxy(25,8);write('Ban co chac muon thoat tro choi ?');textcolor(green);
gotoxy(27,10);write('Y - Co            N - Khong');
end
else begin
gotoxy(30,8);write('Are you sure to exit ?');textcolor(green);
gotoxy(27,10);write('Y - Yes            N - No');
end;

tloi:=readkey;
if tloi='y' then
begin
clrscr;
textcolor(yellow);
gotoxy(23,10);if cngonngu=1 then write('Cam on ban da trai nghiem tro choi !') else write('    Thanks for playing my Game');
delay(1000);
halt(1);
end;
if tloi='n' then goto batdau;
END. {----------------------------------------------------------}
