//
//  UIImage+Intercept.m
//  MyLib
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "UIImage+Intercept.h"

@implementation UIImage (Intercept)


+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect newImgName:(NSString *)name
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, mCGRect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath =[documentPath stringByAppendingPathComponent:name];
    
    NSData *data = UIImagePNGRepresentation(smallImage);
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    return smallImage;
}
@end
