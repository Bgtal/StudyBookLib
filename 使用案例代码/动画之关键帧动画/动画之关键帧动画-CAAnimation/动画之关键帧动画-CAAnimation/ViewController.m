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
@property (nonatomic,strong) UIButton *btn2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self btn];
    [self btn2];
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
        [_btn setTitle:@"Start1" forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_btn];
	}
	return _btn;
}
- (UIButton *)btn2 {
    if(_btn2 == nil) {
        _btn2 = [[UIButton alloc] init];
        _btn2.frame = CGRectMake(0, 0, 100, 50);
        _btn2.center = CGPointMake(self.view.center.x, self.view.center.y+100);
        _btn2.backgroundColor = [UIColor greenColor];
        [_btn2 setTitle:@"Start2" forState:(UIControlStateNormal)];
        [_btn2 addTarget:self action:@selector(click2:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_btn2];
    }
    return _btn2;
}

-(void)click:(UIButton *)btn{
    [self animation1:btn];
}
-(void)click2:(UIButton *)btn{
    [self animation2:btn];
}

-(void)animation2:(UIButton *)btn{
    CGPoint p1 = CGPointMake(100, 50);
    CGPoint p2 = CGPointMake(200, 100);
    CGPoint p3 = CGPointMake(150, 300);
    //创建实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //添加关键路径
    animation.values=@[[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3]];
    //添加关键时间点
    animation.keyTimes = @[@0.0,@0.2,@1];
    //执行时间
    animation.duration = 5;
    //重复次数
    animation.repeatCount = 10.0;
    //加入动画
    [btn.layer addAnimation:animation forKey:nil];
}

-(void)animation1:(UIButton *)btn{
    CGMutablePathRef path = CGPathCreateMutable();
    //将路径的起点定位到（50  120）
    CGPathMoveToPoint(path,NULL,50.0,120.0);
    CGPathAddLineToPoint(path,NULL, 100, 170);
    //下面四行添加四条曲线路径到path
    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    // 创建 实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置path属性
    [animation setPath:path];
    //每个关键点出现在相对时间点
    [animation setKeyTimes:@[@0.0,@0.1,@0.2,@0.3,@0.4,@1]];
    [animation setDuration:5.0];
    //    表示 是否动画逆向返回到原位
    [animation setAutoreverses:YES];
    animation.delegate=self;
    CFRelease(path);
    [btn.layer addAnimation:animation forKey:nil];
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start");

}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"stop");
}


@end
