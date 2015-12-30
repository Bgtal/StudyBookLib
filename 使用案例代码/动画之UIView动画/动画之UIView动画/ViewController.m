//
//  ViewController.m
//  动画之UIView动画
//
//  Created by tarena on 15/12/29.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *repeatCountLab;

@property (strong, nonatomic) IBOutlet UILabel *durationLab;
@property (strong, nonatomic) IBOutlet UILabel *delayLab;

@property (strong, nonatomic) IBOutlet UIButton *PlayBtn;
#pragma mark  -- 动画相关的配置
@property (nonatomic,strong) NSString *animationID;//animation标识
@property (nonatomic,strong) NSString *context;//文本内容
@property (nonatomic,assign) NSTimeInterval duration;//持续时间
@property (nonatomic,assign) NSTimeInterval Delay;//延时时间
@property (nonatomic,assign) UIViewAnimationCurve curve;//动画进入状态
@property (nonatomic,assign) float repeatCount;//重复次数
@property (nonatomic,assign) BOOL repeatAutoreverses;//动画是否返回执行
@property (nonatomic,assign) UIViewAnimationTransition transition;

@property (nonatomic,assign) BOOL isFistPic;
@property (nonatomic,strong) UIImage *fistImg;
@property (nonatomic,strong) UIImage *secondImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mInit];
}

-(void)mInit{
    self.animationID = @"animationID";
    self.context = @"context";
    self.duration = 1;
    self.Delay  = 0 ;
    
    self.curve = UIViewAnimationCurveEaseInOut;
    self.repeatCount = 0;
    self.repeatAutoreverses = NO;
    self.transition = UIViewAnimationTransitionNone;
    
    self.isFistPic = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark  -- 懒加载
- (UIImage *)fistImg {
    if(_fistImg == nil) {
        _fistImg = [UIImage imageNamed:@"pic.jpg"];
    }
    return _fistImg;
}

- (UIImage *)secondImg {
    if(_secondImg == nil) {
        _secondImg = [UIImage imageNamed:@"pic2.jpg"];
    }
    return _secondImg;
}

#pragma  mark  -- 配置相关属性
- (IBAction)changCurve:(UISegmentedControl*)sender {
    self.curve = sender.selectedSegmentIndex;
    NSLog(@"选中进入效果是:%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
}

- (IBAction)changTransition:(UISegmentedControl *)sender {
    self.transition = sender.selectedSegmentIndex;
    NSLog(@"选中动画效果是:%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
}

- (IBAction)changeRepeatCount:(UIStepper *)sender {
    self.repeatCount = sender.value;
    self.repeatCountLab.text = [NSString stringWithFormat:@"%lf",sender.value];
    NSLog(@"重复次数为%lf",sender.value);
    
}
- (IBAction)changRepeatAutoreverses:(UISwitch*)sender {
    self.repeatAutoreverses = sender.isOn;
}
- (IBAction)changeDuration:(UISlider *)sender {
    self.duration = sender.value;
    self.durationLab.text=[NSString stringWithFormat:@"%.2lf",self.duration];
}
- (IBAction)changeDealy:(UISlider*)sender {
    self.Delay = sender.value;
    self.delayLab.text = [NSString stringWithFormat:@"%.2lf",self.Delay];
}


#pragma mark  -- UIView启动动画
- (IBAction)startAnimation:(id)sender {
    [self startAnimation];
}


#pragma mark  -- UIView动画相关的设置
-(void)start:(NSString *)animationID context:(void *)context{
    NSLog(@"start!!!");
    NSLog(@"start animationID:%@,context:%@",animationID,context);
    self.PlayBtn.enabled=NO;
    if (self.repeatAutoreverses) {
        self.imgView.image =self.isFistPic?self.secondImg:self.fistImg;
        self.isFistPic=!self.isFistPic;
    }
}
-(void)stop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    NSLog(@"stop!!!!!");
    NSLog(@"stop animationID:%@,finishe:%ld,context:%@",animationID,[finished integerValue],context);
    self.PlayBtn.enabled=YES;
}

-(void)startAnimation{
    
    [UIView beginAnimations:self.animationID context:(void*)self.context];
    
    [UIView setAnimationDelegate:self];//默认是空
    
    [UIView setAnimationWillStartSelector:@selector(start:context:)];//默认是空
    //-(void)start:(NSString *)animationID context:(void *)context
    
    self.imgView.image =self.isFistPic?self.secondImg:self.fistImg;
     self.isFistPic=!self.isFistPic;
    [UIView setAnimationDidStopSelector:@selector(stop:finished:context:)];
    //-(void)stop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
    
    [UIView setAnimationDuration:self.duration];//持续时间 默认0.2秒
    
    [UIView setAnimationDelay:self.Delay];//延迟时间,默认立即执行(0.0秒)
    
//    [UIView setAnimationStartDate:[NSDate dateWithTimeIntervalSinceNow:10]];//默认立即执行//default = now ([NSDate date])
    //但是测试的时候不知道怎么用,只要设置就不会运行动画
    
    [UIView setAnimationCurve:self.curve];//默认是慢进来慢出
    
    [UIView setAnimationRepeatCount:self.repeatCount];//重复次数 默认是一次(0.0);//可以是分数,会执行动画的分数帧
    
    [UIView setAnimationRepeatAutoreverses:self.repeatAutoreverses];//是否自动返回
    //默认是不返回,YES会使动画执行完后再原路返回到开始状态
    //当RepeatCount不为0的时候(实验的时候设置0和设置1效果一样返回一次)会重复repeatCount次数
    
    [UIView setAnimationBeginsFromCurrentState:NO];//默认是NO,翻译说"如果是YES那么当前视图的位置永远作为新的动画--允许动画'堆积'在其他的上面,否者,这个最后的状态被用作为动画(默认)"
    
    [UIView setAnimationTransition:self.transition forView:self.imgView cache:YES];
    
    [UIView setAnimationsEnabled:YES];//设置动画是否可用,默认是YES
    //仅仅是动画是否可用，在动画中被改变的UI对象依然是起作用的。仅仅是动画效果被禁用了。(试验中没看出效果,可能方法有问题)
    
    BOOL b=[UIView areAnimationsEnabled];//获取动画效果是否可用
    NSLog(@"areanimationEnable:%@",b?@"YES":@"NO");
    
    [UIView performWithoutAnimation:^{//在动画执行之前执行这个block
        NSLog(@"动画之前执行");
    }];
    
    NSTimeInterval tim = [UIView inheritedAnimationDuration];//获取动画的持续时间(单次动画既上面设置的Duration时间);
    NSLog(@"NSTime = %lf",tim);
    
    [UIView commitAnimations];
    
}


@end
