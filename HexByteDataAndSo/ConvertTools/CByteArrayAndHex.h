//
//  CByteArrayAndHex.h
//  HexByteDataAndSo
//
//  Created by YXk on 2021/9/1.
//

#ifndef CByteArrayAndHex_h
#define CByteArrayAndHex_h

#include <stdio.h>
#include <_ctype.h>
#include <string.h>

/**
 C语言 字节流 转换为 十六进制字符串
 */
void ByteToHexStr(const unsigned char* source, char* dest, int sourceLen);

/**
 C语言 十六进制字符串 转换为 字节流
 */
void HexStrToByte(const char* source, unsigned char* dest, int sourceLen);

/**
 测试C语言 Byte数组 和 HEX字符串 之间的转换
 */
void testHexStrAndByteArray(void);

#endif /* CByteArrayAndHex_h */
