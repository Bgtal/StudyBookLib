//
//  PListrController.m
//  数据持久化
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "PListrController.h"

@interface PListrController ()
@property (nonatomic,strong) NSString *bundlePath;
@property (nonatomic,strong) NSString *dataPath;
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@end

@implementation PListrController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)readBundle:(id)sender {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:self.bundlePath];
    NSArray *allKey = [dic allKeys];
    NSMutableString *text = [[NSMutableString alloc]initWithCapacity:50];
    for (NSString *key in allKey) {
        NSArray *arr = [dic objectForKey:key];
        [text appendString:key];
        
        [text appendString:@":{"];
        
        for(NSString *str in arr ){
            [text appendString:[NSString stringWithFormat:@"%@,",str]];
        }
        
        [text appendString:@"}\n"];
    }
    self.showLab.text=text;
}

- (IBAction)saveData:(id)sender {
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:4];
    [arr addObject:@"haha"];
    [arr addObject:@"huhu"];
    [arr addObject:@[@"hehe",@"jiji"]];
    [arr addObject:[NSNumber numberWithInteger:12]];
    
    [arr writeToFile:self.dataPath atomically:YES];
    
}
- (IBAction)readData:(id)sender {
    NSArray *arr = [NSArray arrayWithContentsOfFile:self.dataPath];
    self.showLab.text = [arr description];
}

- (NSString *)bundlePath {
	if(_bundlePath == nil) {
		_bundlePath = [[NSBundle mainBundle]pathForResource:@"citys" ofType:@"plist"];
	}
	return _bundlePath;
}

- (NSString *)dataPath {
	if(_dataPath == nil) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _dataPath = [documentPath stringByAppendingPathComponent:@"test.plist"];
	}
	return _dataPath;
}

@end
