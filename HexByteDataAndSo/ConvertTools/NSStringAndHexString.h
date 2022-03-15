//
//  NSStringAndHexString.h
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSStringAndHexString : NSObject

/**
 16进制字符串 转 NSString
 */
+ (NSString *)hexStringToNSString:(NSString *)inputString;

/**
 16进制字符串 转 NSString
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/**
 NSString 转 16进制字符串
 */
+ (NSString *)stringToHexString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
