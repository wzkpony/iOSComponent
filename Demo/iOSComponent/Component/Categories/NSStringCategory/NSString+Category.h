//
//  NSString+Category.h
//  IronFish
//
//  Created by wzk on 2018/12/10.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//数据验证
#define kStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define kSafeStr(f) (kStrValid(f) ? f:@"")
#define kHasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define kValidStr(f) kStrValid(f)
#define kValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define kValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]])
#define kValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define kValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define kValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

@interface NSString (Category)
//按字节截取字符串
- (NSString *)subStringByByteWithIndex:(NSInteger)index;

//计算字节长度
- (NSInteger)getToInt;
/**获取汉字的首字母*/
+ (NSString *)firstCharactor:(NSString *)aString;


//获取沙盒路径
+ (NSString *)getDocumentPath;

/**电话号码中间4位数脱敏*/
+ (NSString *)phoneXingString:(NSString *)phone;

/**获取电话号码尾号4位数*/
+ (NSString *)phoneLastFourString:(NSString *)phone;


/**6-20位英文和数字组合 密码校验*/
+ (BOOL)checkPassword:(NSString *) password;

/**脱敏*/
+ (NSString *)phoneFirstXingString:(NSString *)string;

//获取设备👌
+ (NSString *)getDeviceId:(NSString *)kKeychainService kKeychainDeviceId:(NSString *)kKeychainDeviceId;
/**99+字符串*/
+ (NSString *)numberString:(NSString *)numberString;
/**判断是否为空*/
+ (BOOL)isBlankString:(NSString *)string;
/**获取UUID*/
+ (NSString*)generateUuidString;
/**获取高度*/
+ (CGFloat)getAttributeSizeHeight:(NSAttributedString *)attr Width:(CGFloat)width;
/**字符串高度*/
+ (CGFloat)getTextSizeHeight:(NSString*)text UIFont:(UIFont *)font Width:(CGFloat)width;
/**获取字符串高度*/
+ (CGFloat)getTextSizeWidth:(NSString *)text UIFont:(NSInteger)font  Height:(CGFloat)height;

/**后7脱敏*/
+ (NSString *)securePhone:(NSString *)phone;
/**富文本*/
+ (NSMutableAttributedString *)attributeWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)color;

/**获取星期*/
+ (NSString *)dateWeekWithDateString:(NSString *)dateString;
//判断是否输入了emoji 表情

+ (BOOL)stringContainsEmoji:(NSString *)string;
//判断是否输入了emoji 表情。
+ (BOOL)isEmoji:(NSString *)string;
//不得超过两位小数
+ (BOOL)checkDecimal:(NSString *)str;
/**固定电话，包括400电话*/
+ (BOOL)telHas:(NSString *)str;

/**
 整数 
 @param str 字符串
 @return yes/no
 */
+ (BOOL)checkInteger:(NSString *)str;

+ (BOOL)checkNumber:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
