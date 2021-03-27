#include<iostream>

using namespace std;

int main() {
    for(unsigned short int i = 0; i <=255; ++i) {
        cout << i << " " << char(i) << endl;
    }

    cin.get();
    return 0;
}