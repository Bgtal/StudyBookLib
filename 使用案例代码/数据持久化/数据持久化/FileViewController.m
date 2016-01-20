//
//  FileViewController.m
//  数据持久化
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "FileViewController.h"

@interface FileViewController ()
@property (nonatomic,strong) NSString *filePath;
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)saveFile:(id)sender {
    //准备数据
    NSArray *array = @[@"name", @"age"];
    NSArray *stuArray = @[@"Jonny", @19, @[@"Objective-C", @"Ruby"]];
    
    //1.准备存储归档数据的可变数据类型
    NSMutableData *mutableData = [NSMutableData data];
    NSLog(@"归档前数据长度:%lu", (unsigned long)mutableData.length);
    
    //2.创建NSKeyedArchiver对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    
    //3.对要归档的数据进行编码操作(二进制)
    [archiver encodeObject:array forKey:@"firstArray"];
    [archiver encodeObject:stuArray forKey:@"secondArray"];
    
    //4.完成编码操作
    [archiver finishEncoding];
    NSLog(@"归档之后的数据长度:%lu", (unsigned long)mutableData.length);
    
    //5.将编码后的数据写到文件中
    [mutableData writeToFile:self.filePath atomically:YES];
    
}
- (IBAction)readFile:(id)sender {
    
    //1.从文件中读取数据(NSData)
    NSData *data = [NSData dataWithContentsOfFile:self.filePath];
    //2.创建NSKeyedUnarchiver对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //3.对数据进行解码操作
    NSArray *firstArray = [unarchiver decodeObjectForKey:@"firstArray"];
    NSArray *secondArray = [unarchiver decodeObjectForKey:@"secondArray"];
    //4.完成解码操作
    [unarchiver finishDecoding];
    //验证
    NSLog(@"firstArray:%@; secondArray:%@", firstArray, secondArray);
    self.showLab.text = [NSString stringWithFormat:@"%@ \n %@",[firstArray description],[secondArray description]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)filePath {
	if(_filePath == nil) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _filePath = [documentPath stringByAppendingPathComponent:@"archiving"];
        
	}
	return _filePath;
}

@end
