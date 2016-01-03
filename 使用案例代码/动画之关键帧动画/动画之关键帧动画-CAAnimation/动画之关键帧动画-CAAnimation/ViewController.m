//
//  ViewController.m
//  动画之关键帧动画-CAAnimation
//
//  Created by tarena on 16/1/3.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIButton *)btn {
	if(_btn == nil) {
		_btn = [[UIButton alloc] init];
        _btn.frame = CGRectMake(0, 0, 100, 50);
        _btn.center = self.view.center;
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"Start" forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_btn];
	}
	return _btn;
}

-(void)click:(UIButton *)btn{
    NSLog(@"clcik");
//    btn.center.x=10;
//    [self animation4:btn];
    [self animation1:btn];
}
-(void)animation4:(UIButton *)btn{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";

    animation.values = @[@100,@200,@300,@10];

    animation.duration = 3;
    animation.autoreverses = YES;
    animation.delegate =self;
    [btn.layer addAnimation:animation forKey:@"animation4"];
}
-(void)animation3:(UIButton *)btn{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
//    btn.layer.position.x
    animation.values = @[@100,@200,@50,@300];
    animation.keyTimes = @[@0.0,@0.1,@0.4,@1];
    animation.duration = 5;
    animation.delegate = self;
    [btn.layer addAnimation:animation forKey:nil];
    
}

-(void)animation2:(UIButton *)btn{
    CGPoint p1 = CGPointMake(0, 0);
    CGPoint p2 = CGPointMake(100, 100);
    CGPoint p3 = CGPointMake(100, 300);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values=@[[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3]];
    animation.keyTimes = @[@0.0,@0.2,@1];
    animation.duration = 5;//执行时间
    [btn.layer addAnimation:animation forKey:nil];//加入动画
}

-(void)animation1:(UIButton *)btn{
    CGMutablePathRef path = CGPathCreateMutable();
    //将路径的起点定位到
    //    （50  120）
    CGPathMoveToPoint(path,NULL,50.0,120.0);
    CGPathAddLineToPoint(path,NULL, 100, 170);
    //下面四行添加四条曲线路径到path
    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    //以“position”为关键字
    //    创建 实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置path属性
    [animation setPath:path];
    [animation setKeyTimes:@[@0.0,@0.1,@0.2,@0.3,@0.4,@1]];
    [animation setDuration:13.0];
    //这句代码
    //    表示 是否动画回到原位
    //
//    [animation setAutoreverses:YES];
    CFRelease(path);
    [btn.layer addAnimation:animation forKey:NULL];
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"stop%@",anim);
    NSLog(@"stop%@",[self.btn.layer animationForKey:@"animation4"]);
}
@end
