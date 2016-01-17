//
//  smsManager.h
//  EyesHomeWork
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

typedef enum {

    CallPhoneTypeSimple,//调用简单的方法直接拨打
    CallPhoneTypeWebView,//调用web的方法,有提示
    CallPhoneTypeSelfApi,//调用苹果私有api
    
}CallPhoneType;

typedef enum {
    mimeTypeTextPlain,//纯文本
    mimeTypeTextHtml,//HTML文档
    mimeTypeImgGif,//GIF
    mimeTypeImgJpg,//JPG
    mimeTypeImgPng,//PNG
    mimeTypeVideoMpeg,//MPEG动画
    mimeTypeApplicationPdf,//PDF
    mimeTypeApplicationWord,//Microsoft Word
}mimeType;

typedef void (^sendMessageCallBack)(MessageComposeResult result);
typedef void (^sendEmailCallBack)(MFMailComposeResult result);

@interface SnbSMSManager : NSObject
NS_ASSUME_NONNULL_BEGIN

/**
 *  @author ssnb, 16-01-14 14:01:07
 *
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 *  @param type        拨打类型(简单/通用/私有api)
 *  @param fromController 由哪个控制器调用
 */
-(void)callPhone:(NSString *)phoneNumber WithType:(CallPhoneType)type fromController:(UIViewController *)fromController;

/**
 *  @author ssnb, 16-01-14 15:01:30
 *
 *  通过调出系统发送短信界面发送短信
 *
 *  @param phoneNumber 需要发送的号码
 *  @param controller   由哪个控制器发起请求
 */
-(void)sendMessageToPhoneNumber:(NSString*)phoneNumber fromController:(UIViewController *)fromController;

/**
 *  @author ssnb, 16-01-14 15:01:15
 *
 *  通过框架的方法发送短信
 *
 *  @param message      发送的信息
 *  @param phoneNumbers 需要发送的电话群组
 *  @param controller   由哪个控制器发起请求
 */
-(void)sendMessage:(NSString*)message toPhoneNumbers:(NSArray*)phoneNumbers fromController:(UIViewController *)controller;

/**
 *  @author ssnb, 16-01-14 16:01:11
 *
 *  当发送短信结束后会调用这个方法
 *
 *  @param callback block返回发送短信返回状态
 */
-(void)sendMessageFinishBlock:(sendMessageCallBack) callback;

/**
 *  @author ssnb, 16-01-14 22:01:15
 *
 *  通过框架来发送Email
 *  @param title          邮件的主题
 *  @param message        发送的内容
 *  @param isHTML         文本内容是否是HTML格式的(YES表示内容为HTML格式)
 *  @param emailAddres    收件人(们)的邮箱地址
 *  @param fromController 调用这个方法的控制器
 */
-(void)sendEmailTitle:(NSString *)title andMessage:(NSString *)message byHTML:(BOOL)isHTML toEmails:(NSArray *)emailAddres fromController:(UIViewController*) fromController;

/**
 *  @author ssnb, 16-01-14 22:01:51
 *
 *  添加邮件的发送文件
 *
 *  @param filePath 文件路径
 *  @param mimeType 文件类型
 */
-(void)addEmailFilePath:(NSString *)filePath andType:(mimeType)mimeType;

/**
 *  @author ssnb, 16-01-14 22:01:34
 *
 *  增加抄送人员和秘送人员
 *
 *  @param CcRecipients  抄送人员(们)
 *  @param BccRecipients 秘送人员(们)
 */
-(void)addEmailCcRecipients:(nullable NSArray *)CcRecipients andBccRecipients:(nullable NSArray *)BccRecipients;

/**
 *  @author ssnb, 16-01-14 16:01:07
 *
 *  发送Email结束后会调用这个Block
 *
 *  @param callback bolck返回Email返回的状态
 */
-(void)sendEmailFinishBlock:(sendEmailCallBack) callback;

@end
NS_ASSUME_NONNULL_END
