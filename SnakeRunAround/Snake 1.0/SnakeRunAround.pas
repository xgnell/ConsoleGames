uses crt;
type thanran = record x,y:integer; end;
var  ran:array[1..1000] of thanran;
     x,y,i,diem,x1,y1,x2,y2,dairan,tocdo:integer;
     dch,tan,tloi,hdtan,hdran:char;
     chedo,tuychon,lchonn,mran,camthanh,cngonngu,gamemode,demcua,cbando:byte;
label batdau;
const aba = 1;

procedure mauran;
begin
clrscr;
textcolor(cyan);

if cngonngu=1 then begin
gotoxy(30,8);write('CHON MAU RAN');
textcolor(blue);gotoxy(31,10);write('1 - Xanh lam');
textcolor(green);gotoxy(31,11);write('2 - Xanh luc');
textcolor(cyan);gotoxy(31,12);write('3 - Xanh lo');
textcolor(red);gotoxy(31,13);write('4 - Do');
textcolor(magenta);gotoxy(31,14);write('5 - Tim');
textcolor(yellow);gotoxy(31,15);write('6 - Vang');
textcolor(white);gotoxy(31,16);write('7 - Trang');
textcolor(green);gotoxy(31,20);write('Chon mau : ');read(mran);
end
else begin
gotoxy(30,8);write('SNAKE COLOR');
textcolor(blue);gotoxy(31,10);write('1 - Blue');
textcolor(green);gotoxy(31,11);write('2 - Green');
textcolor(cyan);gotoxy(31,12);write('3 - Cyan');
textcolor(red);gotoxy(31,13);write('4 - Red');
textcolor(magenta);gotoxy(31,14);write('5 - Magenta');
textcolor(yellow);gotoxy(31,15);write('6 - Yellow');
textcolor(white);gotoxy(31,16);write('7 - White');
textcolor(green);gotoxy(31,20);write('Choose color : ');read(mran);
end;

readln;
end;

procedure veran;
begin
case mran of
  1:textcolor(blue);
  2:textcolor(green);
  3:textcolor(cyan);
  4:textcolor(red);
  5:textcolor(magenta);
  6:textcolor(yellow);
  7:textcolor(white)
  else textcolor(cyan);
end;
for i:=1 to dairan do
begin
gotoxy(ran[i].x,ran[i].y);write(hdran);
end;
end;

procedure xoaran;
begin
for i:=1 to dairan do
begin
if hdran=#0 then hdran:='o';
gotoxy(ran[i].x,ran[i].y);write(' ');
end;
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
if lchonn=1 then tocdo:=200;
if lchonn=2 then tocdo:=150;
if lchonn=3 then tocdo:=100;
if lchonn=4 then tocdo:=50;
if lchonn=5 then tocdo:=15;
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
readln;
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
readln;
end;

procedure chonamthanh;
begin
repeat
clrscr;
textcolor(cyan);
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
until (camthanh=1)or(camthanh=2);
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
readln;
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
gotoxy(35,20);write('Chon che do : ');
end
else begin
gotoxy(36,8);write(' GAME MODE');
textcolor(white);
gotoxy(33,10);write('<1> - Classic');
gotoxy(33,11);write('<2> - Campaign');
gotoxy(35,20);write('Select mode : ');
end;
readln(gamemode);
until (gamemode=1)or(gamemode=2);
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
readln(cbando);
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



BEGIN {------------------------------------------------------}
clrscr;
if cngonngu=0 then cngonngu:=1;       {Cai dat mac dinh}
if camthanh=0 then camthanh:=2;
if gamemode=0 then gamemode:=1;
if cbando=0 then cbando:=1;
if lchonn=0 then tocdo:=200;
textcolor(green);
gotoxy(34,12);write('Loading...');       {Phan loading de vao game}
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
gotoxy(36,13);write('100%');delay(900);
clrscr;
textcolor(yellow);
gotoxy(30,10);write('@ - GAME PROGRAMING');delay(1300);
batdau: repeat
clrscr;
amthanh;
textcolor(cyan);gotoxy(30,8);write('GAME SNAKE RUN AROUND');
textcolor(green);
        if cngonngu=1 then begin
                 gotoxy(35,10);write('1 - Choi');
                 gotoxy(35,11);write('2 - Tuy chon');
                 gotoxy(35,12);write('3 - Diem cao');
                 gotoxy(35,13);write('4 - Thong tin');
                 gotoxy(35,14);write('5 - Thoat');
                 gotoxy(32,20);write('Chon chuc nang : ');end
          else
               begin
                 gotoxy(35,10);write('1 - Play');
                 gotoxy(35,11);write('2 - Select');
                 gotoxy(35,12);write('3 - High Score');
                 gotoxy(35,13);write('4 - About');
                 gotoxy(35,14);write('5 - Exit');
                 gotoxy(32,20);write('Choose function : ');
               end;
readln(chedo);

if chedo=1 then
begin
 clrscr;
 randomize;

                                               {khai bao cac thong so}
 x:=10;y:=10;
 diem:=0;
 vekhung;
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


 while (aba = 1) do
  begin
   textcolor(yellow);

   if cngonngu=1 then begin
   gotoxy(67,2);write('DIEM : ',diem);        {Viet cac thong tin len man hinh}
   gotoxy(67,4);write('P: Tam dung');
   gotoxy(67,6);write('Do kho :');
   gotoxy(67,8);write('Che do game :');
   end
   else begin
   gotoxy(67,2);write('SCORE : ',diem);
   gotoxy(67,4);write('P: Pause');
   gotoxy(67,6);write('Level :');
   gotoxy(67,8);write('Game mode :');
   end;

   case lchonn of
     1:begin gotoxy(68,7);write('Beginner'); end;
     2:begin gotoxy(68,7);write('Easy'); end;
     3:begin gotoxy(68,7);write('Medium'); end;
     4:begin gotoxy(68,7);write('Hard'); end;
     5:begin gotoxy(68,7);write('Super hard'); end
     else gotoxy(68,7);write('Beginner');
   end;

   case gamemode of
     1:begin gotoxy(68,9);write('Mode 1'); end;
     2:begin gotoxy(68,9);write('Mode 2'); end;
   end;

                                              {thiet lap thong so cho ran}
   ran[1].x:=x;
   ran[1].y:=y;
   for i:= dairan downto 2 do
    begin
     ran[i].x:=ran[i-1].x;ran[i].y:=ran[i-1].y;
    end;


   veran;                                         {ve ran}
   delay(tocdo);                                {toc do ran}
   xoaran;

   textcolor(red);
   gotoxy(x1,y1);write(hdtan);
   textcolor(white);
                                              {doc chuyen dong}
   if keypressed then dch:=readkey;
   if dch=chr(97) then x:=x-1;
   if dch=chr(100) then x:=x+1;
   if dch=chr(115) then y:=y+1;
   if dch=chr(119) then y:=y-1;
   if (dch=#27) then goto batdau;                    {tro ve menu}


   if gamemode=1 then                          {Kiem tra ran an}
   if (x=x1)and(y=y1) then
    begin
     amthanh;
     diem:=diem+1;
     dairan:=dairan+1;
     repeat
     x1:=random(60)+5;
     y1:=random(22)+2;
     until (x1>2)and(x1<64)and(y1>2)and(y1<24);
    end;

   if gamemode=2 then
   begin
   if (x=x1)and(y=y1) then
    begin
     amthanh;
     diem:=diem+1;
     dairan:=dairan+1;
     demcua:=demcua+1;
        if demcua<50 then
       begin
        x1:=random(60)+5;
        y1:=random(22)+2;
       end
       else
       begin
         x2:=random(60)+5;
         y2:=random(22)+2;
         gotoxy(x2,y2);write(#219);
       end;
     end;
   if (x=x2)and(y=y2) then
     begin
      amthanh;
      diem:=diem+1;
      demcua:=0;
      delay(200);
      { Ban chien thang}
      clrscr;textcolor(white);gotoxy(32,10);if cngonngu=1 then write('BAN DA THANG !') else write(' ! YOU WIN !');
      delay(800);goto batdau;
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
   if (x<2)or(x>64)or(y<2)or(y>24) then
    begin
     veran;delay(500);
     clrscr;amthanh;
     textcolor(green);

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
  end; {het che do 1}

if chedo=2 then
  begin
   clrscr;
   textcolor(cyan);

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
   gotoxy(30,18);write('9 - Chon che do choi');
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
   gotoxy(30,18);write('9 - Select game modes');
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
  end;

if chedo=3 then
begin
clrscr;
textcolor(yellow);
gotoxy(30,10);if cngonngu=1 then write('DIEM CUA BAN : ',diem) else write('YOUR SCORE : ',diem);readln;
end;

if chedo=4 then
begin
clrscr;
textcolor(cyan);

if cngonngu=1 then begin
gotoxy(33,8);write('THONG TIN');
textcolor(green);
gotoxy(27,10);write('Ten tro choi : ');textcolor(yellow);gotoxy(45,10);write('SNAKE RUN AROUND');
textcolor(green);
gotoxy(27,11);write('Phien ban : 1.0');
gotoxy(27,12);write('Nha phat trien : Hoang Quoc An');
gotoxy(25,20);write('Nhan phim ENTER de tro ve Menu chinh');
end
else begin
gotoxy(33,8);write('INFORMATIONS');
textcolor(green);
gotoxy(27,10);write('Name : ');textcolor(yellow);gotoxy(34,10);write('SNAKE RUN AROUND');
textcolor(green);
gotoxy(27,11);write('Version : 1.0');
gotoxy(27,12);write('Developer : Hoang Quoc An');
gotoxy(25,20);write('Press ENTER to return Menu');
end;

readln;
end;


until chedo=5;
clrscr;
textcolor(cyan);

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