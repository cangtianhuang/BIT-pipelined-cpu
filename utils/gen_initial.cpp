#include <iostream>
#include<string>
#include<stdio.h>

using namespace std;

int main()
{
   freopen("./t.txt","w",stdout);

   string pre="data[";
   string index;
   string suf="]  <= 32'h";
   string value;
   string end=";";

   for(int i=0;i<256;i++){
       index=to_string(i);
       value="ffffffff";
       cout<<pre+index+suf+value+end<<endl;
   }
   
   return 0;
}
