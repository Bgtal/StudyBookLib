//
//  day04.h
//  MyCode
//
//  Created by tarena on 15/10/10.
//  Copyright (c) 2015年 ssnb. All rights reserved.
//
#include <stdbool.h>
#ifndef MyCode_day04_h
#define MyCode_day04_h
void day04_1(){
    printf("bool 类型");
    bool r2=123;
    printf("%d\n",r2);
     r2=123;
    printf("%d\n",r2);
     r2=0;
    printf("%d\n",r2);
     r2='2';
    printf("%d\n",r2);
}

void day04_2(){
    printf("输入你的年龄\n");
    int age ;
    
    scanf("%d",&age);
    if (age>70) {
        printf("old");
    }else if(age>40){
        printf("large");
    }else if(age>20){
        printf("mind");
    }else{
        printf("small");
    }
    
    printf("\n");
}
bool day04_3(int year){
    bool isrun =false;
    if ((year%4==0&&year%100!=0)||(year%400==0)) {
        printf("闰年");
        isrun=true;
    }else{
        printf("不是闰年");
    }
    return isrun;
}

void day04_4(int time){
    int year=time/100;
    int month=time%100;
    
    bool isrun =day04_3(year);
    if(month==2){
        if (isrun) {
            printf("29天");
        }else{
            printf("28天");
        }
    }else if(month==4||month==6||month==9||month==11){
        printf("30天");
    }else{
        printf("31天");
    }
    
}

#endif
