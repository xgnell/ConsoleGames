#include<iostream>
#include<string>

#include "ConsoleCore.hpp"

using namespace std;

class Window {
    public:
        int x,y, width, height, color;

        Window() {}

        void DrawWindow() {
            DrawRect(x, y, width, height, char(219), color);
        }
};


void PrintIn(int x, int y, string msg) {
    Gotoxy(x,y);
    cout << msg;
}

void DeleteIn(int x, int y) {
    Gotoxy(x,y);
    cout << "                           ";
}

Window win;

int main() {

    SetConsoleMode(hStdIn, ENABLE_PROCESSED_INPUT);
    SetConsoleMode(hStdIn, ENABLE_MOUSE_INPUT);



    INPUT_RECORD InputRecord;
    DWORD Events;

    win.x = 10; win.y = 5;
    win.width = 25; win.height = 20;
    win.color = 15;


    bool isContinue = true;

    COORD oldCoord;
    COORD coord;

    bool choose = false;

    while(isContinue) {
        
        ReadConsoleInput(hStdIn, &InputRecord, 1, &Events);

        /*
        if(InputRecord.EventType == KEY_EVENT) {
            DeleteIn(0,0);
            switch(InputRecord.Event.KeyEvent.wVirtualKeyCode) {
                case VK_UP:
                    PrintIn(0,0, "Up arrow was pressed");
                    break;
                case VK_DOWN:
                    PrintIn(0,0, "Down arrow was pressed");
                    break;
                case VK_LEFT:
                    PrintIn(0,0, "Left arrow was pressed");
                    break;
                case VK_RIGHT:
                    PrintIn(0,0, "Right arrow was pressed");
                    break;
                case VK_ESCAPE:
                    isContinue = false;
                    break;
                default:
                    PrintIn(0,0, "Unknown key was pressed");
                    break;
            }
        }
        */
        if(InputRecord.EventType == MOUSE_EVENT) {

            if(InputRecord.Event.MouseEvent.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED) {

                oldCoord = coord;
                coord = InputRecord.Event.MouseEvent.dwMousePosition;

                switch(InputRecord.Event.MouseEvent.dwEventFlags) {
                    case MOUSE_MOVED:

                        if(choose == true) {
                            int sizeX = coord.X - oldCoord.X;
                            int sizeY = coord.Y - oldCoord.Y;

                            win.x += sizeX; win.y += sizeY;
                        }

                        break;
                    default:

                        break;
                    
                } 
                // End switch
                if((coord.X == 0) && (coord.Y == 0)) break; 
                if((coord.Y == win.y) && ((coord.X >= win.x) && (coord.X <= win.x+ win.width))) {
                    if(choose == false) {
                        choose = true;
                        win.color = 12;
                    }
                }

            } else if(InputRecord.Event.MouseEvent.dwButtonState == RIGHTMOST_BUTTON_PRESSED) {
                if(choose == true) {
                    choose = false;
                    win.color = 15;
                }
            }

        }

        win.DrawWindow();

        UpdateConsole();

        Gotoxy(0,0); cout << char(219);

        Sleep(30);

        ClearConsole();


        FlushConsoleInputBuffer(hStdIn);
    }

    return 0;
}