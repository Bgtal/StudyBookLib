//
//  XmlViewController.m
//  数据解析
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 ssnb. All rights reserved.
//

#import "XmlViewController.h"

@interface XmlViewController ()<NSXMLParserDelegate>
@property (nonatomic,strong) NSString *xmlPath;
@property (strong, nonatomic) IBOutlet UILabel *xmlLab;
@property (strong, nonatomic) IBOutlet UILabel *showLab;
@property (nonatomic,strong) NSMutableString *xmlStr;
@end

@implementation XmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [[NSString alloc]initWithContentsOfFile:self.xmlPath encoding:(NSUTF8StringEncoding) error:nil];
    self.xmlLab.text = [NSString stringWithFormat:@"xml原文:%@",str];
}

- (IBAction)jiexi:(id)sender {
    NSData *data = [NSData dataWithContentsOfFile:self.xmlPath];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:data];
    xmlParser.delegate = self;
    [xmlParser parse];
    
}
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"开始解析");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    [self.xmlStr appendString:[NSString stringWithFormat:@"<%@>",elementName]];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(nonnull NSString *)string{
    [self.xmlStr appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    [self.xmlStr appendString:[NSString stringWithFormat:@"</%@>",elementName]];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"%@",self.xmlStr);
    self.showLab.text = self.xmlStr;
}
/**
 *  @author ssnb, 16-01-20 16:01:27
 *
 *  解析错误时候返回
 *
 */
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    if (parseError) {
        NSLog(@"dd");
        [parser abortParsing];
        
        self.showLab.text = self.xmlStr;
    }
}
/**
 *  @author ssnb, 16-01-20 16:01:48
 *
 *  验证的时候错误
 *
 */
-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
    if (validationError) {
        NSLog(@"xxx");
        [parser abortParsing];
        
//        self.showLab.text = self.xmlStr;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)xmlPath {
	if(_xmlPath == nil) {
		_xmlPath = [[NSBundle mainBundle] pathForResource:@"mXml" ofType:@"xml"];
	}
	return _xmlPath;
}

- (NSMutableString *)xmlStr {
	if(_xmlStr == nil) {
		_xmlStr = [[NSMutableString alloc] init];
	}
	return _xmlStr;
}

@end
