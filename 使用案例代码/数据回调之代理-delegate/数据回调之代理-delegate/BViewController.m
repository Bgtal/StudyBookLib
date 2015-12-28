//
//  BViewController.m
//  数据回调之代理-delegate
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
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"返回数据" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(gobackAVC:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}
- (void)gobackAVC:(id)sender
{
    //第四步：在返回之前，给代理发消息
    [self.delegate bViewController:self didInputMessage:@"返回的数据"];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
