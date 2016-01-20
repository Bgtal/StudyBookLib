//
//  NSUserDefaultsController.m
//  数据持久化
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "NSUserDefaultsController.h"

@interface NSUserDefaultsController ()
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@property (nonatomic,weak) NSUserDefaults *userDefaults;
@end

@implementation NSUserDefaultsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addData:(id)sender {
    [self.userDefaults setBool:YES forKey:@"bool"];
    [self.userDefaults setInteger:10 forKey:@"nub"];
    NSArray *arr = @[@"ssnb0",@"ssnb1",@"ssnb2",@"ssnb3",@"ssnb4"];
    [self.userDefaults setObject:arr forKey:@"arr"];
    [self.userDefaults setObject:@"i'm string" forKey:@"string"];
    [self.userDefaults synchronize];//因为NSUserDefaults不会立即更新到文件中，而是会保存一下，所以这里要强制同步，防止突发事件退出后设置不生效
    
}

- (IBAction)readData:(id)sender {
    NSString *string = [NSString stringWithFormat:@" bool:%d \n nub:%ld \n arr:%@ \n string:%@",[self.userDefaults boolForKey:@"bool"],[self.userDefaults integerForKey:@"nub"],[self.userDefaults arrayForKey:@"arr"],[self.userDefaults stringForKey:@"string"]];
    self.showLab.text = string;
    
}
- (IBAction)deleteData:(id)sender {
    [self.userDefaults removeObjectForKey:@"bool"];
    [self.userDefaults removeObjectForKey:@"nub"];
    [self.userDefaults removeObjectForKey:@"arr"];
}

- (NSUserDefaults *)userDefaults {
	if(_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
	}
	return _userDefaults;
}

@end
