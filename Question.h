//
//  Question.h
//  MyCode
//
//  Created by tarena on 15/10/9.
//  Copyright (c) 2015年 ssnb. All rights reserved.
//

#ifndef MyCode_Question_h
#define MyCode_Question_h

void day02_1(){
    printf("整型的赋值注意问题\n");
    int i = 1000000000*10;//超范围，计算中的超范围是最难查找出的问题
    printf("%d\n",i);
    
    //float j = 5/3;//类型不一样导致结果与预期不一样
    float j =5.0/3;
    printf("%f\n",j);
    
    long a1 = 12345678912345;
    printf("%ld\n",a1);
    //a1=INT32_MAX+100;//两个整型数运算结果任然是整型
    a1=INT32_MAX+100l;//所以需要加l转换
    printf("%ld\n",a1);
}
void day02_2(){
    //整型的赋值
    printf("整型的赋值问题\n");
    int x ;
    x=10;//10 进制
    printf("%d\n",x);
    
    int y ;
    y=010;//8进制
    //0108，08//为10进制，八进制中没有8，就像10进制没有10；
    printf("%#o\n",y);
    int z ;
    z=0x20;//16进制
    printf("%#x\n",z);
}

void day02_3(int nub){
    printf("将10进制数%d转换为二进制，八进制和十六进制\n",nub);
    int ten2two[20];
    short length=0;
    int mnub =nub;
    while(nub/2.0>0){
        if (nub%2==1) {
            ten2two[length]=1;
        }else{
            ten2two[length]=0;
        }
        nub=nub/2;
        length++;
    }
    printf("转换为二进制为\n");
    for (int i = 0 ; i<=length; i++) {
        printf("%d",ten2two[length-i]);
    }
    printf("\n");
    nub=mnub;
    length=0;
    while(nub/8.0>0){
        ten2two[length]=nub%8;
        nub=nub/8;
        length++;
    }
    printf("转换为八进制为\n");
    for (int i = 0 ; i<=length; i++) {
        printf("%d",ten2two[length-i]);
    }    printf("\n");
    
    nub=mnub;
    length=0;
    while(nub/16.0>0){
        ten2two[length]=nub%16;
        nub=nub/16;
        length++;
    }
    printf("转换为八进制为\n");
    for (int i = 0 ; i<=length; i++) {
        printf("%d",ten2two[length-i]);
    }
    
    //10000110
}


void day02_4(){
    printf("关于Char的说明\n");
    char ch1='asd';//当输入多内容的时候只保存最后一个字符
    printf("%c",ch1);
}
void day02_5(){
    printf("");
    printf("·-----------·\n");
    printf("|           |\n");
    printf("|           |\n");
    printf("|           |\n");
    printf("·-----------·\n");
}

void day02_6(){
    printf("浮点型数据的舍入误差");
    
    double a =3.0;
    double b=2.9;
    if(a-b==0.1){
        printf("相等");
        return;
    }
    printf("不相等");
    printf("3.0-2.9=%.18lf",a-b);//因为二进制数无法精确的表示1/10(就像10进制数无法表示1/3)，所以不能用浮点数相减==x来判断是否相等
}
void day02_7(){
    printf("sizeof 的相关\n");
    int x;
    printf("%lu\n",sizeof(float));
    printf("%lu\n",sizeof(12L));
    printf("%lu\n",sizeof(x));
    printf("%lu\n",sizeof(5?0:1));
}

void day02_8(){
    printf("请输入时间（秒）\n");
    
    int second;
    scanf("%d",&second);
    
    int hour=second/3600;//
    int minter=second%3600/60;//余下多少分钟
    second%=60;//余下多少秒
    
    printf("%d:%d:%d",hour,minter,second);
    
}

void day02_9(){
    printf("输入一个任意整数，输入倒数\n");
    int nub;
    scanf("%d",&nub);
    while(nub/10.0>0){
        printf("%d",nub%10);
        nub/=10;
    }
    printf("\n");
    
}

void day02_10(){
    printf("++与--\n");
    
}
/*
void day02_(){
    printf("\n");
}
*/

void intChange(int nub,int style){
    char ch[20];
    int length=0;
    int base;
    switch (style) {
        case 0://10---》2
            base=2;
            printf("转换为二进制为\n");
            break;
        case 1://10---》8
            base=8;
            printf("转换为八进制为\n");
            break;
        case 2://10---》16
            base =16;
            printf("转换为十六进制为\n");
            break;
        default:
            printf("没有对应的转换\n");
            return;
    }
    
    while (nub/(float)base>0) {
        if(nub%base<10){
            ch[length]=nub%base+48;
        }else{
            ch[length]=nub%base+55;
        }
        nub=nub/base;
        length++;
    }
    for (int i = 1 ; i<=length; i++) {
        printf("%c",ch[length-i]);
    }
    printf("\n");
}

#endif
