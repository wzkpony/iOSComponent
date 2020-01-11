//
//  NSString+NCDate.h
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NCDate)
+(NSString *)timeIntervalFromTimeStr:(NSString *)timeStr withFormater:(NSString *)formater; //时间转换为时间戳
+(NSString *)formateDate:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateForLong:(long)second formatter:(NSString *)fomatter;//时间戳转换为时间

+(NSInteger)getNowInterVal;//获取当前的时间戳
+(NSString *)getNowTime;//获取当前的时间字符串
+(NSString *)formateDateToDay:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyYueri:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyShifen:(NSString *)string;//时间戳转换为时间

+(NSDate *)dateFromTimeStr:(NSString *)timeStr;//年月日转换为date;
+(NSString *)dateFromTimeFormatStr:(NSString *)formatStr withTimeString:(NSString *)timeString;//年月日时分秒时间转换为任意格式时间;

+(NSString *)ret32bitString;//随机的32位字符串

// UTC时间转成本地时间
-(NSString *)timeFromUTCTimeToFormatter:(NSString *)formatterString;

+ (NSString *)getUTCFormateLocalDate;
@end