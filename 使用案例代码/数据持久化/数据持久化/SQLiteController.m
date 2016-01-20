//
//  SQLiteController.m
//  数据持久化
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "SQLiteController.h"
#import <sqlite3.h>
@interface SQLiteController ()
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@property (nonatomic,assign) sqlite3 *db;
@property (nonatomic,strong) NSString *dbPath;
@end

@implementation SQLiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)createDB:(id)sender {
    _db=NULL;
    int request =sqlite3_open([self.dbPath cStringUsingEncoding:NSUTF8StringEncoding], &(_db));
    if (request!=SQLITE_OK) {
        self.showLab.text=[NSString stringWithFormat:@"创建数据库失败 \n%s",sqlite3_errmsg(_db)];
        return;
    }else{
        self.showLab.text=@"创建数据库成功";
    }
    sqlite3_close(_db);
    
    
}
-(BOOL)openDB{
    _db=NULL;
    int request =sqlite3_open([self.dbPath cStringUsingEncoding:NSUTF8StringEncoding], &(_db));
    if (request!=SQLITE_OK) {
        self.showLab.text=[NSString stringWithFormat:@"打开数据库库失败 \n%s",sqlite3_errmsg(_db)];
        return NO;
    }
    return YES;
}
-(void)closeDB{
    sqlite3_close(_db);
}
- (IBAction)createTable:(id)sender {
    if ([self openDB]) {
        const char *createTbSQL="create table if not exists student (id integer primary key,name text , age integer)";
        char *error = nil;
        int request =sqlite3_exec(_db, createTbSQL, nil,nil, &error);
        if (request != SQLITE_OK) {
            self.showLab.text=[NSString stringWithFormat:@"创建表失败 \n%s",sqlite3_errmsg(_db)];
        }else{
            self.showLab.text = @"创建表成功";
        }
        [self closeDB];
    }
}
- (IBAction)addData:(id)sender {
    if ([self openDB]) {
        const char *addSQL= "insert into student (name,age) values ('ssnb',15)";
        char *error = nil;
        int request = sqlite3_exec(_db, addSQL, nil, nil, &error);
        if (request!=SQLITE_OK) {
            self.showLab.text=[NSString stringWithFormat:@"添加数据失败 \n%s",sqlite3_errmsg(_db)];
        }
        [self closeDB];
    }
    
}
- (IBAction)deleteData:(id)sender {
    if([self openDB]){
        const char *deleteSQL = "delete from student where id=5";
        char *error =nil;
        int request = sqlite3_exec(_db, deleteSQL, NULL, NULL, &error);
        if (request != SQLITE_OK) {
            self.showLab.text=[NSString stringWithFormat:@"删除数据失败 \n%s",sqlite3_errmsg(_db)];
        }
    }
}
- (IBAction)changeData:(id)sender {
    if ([self openDB]) {
    const char *updateSQL = "update student set name='maggie' where id=8";
        char * error =nil;
        int request = sqlite3_exec(_db, updateSQL, NULL, NULL, &error);
        if (request != SQLITE_OK) {
            self.showLab.text=[NSString stringWithFormat:@"数据更新失败 \n%s",sqlite3_errmsg(_db)];
        }
        [self closeDB];
    }
}
- (IBAction)selectData:(id)sender {
    if ([self openDB]) {
        //查询记录
        const char *selectData = "select * from student ";//where name='maggie'";
        //第四个参数:存储所有的查询结果
        sqlite3_stmt *stmt;
        int request = sqlite3_prepare_v2(_db, selectData, -1, &stmt, NULL);
        if (request == SQLITE_OK) {
            //从stmt变量中取数据(循环+选择方法)
            NSMutableString *requestStr = [NSMutableString new];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                //一列一列取(选择方法+哪一列)
                //name
                const unsigned char *name = sqlite3_column_text(stmt, 1);
                //age
                int age = sqlite3_column_int(stmt, 2);
                int mid = sqlite3_column_int(stmt, 0);
                [requestStr appendString:[NSString stringWithFormat:@"id:%d; name:%s; age:%d \n", mid,name, age]];
            }
            self.showLab.text=requestStr;
        }else{
            self.showLab.text=[NSString stringWithFormat:@"数据查询失败 \n%s",sqlite3_errmsg(_db)];
        }
        //收尾工作: 释放stmt占用的内存
        sqlite3_finalize(stmt);
        [self closeDB];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSString *)dbPath {
	if(_dbPath == nil) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
		_dbPath = [documentPath stringByAppendingPathComponent:@"mdb.sqlite"];
	}
	return _dbPath;
}

@end
