#include<iostream>

#include "ConsoleCore.hpp"

using namespace std;

int image[25] = {
    0,0,3,0,0,
    0,3,0,3,0,
    0,3,0,3,0,
    3,0,0,0,3,
    3,3,3,3,3
};

int main() {
    InitConsole();

    DrawImage(10,5, 5, 5, image, 14, COLOR_DARK_RED);
    
    UpdateConsole();

    cin.get();
    return 0;
}