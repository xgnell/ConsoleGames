
#include "ConsoleCore.hpp"

#include<conio.h>
#include<iostream>

void InitConsoleLayer(consoleLayer* cLayer,int X = 0, int Y = 0, int scWidth = CONSOLE_MAX_WIDTH, int scHeight = CONSOLE_MAX_HEIGHT) {
    cLayer->screenWidth = scWidth;
    cLayer->screenHeight = scHeight;
    cLayer->bufferCoord = {X, Y};
    cLayer->bufferSize = {CONSOLE_MAX_WIDTH, CONSOLE_MAX_HEIGHT};
    cLayer->bufferArea = {X, Y, scWidth, scHeight};
}
void InitConsole(int consoleWidth = CONSOLE_MAX_WIDTH, int consoleHeight = CONSOLE_MAX_HEIGHT, const char* consoleTitle = defaultTitle) {
    // Default Screen Size
    SMALL_RECT consoleSize = {0, 0, consoleWidth, consoleHeight};
    SetConsoleWindowInfo(hStdOut, TRUE, &consoleSize);

    // Init currentLayer
    InitConsoleLayer(&defaultLayer);
    SetCurrentLayer(&defaultLayer);

    // Clear
    Clear();

    // Set Title
    const char* title = consoleTitle;
    SetConsoleTitleA(title);
}
void SetCurrentLayer(consoleLayer* cLayer) {
    currentLayer = cLayer;
    SetConsoleScreenBufferSize(hStdOut, currentLayer->bufferSize);
}
void SetConsoleTitle(std::string title) {
    const char* tl = title.c_str();
    SetConsoleTitleA(tl);
}
void SetConsoleBackgroundColor(int color) {
    backgroundColor = color;

    int limitElement = currentLayer->screenWidth * currentLayer->screenHeight;
    for(int i = 0; i < limitElement; ++i) {
        int clr = MixColor(currentLayer->displayScreen[i].Attributes &= 0x000F , backgroundColor);
        (currentLayer->displayScreen)[i].Attributes = clr;
    }
}
void UpdateConsole() {
    COORD bufferSize = currentLayer->bufferSize;
    COORD bufferCoord = currentLayer->bufferCoord;
    PSMALL_RECT bufferArea = &(currentLayer->bufferArea);
    WriteConsoleOutput(hStdOut, currentLayer->displayScreen, bufferSize, bufferCoord, bufferArea);
}
void ClearConsole() {
    int limitElement = (currentLayer->screenWidth) * (currentLayer->screenHeight);
    for(int i = 0; i < limitElement; ++i) {
        (currentLayer->displayScreen)[i].Char.UnicodeChar = ' ';
        (currentLayer->displayScreen)[i].Attributes = backgroundColor;
    }
}
void DisplayMode(int mode) {
    SetConsoleDisplayMode(hStdOut, mode, NULL);
}
void HideCursor() {
    CONSOLE_CURSOR_INFO cursorInfo;
    cursorInfo.dwSize = 25;
    cursorInfo.bVisible = false;

    SetConsoleCursorInfo(hStdOut, &cursorInfo);
}
void ShowCursor() {
    CONSOLE_CURSOR_INFO cursorInfo;
    cursorInfo.dwSize = 25;
    cursorInfo.bVisible = true;

    SetConsoleCursorInfo(hStdOut, &cursorInfo);
}
int GetElementFromCoord(int x, int y, int maxWidth = currentLayer->screenWidth) {
    return x + maxWidth * y;
}
int MixColor(int foreColor, int backColor) {
    foreColor &= 0x000F;

    backColor <<= 4;
    backColor &= 0xFFF0;

    return foreColor | backColor;
}
void Clear() {
    ClearConsole();
    UpdateConsole();
}

void DrawPoint(int x, int y, char ch, int color = COLOR_DEFAULT) {
    int element = GetElementFromCoord(x,y);
    (currentLayer->displayScreen)[element].Char.UnicodeChar = ch;
    (currentLayer->displayScreen)[element].Attributes = MixColor(color, backgroundColor);
}
void DrawString(int x, int y, std::string str, int color = COLOR_DEFAULT) {
    int width = str.length();
    const char* sr = str.c_str();
    for(int i = 0; i < width; ++i) {
        int element = GetElementFromCoord(x + i, y);
        (currentLayer->displayScreen)[element].Char.UnicodeChar = sr[i];
        (currentLayer->displayScreen)[element].Attributes = MixColor(color, backgroundColor);
    }

}
void DrawImage(int X, int Y, int width, int height, int image[], char ImageCode[],  int mainColor = COLOR_DEFAULT, int fillColor = COLOR_TRANSPARENT) {
    for (int x = 0; x < width; ++x) {
        for (int y = 0; y < height; ++y) {
            int eConsole = GetElementFromCoord(x + X, y + Y);
            int eImage = GetElementFromCoord(x, y, width);

            (currentLayer->displayScreen)[eConsole].Char.UnicodeChar = ImageCode[image[eImage]];
            
            if(fillColor != COLOR_TRANSPARENT) {
                (currentLayer->displayScreen)[eConsole].Attributes = MixColor(mainColor, fillColor);
            } else
                (currentLayer->displayScreen)[eConsole].Attributes = MixColor(mainColor, backgroundColor);
            
        }
    }

}
void DrawImage(int X, int Y, int width, int height, int image[], char ImageCode[], int color[]) {
    for (int x = 0; x < width; ++x) {
        for (int y = 0; y < height; ++y) {
            int eConsole = GetElementFromCoord(x + X, y + Y);
            int eImage = GetElementFromCoord(x, y, width);
            (currentLayer->displayScreen)[eConsole].Char.UnicodeChar = ImageCode[image[eImage]];
            (currentLayer->displayScreen)[eConsole].Attributes = color[eImage];
        }
    }

}
void DrawImage(int X, int Y, int width, int height, std::string image[], int mainColor = COLOR_DEFAULT, int fillColor = COLOR_TRANSPARENT) {
    for(int e = 0; e < height; ++e) {
        for(int i = 0; i < width; ++i) {
            int element = GetElementFromCoord(i + X, e + Y);

            (currentLayer->displayScreen)[element].Char.UnicodeChar = image[e][i];

            if(fillColor != COLOR_TRANSPARENT) {
                (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, fillColor);
            } else
                (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, backgroundColor);

        }
    }
}
void DrawImage(int X, int Y, int width, int height, std::string image[], int color[]) {
    for(int e = 0; e < height; ++e) {
        for(int i = 0; i < width; ++i) {
            int eConsole = GetElementFromCoord(i + X, e + Y);
            int eColor = GetElementFromCoord(i, e);
            (currentLayer->displayScreen)[eConsole].Char.UnicodeChar = image[e][i];
            (currentLayer->displayScreen)[eConsole].Attributes = color[eColor]; 
        }
    }
}
void DrawHLine(int xstart, int xend, int y, char ch, int color = COLOR_DEFAULT) {
    for(int i = xstart; i <= xend; i++) {
        int element = GetElementFromCoord(i, y);
        (currentLayer->displayScreen)[element].Char.UnicodeChar = ch;
        (currentLayer->displayScreen)[element].Attributes = MixColor(color, backgroundColor);
    }
}
void DrawVLine(int x, int ystart, int yend, char ch, int color = COLOR_DEFAULT) {
    for(int i = ystart; i <= yend; i++) {
        int element = GetElementFromCoord(x, i);
        (currentLayer->displayScreen)[element].Char.UnicodeChar = ch;
        (currentLayer->displayScreen)[element].Attributes = MixColor(color, backgroundColor);
    }
}
void DrawRect(int x, int y, int width, int height, char ch, int mainColor = COLOR_DEFAULT, int fillColor = COLOR_TRANSPARENT) {
    DrawHLine(x, x + width - 1, y, ch, mainColor);
    DrawHLine(x, x + width - 1, y + height - 1, ch, mainColor);
    DrawVLine(x, y + 1, y + height - 2, ch, mainColor);
    DrawVLine(x + width - 1, y + 1, y + height - 2, ch, mainColor);

    if(fillColor != COLOR_TRANSPARENT) {
        if((width > 2) || (height > 2)) {
            for(int i = x + 1; i < x + width - 1; i++) {
                for(int j = y + 1; j < y + height - 1; j++) {
                    int element = GetElementFromCoord(i, j);

                    (currentLayer->displayScreen)[element].Char.UnicodeChar = ' ';
                    (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, fillColor);
                }
            }
        }
    }

}

void DrawGrid(int x, int y,int numColumn, int numRow, int aWidth, int aHeight, const char boderChar, const int mainColor, const int fillColor = COLOR_TRANSPARENT) {
    int sumWidth = ((aWidth + 1) * numColumn) + 1;
    int sumHeight = ((aHeight + 1) * numRow) + 1;
    
    for(int j = 0; j < sumHeight; j++) {
        int row = y + j;

        if(j % (aHeight + 1) == 0) {
            // Draw a line
            for(int i = 0; i < sumWidth; i++) {
                int column = x + i;
                int element = GetElementFromCoord(column, row);
                (currentLayer->displayScreen)[element].Char.UnicodeChar = boderChar;

                if(fillColor != COLOR_TRANSPARENT) {
                    (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, fillColor);
                } else {
                    (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, backgroundColor);
                }
                
            }
        } else {
            // Draw dot line
            for(int i = 0; i < sumWidth; i++) {
                int column = x + i;
                int element = GetElementFromCoord(column, row);

                if(i % (aWidth + 1) == 0) {
                    (currentLayer->displayScreen)[element].Char.UnicodeChar = boderChar;
                } else {
                    (currentLayer->displayScreen)[element].Char.UnicodeChar = ' ';
                }

                if(fillColor != COLOR_TRANSPARENT) {
                    (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, fillColor);
                } else {
                    (currentLayer->displayScreen)[element].Attributes = MixColor(mainColor, backgroundColor);
                }

            }
        }
    }
}

void Gotoxy(int x, int y) {
    COORD coord = {short(x), short(y)};
    SetConsoleCursorPosition(hStdOut, coord);
}
void TextColor(int foreColor, int backColor = COLOR_BLACK) {
    foreColor &= 0x000F;

    backColor <<= 4;
    backColor &= 0xFFF0;
    
    int color= foreColor | backColor;
    SetConsoleTextAttribute(hStdOut, color);
}

void EnableInputEvent(std::string event) {
    if (event == "keyboard") {
        SetConsoleMode(hStdIn,  ENABLE_PROCESSED_INPUT);
    } else if (event == "mouse") {
        SetConsoleMode(hStdIn,  ENABLE_MOUSE_INPUT);
    } else if (event == "all") {
        SetConsoleMode(hStdIn,  ENABLE_PROCESSED_INPUT | ENABLE_MOUSE_INPUT);
    }
}
int GetInput() {
    INPUT_RECORD InputRecord;
    DWORD Events;

    ReadConsoleInput(hStdIn, &InputRecord, 1, &Events);

    switch(InputRecord.EventType) {
        case KEY_EVENT:

            return InputRecord.Event.KeyEvent.wVirtualKeyCode;

            break;
        case MOUSE_EVENT:
            break;
        default:
            break;
    }

    FlushConsoleInputBuffer(hStdIn);
    return -1;
}
char GetKey() {
    //static char keyList[5];

    char key = getch();
    return key;

}