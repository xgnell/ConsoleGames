uses crt;
type
     conran = record
       thanran:array[1..1000] of record x,y:byte; end;
       mran:byte;
       dairan:integer;
       hdran:char;
       diem:integer;
       end;

var  ran:conran;                           {Khai bao ca player}
     ran2:conran;

     bomb:array[1..31] of record x,y:byte; end;  {Khai bao cac yeu to anh huong}
     item:array[1..7] of
        record
         hinh:char;  {hinh dang item}
         x,y:byte;   {toa do item}
         color:byte;
         show,an:boolean;  {tan so xuat hien}
         time:byte; {Thoi gian item ton tai}
        end;


     x,y,i,j,x2,y2,x3,y3,tocdo:integer;            {Khai bao bien su dung}
     dch,dchcu,dch2,dchcu2,tloi:char;
     chedo,tuychon,lchonn,camthanh,cngonngu,gamemode,cbando,xch,ych,quaman:byte;
     time,demtgian,soluongbomb,xuathien:byte;
     multiplayer,gtricu:byte;
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
textcolor(green);gotoxy(31,20);write('Chon mau ran : ');read(ran.mran);
if multiplayer<>1 then begin
textcolor(green);gotoxy(31,21);write('Chon mau ran 2 : ');read(ran2.mran); end;
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
textcolor(green);gotoxy(31,20);write('Choose color snake : ');read(ran.mran);
if multiplayer<>1 then begin
textcolor(green);gotoxy(31,21);write('Choose color snake 2 : ');read(ran2.mran); end;
end;
exit;
end;

procedure veran(rannao:conran);
begin
case rannao.mran of
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
gotoxy(rannao.thanran[1].x,rannao.thanran[1].y);write(rannao.hdran);
if rannao.mran=8 then begin gotoxy(rannao.thanran[rannao.dairan].x,rannao.thanran[rannao.dairan].y);write(rannao.hdran); end;
end;

procedure xoaran(rannao:conran);
begin
{for i:=1 to dairan do
begin
gotoxy(ran[i].x,ran[i].y);write(' ');
end;}
if rannao.mran=8 then begin gotoxy(rannao.thanran[1].x,rannao.thanran[1].y);write(' '); end;
gotoxy(rannao.thanran[rannao.dairan].x,rannao.thanran[rannao.dairan].y);write(' ');
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
for j:=1 to 65 do write('_');
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
gotoxy(30,10);write('Ve : ');read(item[1].hinh);
end
else begin
gotoxy(29,8);write('FOOD SHAPE');
gotoxy(30,10);write('Draw : ');read(item[1].hinh);
end;
readln; exit;
end;

procedure hinhdangran;
begin
 clrscr;
 textcolor(yellow);
 if cngonngu=1 then
 begin
  gotoxy(29,8);write('HINH DANG RAN');
   if multiplayer<>1 then
   begin
    gotoxy(30,11);write('Ve ran 2 : ');readln(ran2.hdran);
   end;
   gotoxy(30,10);write('Ve ran : ');readln(ran.hdran);
 end
 else
 begin
  gotoxy(29,8);write('SNAKE SHAPE');
   if multiplayer<>1 then
   begin
    gotoxy(30,11);write('Draw snake 2 : ');readln(ran2.hdran);
   end;
   gotoxy(30,10);write('Draw snake : ');readln(ran.hdran);
 end;
exit;
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
gotoxy(27,12);write(' Nguoi choi 1');
gotoxy(30,14);write('   W  ');
gotoxy(30,15);write('A     D');
gotoxy(30,16);write('   S');

gotoxy(42,12);write(' Nguoi choi 2');
gotoxy(45,14);write('   I  ');
gotoxy(45,15);write('J     L');
gotoxy(45,16);write('   K');
textcolor(green);
gotoxy(27,20);write('Nhan ENTER de tro ve menu chinh');
end
else begin
gotoxy(32,8);
write('GAME INTRUCTIONS');textcolor(white);
gotoxy(39,10);write('Move : ');
gotoxy(29,12);write(' Player 1');
gotoxy(30,14);write('   W  ');
gotoxy(30,15);write('A     D');
gotoxy(30,16);write('   S');

gotoxy(43,12);write(' Player 2');
gotoxy(45,14);write('   I  ');
gotoxy(45,15);write('J     L');
gotoxy(45,16);write('   K');
textcolor(green);
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
 veran(ran);if multiplayer<>1 then veran(ran2); delay(500);
     clrscr;amthanh;
     textcolor(lightgreen);

     if cngonngu=1 then begin
     gotoxy(32,10);write('BAN DA THUA');
     gotoxy(30,11);write('DIEM CUA BAN : ',ran.diem);
     if multiplayer<>1 then begin
      gotoxy(30,11);write('DIEM Nguoi choi 1 : ',ran.diem);
      gotoxy(30,12);write('DIEM Nguoi choi 2 : ',ran2.diem);
     end;
     gotoxy(12,14);write('Nhan ESC de thoat - Nhan phim bat ki de ve Menu chinh');
     end
     else begin
     gotoxy(32,10);write('YOU LOSE');
     gotoxy(30,11);write('YOUR SCORE : ',ran.diem);
     if multiplayer<>1 then begin
      gotoxy(30,11);write('Player 1 score : ',ran.diem);
      gotoxy(30,12);write('Player 2 score : ',ran2.diem);
     end;
     gotoxy(12,14);write('Press ESC to exit - Press any key to return Menu');
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

procedure vethucan(inao:byte);
begin
 textcolor(item[inao].color);
 gotoxy(item[inao].x,item[inao].y);write(item[inao].hinh);
end;

{procedure xoathucan(inao:byte);
begin
 gotoxy(item[inao].x,item[inao].y);write(' ');
end; }

procedure kiemtraranan(var rannao:conran; ran,agi:byte);
var it:byte;
begin
 if (rannao.thanran[1].x=item[2].x)and(rannao.thanran[1].y=item[2].y) then
  begin
     amthanh;
     if (agi=2) then begin
       it:=random(8);
      if it=0 then  begin rannao.diem:=rannao.diem+5;gotoxy(67,14);write('Item +5 score');delay(500);gotoxy(67,14);write('             ');delay(500);end;
      if it=1 then  begin rannao.diem:=rannao.diem+10;gotoxy(67,14);write('Item +10 score');delay(500);gotoxy(67,14);write('              ');delay(500); end;
      if it=2 then  begin rannao.diem:=rannao.diem*2;gotoxy(67,14);write('Item x2 score');delay(500);gotoxy(67,14);write('             ');delay(500);end;
      if it=3 then  agi:=3;
      if it=4 then  agi:=4;
      if it=5 then  agi:=5;
      if it=6 then  agi:=6;
      if it=7 then  agi:=7;
      if it=8 then  agi:=8;
      {if random(7):=5 then  agi:=3;  } {Cu dung agi:=?? . Sau do o duoi tinh sau}

      {else rannao.diem:=rannao.diem+1;}end;
      xuathien:=xuathien+1;
      rannao.dairan:=rannao.dairan+1;
     if gamemode=3 then begin time:=time+1;gotoxy(78,10);write('  '); gotoxy(78,10);write(time);end;

     if agi=2 then begin xuathien:=0;item[2].an:=true;item[2].show:=false; end else item[2].an:=false;
     if agi=3 then
        begin
         item[3].time:=200;gtricu:=tocdo;
         tocdo:=tocdo-50;
         item[3].show:=true;textcolor(lightred);
         gotoxy(67,14);write('Item +speed');delay(500);
         gotoxy(67,14);write('T.gian: ',item[3].time);delay(100);
        end;
     if agi=4 then
        begin
         item[4].time:=30;gtricu:=tocdo;
         tocdo:=tocdo+100;
         item[4].show:=true;textcolor(lightgreen);
         gotoxy(67,14);write('Item -speed');delay(500);
         gotoxy(67,14);write('T.gian: ',item[4].time);delay(100);
        end;
     if agi=5 then
        begin
         item[5].time:=100;
         if ran=1 then item[5].show:=true;
         if ran=2 then item[5].an:=true;
         gtricu:=rannao.mran;
         rannao.mran:=random(15);
         textcolor(white);
         gotoxy(67,14);write('Item color');delay(500);
         gotoxy(67,14);write('T.gian: ',item[5].time);delay(100);

        end;
     if agi=6 then
     if rannao.diem>5 then begin
         if (ran=1) then item[6].show:=true;
         if (ran=2) then item[6].an:=true;
         rannao.diem:=rannao.diem-5;
         textcolor(yellow);
         gotoxy(67,14);write('Item -score');delay(800);
         gotoxy(67,14);write('           ');
     end else rannao.diem:=rannao.diem+1;
     if agi=7 then
     if (rannao.dairan>3) then begin
         if (ran=1) then item[7].show:=true;
         if (ran=2) then item[7].an:=true;
         rannao.dairan:=rannao.dairan-3;
         textcolor(lightmagenta);
         gotoxy(67,14);write('Item -long');delay(800);
         gotoxy(67,14);write('          ');

     end else rannao.diem:=rannao.diem+1;
     if agi=8 then
     begin
        if ran=1 then item[8].show:=true;
        if ran=2 then item[8].an:=true;
         rannao.dairan:=rannao.dairan+5;
         textcolor(lightblue);
         gotoxy(67,14);write('Item +long');delay(800);
         gotoxy(67,14);write('          ');

     end;
     item[2].x:=random(61)+2;item[2].y:=random(22)+2;xuathien:=0;
     item[2].show:=false;
     item[2].an:=true;

    { item[2].show:=false;}
     {xuathien:=0;item[2].an:=true; }
   end;

end;

procedure kiemtraanitem(i:byte);
begin
if item[i].show=true then
   begin
    item[i].time:=item[i].time-1;
    gotoxy(75,14);write(item[i].time,'  ');
    if item[i].time<1 then
   begin
    if (i=3)or(i=4) then tocdo:=gtricu;
    if i=5 then ran.mran:=gtricu;
    item[i].show:=false;gotoxy(67,14);write('          ');
   end;
   end;
if (multiplayer<>1)and(item[i].an=true) then
   begin
    item[i].time:=item[i].time-1;
    gotoxy(75,14);write(item[i].time,'  ');
    if item[i].time<1 then
   begin
    if (i=3)or(i=4) then tocdo:=gtricu;
    if i=5 then ran2.mran:=gtricu;
    item[i].an:=false;gotoxy(67,14);write('          ');
   end;
   end;

end;

procedure kiemtravatuong(rannao:conran);
begin
lost;
{ if (gamemode<>1) then   }
  { if (rannao.thanran[1].x<2)or(rannao.thanran[1].x>64)or(rannao.thanran[1].y<2)or(rannao.thanran[1].y>24) then }
    { veran(rannao);delay(500);
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
        {goto batdau; }
        exit;
       end;}
end;



BEGIN {------------------------------------------------------}
clrscr;
if cngonngu=0 then cngonngu:=1;       {Cai dat mac dinh}
if camthanh=0 then camthanh:=2;
if gamemode=0 then gamemode:=1;
if cbando=0 then cbando:=1;
if lchonn=0 then tocdo:=90;
if ran.hdran=#0 then ran.hdran:=chr(219);
if multiplayer=0 then multiplayer:=1;

textcolor(lightgreen);
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
textcolor(lightmagenta);
gotoxy(20,5);write('  ___    _     _      _      _    _   _______ ');delay(100);
gotoxy(20,6);write(' / _ \  | \   | |    / \    | |  / | | ______|');delay(100);
gotoxy(20,7);write('| / \_| |  \  | |   / _ \   | | / /  | |      ');delay(100);
gotoxy(20,8);write('| |     |   \ | |  / / \ \  | |/ /   | |_____ ');delay(100);
gotoxy(20,9);write(' \ \    | |\ \| | | /___\ | |   /    | ______|');delay(100);
gotoxy(20,10);write('  \ \   | | \   | |  ___  | |   \    | |      ');delay(100);
gotoxy(20,11);write('   | \  | |  \  | | |   | | | |\ \   | |      ');delay(100);
gotoxy(20,12);write('|\__\ | | |   | | | |   | | | | \ \  | |_____ ');delay(100);
gotoxy(20,13);write('|_____/ |_|   |_| |_|   |_| |_|  \_\ |_______|');delay(400);textcolor(lightred);
gotoxy(37,16);write('RUN AROUND ');delay(500);textcolor(white);gotoxy(48,16);write('1.2');
delay(1400);
batdau: repeat
clrscr;
amthanh;
{Dat moi thu ve ban dau}
for i:=1 to 8 do item[i].time:=0;
for j:=2 to 8 do begin item[j].show:=false;item[j].an:=false;end;
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
textcolor(lightgray);
gotoxy(x,y);write('GAME SNAKE RUN AROUND');
while (not keypressed) do
begin
gotoxy(x,y);write('                     ');
if (dch='d')or(dch='D') then x:=x+1;
if (dch='a')or(dch='A') then x:=x-1;
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
 ran.diem:=0;if multiplayer<>1 then ran2.diem:=0;
 playgame: clrscr;
 randomize;
 textcolor(lightcyan);
 if gamemode<>2 then begin
 if cngonngu=1 then begin
 gotoxy(33,10);write('Mot nguoi choi');
 gotoxy(33,11);write('Hai nguoi choi (Survival)');
 gotoxy(33,12);write('Hai nguoi choi (Battle)');
 {gotoxy(33,13);write('Hai nguoi choi (Dau boss)'); }
 end
 else begin
  gotoxy(33,10);write('Singer player');
  gotoxy(33,11);write('Multiplayer (Survival)');
  gotoxy(33,12);write('Multiplayer (Battle)');
  {gotoxy(33,13);write('Multiplayer (Boss fighter)');}
 end;
xch:=30;ych:=10;
multiplayer:=1;
dch:=readkey;
while (dch <> chr(13)) do
begin
textcolor(white);
gotoxy(xch,ych);write(chr(16));gotoxy(32,20);
dch:=readkey;
case dch of
  's':begin  gotoxy(xch,ych);write('  ');ych:=ych+1;multiplayer:=multiplayer+1; end;
  'w':begin  gotoxy(xch,ych);write('  ');ych:=ych-1;multiplayer:=multiplayer-1; end;
end;
if multiplayer=0 then begin multiplayer:=3;ych:=12;end;
if multiplayer=4 then begin multiplayer:=1;ych:=10;end;
end;
 clrscr;
 end;

 if (gamemode=1)or((gamemode=4)and(lchonn<4)) then vekhung2 else vekhung;
 {if (gamemode<>2) then multiplayer:=<>1; }
 {if gameplay=1 then multiplayer:=false;  }
    {Dong tren chinh sua de co cac che do multi khac}



                                               {khai bao cac thong so}
 x:=random(50)+3;y:=random(20)+3;ran.dairan:=4;
 if multiplayer<>1 then
   begin
   x3:=random(53)+3;y3:=random(17)+3;ran2.dairan:=4;if ran2.hdran=#0 then ran2.hdran:=#176;
   if ran2.mran=0 then  ran2.mran:=15;
   dch2:='l';
   end;

 if gamemode=4 then begin soluongbomb:=1;bomb[1].x:=random(62)+2;bomb[1].y:=2; end;

 {Dat tao do mac dinh cua item}
 if item[1].hinh=#0 then item[1].hinh:=#4; item[1].color:=12;
        item[1].x:=random(30)+5;item[1].y:=random(20)+2;
 item[2].hinh:='?'; item[2].color:=14;
        item[2].x:=random(30)+5;item[2].y:=random(20)+2; item[2].show:=false;item[2].an:=false;




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

   if gamemode=2 then multiplayer:=1;
   ran.thanran[1].x:=x;
   ran.thanran[1].y:=y;
   ran2.thanran[1].x:=x3;
   ran2.thanran[1].y:=y3;

while (aba = 1) do
  begin

   textcolor(yellow);gotoxy(80,25);
   if cngonngu=1 then begin
   if multiplayer=1 then begin
   gotoxy(67,2);write('DIEM : ',ran.diem,'  ');end        {Viet cac thong tin len man hinh}
   else begin
   if (ran.thanran[1].x<>0) then  begin gotoxy(67,2);write('Diem p1: ',ran.diem,'  ');end else begin textcolor(lightred);gotoxy(67,3);write('p1 teo : ',ran.diem,'  '); end;
   if (ran2.thanran[1].x<>0) then  begin gotoxy(67,3);write('Diem p2: ',ran2.diem,'  ');end else begin textcolor(lightred);gotoxy(67,3);write('p2 teo : ',ran2.diem,'  '); end;
   end;textcolor(yellow);
   gotoxy(67,4);write('P: Tam dung');
   gotoxy(67,6);write('Do kho :');
   gotoxy(67,8);write('Che do game :');
   gotoxy(67,12);if (multiplayer<>1)and(gamemode<>2) then write('Hai nguoi choi') else write('Mot nguoi choi');
     if gamemode=3 then begin gotoxy(67,10);write('Thoi gian: '); end;
   end
   else begin
   if multiplayer=1 then begin
   gotoxy(67,2);write('SCORE : ',ran.diem,'  ');end
   else begin
   if (ran.thanran[1].x<>0) then  begin gotoxy(67,2);write('Score p1: ',ran.diem,'  ');end else begin textcolor(lightred);gotoxy(67,3);write('p1 died : ',ran.diem,'  '); end;
   if (ran2.thanran[1].x<>0) then  begin gotoxy(67,3);write('Score p2: ',ran2.diem,'  ');end else begin textcolor(lightred);gotoxy(67,3);write('p2 died : ',ran2.diem,'  '); end;
   end;textcolor(yellow);
   gotoxy(67,4);write('P: Pause');
   gotoxy(67,6);write('Level :');
   gotoxy(67,8);write('Game mode :');
   gotoxy(67,12);if (multiplayer<>1)and(gamemode<>2) then write('Multiplayer') else write('Singer player');
     if gamemode=3 then begin gotoxy(67,10);write('     Time: '); end;
   end;

  { readln;}

   ran.thanran[1].x:=x;
   ran.thanran[1].y:=y;
   for i:= ran.dairan downto 2 do
    begin
     ran.thanran[i].x:=ran.thanran[i-1].x;ran.thanran[i].y:=ran.thanran[i-1].y;
    end;
   if (multiplayer<>1)and(ran2.thanran[1].x<>0) then begin
   ran2.thanran[1].x:=x3;
   ran2.thanran[1].y:=y3;
   for i:= ran2.dairan downto 2 do
    begin
     ran2.thanran[i].x:=ran2.thanran[i-1].x;ran2.thanran[i].y:=ran2.thanran[i-1].y;
    end;
   end else for i:= ran2.dairan downto 2 do
    begin
     ran2.thanran[i].x:=0;ran2.thanran[i].y:=0;
    end;

   {readln;}
                                   {thiet lap thong so cho ran}
   veran(ran);if (multiplayer<>1)and(ran2.thanran[1].x<>0) then veran(ran2);          {ve ran}
    if gamemode=4 then setbomb;
   delay(tocdo);                                {toc do ran}
   xoaran(ran);if (multiplayer<>1)and(ran2.thanran[1].x<>0) then xoaran(ran2);
    if gamemode=4 then
     begin
      xoabomb;
      for i:=1 to soluongbomb do bomb[i].y:=bomb[i].y+1;
     end;
   { readln; }

   if (gamemode=1)or((gamemode=4)and(lchonn<4)) then
   begin
   { for i:=2 to ran.dairan do }
    if (ran.thanran[1].x<2) then begin x:=65;vekhung2;end;
    if (ran.thanran[1].x>64) then begin x:=2;vekhung2;end; {Tuy chinh vuot map trong mode 1}
    if (ran.thanran[1].y<2) then begin y:=25;vekhung2;end;
    if (ran.thanran[1].y>24) then begin y:=2;vekhung2;end;
   if (multiplayer<>1)and(ran2.thanran[1].x<>0) then begin
    if (ran2.thanran[1].x<2) then begin x3:=65;vekhung2;end;
    if (ran2.thanran[1].x>64) then begin x3:=2;vekhung2;end;              {Tuy chinh vuot map trong mode 1}
    if (ran2.thanran[1].y<2) then begin y3:=25;vekhung2;end;
    if (ran2.thanran[1].y>24) then begin y3:=2;vekhung2;end; end;
   end;

  { readln;}


   vethucan(1);        {Ve thuc an}

   if xuathien>7 then
    begin
     if item[2].an=true then
     begin item[2].x:=random(61)+2;item[2].y:=random(22)+2;xuathien:=0;  end;
     item[2].show:=true;
    end;
   if item[2].show=true then vethucan(2);

   {readln; }

    textcolor(white);
                                              {doc chuyen dong}
   if keypressed then begin dchcu2:=dch2;dchcu:=dch;dch:=readkey; end;
   {Bien tloi su dung tam thoi}
   if (dch=#27) then goto batdau;                 {tro ve menu}
   if (dch='a')and(dchcu='d') then dch:=dchcu;    {Kiem tra nguoc huong}
   if (dch='d')and(dchcu='a') then dch:=dchcu;
   if (dch='w')and(dchcu='s') then dch:=dchcu;
   if (dch='s')and(dchcu='w') then dch:=dchcu;
   if multiplayer<>1 then
   begin
    if (dch=#106)or(dch=#108)or(dch=#105)or(dch=#107)then
    begin
    dch2:=dch; dch:=dchcu;
    if (dch2='j')and(dchcu2='l') then dch2:=dchcu2;   { Kiem tra nguoc huong cho p2}
    if (dch2='l')and(dchcu2='j') then dch2:=dchcu2;
    if (dch2='i')and(dchcu2='k') then dch2:=dchcu2;
    if (dch2='k')and(dchcu2='i') then dch2:=dchcu2;

    end;
        if (dch=chr(97)) then x:=x-1 ;
        if (dch=chr(100)) then x:=x+1  ;
        if (dch=chr(119)) then y:=y-1  ;
        if (dch=chr(115)) then y:=y+1  ;
     if (ran2.thanran[1].x<>0) then begin
        if (dch2=#106)or(dch=#74) then x3:=x3-1;
        if (dch2=#108)or(dch=#76) then x3:=x3+1;
        if (dch2=#105)or(dch=#73) then y3:=y3-1;
        if (dch2=#107)or(dch=#75) then y3:=y3+1;end else dch2:=#0;

    end;
    if multiplayer=1 then
    begin
        if (dch=chr(97)) then x:=x-1 ;
        if (dch=chr(100)) then x:=x+1 ;
        if (dch=chr(119)) then y:=y-1 ;
        if (dch=chr(115)) then y:=y+1 ;
    end;

   {readln;}

   if gamemode<>2 then begin                         {Kiem tra ran an}
   if (x=item[1].x)and(y=item[1].y) then
    begin
     amthanh;
     ran.diem:=ran.diem+1;xuathien:=xuathien+1;
     ran.dairan:=ran.dairan+1;
     if gamemode=3 then begin time:=time+1;gotoxy(78,10);write('  '); gotoxy(78,10);write(time);end;
     repeat
     item[1].x:=random(60)+5;
     item[1].y:=random(22)+2;
     until (item[1].x>2)and(item[1].x<64)and(item[1].y>2)and(item[1].y<24);
    end;
   if (multiplayer<>1)and(ran2.thanran[1].x<>0) then begin
    if (x3=item[1].x)and(y3=item[1].y) then
    begin
     amthanh;
     ran2.diem:=ran2.diem+1;xuathien:=xuathien+1;
     ran2.dairan:=ran2.dairan+1;
     if gamemode=3 then begin time:=time+1;gotoxy(78,10);write('  '); gotoxy(78,10);write(time);end;
     repeat
     item[1].x:=random(60)+5;
     item[1].y:=random(22)+2;
     until (item[1].x>2)and(item[1].x<64)and(item[1].y>2)and(item[1].y<24);
    end;
   end;
   end;


   kiemtraranan(ran,1,2);
   if(multiplayer<>1)and(ran2.thanran[1].x<>0) then kiemtraranan(ran2,2,2);
   {Kiem tra an cac loai Item}
   if (item[2].show=false) then
   begin

   kiemtraanitem(3);kiemtraanitem(4);kiemtraanitem(5);
    if (multiplayer<>1)and(ran2.thanran[1].x<>0) then
    begin
    kiemtraanitem(3);kiemtraanitem(4);kiemtraanitem(5);
   end;
   end;

  { readln;}

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
       ran.diem:=ran.diem+1;
       cbando:=1;
       delay(200);
        {Ban chien thang}
       clrscr;textcolor(white);gotoxy(32,10);amthanh;if cngonngu=1 then write('BAN DA THANG !') else write(' ! YOU WIN !');
       delay(800);goto batdau;
      end;

     end;
     if (x=item[1].x)and(y=item[1].y) then
     begin
     amthanh;
     ran.diem:=ran.diem+1;xuathien:=xuathien+1;
     ran.dairan:=ran.dairan+1;
       { if (diem=20)or(diem=30)or(diem=45)or(diem=60)or(diem=85)or(diem=100) then }      {So sau demcua<... la so diem toi da de qua man}
       if (ran.diem>10)and(random(4)=1) then
       begin
         x2:=random(60)+5;
         y2:=random(22)+2;               {Kiem tra ki tu qua man mode 2}
         gotoxy(x2,y2);write(#176);
       end
       else
       begin
         item[1].x:=random(60)+5;
         item[1].y:=random(22)+2;
       end;
    end;
   end;

    if gamemode=4 then           {Kiem tra va bomb trong mode 4}
    begin

     for j:=1 to ran.dairan do
      for i:=1 to soluongbomb do
       if (ran.thanran[j].x=bomb[i].x)and(ran.thanran[j].y=bomb[i].y) then
        begin
         setbomb;                                   {Kiem tra ran va bomb}
         lost;goto batdau;
        end;
     if (multiplayer<>1)and(ran2.thanran[1].x<>0) then begin
     for j:=1 to ran2.dairan do
      for i:=1 to soluongbomb do
       if (ran2.thanran[j].x=bomb[i].x)and(ran2.thanran[j].y=bomb[i].y) then
        begin
         setbomb;                                   {Kiem tra ran va bomb}
         lost;goto batdau;
        end;end;

      if (ran.diem>100)or(ran2.diem>100) then soluongbomb:=30;
      if (ran.diem>90)or(ran2.diem>90) then soluongbomb:=20;
      if (ran.diem>80)or(ran2.diem>80) then soluongbomb:=18;
      if (ran.diem>70)or(ran2.diem>70) then soluongbomb:=13;
      if (ran.diem>60)or(ran2.diem>60) then soluongbomb:=10;
      if (ran.diem>50)or(ran2.diem>50) then soluongbomb:=8;             {Kiem tra so luong bomb}
      if (ran.diem>40)or(ran2.diem>40) then soluongbomb:=6;
      if (ran.diem>30)or(ran2.diem>30) then soluongbomb:=5;
      if (ran.diem>20)or(ran2.diem>20) then soluongbomb:=4;
      if (ran.diem>10)or(ran2.diem>10) then soluongbomb:=2;

     for i:=1 to soluongbomb do
      if bomb[i].y=0 then                {Kiem tra dat toa do cho bomb moi}
       begin
        bomb[i].x:=random(62)+2;bomb[i].y:=2;
       end;

    end;

    {readln;}


    for i:=4 to ran.dairan do                        {kiem tra va vao ran}
    if (ran.thanran[1].x=ran.thanran[i].x)and(ran.thanran[1].y=ran.thanran[i].y) then
      begin
      amthanh;veran(ran);if (multiplayer<>1)and(ran2.thanran[1].x<>0) then veran(ran2);
      delay(500);textcolor(white);
      delay(500);clrscr;gotoxy(32,10);if cngonngu=1 then write('BAN DA THUA') else write('YOU LOSE');
      gotoxy(30,11);if cngonngu=1 then write('DIEM CUA NGUOI CHOI : ',ran.diem) else write('PLAYER SCORE  : ',ran.diem);if multiplayer=1 then begin readln;goto batdau;end else begin delay(500);dch:=#27; end;
      end;
    if (multiplayer<>1)and(ran2.thanran[1].x<>0) then
    for i:=4 to ran2.dairan do                        {kiem tra va vao ran2}
    if (ran2.thanran[1].x=ran2.thanran[i].x)and(ran2.thanran[1].y=ran2.thanran[i].y) then
      begin
      gotoxy(32,10);if cngonngu=1 then write('BAN DA THUA') else write('YOU LOSE');
      gotoxy(30,12);if cngonngu=1 then write('DIEM CUA NGUOI CHOI 2 : ',ran2.diem) else write('PLAYER 2 SCORE : ',ran2.diem);readln;goto batdau;
      end else
      if (ran.thanran[1].x=ran.thanran[i].x)and(ran.thanran[1].y=ran.thanran[i].y) then begin readln;goto batdau;end;

    {readln; }

    {Kiem tra 2 con ran va vao nhau trong multiplayer}
   { if multiplayer=3 then
     for i:=1 to ran.dairan do
      for j:=1 to ran2.dairan do
       if (ran.thanran[i].x=ran2.thanran[j].x)and(ran.thanran[i].y=ran2.thanran[j].y) then
         begin
          ran2.thanran[1].x:=0;
         end; }

    if multiplayer=3 then
    begin
     for i:=1 to ran.dairan do
      if (ran2.thanran[1].x=ran.thanran[i].x)and(ran2.thanran[1].y=ran.thanran[i].y) then
         begin
          ran2.thanran[1].x:=0;
         end;

     for j:=1 to ran2.dairan do
      if (ran.thanran[1].x=ran2.thanran[j].x)and(ran.thanran[1].y=ran2.thanran[j].y) then
         begin
          ran.thanran[1].x:=0;
         end;
    end;

       { readln; }

    if (dch=chr(80))or(dch=chr(112)) then       {tam dung tro choi}
    begin
    veran(ran);if multiplayer<>1 then veran(ran2);
    dch:=readkey;
    xoaran(ran);if multiplayer<>1 then xoaran(ran2);
    end;
    read;

                                                 {Kiem tra va tuong}
    if (gamemode<>1)or((gamemode=4)and(lchonn>4)) then begin
    if (ran.thanran[1].x<2)or(ran.thanran[1].x>64)or(ran.thanran[1].y<2)or(ran.thanran[1].y>24) then  begin
    kiemtravatuong(ran);goto batdau;end;

    if (multiplayer<>1)and(ran2.thanran[1].x<>0) then
     if (ran2.thanran[1].x<2)or(ran2.thanran[1].x>64)or(ran2.thanran[1].y<2)or(ran2.thanran[1].y>24) then begin
      kiemtravatuong(ran2);goto batdau; end;
    end;

  { readln;}
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
gotoxy(30,10);
if cngonngu=1 then
 write('DIEM CUA BAN : ',ran.diem+ran2.diem)
 else
 write('YOUR SCORE : ',ran.diem+ran2.diem);
readln;
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
gotoxy(27,11);write('Phien ban : ');gotoxy(40,11);textcolor(lightmagenta);write('1.2');textcolor(green);
gotoxy(27,12);write('Nha phat trien : Hoang Quoc An');textcolor(yellow);
gotoxy(27,13);write('Thuoc : @ - GAME PROGRAMMING');textcolor(green);
gotoxy(25,20);write('Nhan phim ENTER de ve Menu chinh');
end
else begin
gotoxy(33,8);write('INFORMATIONS');
textcolor(green);
gotoxy(27,10);write('Name : ');textcolor(lightred);gotoxy(34,10);write('SNAKE RUN AROUND');
textcolor(green);
gotoxy(27,11);write('Version : ');gotoxy(39,11);textcolor(lightmagenta);write('1.2');textcolor(green);
gotoxy(27,12);write('Developer : Hoang Quoc An');textcolor(yellow);
gotoxy(27,13);write('By : @ - GAME PROGRAMMING');textcolor(green);
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
