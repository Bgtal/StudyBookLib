//
//  ViewController.m
//  数据回调之广播-NSNotificationCenter
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册广播 并将频道取名为callBack 节目为hehe
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listerner:) name:@"callBack" object:@"hehe"];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"下一页" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(nextView:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}
-(void)nextView:(UIButton *)btn{
    BViewController *bvc = [[BViewController alloc]init];
    [self presentViewController:bvc animated:YES completion:nil];
}

//监听到广播后执行的方法
-(void)listerner:(NSNotification*)notification{

    NSLog(@"listern:%@",notification.userInfo);
}

-(void)dealloc{
    //移除广播
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
