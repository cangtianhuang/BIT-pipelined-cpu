#include <iostream>
#include<string>
#include<stdio.h>
#include<ctime>
#include<cstdlib>

using namespace std;

int main()
{
    freopen("./code.txt","w",stdout);
    int lh,uh,lv,uv;

    for(int i=0;i<256;i++){
        int x=i%16;
        int y=i/16;
        lh=500+x*40;
        uh=540+x*40;
        lv=100+y*40;
        uv=140+y*40;
        string head="if (h_count < "+to_string(uh)+" && h_count > "+to_string(lh)+" && v_count < "+to_string(uv)+" && v_count > "+to_string(lv)+") begin";
        if(i>0){
            head="else "+head;
        }
        cout<<head<<endl;
        srand(i);
        int color=rand();
        int color2=rand();
        int color3=rand();
        cout<<"reg_red   <=4'b"<<(((color>>0)&1)?"0":"1")<<(((color>>1)&1)?"0":"1")<<(((color>>2)&1)?"0":"1")<<(((color>>3)&1)?"0":"1")<<";"<<endl;
        cout<<"reg_green   <=4'b"<<(((color2>>0)&1)?"0":"1")<<(((color2>>1)&1)?"0":"1")<<(((color2>>2)&1)?"0":"1")<<(((color2>>3)&1)?"0":"1")<<";"<<endl;
        cout<<"reg_blue   <=4'b"<<(((color3>>0)&1)?"0":"1")<<(((color3>>1)&1)?"0":"1")<<(((color3>>2)&1)?"0":"1")<<(((color3>>3)&1)?"0":"1")<<";"<<endl;
        cout<<"end"<<endl;
    }

   
//    system("pause");
   return 0;
}
