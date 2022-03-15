//
//  NSDataAndByte.h
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDataAndByte : NSObject

/**
 * @param inputData 将要进行转换的NSData类型数据
 * @return 返回转换后的Byte类型结果
 * 方法描述：将NSData类型数据转换为Byte类型数据
 */
+ (Byte *)convertNSDataToByte:(NSData *)inputData;


/**
 * @param inputString 将要进行转换的NSString类型数据
 * @return 返回转换后的Byte类型结果
 * 方法描述：将NSString类型数据转换为Byte类型数据
 */
+ (Byte *)convertNSStringToByte:(NSString *)inputString;


/**
 * @param inputByteArr 将要进行转换的Byte类型数据
 * @return 返回转换后的NSData类型结果
 * 方法描述：将Byte数组转换为NSData
 */
+ (NSData *)convertByteToNSData:(const void *)inputByteArr;

@end

NS_ASSUME_NONNULL_END
