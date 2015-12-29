//
//  ViewController.m
//  方法回调之Block
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
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    [btn addTarget:self action:@selector(goToNextViewController:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:@"点我进入下一页" forState:(UIControlStateNormal)];
    btn.backgroundColor =[UIColor redColor];
    [self.view addSubview:btn];
    
    
}
-(void)goToNextViewController:(UIButton*)btn{
    BViewController *bvc = [[BViewController alloc]init];
#warning 特别要注意这一点
    __weak __typeof(self)weaSelf = self;
    bvc.Block1=^(NSString *info){
        weaSelf.view.backgroundColor = [UIColor yellowColor];
        NSLog(@"%@",info);
    };
    bvc.block2=^(NSString *mess){
        NSLog(@"%@",mess);
    };
    [bvc blockCallBack:^(NSString *mess) {
        NSLog(@"%@",mess);
    }];
    [self presentViewController:bvc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
