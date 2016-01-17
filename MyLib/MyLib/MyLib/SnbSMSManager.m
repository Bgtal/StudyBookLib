//
//  smsManager.m
//  EyesHomeWork
//
//  Created by tarena on 16/1/14.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "SnbSMSManager.h"

@interface SnbSMSManager ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic,copy) sendMessageCallBack messageBlock;
@property (nonatomic,copy) sendEmailCallBack emailBlock;

@property (nonatomic,copy) NSArray *CcRecipients;
@property (nonatomic,copy) NSArray *BccRecipients;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,assign) NSString *fileType;

@end

@implementation SnbSMSManager

#pragma mark  打电话相关

-(void)callPhone:(NSString *)phoneNumber WithType:(CallPhoneType)type fromController:(UIViewController *)fromController{
    
    NSString *urlStr=nil;
    switch (type) {
        case CallPhoneTypeSimple:
            urlStr = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            [self callPhone:urlStr fromController:fromController];
            break;
            
        case CallPhoneTypeSelfApi:
            urlStr = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
            [self callPhone:urlStr fromController:fromController];
            break;
            
        case CallPhoneTypeWebView:
            urlStr = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            [self callPhoneByWeb:urlStr];
            break;
            
        default:
            break;
    }
}

-(void)callPhone:(NSString *)urlstr fromController:(UIViewController *)controller{
    if(![self openUrl:[NSURL URLWithString:urlstr]]){
        [self alertWithTitle:@"打开失败" msg:@"该设备不支持拨号功能" fromController:controller];
    }
}

-(BOOL)openUrl:(NSURL*)url{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
        return YES;
    }
    return NO;
}
-(void)callPhoneByWeb:(NSString*)phoneNumber{
    NSURL  *url = [NSURL URLWithString:phoneNumber];
    UIWebView* callWebview =[[UIWebView alloc] initWithFrame:CGRectZero];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [callWebview loadRequest:request];
}

#pragma  mark  发短信相关


-(void)sendMessageToPhoneNumber:(NSString*)phoneNumber fromController:(UIViewController *)fromController{
    
    NSString *urlStr = [NSString stringWithFormat:@"sms://%@",phoneNumber];
    if (![self openUrl:[NSURL URLWithString:urlStr]]) {
        [self alertWithTitle:@"打开失败" msg:@"该设备不支持短信功能" fromController:fromController];
    }
}

-(void)sendMessageFinishBlock:(sendMessageCallBack) callback{
    self.messageBlock =callback;
}

-(void)sendMessage:(NSString*)message toPhoneNumbers:(NSArray*)phoneNumbers fromController:(UIViewController *)fromController{
    if( [MFMessageComposeViewController canSendText] )//判断能否发送短信
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];//获得发送短信的控制器
        controller.recipients = phoneNumbers;//需要发送的号码
        controller.navigationBar.tintColor = [UIColor redColor];//右上角'取消'btn颜色
        controller.body = message;//文本内容
        controller.messageComposeDelegate = self;//代理
        [fromController presentViewController:controller animated:YES completion:nil];//推出界面
        //        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }else{
        [self alertWithTitle:@"启动失败" msg:@"该设备不支持短信功能" fromController:fromController];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    if (self.messageBlock !=nil) {
        self.messageBlock(result);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma  mark  发送email相关
-(void)sendEmailFinishBlock:(sendEmailCallBack)callback{
    self.emailBlock =callback;
}

-(void)sendEmailTitle:(NSString *)title andMessage:(NSString *)message byHTML:(BOOL)isHTML toEmails:(NSArray *)emailAddres fromController:(UIViewController*) fromController {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
        controller.mailComposeDelegate = self;
        
        [controller setToRecipients:emailAddres];
        if (self.CcRecipients !=nil ||self.CcRecipients.count>0) {
            [controller setCcRecipients:self.CcRecipients];
        }
        if (self.BccRecipients !=nil ||self.BccRecipients.count>0) {
            [controller setBccRecipients:self.BccRecipients];
        }
        [controller setSubject:title];
        [controller setMessageBody:message isHTML:isHTML];
        if (self.path!=nil&&![self.path isEqualToString:@""]) {
            NSData *data = [NSData dataWithContentsOfFile:self.path];
            if (data!=nil||data.length>0) {
                [controller addAttachmentData:data mimeType:self.path fileName:[self.path lastPathComponent]];
            }
        }
        [fromController presentViewController:controller animated:YES completion:nil];
        
    }else{
        [self alertWithTitle:@"发送失败" msg:@"该设备不支持邮件功能" fromController:fromController];
    }
}

-(void)addEmailFilePath:(nonnull NSString *)filePath andType:(mimeType)mimeType{
    self.path = filePath;
    switch (mimeType) {
        case mimeTypeTextPlain:
            self.fileType =@"text/plain";
            break;
        case mimeTypeTextHtml:
            self.fileType=@"text/html";
            break;
        case mimeTypeImgGif:
            self.fileType=@"image/gif";
            break;
        case mimeTypeImgJpg:
            self.fileType=@"image/jpeg";
            break;
        case mimeTypeImgPng:
            self.fileType=@"image/png";
            break;
        case mimeTypeApplicationPdf:
            self.fileType=@"application/pdf";
            break;
        case mimeTypeVideoMpeg:
            self.fileType=@"video/mpeg";
            break;
        case mimeTypeApplicationWord:
            self.fileType=@"application/msword";
            break;
        default:
            break;
    }
}

-(void)addEmailCcRecipients:(NSArray *)CcRecipients andBccRecipients:(NSArray *)BccRecipients{
    self.CcRecipients = CcRecipients;
    self.BccRecipients = BccRecipients;
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (self.emailBlock !=nil) {
        self.emailBlock(result);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg fromController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:cancle];
    [controller presentViewController:alert animated:YES completion:nil];
}
@end
