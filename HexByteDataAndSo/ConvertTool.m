//
//  ConvertTool.m
//  HexByteDataAndSo
//
//  Created by 木熹鱼 on 2021/8/16.
//

#import "ConvertTool.h"

@implementation ConvertTool

+ (NSString *)hexStringToISO_8859_1String:(NSString *)inputHexString
{
    NSString *strtest = inputHexString;
    NSLog(@"%lu", (unsigned long)strtest.length);
    // 16进制 转 nsstring
    NSString *tempStr1 = [self hexStringToNSString:strtest];
    NSLog(@"tempStr1---%@", tempStr1);
    // nsstring 转 utf-8
    NSString *utf8Str = [NSString stringWithCString:[tempStr1 UTF8String] encoding:NSUTF8StringEncoding];
    NSLog(@"utf8Str---%@", utf8Str);
    // utf-8 转 unicode
    NSString *unicodeStr = [self utf8ToUnicode:utf8Str];
    NSLog(@"unicideStr---%@", unicodeStr);
    // unicode 转 nsstring
    NSString *iso_8859_1String = [self replaceUnicode:unicodeStr];
    NSLog(@"iso_8859_1String---%@", iso_8859_1String);
    return iso_8859_1String;
}

// 16进制 转 NSString
+ (NSString *)hexStringToNSString:(NSString *)inputString
{
//    NSString * str = @"68656c6c6f";
    NSString *str = inputString;
    NSMutableString * newString = [[NSMutableString alloc] init];
    int i = 0;
    while (i < [str length]) {
        NSString * hexChar = [str substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
        i+=2;
    }
    NSLog(@"Log newString---%@", newString);
    return newString;
}

// Unicode 转字 符串
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString
{

    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];

    NSString * returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                     options:NSPropertyListImmutable
                                                                      format:NULL
                                                                       error:NULL];

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

// utf-8 nsstring 转 unicode nsstring
+ (NSString *)utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0; i < length; i++) {
        unichar _char = [string characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
        else if(_char >='a' && _char <='z') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
        else if (_char >='A' && _char <='Z') {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }
        else {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}

@end
