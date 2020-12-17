//
//  ViewController.m
//  EncodeDecoder
//
//  Created by jinglin sun on 2020/9/6.
//  Copyright © 2020 jinglin sun. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"
#import "NSString+EncodeDecode.h"

static NSDateFormatter *crfdateFormatter = nil;

@interface ViewController()
@property (weak) IBOutlet NSButton *sBaseMsgIDOption;
@property (weak) IBOutlet NSButton *base64Option;
@property (weak) IBOutlet NSButton *base64OFromXMLption;
@property (weak) IBOutlet NSButton *md5Option;
@property (weak) IBOutlet NSButton *sha1Option;
@property (weak) IBOutlet NSButton *sha256Option;
@property (weak) IBOutlet NSButton *hashOption;
@property (weak) IBOutlet NSButton *urlOption;
@property (weak) IBOutlet NSButton *unicodeOption;
@property (weak) IBOutlet NSButton *jsonOption;
@property (weak) IBOutlet NSButton *unixTimeOption;
@property (weak) IBOutlet NSButton *htmlToText;

@property (weak) IBOutlet NSTextView *inputText;
@property (weak) IBOutlet NSTextView *outputText;

@property (strong) NSButton *selectedOption;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setOptionSelected:self.base64Option];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setOptionSelected:(NSButton *)btn {
    [self setAllOptionUNSelected];
    [btn setState:NSControlStateValueOn];
    self.selectedOption = btn;
}

- (void)setAllOptionUNSelected {
    for (NSButton *bt in [self  getAllOptions]) {
        [bt setState:NSControlStateValueOff];
    }
}

- (NSArray *)getAllOptions {
    return @[self.sBaseMsgIDOption,
             self.base64Option,
             self.base64OFromXMLption,
             self.md5Option,
             self.md5Option,
             self.sha256Option,
             self.hashOption,
             self.unicodeOption,
             self.urlOption,
             self.jsonOption,
             self.unixTimeOption
             ];
}


#pragma mark- Aciton
- (IBAction)encodeClicked:(id)sender {
    NSString *input = self.inputText.string;
    if (!input.length) {
        return;
    }
    
    BOOL isExecuted = [self executeEncodeCommand:input forButtonClicked:sender];
    if (!isExecuted) {
        NSError *error = [NSError errorWithDomain:@"encodeCommand" code:-1 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        }];
    }
}

- (BOOL)executeEncodeCommand:(NSString *)input forButtonClicked:(NSButton *)sender {
    if (self.selectedOption == self.base64Option) {
        self.outputText.string = [input encodeBase64];
        return YES;
    }
    
    if (self.selectedOption == self.base64OFromXMLption) {
        NSString *output = [input encodeBase64];
        output = [output stringByReplacingOccurrencesOfString:@" " withString:@"&#x0A;"];
        self.outputText.string = output;
        return YES;
    }
    
    if (self.selectedOption == self.unixTimeOption) {
        long long timeStamp = [input longLongValue];
        NSDate *currentData = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        NSString *localTime = [self getLocalFormatDate:currentData];
        
        self.outputText.string = [NSString stringWithFormat:@"timeStr=%@ \r\nlocaltime=%@, \r\ntimeDesc=%@", @(timeStamp).stringValue, localTime, currentData];
        return YES;
    }
    
    if (self.selectedOption == self.sha256Option) {
        self.outputText.string = [input sha256];
        return YES;
    }
    
    if (self.selectedOption == self.sha1Option) {
        self.outputText.string = [input sha1];
        return YES;
    }
    
    if (self.selectedOption == self.md5Option) {
        self.outputText.string = [input md5];
        return YES;
    }
    
    if (self.selectedOption == self.hashOption) {
        return NO;
    }
    
    if (self.selectedOption == self.urlOption) {
        self.outputText.string = [input queryStringPercentEncode];
        return YES;
    }
    
    if (self.selectedOption == self.unicodeOption) {
        self.outputText.string = [input utf8ToUnicode];
        return YES;
    }
    
    if (self.selectedOption == self.sBaseMsgIDOption) {
        long long timeStamp = ((input.longLongValue * 1000) << 20)  + arc4random()%1000;
        self.outputText.string = @(timeStamp).stringValue;
        return YES;
    }
    
    if (self.selectedOption == self.jsonOption) {
        return NO;
    }
    
    return NO;
}

- (IBAction)deCodeClicked:(id)sender {
    NSString *output = self.outputText.string;
    if (!output.length) {
        return;
    }
    
    BOOL isExecuted = [self executeDecodeCommand:output forButtonClicked:sender];
    if (!isExecuted) {
        NSError *error = [NSError errorWithDomain:@"decodeCommand" code:-1 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        }];
    }
}

- (BOOL)executeDecodeCommand:(NSString *)output forButtonClicked:(NSButton *)sender {
    if (self.selectedOption == self.base64Option) {
        self.inputText.string = [output decodeBase64];
        return YES;
    }
    
    if (self.selectedOption == self.base64OFromXMLption) {
        output = [output stringByReplacingOccurrencesOfString:@"&#x0A;" withString:@" "];
        self.inputText.string = [output decodeBase64];
        return YES;
    }
    
    if (self.selectedOption == self.sBaseMsgIDOption) {
        long long time64 = [output longLongValue];
        long long timeStamp = (time64>>20) / 1000;
        NSDate *currentData = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        NSString *localTime = [self getLocalFormatDate:currentData];
        
        self.inputText.string = [NSString stringWithFormat:@"timeStr=%@ \r\nlocaltime=%@, \r\ntimeDesc=%@", @(timeStamp).stringValue, localTime, currentData];
        return YES;
    }
    
    if (self.selectedOption == self.unixTimeOption) {
        NSDate *localTime = [self getLocalDateFormatString:output];
        long long timeInterval = [localTime timeIntervalSince1970];
        self.inputText.string = [NSString stringWithFormat:@"%@", @(timeInterval).stringValue];
        return YES;
    }
    
    if (self.selectedOption == self.htmlToText) {
    //    NSXMLElement *ele = [[NSXMLElement alloc] initWithXMLString:output error:nil];
        self.inputText.string = [output removeHtml];
        return YES;
    }
    
    if (self.selectedOption == self.sha256Option) {
        return NO;
    }
    
    if (self.selectedOption == self.sha1Option) {
        return NO;
    }
    
    if (self.selectedOption == self.md5Option) {
        return NO;
    }
    
    if (self.selectedOption == self.hashOption) {
        return NO;
    }
    
    if (self.selectedOption == self.urlOption) {
        self.inputText.string = [output queryStringPercentDecode];
        return YES;
    }
    
    if (self.selectedOption == self.unicodeOption) {
        self.inputText.string = [output unicodeToUft8];
        return YES;
    }
    
    if (self.selectedOption == self.jsonOption) {
        return NO;
    }
    
    return NO;
}

- (IBAction)onOptionBtnClick:(NSButton *)sender {
    [self setOptionSelected:sender];
}

#pragma mark-
- (NSString *)getLocalFormatDate:(NSDate *)date {
    if (crfdateFormatter==nil) {
        crfdateFormatter = [[NSDateFormatter alloc]init];
        NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
        [crfdateFormatter setTimeZone:timeZone];
    }
    
    // 这里注意：分是小写的mm. 如果错误写成MM，则改位置对应出来的是“月份的值”
    // 这里注意：秒是小写的ss. 如果错误写成MM，则改位置对应出来的是“00”
    [crfdateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    return [crfdateFormatter stringFromDate:date];
}

//把国际时间转换为当前系统时间
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

- (NSDate *)getLocalDateFormatString:(NSString *)string {
    if (crfdateFormatter==nil) {
        crfdateFormatter = [[NSDateFormatter alloc]init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [crfdateFormatter setTimeZone:timeZone];
    }
    
    if ([string containsString:@"/"]) {
        [crfdateFormatter setDateFormat:@"yyyy/MM/dd HH:mmss"];
    } else if ([string containsString:@"-"]) {
        [crfdateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [crfdateFormatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
    }
    
    return [crfdateFormatter dateFromString:string];
}
@end
