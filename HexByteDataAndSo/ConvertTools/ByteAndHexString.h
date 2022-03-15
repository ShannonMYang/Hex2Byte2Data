//
//  ByteAndHexString.h
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ByteAndHexString : NSObject

/**
 Byte数组 转 16进制 字符串
 */
+ (NSString *)parseByteArray2HexString:(Byte *)bytes;

/**
 Byte数组 转 16进制 字符串
 */
+ (NSString *)byteArrayToHexString:(Byte *)bytes;

/**
 16进制 字符串 转 Byte数组
 */
+ (Byte *)hexStringToByteArray:(NSString *)inputHexString;

@end

NS_ASSUME_NONNULL_END
