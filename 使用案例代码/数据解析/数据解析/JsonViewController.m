//
//  JsonViewController.m
//  数据解析
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "JsonViewController.h"

@interface JsonViewController ()
@property (nonatomic,strong)  NSString *jsonPath;
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@property (strong, nonatomic) IBOutlet UILabel *json;
@end

@implementation JsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *st = [[NSString alloc]initWithContentsOfFile:self.jsonPath encoding:(NSUTF8StringEncoding) error:nil];
    self.json.text=[NSString stringWithFormat:@"Json原文：\n%@",st];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)jiexi:(id)sender {
    NSData *data = [NSData dataWithContentsOfFile:self.jsonPath];
    //接收原则:{}使用字典;[]使用数组
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&err];
    if (err) {
        self.showLab.text =[err description];
        return;
    }
    
    NSMutableString *str = [[NSMutableString alloc]initWithCapacity:100];
    [str appendString:@"Json解析:\n{\n"];
    
    NSInteger FeelsLikeC = [[dic objectForKey:@"FeelsLikeC"] integerValue];
    [str appendString:[NSString stringWithFormat:@"FeelsLikeC:%ld,\n",FeelsLikeC]];
    
    NSString *temp_c = [dic objectForKey:@"temp_c"];
    [str appendString:@"temp_c:"];
    [str appendString:temp_c];
    [str appendString:@",\n"];
    
    NSArray *arr = [dic objectForKey:@"request"];
    [str appendString:@"request:\n[\n"];
    
    NSDictionary *dic2 = arr[0];
    [str appendString:@"{\nquery:"];
    NSString *query = [dic2 objectForKey:@"query"];
    [str appendString:query];
    
    [str appendString:@"\n}\n]\n}"];
    
    self.showLab.text = str;
    
}


- ( NSString *)jsonPath {
	if(_jsonPath == nil) {
        _jsonPath = [[NSBundle mainBundle]pathForResource:@"mJson" ofType:@"json"];
	}
	return _jsonPath;
}

@end
