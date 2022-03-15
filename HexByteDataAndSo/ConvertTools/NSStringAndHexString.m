//
//  NSStringAndHexString.m
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import "NSStringAndHexString.h"

@implementation NSStringAndHexString

// 16进制 转 NSString
+ (NSString *)hexStringToNSString:(NSString *)inputString
{
    NSString *str = inputString;
    NSMutableString *newString = [[NSMutableString alloc] init];
    int i = 0;
    while (i < [str length]) {
        NSString * hexChar = [str substringWithRange:NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
        i += 2;
    }
    
    return newString;
}

// 16进制 转换为 普通字符串
+ (NSString *)stringFromHexString:(NSString *)hexString
{
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}

//普通字符串转换为十六进制的。
+ (NSString *)stringToHexString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    // 下面是Byte 转换为 16进制
    NSString *hexStr=@"";
    for (int i = 0; i < [myD length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];///16进制数
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

@end
