#include<iostream>

#include "ConsoleCore.hpp"

using namespace std;

consoleLayer newLayer;

int main() {
    InitConsole();

    int hang, cot, fill;
    cout << "Nhap hang: "; cin >> hang;
    cout << "Nhap cot: "; cin >> cot;
    cout << "Nhap fillcolor: "; cin >> fill;

    InitConsoleLayer(&newLayer, 5, 5, (3 * cot)+1, (3 * hang)+1);

    ClearConsole();

    // Default Layer
    DrawGrid(0, 0, cot, hang, 2, 2, '#', COLOR_LIGHT_BLUE, fill);
    UpdateConsole();

    cin.ignore();
    cin.get();
    // newLayer
    SetCurrentLayer(&newLayer);

    DrawGrid(0, 0, cot, hang, 2, 2, '.', COLOR_LIGHT_GREEN, fill);
    UpdateConsole();

    cin.get();
    return 0;
}