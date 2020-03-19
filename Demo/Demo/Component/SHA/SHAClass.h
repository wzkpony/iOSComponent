//
//  SHAClass.h
//  MHTProject
//
//  Created by mahaitao on 2017/7/31.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHAClass : NSObject
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;
//sha224加密方式
+ (NSString *)getSha224String:(NSString *)srcString;
//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString ;
//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString ;
//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString;
@end
