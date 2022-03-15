//
//  ByteAndHexString.m
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import "ByteAndHexString.h"

@implementation ByteAndHexString

+ (NSString *)parseByteArray2HexString:(Byte *)bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc] init];
    int i = 0;
    if (bytes) {
        while (bytes[i] != '\0') {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];  //16 进制数
            if ([hexByte length] == 1) {
                [hexStr appendFormat:@"0%@", hexByte];
            }
            else {
                [hexStr appendFormat:@"%@", hexByte];
            }
            i++;
        }
    }
    NSLog(@"bytes 的 16 进制数为:%@" ,hexStr);
    return hexStr;
}

+ (NSString *)byteArrayToHexString:(Byte *)bytes
{
    // 因bytes长度无法获取，弃用 byte[] 转 NSData
    // NSData *byteData = [[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
    // byte[] 转 16进制
    NSString *hexStr = @"";
    int i = 0;
    if (bytes) {
        while (bytes[i] != '\0') {
            NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];  // 16进制数
            if ([newHexStr length] == 1) {
                hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
            } else {
                hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
            }
            i++;
        }
    }
    NSLog(@"bytes 的16进制 字符串 为:%@",hexStr);
    return hexStr;
}

// 16进制 字符串 转 byte[]
+ (Byte *)hexStringToByteArray:(NSString *)inputHexString
{
    int z = (int)inputHexString.length;
    // Byte * 需要申请固定内存空间
    Byte *bt = malloc(z);
    
    for (int i = 0; i < z; i += 2) {
        NSString *strByte = [inputHexString substringWithRange:NSMakeRange(i, 2)];
        // 将字符串 转换成 unsigned long (无符号长整型数)
        unsigned long red = strtoul([strByte UTF8String], 0, 16);
        Byte b = (Byte)(0xff & red);
        bt[i/2 + 0] = b;
//        NSLog(@"b = %hhu, bt[%d] = %hhu", b, i/2+0, bt[i/2 + 0]);
    }
    
    // 可做打印，校验 16进制字符串 是否成功转为 byte[]
//    for (int i = 0; i < z / 2; i++) {
//        NSLog(@"bt[%d] = %hhu", i, bt[i]);
//    }
    return bt;
}


@end
