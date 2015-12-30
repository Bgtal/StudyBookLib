//
//  ViewController.m
//  动画之关键帧动画
//
//  Created by tarena on 15/12/30.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *flyImgView;
@property (nonatomic,strong) UIButton *mbtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mInit];
}

-(void)mInit{
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(self.view.bounds.size.width/2.0-30, self.view.bounds.size.height-50, 60, 40);
    [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"Go!" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    self.mbtn=btn;
}
-(void)click:(UIButton *)btn{
    btn.enabled=NO;
    [UIView animateKeyframesWithDuration:3 delay:0.2 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.25 animations:^{
            self.mbtn.center=CGPointMake(self.mbtn.center.x+40, self.mbtn.center.y-200);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.5 animations:^{
            
            self.mbtn.center=CGPointMake(self.mbtn.center.x-100, self.mbtn.center.y-100);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.75 animations:^{
            
            self.mbtn.center=CGPointMake(self.mbtn.center.x-50, self.mbtn.center.y+80);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:1 animations:^{
            
            self.mbtn.center=CGPointMake(self.mbtn.center.x+110, self.mbtn.center.y+220);
        }];
    } completion:^(BOOL finished) {
        NSLog(@"over");
        btn.enabled = YES;
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
