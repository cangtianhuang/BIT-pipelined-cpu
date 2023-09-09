#include<iostream>
#include<string>
#include<stdio.h>

using namespace std;

int main(){
    string prefix=string(4,'0');
    string red=prefix+"0f00";
    string green=prefix+"00f0";
    string blue=prefix+"000f";

    freopen("../vga_demo/testcode/data.mem","w",stdout);
    for(int i=0;i<256;i++){
        switch (i%3)
        {
        case 0:
            cout<<red<<endl;
            break;
        case 1:
            cout<<green<<endl;
            break;
        case 2:
            cout<<blue<<endl;
            break;
        default:
            break;
        }
    }

    return 0;
}