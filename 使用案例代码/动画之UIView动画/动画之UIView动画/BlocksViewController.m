//
//  BlocksViewController.m
//  动画之UIView动画
//
//  Created by tarena on 15/12/30.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import "BlocksViewController.h"

@interface BlocksViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIImageView *backImgView;

@property (nonatomic,assign) NSTimeInterval duration;//执行时间
@property (nonatomic,assign) NSTimeInterval delay;//延时时间
@property SEL sele;
@property (nonatomic,assign) UIViewAnimationOptions curve;//进入效果
@property (nonatomic,assign) UIViewAnimationOptions transform;//动画效果

@property (nonatomic,assign) BOOL isFistPic;
@property (nonatomic,strong) UIImage *fistImg;
@property (nonatomic,strong) UIImage *secondImg;
@end

@implementation BlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mInit];
}
-(void)mInit{
    
    self.fistImg = [UIImage imageNamed:@"pic.jpg"];
    self.secondImg = [UIImage imageNamed:@"pic2.jpg"];
    
    self.duration = 2;
    self.sele = @selector(model3);
    self.delay = 0;
    self.curve = UIViewAnimationOptionCurveEaseInOut;//default
    self.transform = UIViewAnimationOptionTransitionNone;//default;
    self.transform=UIViewAnimationOptionTransitionFlipFromLeft;
};
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  -- 配置相关


-(void)updatePZ:(NSInteger)tag{
    switch (tag) {
        case 0:
            self.sele=@selector(model3);
            break;
        case 1:
            self.sele=@selector(model4);
            break;
        case 2:
            self.sele=@selector(model5);
            break;
        case 3:
            self.sele=@selector(model6);
            break;
        case 4:
            self.sele=@selector(model4);
            break;
        case 5:
            self.sele=@selector(model5);
            break;
        case 6:
            self.sele=@selector(model6);
            break;
        default:
            self.sele = nil;
            break;
    }
}
#pragma mark  -- Blocks启动动画
- (IBAction)changStyle:(UISegmentedControl *)sender {
    
    [self updatePZ:sender.selectedSegmentIndex];
    
}

- (IBAction)blockStartAnimation:(UIButton*)sender {
    if (self.sele!=nil) {
        [self performSelector:self.sele];
    }
}

//基础的动画实现
-(void)model0{
    //animation 表示动画效果代码块,可以设置 frame,bounds,center,transform,aplha,backgroundcolor,contentStretch
    //delay = 0.0 ,options = 0; completion = null;
    [UIView animateWithDuration:self.duration
                     animations:^{
                         NSLog(@"动画效果代码");
                     }
     ];
}

//增加结束block
-(void)model1{
    
    [UIView animateWithDuration:self.duration
                     animations:^{
        
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"动画结束");//动画结束后执行
                     }
     ];//delay = 0 ,options = 0;
    

}

//增加 延时和动画选项
-(void)model2{
    [UIView animateWithDuration:self.duration
                          delay:self.delay
                        options:(self.curve|self.transform)
                     animations:^{
        
                     }
                     completion:^(BOOL finished) {
        
                     }
     ];
}

//增加弹簧动画的阻尼值[0,1]:1表示阻力很大(弹性小) 弹簧动画速率[0,1]:1表示弹簧拉伸很大(既力很大,0表示忽略该属性)
-(void)model3{
    CGRect from=self.imgView.frame;
    CGRect end=self.imgView.frame;
    
    from.origin.y=-from.size.height;
    end.origin.y =self.imgView.frame.origin.y;
    
    self.imgView.frame = from;
    [UIView animateWithDuration:self.duration
                          delay:self.delay
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.5
                        options:(self.curve|self.transform)
                     animations:^{
                         NSLog(@"model3");
                         self.imgView.frame=end;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"动画结束");
                     }
     ];
}
#pragma  mark --  view 变换
//从变换 view
-(void)model4{
    [UIView transitionWithView:self.imgView
                      duration:self.duration
                       options:(self.curve|self.transform)
                    animations:^{
                        NSLog(@"model4");
                    }
                    completion:^(BOOL finished) {
        
                    }
     ];
    
}


//view1 切换到 view2 的动画
-(void)model5{
    UIImageView *fromView,*toView;
    if (self.isFistPic) {
        fromView =self.backImgView;
        fromView.frame = self.backImgView.frame;
        toView=self.imgView;
        toView.frame = self.imgView.frame;
    }else{
        fromView = self.imgView;
        fromView.frame = self.imgView.frame;
        toView=self.backImgView;
        toView.frame = self.backImgView.frame;
    }
    //用法不是这样用的,我没时间调试了,暂且就这样
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:self.duration
                       options:(self.curve|self.transform)
                    completion:^(BOOL finished) {
                        NSLog(@"跑完");
                        self.isFistPic=!self.isFistPic;
                        NSLog(@"imgview:%@",NSStringFromCGRect(self.imgView.frame));
                        NSLog(@"back:%@",NSStringFromCGRect(self.backImgView.frame));
                    }
     ];
}

//系统动画,消失
-(void)model6{
    
    [UIView performSystemAnimation:(UISystemAnimationDelete)
                           onViews:@[self.imgView]//要消失的界面//消失后还是占用内存的,所以需要移除对象
                           options:(self.curve|self.transform)
                        animations:^{
        
                        }
                        completion:^(BOOL finished) {
                            [self.view willRemoveSubview:self.imgView];
                        }
     ];
}


@end
