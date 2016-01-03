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
@property (nonatomic,assign) CGFloat VWight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mInit];
}

-(void)mInit{
    [self mbtn];
    [self flyImgView];
    self.VWight=self.view.frame.size.width;
}
-(void)click:(UIButton *)btn{
    btn.enabled=NO;
    CGPoint flyCenter = self.flyImgView.center;
    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        //旋转-45/2
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.03 animations:^{
            self.flyImgView.transform = CGAffineTransformMakeRotation(-M_PI_4*0.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.03 relativeDuration:0.03 animations:^{
            self.flyImgView.transform = CGAffineTransformMakeRotation(0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.06 relativeDuration:0.03 animations:^{
            
            self.flyImgView.transform = CGAffineTransformMakeRotation(-M_PI_4*0.5);
        }];
        
        //移动到右上角并旋转45/2
        [UIView addKeyframeWithRelativeStartTime:0.09 relativeDuration:0.35 animations:^{
            self.flyImgView.center = CGPointMake(flyCenter.x+self.VWight,flyCenter.y-280);
            self.flyImgView.transform = CGAffineTransformMakeRotation(M_PI_4*0.5);
            self.flyImgView.alpha = 0;

        }];
        //快速变化到下方
        [UIView addKeyframeWithRelativeStartTime:0.44 relativeDuration:0.01 animations:^{
            self.flyImgView.alpha=0.3;
            self.flyImgView.center = CGPointMake(flyCenter.x+self.VWight, flyCenter.y-180);
            self.flyImgView.transform = CGAffineTransformMakeRotation(M_PI_4*5);
        }];
        //移动到左下角
        [UIView addKeyframeWithRelativeStartTime:0.45 relativeDuration:0.3 animations:^{
            self.flyImgView.alpha = 1;
            self.flyImgView.center = CGPointMake(-flyCenter.x, flyCenter.y-80);
            self.flyImgView.transform =CGAffineTransformMakeRotation(M_PI);
        }];
        //
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.01 animations:^{
            self.flyImgView.center = CGPointMake(-flyCenter.x, flyCenter.y+80);
            self.flyImgView.transform = CGAffineTransformIdentity;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.76 relativeDuration:0.24 animations:^{
            self.flyImgView.center = flyCenter;
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"over");
        btn.enabled = YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIButton *)mbtn {
	if(_mbtn == nil) {
		_mbtn = [[UIButton alloc] init];
        _mbtn.frame = CGRectMake(self.view.bounds.size.width/2.0-30, self.view.bounds.size.height-50, 60, 40);
        [_mbtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        _mbtn.backgroundColor=[UIColor redColor];
        [_mbtn setTitle:@"Go!" forState:(UIControlStateNormal)];
        [self.view addSubview:_mbtn];
	}
	return _mbtn;
}

- (UIImageView *)flyImgView {
	if(_flyImgView == nil) {
		_flyImgView = [[UIImageView alloc] init];
        _flyImgView.frame = CGRectMake(50, 400, 50,50);
        _flyImgView.image = [UIImage imageNamed:@"a.png"];
        
        [self.view addSubview:_flyImgView];
	}
	return _flyImgView;
}

@end
