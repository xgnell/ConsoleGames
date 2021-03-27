#include<iostream>

#include "ConsoleCore.hpp"

using namespace std;

#define LOOP_TIME 50

class Object {
    public:
        int x,y;
        char image;

        Object() {}
        Object(int x, int y, char image) {
            this->x = x;
            this->y - y;
            this->image = image;
        }

        void Draw() {
            Gotoxy(this->x, this->y);
            cout << this->image;
        }

        void Delete() {
            Gotoxy(this->x, this->y);
            cout << ' ';
        }
};

void InitObj(Object& obj) {
    obj.x = 5; obj.y = 5;
    obj.image = 'O';
}

int main() {
    Object myO;
    InitObj(myO);

    bool endGame = false;
    HideCursor();

    myO.Draw();
    while(!endGame) {

        Sleep(LOOP_TIME);

        if(kbhit()) {
            myO.Delete();

            char key = GetKey();

            switch(key) {
                case 'w':
                    myO.y--;
                    break;
                case 's':
                    myO.y++;
                    break;
                case 'a':
                    myO.x--;
                    break;
                case 'd':
                    myO.x++;
                    break;
                case 'q':
                    endGame = true;
                    break;
                default:
                    break;
            }
            myO.Draw();

        }


    }

    return 0;
}