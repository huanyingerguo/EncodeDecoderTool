//
//  NSString+EncodeDecode.h
//  EncodeDecoder
//
//  Created by jinglin sun on 2020/9/7.
//  Copyright © 2020 jinglin sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EncodeDecode)
- (NSString *)queryStringPercentEncode;
- (NSString *)queryStringPercentDecode;
- (NSString *)utf8ToUnicode;
- (NSString *)unicodeToUft8;
- (NSString *)encodeBase64;
- (NSString *)decodeBase64;
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString*)removeHtml;
- (NSString *)stringByDecodingXMLEntities;
@end

NS_ASSUME_NONNULL_END
