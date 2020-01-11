//
//  NSString+JSON.m
//  IronFish
//
//  Created by wzk on 2018/12/10.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

/**数组字典转json字符串*/
+ (NSString*)stringToJsonData:(NSDictionary *)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return jsonString;
}
//url编码
+ (NSString *)urlEncoding:(NSString *)stringURL
{
//    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)stringURL, nil, nil, kCFStringEncodingUTF8));
    NSString * encodingString = [stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodingString;
}
@end
