/*
	Name: Console Game Engine
	Copyright: An
	Author: An
	Date: 12/06/18 11:52
	Description: 
*/

#ifndef __CONSOLE_GAME_ENGINE_1_0__
#define __CONSOLE_GAME_ENGINE_1_0__

#include<iostream>
#include<conio.h>
#include<windows.h>

/* Cac hang so */

/* Cac bien so */
int ScreenWidth = 80;
int ScreenHeight = 25;

/* Basic Console Processing */

// Lay HANDLE cua so console hien tai
HANDLE hCon = GetStdHandle(STD_OUTPUT_HANDLE);
 
// Di chuyen de vi tri (x,y)
void Gotoxy(short x,short y)
{
    HANDLE hConsoleOutput;
    COORD Cursor_an_Pos = { x,y};
    hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleCursorPosition(hConsoleOutput , Cursor_an_Pos);
}
 
// Mau chu
void TextColor(WORD color)
{
    HANDLE hConsoleOutput;
    hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
 
    CONSOLE_SCREEN_BUFFER_INFO screen_buffer_info;
    GetConsoleScreenBufferInfo(hConsoleOutput, &screen_buffer_info);
 
    WORD wAttributes = screen_buffer_info.wAttributes;
    color &= 0x000f;
    wAttributes &= 0xfff0;
    wAttributes |= color;
 
    SetConsoleTextAttribute(hConsoleOutput, wAttributes);
}
 
// Mau nen chu
void BackgroundColor(WORD color)
{
    HANDLE hConsoleOutput;
    hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
 
    CONSOLE_SCREEN_BUFFER_INFO screen_buffer_info;
    GetConsoleScreenBufferInfo(hConsoleOutput, &screen_buffer_info);
 
    WORD wAttributes = screen_buffer_info.wAttributes;
    color &= 0x000f;
    color <<= 4;
    wAttributes &= 0xff0f;
    wAttributes |= color;
 
    SetConsoleTextAttribute(hConsoleOutput, wAttributes);
}
 
// Hien thi
BOOL NT_SetConsoleDisplayMode(HANDLE hOutputHandle, DWORD dwNewMode)
{
    typedef BOOL (WINAPI *SCDMProc_t) (HANDLE, DWORD, LPDWORD);
    SCDMProc_t SetConsoleDisplayMode;
    HMODULE hKernel32;
    BOOL bFreeLib = FALSE, ret;
    const char KERNEL32_NAME[] = "kernel32.dll";
 
    hKernel32 = GetModuleHandleA(KERNEL32_NAME);
    if (hKernel32 == NULL)
    {
        hKernel32 = LoadLibraryA(KERNEL32_NAME);
        if (hKernel32 == NULL)
            return FALSE;
 
        bFreeLib = true;
    }
 
    SetConsoleDisplayMode =
        (SCDMProc_t)GetProcAddress(hKernel32, "SetConsoleDisplayMode");
    if (SetConsoleDisplayMode == NULL)
    {
        SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
        ret = FALSE;
    }
    else
    {
        DWORD tmp;
        ret = SetConsoleDisplayMode(hOutputHandle, dwNewMode, &tmp);
    }
 
    if (bFreeLib)
        FreeLibrary(hKernel32);
 
    return ret;
}
 
// FullScreen
void SetFullScreen()
{
    NT_SetConsoleDisplayMode( GetStdHandle( STD_OUTPUT_HANDLE ), 1 );
}
 
// Thoát fullscreen
void ExitFullScreen()
{
    NT_SetConsoleDisplayMode( GetStdHandle( STD_OUTPUT_HANDLE ), 0 );
}
 
// Hien con tro chuot nhap nhay
void ShowCursor(bool CursorVisibility)
{
    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO cursor = {1, CursorVisibility};
    SetConsoleCursorInfo(handle, &cursor);
}
 
// Xoa man hinh
void cls( HANDLE hConsole )
{
   COORD coordScreen = { 0, 0 };    // home for the cursor 
   DWORD cCharsWritten;
   CONSOLE_SCREEN_BUFFER_INFO csbi; 
   DWORD dwConSize;
 
// Get the number of character cells in the current buffer. 
 
   if( !GetConsoleScreenBufferInfo( hConsole, &csbi ))
      return;
   dwConSize = csbi.dwSize.X * csbi.dwSize.Y;
 
   // Fill the entire screen with blanks.
 
   if( !FillConsoleOutputCharacter( hConsole, (TCHAR) ' ',
      dwConSize, coordScreen, &cCharsWritten ))
      return;
 
   // Get the current text attribute.
 
   if( !GetConsoleScreenBufferInfo( hConsole, &csbi ))
      return;
 
   // Set the buffer's attributes accordingly.
 
   if( !FillConsoleOutputAttribute( hConsole, csbi.wAttributes,
      dwConSize, coordScreen, &cCharsWritten ))
      return;
 
   // Put the cursor at its home coordinates.
 
   SetConsoleCursorPosition( hConsole, coordScreen );
}
// Xoa man hinh hien tai
void ClearConsole()
{
    cls(hCon);
}
// Kiem tra phim nao duoc nhan
bool CheckKey(int key)
{
    return GetAsyncKeyState(key);
}


#endif

/* Cac Buffer */


/* (Viet nhanh hon trong Console)
wchar_t *screen = new wchar_t[ScreenWidth*ScreenHeight];
	HANDLE hConsole = CreateConsoleScreenBuffer(GENERIC_READ | GENERIC_WRITE, 0, NULL, CONSOLE_TEXTMODE_BUFFER, NULL);
	SetConsoleActiveScreenBuffer(hConsole);
	DWORD dwBytesWritten = 0;
	
	screen[ScreenWidth*ScreenHeight - 1] = '\0';
	WriteConsoleOutputCharacter(hConsole, screen, ScreenWidth*ScreenHeight, {0,0}, &dwBytesWritten);
*/
