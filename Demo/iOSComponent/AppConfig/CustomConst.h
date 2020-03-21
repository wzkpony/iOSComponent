//
//  CustomConst.h
//  DuoRongApp
//
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#ifndef CustomConst_h
#define CustomConst_h

//定义UIImage对象
#define App_IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define App_File_URL_String(path,namePath) (App_IsEmpty(namePath)?@"":[NSString stringWithFormat:@"%@%@",path,namePath])


// 空字符串 YES 代表空
#define App_IsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || str == NULL || [str length]<1 ? YES : NO)
/**空转化成展示@“”*/
#define App_ShowString(str) (App_IsEmpty(str)?@"":str)
/**空对象转化@“”对象*/
#define App_ShowObj(obj) (obj?obj:@"")

#define App_EmojiCheatUniCode(str)  [App_ShowString(str) jk_stringByReplacingEmojiCheatCodesWithUnicode]

/**如果是空的就显示“暂无”*/
#define dataOrNotAvailable(string) (App_IsEmpty([string stringByReplacingOccurrencesOfString:@" " withString:@""])?@"暂无":string)


//打印json
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

///常用缩写
#define App_Application        [UIApplication sharedApplication]
#define App_KeyWindow          [UIApplication sharedApplication].keyWindow
#define App_AppDelegate        [UIApplication sharedApplication].delegate
#define App_UserDefaults       [NSUserDefaults standardUserDefaults]
#define App_NotificationCenter [NSNotificationCenter defaultCenter]


#define WeakSelf __weak typeof(self) weakSelf = self;

//app版本号
#define App_SYSTEM_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//build号
#define App_SYSTEM_Build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//app名字
#define App_InfoDict [NSBundle mainBundle].localizedInfoDictionary ?: [NSBundle mainBundle].infoDictionary
#define App_APPName [kInfoDict valueForKey:@"CFBundleDisplayName"] ?: [kInfoDict valueForKey:@"CFBundleName"]

//检查系统版本
#define App_SYSTEM_VERSION_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define App_SYSTEM_VERSION_GREATER_THAN(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define App_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define App_SYSTEM_VERSION_LESS_THAN(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define App_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//延迟
#define App_DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))

#define App_Delegate [UIApplication sharedApplication].delegate

//打开
#define App_OpenURL(url) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]

//


#define APP_FloatPrice(price) [NSString stringWithFormat:@"%.2f",price]


/*时间格式*/
#define DataTimeFormatter @"yyyy-MM-dd HH:mm"//项目中所有的时间格式
#define DataFormatter @"yyyy-MM-dd"//项目中所有的时间格式
#define DataTimeSSFormatter @"yyyy-MM-dd HH:mm:ss"//项目中所有的时间格式


//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* CustomConst_h */
