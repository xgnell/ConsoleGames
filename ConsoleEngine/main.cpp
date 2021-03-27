#include<iostream>
#include<windows.h>
#include "ConsoleCore.hpp"

#define SLEEP_TIME 10

using namespace std;

char ImageCode[] = {
    ' ',
    '.',
    'O',
    '#',
};

class TestObject {
    public:
        int image[24*12] = {
            3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,
            3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,
            3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
        };
        int width = 24;
        int height = 12;
        int layer;
        int color;

        TestObject() {}
        TestObject(int color, int layer) {
            this->color = color;
            this->layer = layer;
        }
};

void ClearScreen() {
    system("cls");
}

unsigned short int now = 0;

int main() {
    ClearScreen();
    TestObject test1(14, 0);

    TestObject test2(13, 1);

    while(now < 45) {

        DrawImage(3+now, 5, test1.width, test1.height, test1.image, ImageCode,  test1.color);
        DrawImage(10+now, 10, test2.width, test2.height, test2.image, ImageCode,  test2.color);

        now++;
        UpdateConsole();
        Sleep(SLEEP_TIME);
        ClearConsole();

    }

    cin.get();
    return 0;
}
