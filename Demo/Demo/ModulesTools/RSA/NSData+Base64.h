//
//  NSData+Base64.h
//  rsa
//
//  Created by wzk on 2017/12/29.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end

