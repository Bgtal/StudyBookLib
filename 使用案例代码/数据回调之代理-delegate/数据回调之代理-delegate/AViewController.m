//
//  ViewController.m
//  数据回调之代理-delegate
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
@interface AViewController ()<BViewControllerDelegate>

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn =[UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"下一页" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(nextView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}

-(void)nextView{
    BViewController *bvc = [[BViewController alloc]init];
    bvc.delegate =self;
    [self presentViewController:bvc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)bViewController:(BViewController *)bvc didInputMessage:(NSString *)str{
    NSLog(@"返回数据:%@",str);
}

@end
