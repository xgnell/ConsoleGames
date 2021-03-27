#include<iostream>
#include<string>
#include "ConsoleCore.hpp"

using namespace std;

string image[5] = {
    "...##...",
    "#  OO  #",
    "#......#",
    "#  ||  #",
    "########"
};

int main() {
    InitConsole();

    DrawImage(5, 5, 8, 5, image, COLOR_LIGHT_GREEN, COLOR_DARK_BLUE);

    UpdateConsole();

    cin.get();
    return 0;
}