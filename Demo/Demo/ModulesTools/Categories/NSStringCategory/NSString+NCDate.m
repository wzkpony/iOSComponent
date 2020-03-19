//
//  NSString+NCDate.m
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import "NSString+NCDate.h"

@implementation NSString (NCDate)
+(NSString *)timeIntervalFromTimeStr:(NSString *)timeStr withFormater:(NSString *)formater{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = formater?formater:@"yyyy-MM-dd";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    
    return [NSString stringWithFormat:@"%.f",date.timeIntervalSince1970 *1000];
}
+(NSString *)formateDate:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSString *)formateDateForLong:(long)second formatter:(NSString *)fomatter
{
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second / 1000.0];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = fomatter;
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSString *)formateDateToDay:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}

+(NSString *)formateDateOnlyYueri:(NSString *)string{
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM-dd";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSString *)formateDateOnlyShifen:(NSString *)string{
    
    NSTimeInterval second = string.longLongValue / 1000.0; //毫秒需要除
    
    // 时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    //    NSLog(@"%@", date);
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    
    NSString *stringNew = [fmt stringFromDate:date];
    return stringNew;
}
+(NSInteger)getNowInterVal{
    NSDate  *date = [NSDate date];
    return date.timeIntervalSince1970 * 1000; //乘以1000为毫秒
}
+(NSString *)getNowTime{
    NSDate  *date = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =[fmt stringFromDate:date];
    return dateStr;
}
+(NSDate *)dateFromTimeStr:(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    fmt.dateFormat = @"yyyy-MM-dd";
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    return date;
}

+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}


// 将年月日时分秒时间格式转化成任意格式
- (NSString *)timeFromUTCTimeToFormatter:(NSString *)formatterString {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone localTimeZone];

    if ([self containsString:@"T"]) {
        format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    }
    NSDate *utcDate = [format dateFromString:self];
    [format setDateFormat:formatterString];//
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
    
}
// 将一种时间格式转化成另一种格式
- (NSString *)timeFromUTCTimeFromFromatter:(NSString *)fromMatterString ToFormatter:(NSString *)formatterString {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = fromMatterString;
    format.timeZone = [NSTimeZone localTimeZone];
    
    if ([self containsString:@"T"]) {
        format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    }
    NSDate *utcDate = [format dateFromString:self];
    [format setDateFormat:formatterString];//
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
    
}

//将本地日期字符串转为UTC日期字符串
//本地日期格式:北京时间UTC格式
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate
{
    NSDate  *date = [self getLocalDateWithDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr =[dateFormatter stringFromDate:date];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:dateStr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

//1.根据系统Date获取当地Date
+ (NSDate *)getLocalDateWithDate:(NSDate *)date {
    // 获得系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger interval = [zone secondsFromGMTForDate: date];
    //返回以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

//2.根据字符串获取当地Date
+ (NSDate *)getLocalDateWithDateStr:(NSString *)dateStr {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate * date = [formatter dateFromString:dateStr];
    return date;
}

//3.根据系统Date获取当地Date的字符串
+ (NSString *)getLocalDateStrWithDate:(NSDate *)date {
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    // 下面的格式设置成你想要转化的样子, 2017-07-24 17:47:10
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString * dateStr = [formatter stringFromDate:date];
    return dateStr;
}
//日期对比
- (int)compareOneDay:(NSDate *)currentDay withAnotherDay:(NSDate *)BaseDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *currentDayStr = [dateFormatter stringFromDate:currentDay];
    NSString *BaseDayStr = [dateFormatter stringFromDate:BaseDay];
    NSDate *dateA = [dateFormatter dateFromString:currentDayStr];
    NSDate *dateB = [dateFormatter dateFromString:BaseDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", currentDay, BaseDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}
@end
