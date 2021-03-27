#include<iostream>
#include<conio.h>
#include<ctime>
#include<stdio.h>
#include<fstream>
#include "Lib\Console_Game_Engine_1_0.h"
#include<mmsystem.h> // Phai include thu vien windows.h vao de su dung duoc cac kieu du lieu cua winapi

// PlaySound(TEXT("D:\\jarvisload.wav"),NULL, SND_ASYNC);
// --> Choi am nhac
/*
	Project phai co linker -lwinmm thi moi co the choi nhac
*/

//#pragma comment(lib, "winmm.lib")

using namespace std;

#define MainScreenWidth 80
#define MainScreenHeight 25

#define MaxObject 1000
#define GameLoop 10
#define DefaultTickMax 17
#define DefaultTimer 60
#define DefaultColor 15
#define DefaultMaxThings 30
#define NumberOfInfo 4
#define MenuParts 5
#define MaxRank 5

enum ObjectState {
	wait, out, destroyed
};
// take la co the hung, notake: hung la chet, none: chi de khien nguoi choi de nham lan -> tang do kho
enum ObjectAttribute {
	none, take, notake
};

enum ItemType {
	scorex15, scorexx2, scorexx3, heartx5, normal
};

/*enum MoveState {
	mUp, mDown , mLeft, mRight
};
*/

struct Menu {
	struct Title {
		char title[50];
		unsigned short int x,y;
	} mTitle;
	struct Part {
		char option[MenuParts][15];
		unsigned short int x,y;
	} mParts;
};

struct Player {
	unsigned short int x,y;
	char shape;
	unsigned short int color;
	unsigned short int length;
};

struct Object {
	unsigned short int x,y;
	char shape;
	unsigned short int color;
	unsigned short int speed;
	ObjectState state;
	ObjectAttribute attr;
	unsigned short int tickMax;
	unsigned short int tickCount;
	ItemType item;
};

struct Screen {
	unsigned short int x,y;
	unsigned short int width, height;
	unsigned short int color;
	char boder;
};

struct Arrow {
	unsigned short int x,y;
};

struct Rank {
	char name[10];
	unsigned short int score;
};




// Khai bao bien
Player player;
Object object[MaxObject];
Screen GameScreen, InfoScreen, StateScreen, DebugScreen;
Menu menu;
Arrow arrow;
Rank rank;

unsigned short int heartPoint, scorePoint;
unsigned short int WaveTimer = DefaultTimer;
unsigned short int WaveCount = WaveTimer;
bool displayDebug = false;
unsigned short int CurrentScene;
unsigned short int CurrentThings, MaxThings;
bool endScene, endGame;
fstream scoreFile;

void InitScreen() {
	// Khoi tao khu vu man hinh
	
	// GameScreen
	GameScreen.x = 0; GameScreen.y = 0;
	GameScreen.width = 60;
	GameScreen.height = 24;
	GameScreen.boder = char(176);
	GameScreen.color = 15;
	
	// InfoScreen
	InfoScreen.x = 61;
	InfoScreen.y = 0;
	InfoScreen.width = 19;
	InfoScreen.height = 17;
	InfoScreen.boder = 'O';
	InfoScreen.color = 15;
	
	// StateScreen
	StateScreen.x = 61;
	StateScreen.y = 18;
	StateScreen.width = 19;
	StateScreen.height = 6;
	StateScreen.boder = char(4);
	StateScreen.color = 15;
	
	// DebugScreen
	DebugScreen.x = 0;
	DebugScreen.y = 0;
	DebugScreen.width = 5;
	DebugScreen.height = 5;
	DebugScreen.boder = '#';
	DebugScreen.color = 12;
}

void InitPlayer() {
	// Khoi tao nhan vat
	player.x = (GameScreen.x + GameScreen.width)/2;
	player.y = (GameScreen.y + GameScreen.height - 3);
	player.shape = char(219);
	player.color = 15;
	player.length = 5;
}

void InitMenu() {
	// Khoi tao menu
	strcpy(menu.mTitle.title,"!!!~v~ @ SKY DROP @ ~v~!!!");
	menu.mTitle.x = 25; menu.mTitle.y = 10;
	strcpy(menu.mParts.option[0], "Play");
	strcpy(menu.mParts.option[1], "Rank");
	strcpy(menu.mParts.option[2], "Instruction");
	strcpy(menu.mParts.option[3], "About");
	strcpy(menu.mParts.option[4], "Exit");
	menu.mParts.x = 33; menu.mParts.y = 12;
	
	// Khoi tao Arrow
	arrow.x = menu.mParts.x-3; arrow.y = menu.mParts.y;
}

void Initialize() {
	InitScreen();
	InitPlayer();
	InitMenu();
	
	
	// Other things
	ShowCursor(false);
	scoreFile.open("Score\\score.dat", ios::in | ios::out);
	if(scoreFile.bad()) {
		cout << "Error: Can't find score.dat. Create New";
		Sleep(1000);
		scoreFile.close();
		scoreFile.open("SCore\\score.dat", ios::in | ios::out | ios::trunc);
	}
	scoreFile >> rank.name;
	scoreFile >> rank.score;
}

void Reset() {
	// Khoi tao Object
	for(unsigned short int i = 0; i<MaxObject; i++) {
		object[i].x = 0;
		object[i].y = 0;
		object[i].state = wait;
		object[i].tickMax = DefaultTickMax;
		object[i].item = normal;
	}
	
	// Other things
	TextColor(DefaultColor);
	heartPoint = 20;
	scorePoint = 0;
	CurrentScene = 1;
	MaxThings = DefaultMaxThings;
	CurrentThings = DefaultMaxThings;
	endScene = false;
	endGame = false;
}

void DrawArrow() {
	Gotoxy(arrow.x, arrow.y);
	cout << "->";
}

void DeleteArrow() {
	Gotoxy(arrow.x, arrow.y);
	cout << "  ";
}

void DrawScreen(Screen wScreen) {
	Gotoxy(wScreen.x, wScreen.y);
	TextColor(wScreen.color);
	unsigned short int startX = wScreen.x;
	unsigned short int startY = wScreen.y;
	unsigned short int X = wScreen.x + wScreen.width;
	unsigned short int Y = wScreen.y + wScreen.height;
	char Boder = wScreen.boder;
	for(unsigned short int i = wScreen.x; i<X; i++) {
		Gotoxy(i,startY);
		cout << Boder;
		Gotoxy(i,Y);
		cout << Boder;
	}
	for(unsigned short int i = wScreen.y+1; i<Y; i++) {
		Gotoxy(startX,i);
		cout << Boder;
		Gotoxy(X-1,i);
		cout << Boder;
	}
	
	TextColor(DefaultColor);
}

void DrawObject(unsigned short int x, unsigned short int y, char shape,unsigned short int color) {
	TextColor(color);
	Gotoxy(x,y);
	cout << shape;	
	TextColor(DefaultColor);
}

void DeleteObject(unsigned short int x, unsigned short int y) {
	Gotoxy(x,y);
	cout << ' ';
}

void DrawPlayer() {
	unsigned short int x = player.x, y = player.y;
	unsigned short int X = player.x + player.length;
	for(unsigned short int i = x; i<X; i++) {
		DrawObject(i,y,player.shape,player.color);
	}
}

void DeletePlayer() {
	unsigned short int x = player.x, y = player.y;
	unsigned short int X = player.x + player.length;
	for(unsigned short int i = x; i<X; i++) {
		DeleteObject(i,y);
	}
}

void DrawMenu() {
	system("cls");
	Gotoxy(menu.mTitle.x, menu.mTitle.y);
	TextColor(14);
	cout << menu.mTitle.title;
	
	TextColor(8);
	unsigned short int x = menu.mParts.x, y = menu.mParts.y;
	for(unsigned short int i = 0; i<MenuParts; i++) {
		Gotoxy(x, y+i);
		cout << menu.mParts.option[i];
	}
	
	TextColor(DefaultColor);
}

void MenuRank() {
	system("cls");
	Gotoxy(34,5);cout << "YOUR SCORE";
	Gotoxy(27,9);cout << rank.name << " " << rank.score;
	
	Gotoxy(28,20);cout << "Enter to back to Menu";
	getch();
}

void MenuInstruction() {
	system("cls");
	Gotoxy(30,5);cout << "INSTRUCTION";
	Gotoxy(15,7);cout << "Using a,d to move your player's character";
	Gotoxy(15,8);cout << "When you are playing, press p to Pause Game";
	Gotoxy(37,9);cout << "press Esc to quit current game.";
	
	TextColor(12);
	Gotoxy(0,11);
	cout << "	0..9 are useless-objects, it means, each of them doesn't have any effects or score.\n";
	cout << "	a..z are normal objects, if you get them, you will have random score.\n";
	cout << "	A..Z will decrease your heart if you crash them.\n";
	cout << "	Some special characters have special effects as x15 scores, double your current score, ...\n";
	TextColor(DefaultColor);
	
	Gotoxy(28,20);cout << "Enter to back to Menu";
	getch();
}

void MenuAbout() {
	system("cls");
	Gotoxy(33,5);cout << "ABOUT";
	Gotoxy(27,7);cout << "SKY DROP";
	Gotoxy(27,8);cout << "Author: H.Q.An";
	Gotoxy(27,9);cout << "Copyright: @Console-Game-Programming";
	Gotoxy(27,10);cout << "Version: 1.0";
	
	Gotoxy(28,20);cout << "Enter to back to Menu";
	getch();
}

void DrawInfo(unsigned short int type) {
	/*
		0: Heart
		1: Score
		2: Current Id Scene
		3: Current / Number of Scene
	*/
	TextColor(10);
	
	switch(type) {
		case 0:
			Gotoxy(InfoScreen.x+2,InfoScreen.y+1);
			cout << "             ";
			Gotoxy(InfoScreen.x+2,InfoScreen.y+1);
			cout << "Heart: " << heartPoint;
			break;
		case 1:
			Gotoxy(InfoScreen.x+2,InfoScreen.y+2);
			cout << "             ";
			Gotoxy(InfoScreen.x+2,InfoScreen.y+2);
			cout << "Score: " << scorePoint;
			break;
		case 2:
			Gotoxy(InfoScreen.x+2,InfoScreen.y+4);
			cout << "             ";
			Gotoxy(InfoScreen.x+2,InfoScreen.y+4);
			cout << "Scene: " << CurrentScene;
			break;
		case 3:
			Gotoxy(InfoScreen.x+2,InfoScreen.y+5);
			cout << "             ";
			Gotoxy(InfoScreen.x+2,InfoScreen.y+5);
			cout << "Things: " << CurrentThings;
			break;
	}
	
	TextColor(DefaultColor);
}

void DrawInfoTable() {
	for(unsigned short int i = 0; i<NumberOfInfo; i++) {
		DrawInfo(i);
	}
}

void DrawTitle() {
	Sleep(1000);
	TextColor(11);
	Gotoxy(GameScreen.x+5, GameScreen.y+5);
	cout << "Scene " << CurrentScene << ": " << MaxThings << " objects";
	TextColor(DefaultColor);
	Sleep(1500);
	Gotoxy(GameScreen.x+5, GameScreen.y+5);
	cout << "                                    ";
}

void GameLose() {
	Sleep(1000);
	char playerName[15];
	endGame = true;
	Gotoxy(20,10);cout << "@    @@@@  @@@@  @@@@";
	Gotoxy(20,11);cout << "@    @  @  @     @   ";
	Gotoxy(20,12);cout << "@    @  @  @@@@  @@@@";
	Gotoxy(20,13);cout << "@    @  @     @  @   ";
	Gotoxy(20,14);cout << "@@@  @@@@  @@@@  @@@@";
	PlaySound(TEXT("Sounds\\Game_Over.wav"),NULL, SND_LOOP);
	Gotoxy(18,16);cout << "Enter Your Name: ";
	fflush(stdin);
	gets(playerName);
	// Ghi lai name va score
	strcpy(rank.name, playerName);rank.score = scorePoint;
	Gotoxy(23,18);cout << "Good !, " << playerName;
	Sleep(1000);
}

void DrawState(const char notice[10]) {
	TextColor(13);
	Sleep(150);
	Gotoxy(StateScreen.x+1,StateScreen.y+1);
	cout << notice;
	Sleep(400);
	Gotoxy(StateScreen.x+1,StateScreen.y+1);
	cout << "             ";
	TextColor(DefaultColor);
}

void CheckItem(ItemType wItem) {
	PlaySound(TEXT("Sounds\\Correct_Score.wav"),NULL, SND_ASYNC);
	switch(wItem) {
		case normal: {
			unsigned short int scoreAdd = rand() % 10 + 1;					
			scorePoint+=scoreAdd;
			DrawInfo(1);
			break;
		}	
		case scorex15: {
			DrawState("Score + 15");
			scorePoint+=15;
			DrawInfo(1);
			break;
		}
		case scorexx2: {
			DrawState("Score x 2");
			scorePoint*=2;
			DrawInfo(1);
			break;
		}
		case scorexx3: {
			DrawState("Score x 3");
			scorePoint*=3;
			DrawInfo(1);
			break;
		}
		case heartx5: {
			DrawState("Heart + 5");
			heartPoint+=5;
			DrawInfo(0);
			break;
		}
	}
}

bool ControlArrow() {
	 while(1) {
	 	char key = getch();
	 	switch(key) {
	 		case 'w': case 'W':
	 			DeleteArrow();
	 			arrow.y--;
	 			if(arrow.y < menu.mParts.y) arrow.y = menu.mParts.y+MenuParts-1;
	 			DrawArrow();
	 			break;
	 		case 's': case 'S':
	 			DeleteArrow();
	 			arrow.y++;
	 			if(arrow.y > menu.mParts.y+MenuParts-1) arrow.y = menu.mParts.y;
	 			DrawArrow();
	 			break;
	 		case char(13):
	 			unsigned short int id = arrow.y - menu.mParts.y;
	 			switch(id) {
	 				case 0:
	 					return true;
	 					break;
	 				case 1:
	 					MenuRank();
	 					return false;
	 					break;
	 				case 2:
	 					MenuInstruction();
	 					return false;
	 					break;
	 				case 3:
	 					MenuAbout();
	 					return false;
	 					break;
	 				case 4:
	 					system("cls");
	 					Gotoxy(35,10);
	 					cout << "End Game";
	 					Sleep(1500);
	 					// Ghi diem ra file
	 					scoreFile.close();
						scoreFile.open("Score\\score.dat", ios::out | ios::trunc);
						scoreFile << rank.name << " " << rank.score;
						scoreFile.close();
	 					exit(0);
	 					return false;
	 					break;
	 			}
	 			break;
	 	}
	 }
}


/* -------------------------------------------------------- MAIN FUNC ----------------------------------------------------------*/
int main(int argc, char *argv[]){
	Initialize();
	while(1) {
		// Khai bao va khoi tao
		srand(time(NULL));
		Reset();
		
		
		/*  ------------------ Menu lua chon ------------------------------------*/
		bool play;
		do {
			PlaySound(TEXT("Sounds\\Menu_Background.wav"),NULL, SND_ASYNC);
			DrawMenu();
			DrawArrow();
			play = ControlArrow();
			
			// Start Game
			if(play == true) {
				/*---------------------- Before Starting Game ----------------------------*/
				PlaySound(TEXT("Sounds\\Ngat.wav"),NULL, SND_ASYNC);
				system("cls");
				DrawPlayer();
				
				// Draw Screen
				DrawScreen(GameScreen);
				DrawScreen(InfoScreen);
				DrawScreen(StateScreen);
				//if(displayDebug == true) DrawScreen(DebugScreen);
				
				// Draw Info into Info Screen
				DrawInfoTable();
				
				// DrawTitle
				DrawTitle();
				
				// Main Loop	
				while(1) {
					
					// Title
					if(endScene == true) {
						endScene = false;
						// Set lai state cua cac objects
						for(unsigned short int i = 0; i<MaxThings; i++) {
							object[i].state = wait;
						}
						CurrentScene++;
						MaxThings+=10;
						CurrentThings = MaxThings;
			
						DrawTitle();
						DrawInfo(2);DrawInfo(3);
					}
					
					// Debug Mode
					if(displayDebug == true) {
						DrawScreen(DebugScreen);
						Gotoxy(DebugScreen.x+1, DebugScreen.y+1);cout << WaveCount;
					}
					
					// Moving Objects
					for(unsigned short int i = 0 ;i < MaxObject; i++) {
						if(object[i].state == out) {
							object[i].tickCount--;
							if(object[i].tickCount < 1) {
								object[i].tickCount = object[i].tickMax+object[i].speed;
								// Xu li moving
								unsigned short int y = object[i].y, x = object[i].x;
								y++;
								
								// Kiem tra va Player va Wall
								/*if(displayDebug == true) {
									// Va cham voi cua so Debug
									unsigned short int dx = DebugScreen.x, dy = DebugScreen.y, dX = (DebugScreen.x+DebugScreen.width), dY = (DebugScreen.y+DebugScreen.height);
									if( ((x>=dx) && (x<=dX)) && ((y>=dy) && (y<=dY))) {
										object[i].y = y; // chi xu li toa do ma khong hien thi
									}	
								}
								else*/ if((y == player.y) && (object[i].x >= player.x) && (object[i].x <= (player.x+player.length))) {
									// Kiem tra va player
									if(object[i].attr == none) {
										DeleteObject(object[i].x, object[i].y);
										object[i].y = y;
										//DrawObject(object[i].x, object[i].y, object[i].shape, object[i].color);
									}
									else {
										DeleteObject(object[i].x, object[i].y);
										if(object[i].attr == take) {
											CheckItem(object[i].item);
											/*if(object[i].item == normal) {
												scoreAdd = rand() % 10 + 1;					
												scorePoint+=scoreAdd;
												DrawInfo(1);
											} else {
												CheckItem();
											}	*/							
										} else {
											PlaySound(TEXT("Sounds\\Crash.wav"),NULL,SND_ASYNC);
											heartPoint--;
											DrawInfo(0);
											if(heartPoint < 1) {
												// Lose
												GameLose();
												break;
											}
										}
										// set lai state
										object[i].state = destroyed;
									}
								}
								else if(y >= (GameScreen.y+GameScreen.height)) {
									// Kiem tra va tuong
									DeleteObject(object[i].x, object[i].y);
									object[i].state = destroyed;
									if(object[i].attr == take) {
										if(object[i].item == normal) {
											heartPoint--;
											DrawInfo(0);
											if(heartPoint < 1) {
												// Lose
												GameLose();
												break;
											}
										}
										
									}
								}
								else {
									// Neu khong va
									if((object[i].attr == none) && (x>=player.x) && (x<=(player.x+player.length)) && (y == player.y+1)) {
									} else {
										DeleteObject(object[i].x, object[i].y);
									}
									object[i].y = y;
									DrawObject(object[i].x, object[i].y, object[i].shape, object[i].color);
								}	
							}
						}
					}
					
					// Check End Game
					if(endGame == true) {
						system("cls");
						break;
					}
					
					// Check End Scene
					for(unsigned short int i = 0; i< MaxThings; i++) {
						if(object[i].state == destroyed) endScene = true;
						else {
							endScene = false;
							break;
						}
					}
					
					// Check Out time
					WaveCount--;
					//getch();
					if(WaveCount < 1) {
						WaveCount = WaveTimer;
						// Cho cac object ra
						for(unsigned short int i = 0; i< MaxThings; i++) {
							if(object[i].state == wait) {
								object[i].state = out;
								// Khoi tao cac gia tri ban dau cho object
								object[i].y = GameScreen.y+1;
								object[i].x = rand() % (GameScreen.width-2) + GameScreen.x+1;
								object[i].speed = rand() % 20;
								object[i].tickCount = object[i].tickMax+object[i].speed;
								object[i].color = rand() % 14 + 2;
								
								/*object[i].attr = rand() % 2
								ObjectAttribute ab = object[i].attr;*/
								ObjectAttribute ab = ObjectAttribute(rand() % 3);
								object[i].attr = ab;
								// Dua vao thuoc tinh de set shape
								switch(ab) {
									case none:
										object[i].shape = char(rand() % 10 + 48);
										object[i].speed = rand() % 5;
										break;
									case take: {
										unsigned short int it = rand() % 15;
										if(it > 4) object[i].item = normal;
										else {
											object[i].item = ItemType(it);
										}	
										
										if(object[i].item == normal) {
											object[i].shape = char(rand() % 26 + 97);
										} else {
											object[i].shape = char(rand() % 6 + 1);
										}							
										object[i].speed = (rand() % 30)+5;
										break;
										}
									case notake:
										object[i].shape = char(rand() % 26 + 65);
										object[i].speed = rand() % 10;
										break;
								}
								
								DrawObject(object[i].x, object[i].y, object[i].shape, object[i].color);
								if(CurrentThings > 0) CurrentThings--;
								DrawInfo(3);
								break;	
							}
						}
					}
					
					
					// Control
					if(kbhit()) {
						char key = getch();
						unsigned short int x = player.x;
						
						if((key == 'a') || (key == 'A')) x--;
						else if ((key == 'd') || (key == 'D')) x++;
						else if (key == char(27)) break;
						else if ((key == 'p') || (key == 'P')) {
							Gotoxy(StateScreen.x+1, StateScreen.y+1);
							cout << "Pause Game";
							getch();
							Gotoxy(StateScreen.x+1, StateScreen.y+1);
							cout << "           ";
						}
						
						// Kiem tra va tuong
						if((x > GameScreen.x) && ((x+player.length) < (GameScreen.x+GameScreen.width))) {
							DeletePlayer();
							player.x = x;
							DrawPlayer();
						}
					}
					
					Sleep(GameLoop);
				}
			}
		}
		while(play == false);
	}
	// End game
	
	
	
	
	// End
	// Ghi diem ra file
	scoreFile.close();
	getch();
	return 0;
}
