//
//  SHAClass.m
//  MHTProject
//
//  Created by mahaitao on 2017/7/31.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "SHAClass.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SHAClass

//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString{
    //适用于纯字符串以及带有中文的字符串
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}
//sha224加密方式
+ (NSString *)getSha224String:(NSString *)srcString {
    //适用于纯字符串以及带有中文的字符串
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString {
    //适用于纯字符串以及带有中文的字符串
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];

    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString {
    //适用于纯字符串以及带有中文的字符串
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];

    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString {
    //适用于纯字符串以及带有中文的字符串
    NSData *data = [srcString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
@end
