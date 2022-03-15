//
//  NSDataAndHexString.h
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDataAndHexString : NSObject

/**
 * @param inputData 将要进行转换的NSData类型数据
 * @return 返回转换后的16进制 NSString类型结果
 * 方法描述：将NSData类型数据转换为16进制 NSString类型数据
 */
+ (NSString *)convertNSDataToHexString:(NSData *)inputData;


/**
 * @param inputHexString 将要进行转换的16进制 NSString类型数据
 * @return 返回转换后的NSMutableData类型结果
 * 方法描述：将16进制 NSString类型数据转换为NSMutableData类型数据
 */
+ (NSMutableData *)convertHexStringToNSData:(NSString *)inputHexString;

@end

NS_ASSUME_NONNULL_END
