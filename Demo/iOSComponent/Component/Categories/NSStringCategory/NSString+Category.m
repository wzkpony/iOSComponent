//
//  NSString+Category.m
//  IronFish
//
//  Created by wzk on 2018/12/10.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "NSString+Category.h"
#import "SAMKeychain.h"
static CGFloat const kTextLineSpace = 0;

@implementation NSString (Category)
/**获取汉字的首字母*/
+ (NSString *)firstCharactor:(NSString *)aString
{
    NSMutableString *str = [NSMutableString stringWithString:aString];
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *pinYin = [str capitalizedString];
    
    if (pinYin.length>0) {
        pinYin = [pinYin substringToIndex:1];
    }
    
    return pinYin;
}


//获取设备👌
+ (NSString *)getDeviceId:(NSString *)kKeychainService kKeychainDeviceId:(NSString *)kKeychainDeviceId {
    // 读取设备号
    /**
     NSString *kKeychainService = @"com.coscon.COSCOEBProjects";
     NSString *kKeychainDeviceId    = @"KeychainDeviceId";
     */
    
    NSString *localDeviceId = [SAMKeychain passwordForService:kKeychainService account:kKeychainDeviceId];

    if (!localDeviceId) {
        // 保存设备号
        CFUUIDRef deviceId = CFUUIDCreate(NULL);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceId);
        [SAMKeychain setPassword:[NSString stringWithFormat:@"%@", deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId = [NSString stringWithFormat:@"%@", deviceIdStr];
    }
    return localDeviceId;
}
 


//计算字节长度
- (NSInteger)getToInt
{
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}
//按字节截取字符串
- (NSString *)subStringByByteWithIndex:(NSInteger)index{
    NSString *stringContent = [self mutableCopy];
    NSInteger sum = 0;
    
    NSString *subStr = [[NSString alloc] init];
    
    for(int i = 0; i<[stringContent length]; i++){
        
        unichar strChar = [stringContent characterAtIndex:i];
        
        if(strChar < 256){
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            subStr = [stringContent substringToIndex:i+1];
            
            return subStr;
        }
        
    }
    
    return subStr;
}



+ (NSString *)getDocumentPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return documentPath;
}

/**电话号码中间4位数脱敏*/
+ (NSString *)phoneXingString:(NSString *)phone{
    if (phone && phone.length > 7) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(phone.length -8, 4) withString:@"****"];//防止号码有前缀所以使用倒数第8位开始替换
    }
    return phone;
}
/**脱敏*/
+ (NSString *)phoneFirstXingString:(NSString *)string{
    if (string.length > 0) {
        NSString *firstStr = [string substringToIndex:1];
        if ([NSString isChineseFirst:firstStr]) {
            string = [string stringByReplacingCharactersInRange:NSMakeRange(1, string.length-1) withString:@"***"];//
        }
        else if (string.length > 3) {
            
            string = [string stringByReplacingCharactersInRange:NSMakeRange(3, string.length-3) withString:@"***"];//
        }
        else{
            string = [NSString stringWithFormat:@"%@***",string];
        }
    }
   
    return string;
}

/**是否中文开头*/
+ (BOOL)isChineseFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}



/**获取电话号码尾号4位数*/
+ (NSString *)phoneLastFourString:(NSString *)phone{
    if (phone && phone.length > 4) {
        phone = [phone substringWithRange:NSMakeRange(phone.length -4, 4)];//防止号码有前缀所以使用倒数第8位开始替换
    }
    return phone;
}
/**6到20位数字和字母*/
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}


/**99+字符串*/
+ (NSString *)numberString:(NSString *)numberString{
    if (App_IsEmpty(numberString)||
        [numberString intValue] == 0) {
        return nil;
    }
    else{
        if ([numberString integerValue]>99) {
            numberString = @"99+";
        }
        return [NSString stringWithFormat:@"%@",numberString];
    }
}


/**判断是否为空*/
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
/**获取UUID*/
+ (NSString*)generateUuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}
/**获取高度*/
+ (CGFloat)getAttributeSizeHeight:(NSAttributedString *)attr Width:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [attr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil].size;
    return ceilf(size.height);
}
/**字符串高度*/
+ (CGFloat)getTextSizeHeight:(NSString*)text UIFont:(UIFont *)font Width:(CGFloat)width {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    //    paragraph.lineSpacing = kTextLineSpace;
    
    NSDictionary *attributeDic = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributeDic context:nil].size;
    return ceilf(size.height);
}
/**获取字符串高度*/
+ (CGFloat)getTextSizeWidth:(NSString *)text UIFont:(NSInteger)font  Height:(CGFloat)height {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    paragraph.lineSpacing = kTextLineSpace;
    
    NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSParagraphStyleAttributeName: paragraph};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [text boundingRectWithSize:CGSizeMake(0, height) options:options attributes:attributeDic context:nil].size;
    return ceilf(size.width);
}

/**后7脱敏*/
+ (NSString *)securePhone:(NSString *)phone{
    NSString *str = [phone substringFromIndex:7];
    return [@"*******" stringByAppendingString:str];
}

/**富文本*/
+ (NSMutableAttributedString *)attributeWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)color {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = kTextLineSpace;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName: color, NSFontAttributeName: font};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    
    return attributeStr;
}

/**获取星期*/
+ (NSString *)dateWeekWithDateString:(NSString *)dateString
{
    NSTimeInterval time=[dateString doubleValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSString *weekStr;
    if (_weekday == 1) {
        weekStr = @"星期日";
    }else if (_weekday == 2){
        weekStr = @"星期一";
    }else if (_weekday == 3){
        weekStr = @"星期二";
    }else if (_weekday == 4){
        weekStr = @"星期三";
    }else if (_weekday == 5){
        weekStr = @"星期四";
    }else if (_weekday == 6){
        weekStr = @"星期五";
    }else if (_weekday == 7){
        weekStr = @"星期六";
    }
    return weekStr;
}

//判断是否输入了emoji 表情

+ (BOOL)stringContainsEmoji:(NSString *)string{
    
    __block BOOL returnValue = NO;
    
    
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
     
                               options:NSStringEnumerationByComposedCharacterSequences
     
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
                                const unichar hs = [substring characterAtIndex:0];
                                
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    
                                    if (substring.length > 1) {
                                        
                                        const unichar ls = [substring characterAtIndex:1];
                                        
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            
                                            returnValue = YES;
                                            
                                        }
                                        
                                    }
                                    
                                } else if (substring.length > 1) {
                                    
                                    const unichar ls = [substring characterAtIndex:1];
                                    
                                    if (ls == 0x20e3) {
                                        
                                        returnValue = YES;
                                        
                                    }
                                    
                                    
                                    
                                } else {
                                    
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        //键盘也会走这里
                                        returnValue = NO;
                                        
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        
                                        returnValue = YES;
                                        
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        
                                        returnValue = YES;
                                        
                                    }else if (hs == 0x200d){
                                        
                                        returnValue = YES;
                                        
                                    }
                                    
                                }
                                
                            }];
    
    
    
    return returnValue;
    
}
//判断是否输入了emoji 表情。
+ (BOOL)isEmoji:(NSString *)string
{
    if ([string length]<2)
    {
        return NO;
    }
    
    static NSCharacterSet *_variationSelectors;
    _variationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];
    
    if ([string rangeOfCharacterFromSet: _variationSelectors].location != NSNotFound)
    {
        return YES;
    }
    const unichar high = [string characterAtIndex:0];
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF)
    {
        const unichar low = [string characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        BOOL enoji = (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        return enoji;
        // Not surrogate pair (U+2100-27BF)
    }
    else
    {
        BOOL enoji = (0x2100 <= high && high <= 0x27BF);
        return enoji;
    }
}

/**
 判断是否是两位小数
 
 @param str 字符串
 @return yes/no
 */
+ (BOOL)checkDecimal:(NSString *)str
{
    NSString *regex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject: str])
    {
        return YES;
    }else{
        return NO;
    }
}

/**
 整数
 @param str 字符串
 @return yes/no
 */
+ (BOOL)checkInteger:(NSString *)str
{
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject: str])
    {
        return YES;
    }else{
        return NO;
    }
}
/**
 数字
 @param str 字符串
 @return yes/no
 */
+ (BOOL)checkNumber:(NSString *)str
{
    NSString *regex = @"^[0-9]\\d*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject: str])
    {
        return YES;
    }else{
        return NO;
    }
}

/**固定电话，包括400电话*/
+ (BOOL)telHas:(NSString *)str{
//    ^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$
//    (^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[3578]\d{9})$)|(^(400)-(\d{3})-(\d{4})(.)(\d{1,4})$)|(^(400)-(\d{3})-(\d{4}$))
    NSString *regex = @"(^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$)|(^((\\(\\d{3}\\))|(\\d{3}\\-))?(1[3578]\\d{9})$)|(^(400)-(\\d{3})-(\\d{4})(.)(\\d{1,4})$)|(^(400)-(\\d{3})-(\\d{4}$))";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject: str])
    {
        return YES;
    }else{
        return NO;
    }
}
@end
