//
//  BViewController.h
//  方法回调之Block
//
//  Created by tarena on 15/12/28.
//  Copyright © 2015年 ssnb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Block2)(NSString *mess);

@interface BViewController : UIViewController
@property (nonatomic,copy) void(^Block1)(NSString *info);
@property (nonatomic,copy) Block2 block2;

-(void)blockCallBack:(Block2)block;
@end
