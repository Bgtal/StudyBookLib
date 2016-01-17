//
//  UIImage+Intercept.h
//  MyLib
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Intercept)
/**
 *  @author ssnb, 16-01-05 21:01:06
 *
 *  用于截取原始图片中的某块区域图片内容并保存到Documents下
 *
 *  @param image   原始图片
 *  @param mCGRect 要截取的位置
 *  @param name    截取后文件的名字
 *
 *  @return 截取后返回截取到的图像
 */
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect newImgName:(NSString *)name;
@end
