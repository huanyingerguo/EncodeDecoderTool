//
//  ViewController.m
//  EncodeDecoder
//
//  Created by jinglin sun on 2020/9/6.
//  Copyright © 2020 jinglin sun. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"

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
             ];
}


#pragma mark- Aciton
- (IBAction)encodeClicked:(id)sender {
    NSString *input = self.inputText.string;
    if (!input.length) {
        return;
    }
    
    if (self.selectedOption == self.base64Option) {
        self.outputText.string = [GTMBase64 stringByEncodeString:input];
        return;
    }
    
    if (self.selectedOption == self.sha256Option) {
        return;
    }
    
    if (self.selectedOption == self.sha1Option) {
        return;
    }
    
    if (self.selectedOption == self.md5Option) {
        return;
    }
    
    if (self.selectedOption == self.hashOption) {
        return;
    }
    
    if (self.selectedOption == self.urlOption) {
        return;
    }
    
    if (self.selectedOption == self.unicodeOption) {
        return;
    }
    
    if (self.selectedOption == self.sBaseMsgIDOption) {
        return;
    }
    
    if (self.selectedOption == self.jsonOption) {
        return;
    }
}

- (IBAction)deCodeClicked:(id)sender {
    NSString *output = self.outputText.string;
    if (!output.length) {
        return;
    }
    
    if (self.selectedOption == self.base64Option) {
        NSData *encodeData = [GTMBase64 decodeString:output];
        if (encodeData.length) {
            NSString *ouputMsg = [NSString stringWithCString:encodeData.bytes encoding:NSUTF8StringEncoding];
            self.inputText.string = ouputMsg;
        }
        return;
    }
    
    if (self.selectedOption == self.base64OFromXMLption) {
        output = [output stringByReplacingOccurrencesOfString:@"&#x0A;" withString:@" "];
        NSData *encodeData = [GTMBase64 decodeString:output];
        if (encodeData.length) {
            NSString *ouputMsg = [NSString stringWithCString:encodeData.bytes encoding:NSUTF8StringEncoding];
            self.inputText.string = ouputMsg;
        }
        return;
    }
    
    if (self.selectedOption == self.sha256Option) {
        return;
    }
    
    if (self.selectedOption == self.sha1Option) {
        return;
    }
    
    if (self.selectedOption == self.md5Option) {
        return;
    }
    
    if (self.selectedOption == self.hashOption) {
        return;
    }
    
    if (self.selectedOption == self.urlOption) {
        return;
    }
    
    if (self.selectedOption == self.unicodeOption) {
        return;
    }
    
    if (self.selectedOption == self.sBaseMsgIDOption) {
        long long time64 = [output longLongValue];
        long long timeStamp = (time64>>20) / 1000;
        NSDate *currentData = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        NSString *localTime = [self getLocalFormatDate:currentData];
        
        self.inputText.string = [NSString stringWithFormat:@"timeStr=%@ \r\nlocaltime=%@", @(timeStamp).stringValue, localTime];
        return;
    }
    
    if (self.selectedOption == self.jsonOption) {
        return;
    }
}

- (IBAction)onOptionBtnClick:(NSButton *)sender {
    [self setOptionSelected:sender];
}

#pragma mark-
- (NSString *)getLocalFormatDate:(NSDate *)date {
    static NSDateFormatter *crfdateFormatter = nil;
    if (crfdateFormatter==nil) {
        crfdateFormatter = [[NSDateFormatter alloc]init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [crfdateFormatter setTimeZone:timeZone];
        [crfdateFormatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    }
    return [crfdateFormatter stringFromDate:date];
}
@end
