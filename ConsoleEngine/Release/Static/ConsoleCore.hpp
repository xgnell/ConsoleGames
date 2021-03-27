#pragma once

#include "ConsoleDefinition.hpp"
#include<windows.h>
#include<string>

/* Global Objects */
HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
HANDLE hStdIn = GetStdHandle(STD_INPUT_HANDLE);

// CHAR_INFO consoleScreen[CONSOLE_MAX_WIDTH * CONSOLE_MAX_HEIGHT];

COORD defaultBufferSize = {CONSOLE_MAX_WIDTH, CONSOLE_MAX_HEIGHT};
COORD defaultBufferCoord = {0,0};
SMALL_RECT defaultBufferArea = {0, 0, CONSOLE_MAX_WIDTH, CONSOLE_MAX_HEIGHT};
//SMALL_RECT consoleSize = bufferArea;


struct consoleLayer {
    int screenWidth, screenHeight;
    CHAR_INFO displayScreen[CONSOLE_MAX_WIDTH * CONSOLE_MAX_HEIGHT];
    COORD bufferSize;
    COORD bufferCoord;
    SMALL_RECT bufferArea;
} defaultLayer;
consoleLayer* currentLayer;


void InitConsole(int consoleWidth, int consoleHeight, const char* consoleTitle);
void SetCurrentLayer(consoleLayer* cLayer);
void InitConsoleLayer(consoleLayer* cLayer,int X, int Y, int scWidth, int scHeight);
void ClearConsole();
void UpdateConsole();
void SetConsoleTitle(std::string title);
void DisplayMode(int mode); // Error

void DrawPoint(int x, int y, char ch, int color);
void DrawString(int x, int y, std::string str, int color);
void DrawImage(int X, int Y, int width, int height, int image[], char ImageCode[], int mainColor, int fillColor);
void DrawImage(int X, int Y, int width, int height, int image[], char ImageCode[],  int color[]);
void DrawImage(int X, int Y, int width, int height, std::string image[], int mainColor, int fillColor);
void DrawImage(int X, int Y, int width, int height, std::string image[], int color[]);
void DrawHLine(int xstart, int xend, int y, char ch, int color);
void DrawVLine(int x, int ystart, int yend, char ch, int color);
void DrawRect(int x, int y, int width, int height, char ch, int mainColor, int fillColor);
void DrawGrid(int x, int y, int numColumn, int numRow, int aWidth, int aHeight, const char boderChar, const int mainColor, const int fillColor);
int MixColor(int foreColor, int backColor);
void SetConsoleBackgroundColor(int color);

void Gotoxy(int x,  int y);
void TextColor(int foreColor, int backColor);
void HideCursor();
void ShowCursor();

void Clear();
int GetElementFromCoord(int x, int y, int maxWidth);

void EnableInputEvent(std::string event);
int GetInput();
char GetKey();

//#include "ConsoleCore.cpp"