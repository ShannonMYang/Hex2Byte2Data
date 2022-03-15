//
//  ViewController.m
//  HexByteDataAndSo
//
//  Created by YXk on 2021/8/12.
//

#import "ViewController.h"
#import "ConvertTools/ConvertTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self hexToString];
//    [self hexStringToByteArray];
    
    // utf-8字符串 转 16进制字符串
    NSString *s1 = @"/";
    unsigned long l1 = strtoul([s1 cStringUsingEncoding:NSUTF8StringEncoding], NULL, 16);
    NSLog(@"%ld",l1);
    
    //1.ASCII码转NSString
    unichar ch = 65;
    NSString *str =[NSString stringWithUTF8String:(char *)&ch];
    NSLog(@"%@", str);
    //-->A

    // ASCII to NSString

    int asciiCode1 = 132;
    NSString *string1 = [NSString stringWithFormat:@"%c", asciiCode1]; // A
    NSLog(@"%@", string1);
    //-->A


    //2.NSString转ASCII码
    NSString *string2 = @"]";
    int asciiCode2 = [string2 characterAtIndex:0];
    NSLog(@"%d", asciiCode2);
    //-->93
    
    NSString *aaa = @"\u00b2";
    NSString *bbb = @"\u00ff";
    NSString *stringString = [NSString stringWithFormat:@"%@%@", aaa, bbb];
    NSLog(@"%@", stringString);
    
//    for (int i = 128; i < 256; i++) {
//            NSLog(@"%d---%@", i, [NSString stringWithFormat:@"%c", i]);
//    }
    
//    NSString *strtest = @"563801015f7255645a2602124e79ae4f0460a43d03ef5286a6ea3a2251b77606c3381eb9a49fd0cdf39bbfbab5faec411d0d7e32f1611a206785aa42cbd880e15aa4ee147b013442bd9b439fe9e12faf2e80f31ed8e86facee2d5c89436ba22c7336c94bc9aa4a46819985a88d177a071463c7c894d532107a84";
    
//    // 调用封装
//    NSData *testData = [self convertHexStrToData:strtest];
//    Byte *DataByte = (Byte *)[testData bytes];
//    NSMutableString *asciiStr = [NSMutableString string];
//    // 打印检测
//    for (int i = 0; i < testData.length; i++) {
//            NSLog(@"DataByte[%d]---%hhu---%@", i, DataByte[i], [NSString stringWithFormat:@"%c", (int)DataByte[i]]);
//            [asciiStr appendString:[NSString stringWithFormat:@"%c", (int)DataByte[i]]];
//    }
//    NSLog(@"asciiStr---%@", asciiStr);
//    NSLog(@"%lu", (unsigned long)strtest.length);
    
    // 16进制 转 iso 8859-1 nsstring
//    NSString *tempStr1 = [ConvertTool hexStringToISO_8859_1String:strtest];
//    NSLog(@"tempStr1---%@", tempStr1);
}

// 将 NSString 字符串转换成 Unicode 编码（形如 \u597d）
- (NSString *)unicodeStringWithString:(NSString *)string {
    NSString *result = [NSString string];
    for (int i = 0; i < [string length]; i++) {
        result = [result stringByAppendingFormat:@"\\u%04x", [string characterAtIndex:i]];
        /*
         因为 Unicode 用 16 个二进制位（即 4 个十六进制位）表示字符，对于小于 0x1000 字符要用 0 填充空位，
         所以使用 %04x 这个转换符，使得输出的十六进制占 4 位并用 0 来填充开头的空位.
         */
    }
    return result;
}

- (NSString *)stringWithUnicodeString:(NSString *)string {
    NSArray *strArray = [[string substringFromIndex:2] componentsSeparatedByString:@"\\u"];
    NSString *result = [NSString string];
    for (NSString *str in strArray) {
        NSString *tmpStr = [@"0x" stringByAppendingString:str];
        unichar c = strtoul([tmpStr UTF8String], 0, 0);
        /*
         上面两行也可以写成下面一行：
         unichar c = strtoul([str UTF8String], 0, 16);
         */
        result = [result stringByAppendingString:[NSString stringWithCharacters:&c length:1]];
    }
    return result;
}

#pragma mark - 测试16进制字符串 和 普通字符串 之间的转换
- (void)testHexStringAndNSStringConvertToEachOther
{
    NSString *str1 = @"e8afb7e58187e58d95313532373836e8bf98e8819ae9a490666a68676a736a6a646a64";
    NSString *str2 = @"请假单152786还聚餐fjhgjsjjdjd";
    NSString *str3 = [NSStringAndHexString hexStringToNSString:str1];
    NSString *str4 = [NSStringAndHexString stringFromHexString:str1];
    NSString *str5 = [NSStringAndHexString stringToHexString:str2];
    NSLog(@"---%@", str3);
    NSLog(@"---%@", str4);
    NSLog(@"---%@", str5);
}

#pragma mark - 测试NSData和Byte的互转
- (void)testNSDataAndByteConvertToEach
{
    // 测试 NSString --> NSData --> Byte
    NSString *testString = @"1234567890";
    NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
    // 非16进制字符串的情况下，转成NSData后的长度和NSString的长度，是一样的
    NSLog(@"testData.length=%lu, testString.length=%lu", testData.length, testString.length);
    Byte *resultByte = [NSDataAndByte convertNSStringToByte:testString];
    // 循环打印检测结果
    for (int i = 0; i < testString.length; i++) {
        NSLog(@"resultByte[%d]------%hhu", i, resultByte[i]);
    }
    
    
    // 测试 Byte --> NSData
    Byte byteArr[] = {36, 37, 39, 51, 52, 53, 61, 62, 63, 66, 71, 72};
    NSData *Bytedata = [NSDataAndByte convertByteToNSData:byteArr];
    Byte *btbtt = [NSDataAndByte convertNSDataToByte:Bytedata];
    // 循环打印检测结果
    for (int i = 0; i < Bytedata.length; i++) {
        NSLog(@"btbtt[%d]------%hhu", i, btbtt[i]);
    }
    // 最后的encoding，取决于你需要什么编码格式的字符串
    NSString * dataString = [[NSString alloc] initWithData:Bytedata encoding:NSUTF8StringEncoding];
    NSLog(@"datdaString=%@", dataString);
}

#pragma mark - 测试NSData和Hex NSString的互转
- (void)testNSDataAndHexStringConverToEachTwo
{
    NSString *strtest = @"563801015f7255645a2602124e79ae4f0460a43d03ef5286a6ea3a2251b77606c3381eb9a49fd0cdf39bbfbab5faec411d0d7e32f1611a206785aa42cbd880e15aa4ee147b013442bd9b439fe9e12faf2e80f31ed8e86facee2d5c89436ba22c7336c94bc9aa4a46819985a88d177a071463c7c894d532107a84";
    
    // 调用封装 16进制 字符串 转 byte[]
    NSData *testData = [NSDataAndHexString convertHexStringToNSData:strtest];
    // NSData 转 Byte
    Byte *DataByte = (Byte *)[testData bytes];
    NSMutableString *asciiStr = [NSMutableString string];
    
    // 打印检测
    for (int i = 0; i < testData.length; i++) {
        NSLog(@"%hhu", DataByte[i]);
        [asciiStr appendString:[NSString stringWithFormat:@"%c", DataByte[i]]];
    }
    NSLog(@"asciiStr %@", asciiStr);
    
    // 16进制 字符串 转 byte[]
    // https://blog.csdn.net/yqmfly/article/details/45607585
    int z = (int)strtest.length;
    Byte bt[z];
    
    for (int i = 0; i < strtest.length; i+= 2) {
        NSString *strByte = [strtest substringWithRange:NSMakeRange(i, 2)];
        unsigned long red = strtoul([strByte UTF8String],0,16);
        Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
        bt[i/2+0] = b;
    }
    
    // 打印校验 byte[] 是否成功转换
    for (int i = 0; i < z/2; i++) {
        NSLog(@"bt[%d] === %hhu", i, bt[i]);
    }
    
    // byte 转 nsdata
    NSData *Bytedata = [[NSData alloc] initWithBytes:bt length:z/2];
    
    // byte[] 转 16进制 字符串
    NSString *hexStr=@"";
    for (int i = 0; i < [Bytedata length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bt[i] & 0xff]; //16进制数
        if ([newHexStr length]==1) {
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
        }
    }
    NSLog(@"bytes 的16进制 字符串 为:%@",hexStr);

    // 调用封装
    NSString *sss = [NSDataAndHexString convertNSDataToHexString:Bytedata];
    NSLog(@" %@", sss);
}

#pragma mark - 测试16进制NSString 和 Byte数组 的互转
- (void)hexStringToByteArray
{
    NSString *strtest = @"563801015f7255645a2602124e79ae4f0460a43d03ef5286a6ea3a2251b77606c3381eb9a49fd0cdf39bbfbab5faec411d0d7e32f1611a206785aa42cbd880e15aa4ee147b013442bd9b439fe9e12faf2e80f31ed8e86facee2d5c89436ba22c7336c94bc9aa4a46819985a88d177a071463c7c894d532107a84";
    // 16进制 字符串 转 byte[]
    int z = (int)strtest.length;
    Byte *bt = malloc(z);
    bt = [ByteAndHexString hexStringToByteArray:strtest];
    
    // 打印校验 byte[] 是否成功转换
    for (int i = 0; i < z/2; i++) {
        NSLog(@"bt[%d] === %hhu", i, bt[i]);
    }
    
    // byte[] 转 16进制 字符串
    [ByteAndHexString parseByteArray2HexString:bt];
    [ByteAndHexString byteArrayToHexString:bt];
}

@end
