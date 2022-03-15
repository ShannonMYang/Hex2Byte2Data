//
//  NSDataAndByte.m
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/20.
//

#import "NSDataAndByte.h"

@implementation NSDataAndByte

// 由于Byte类型的数组，在作为方法的参数的时候，会由Byte[]变为Byte*，所以参数的类型改成Byte *
// 当然，更建议你写成 +[NSData dataWithBytes:length:] 第二个参数相同的类型const void *
// 参考链接：https://stackoverflow.com/questions/7249054/using-sizeof-correctly-with-byte
/**
 When you pass a C array as a method or C function argument, it "decays" to a pointer to the underlying type (i.e. Byte[] is actually passed as Byte *.) So the called method/function has no idea how many elements are present in the array.

 You must also pass the length of the array in order for the called code to know what you want. That's why +[NSData dataWithBytes:length:] has that second argument.
 */
+ (NSData *)convertByteToNSData:(const void *)inputByteArr
{
    // 计算byte数组的长度
    NSInteger byteArrLength = sizeof(inputByteArr);
    NSData *byteData = [[NSData alloc] initWithBytes:inputByteArr length:byteArrLength];
    return byteData;
}

+ (Byte *)convertNSStringToByte:(NSString *)inputString
{
    NSData *tempData = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    Byte *resultByte = [self convertNSDataToByte:tempData];
    return resultByte;
}

+ (Byte *)convertNSDataToByte:(NSData *)inputData
{
    /**
     NSData 转 Byte
     unsigned char 即 Byte
     */
    Byte *dataByte = (unsigned char *)[inputData bytes];
    return dataByte;
}

@end
