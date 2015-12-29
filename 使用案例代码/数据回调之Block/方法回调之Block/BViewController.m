//
//  BViewController.m
//  方法回调之Block
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()
@property (nonatomic,strong) Block2 block3;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:@"点我回调" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
}

-(void)click:(UIButton *)btn{
    if(self.Block1 != nil){
        self.Block1(@"我是返回数据");
    }
    if (self.block2 != nil) {
        self.block2(@"我是第二种返回");
    }
    if (self.block3 != nil) {
        self.block3(@"我是通过方法返回的数据");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)blockCallBack:(Block2)block{
    self.block3=block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
