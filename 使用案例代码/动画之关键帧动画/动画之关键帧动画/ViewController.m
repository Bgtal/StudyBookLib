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
    [self mbtn];
    [self flyImgView];
}
-(void)click:(UIButton *)btn{
    btn.enabled=NO;
    CGPoint flyCenter = self.flyImgView.center;
    [UIView animateKeyframesWithDuration:13 delay:0.2 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        //从左下角到右上角,变无色
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
//            self.mbtn.center=CGPointMake(self.mbtn.center.x+40, self.mbtn.center.y-200);
            self.flyImgView.center = CGPointMake(flyCenter.x+self.view.frame.size.width+100,flyCenter.y-180);
//            self.flyImgView.transform = CGAffineTransformMakeRotation(M_PI_2*0.2);
            self.flyImgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//            self.flyImgView.alpha = 0;
        }];
      
        //从无色到有色
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.01 animations:^{
            self.flyImgView.center = CGPointMake(self.view.frame.size.width+50,flyCenter.y-130);
            self.flyImgView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        //从右上角到左下角
        [UIView addKeyframeWithRelativeStartTime:0.31 relativeDuration:0.5 animations:^{
            self.flyImgView.alpha = 1;
            self.flyImgView.center = CGPointMake(-flyCenter.x-100, flyCenter.y-90);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.01 animations:^{
            self.flyImgView.center = CGPointMake(-flyCenter.x,flyCenter.y-90);
            self.flyImgView.transform = CGAffineTransformIdentity;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:1 animations:^{
            self.flyImgView.center = flyCenter;
//            self.mbtn.center=CGPointMake(self.mbtn.center.x+110, self.mbtn.center.y+220);
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
        _flyImgView.frame = CGRectMake(50, 200, 50,50);
        _flyImgView.image = [UIImage imageNamed:@"a.png"];
        
        [self.view addSubview:_flyImgView];
	}
	return _flyImgView;
}

@end
