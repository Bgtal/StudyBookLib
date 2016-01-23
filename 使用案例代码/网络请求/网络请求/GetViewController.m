//
//  GetViewController.m
//  网络请求
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "GetViewController.h"

@interface GetViewController ()
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@property (nonatomic,strong) NSString *urlStr;
@property (nonatomic,weak) GetViewController *content;
@end

@implementation GetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.urlStr = @"http://appssnb.applinzi.com/test.php";
    self.urlStr = @"http://localhost/gotyou/Home/Index/post";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)getBtn:(id)sender {
    self.urlStr =[self.urlStr stringByAppendingString:@"?ssnb=haha&name=limin&age=13"];
    //创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    //NSURLSession *session = [NSURLSession sharedSession];
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//    }]; 已经过期用 NSURLSession 代替
    
    //创建回话对象（单例）
    NSURLSession *session =[NSURLSession sharedSession];
//    NSURLSessionStreamTask;
//    NSURLSessionDataTask;//上传下载线程
//    NSURLSessionUploadTask;//上传线程
//    NSURLSessionDownloadTask;//下载线程
    //创建线程
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"thrend:%@\n",[NSThread currentThread]);
//        NSLog(@"location:%@\n",[location description]);//缓存地址
//        NSLog(@"response:%@\n",[response description]);//返回的头文件信息
//        NSLog(@"error:%@\n",[error description]);
        NSLog(@"str:%@",[NSString stringWithContentsOfURL:location]);
        NSDictionary *dic = [self.content jiexi:[NSData dataWithContentsOfFile:location.path]];
        NSLog(@"dic:%@\n",[dic description]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLab.text = [dic description];
        });
    }];
    [task resume];
    
    return;
    NSURLSessionDataTask *dTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic =[self.content jiexi:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLab.text = [dic description];
            
        });
    }];
    [dTask resume];

}
- (IBAction)postBtn:(id)sender {
    /*
    // 1.创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
         request.HTTPMethod = @"POST";
    
         // 2.设置请求头
         [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
         // 3.设置请求体
         NSDictionary *json = @{
                                                              @"order_id" : @"123",
                                                              @"user_id" : @"789",
                                                              @"shop" : @"Toll"
                                                              };
    
     //    NSData --> NSDictionary
         // NSDictionary --> NSData
         NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
         request.HTTPBody = data;
        NSURLSession *se = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *dta = [se downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *str = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:location.path] encoding:NSUTF8StringEncoding];
            NSLog(@"str:%@",str);
    }];
    [dta resume];
    return;*/
    
//    NSMutableURLRequest *re =[[NSMutableURLRequest alloc]init];
//    re.HTTPMethod = @"POST";
//    NSString *s = @"";
//    re.HTTPBody =[s dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    NSURLSession *se = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *dta = [se downloadTaskWithRequest:re completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *str = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:location.path] encoding:NSUTF8StringEncoding];
//        NSLog(@"str:%@",str);
//    }];
//    [dta resume];
//    return;
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];//默认get
    mRequest.HTTPMethod = @"POST";//设置为post
    [mRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dic setObject:@"ssnb" forKey:@"name"];
    [dic setObject:@14 forKey:@"age"];
    [dic setObject:@"xixi" forKey:@"oth"];
    NSError *err = nil;
    NSLog(@"dic:%@",dic);
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic  options:(NSJSONWritingPrettyPrinted) error:&err];
    mRequest.HTTPBody =data;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:mRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str= [NSString stringWithContentsOfURL:location];
        NSLog(@"str:%@",str);
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.showLab.text = [dic description];
            self.showLab.text = str;
        });
    }];
    [task resume];
}

-(NSDictionary *)jiexi:(NSData *)data{
    return  [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
}

- (GetViewController *)content {
	if(_content == nil) {
		_content = self;
	}
	return _content;
}

@end
