//
//  ConvertTool.h
//  HexByteDataAndSo
//
//  Created by 木熹鱼 on 2021/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConvertTool : NSObject

/**
  16进制NSString转换成ISO 8859-1 NSString
 */
+ (NSString *)hexStringToISO_8859_1String:(NSString *)inputHexString;

@end

NS_ASSUME_NONNULL_END
