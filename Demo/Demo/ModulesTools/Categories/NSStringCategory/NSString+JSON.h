//
//  NSString+JSON.h
//  IronFish
//
//  Created by wzk on 2018/12/10.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JSON)
/**数组字典转json字符串*/
+ (NSString*)stringToJsonData:(NSDictionary *)object;
//url编码
+ (NSString *)urlEncoding:(NSString *)stringURL;
@end

NS_ASSUME_NONNULL_END
