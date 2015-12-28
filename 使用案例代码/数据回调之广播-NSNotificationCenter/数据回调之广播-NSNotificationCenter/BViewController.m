//
//  BViewController.m
//  数据回调之广播-NSNotificationCenter
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100,100, 100, 40);
    [btn addTarget:self  action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:@"点我发广播" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
}

-(void)click:(UIButton *)btn{
    
    NSNotification *notification = [[NSNotification alloc]initWithName:@"callBack" object:@"hehe" userInfo:@{@"aaa":@"bbb",@"ccc":@"dddd"}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:@"hehe"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:@"hehe" userInfo:@{@"name":@"xxx",@"asdf":@"xxx"}];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
