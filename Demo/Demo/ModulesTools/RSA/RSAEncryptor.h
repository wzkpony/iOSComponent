//
//  RSAEncryptor.h
//  CashLoan
//
//  Created by wzk on 2017/12/28.
//  Copyright © 2017年 com.shanlinfinance. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PublicKey @"PublicKey"
#define PrivateKey @"PrivateKey"
/*
 //使用body转成的字符串进行使用公钥加密
 NSString* RSAString = [RSAEncryptor encryptString:bodyString publicKey:PublicKey];
 //使用body转成的字符串 进行使用私钥SHA1加密
 NSString* signString = [RSAEncryptor signTheDataSHA1WithRSA:bodyString privateKey:PrivateKey];
 
 */


@interface RSAEncryptor : NSObject
/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;


//签名
+ (NSString *)signTheDataSHA1WithRSA:(NSString *)plainText  privateKey:(NSString *)privateKey;
//验签
+ (BOOL)rsaSHA1VertifyingData:(NSString *)plainData withSignature:(NSString *)signature;

@end
