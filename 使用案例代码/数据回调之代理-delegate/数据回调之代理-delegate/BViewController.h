//
//  BViewController.h
//  数据回调之代理-delegate
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BViewController;
//第一步:定义代理
@protocol BViewControllerDelegate <NSObject>
//第二部:定义方法
-(void)bViewController:(BViewController *)bvc didInputMessage:(NSString *)str;

@end

@interface BViewController : UIViewController
@property (nonatomic,weak) id<BViewControllerDelegate> delegate;//第三部:添加代理对象

@end
