#include "ConsoleCore.hpp"

#include<iostream>

using namespace std;

int main() {
    InitConsole();

    SetConsoleBackgroundColor(2);

    DrawString(10,5,"Sample String", 14);

    DrawRect(7,7, 25,20,'+',12);

    UpdateConsole();
    cin.get();

    Gotoxy(30,20);
    TextColor(14);
    cout << "Hello Here";

    cin.get();

    DrawString(25,10, "I am here", 10);
    
    UpdateConsole();

    cin.get();
    return 0;
}
