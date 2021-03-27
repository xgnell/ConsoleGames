#include<iostream>

#include "..//ConsoleCore.hpp"

using namespace std;

int main() {
    for(unsigned short int i = 0; i <= 15; i++) {
        TextColor(i, 0);
        if(i < 10)
            cout << " " <<  i << " " << char(219) << char(219) << char(219) << endl;
        else
            cout << i << " " << char(219) << char(219) << char(219) << endl;
    }
    cin.get();
    return 0;
}