//
//  NSDataAndHexString.m
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import "NSDataAndHexString.h"

@implementation NSDataAndHexString

// 16进制 转 NSData
+ (NSMutableData *)convertHexStringToNSData:(NSString *)inputHexString
{
    if (!inputHexString || [inputHexString length] == 0) {
        return nil;
    }

    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;

    if ([inputHexString length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }

    for (NSInteger i = range.location; i < [inputHexString length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [inputHexString substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

// NSData 转 16进制 第1种
+ (NSString *)convertNSDataToHexString:(NSData *)inputData
{
    if (!inputData || [inputData length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[inputData length]];

    [inputData enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    return string;
}

// NSData 转 16进制 第2种
- (NSString *)hexStringFormData:(NSData *)data
{
    return [[[[NSString stringWithFormat:@"%@",data]
            stringByReplacingOccurrencesOfString:@"<" withString:@""]
            stringByReplacingOccurrencesOfString:@">" withString:@""]
            stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
