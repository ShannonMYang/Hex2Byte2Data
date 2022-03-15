//
//  CByteArrayAndHex.c
//  HexByteDataAndSo
//
//  Created by YXk on 2021/9/1.
//

#include "CByteArrayAndHex.h"

//字节流转换为十六进制字符串
void ByteToHexStr(const unsigned char* source, char* dest, int sourceLen)
{
    short i;
    unsigned char highByte, lowByte;
    
    for (i = 0; i < sourceLen; i++) {
        highByte = source[i] >> 4;
        lowByte = source[i] & 0x0f;
        
        highByte += 0x30;
        
        if (highByte > 0x39) {
            dest[i * 2] = highByte + 0x07;
        }
        else {
            dest[i * 2] = highByte;
        }
        
        lowByte += 0x30;
        if (lowByte > 0x39) {
            dest[i * 2 + 1] = lowByte + 0x07;
        }
        else {
            dest[i * 2 + 1] = lowByte;
        }
    }
    return;
}

//十六进制字符串转换为字节流
void HexStrToByte(const char* source, unsigned char* dest, int sourceLen)
{
    short i;
    unsigned char highByte, lowByte;
    
    for (i = 0; i < sourceLen; i += 2) {
        highByte = toupper(source[i]);
        lowByte = toupper(source[i + 1]);
        
        if (highByte > 0x39) {
            highByte -= 0x37;
        }
        else {
            highByte -= 0x30;
        }
        
        if (lowByte > 0x39) {
            lowByte -= 0x37;
        }
        else {
            lowByte -= 0x30;
        }
        
        dest[i / 2] = (highByte << 4) | lowByte;
    }
    return;
}

void testHexStrAndByteArray(void)
{
    char array[5] = { 12,45,-12,34,32 };
    char out[1024] = { 0 };
    char arrayout[1024] = { 0 };
    ByteToHexStr((const unsigned char*)array, out, 5);
    printf("%s\n",out);
    HexStrToByte((const char*)out, (unsigned char*)arrayout, (int)strlen(out));
    printf("{");
    for(int i = 0; i<strlen(arrayout);i++)
    {
        printf("%d ",arrayout[i]);
    }
    printf("}");
}
