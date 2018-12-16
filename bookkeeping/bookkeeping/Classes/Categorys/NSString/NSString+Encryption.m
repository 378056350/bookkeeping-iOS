//
//  NSString+Encryption.m
//  imiss
//
//  Created by 郑业强 on 2018/8/18.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encryption)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
- (NSString *)encryption {
    NSString *md5 = [self md5];
    md5 = [md5 md5];
    md5 = [md5 md5];
    NSString *string = [self reverseWordsInString:md5];
    return string;
}

// 倒叙字符串
- (NSString *)reverseWordsInString:(NSString*)oldStr {
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:oldStr.length];
    for (int i = (int)oldStr.length - 1; i >= 0; i --) {
        unichar character = [oldStr characterAtIndex:i];
        [newStr appendFormat:@"%c",character];
    }
    return newStr;
}

@end
