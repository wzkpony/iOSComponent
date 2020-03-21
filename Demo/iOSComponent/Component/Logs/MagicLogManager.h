//
//  MagicLogManager.h
//  lockiOS
//
//  Created by wzk on 2020/3/17.
//  Copyright © 2020 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicLogsVC.h"

NS_ASSUME_NONNULL_BEGIN
/**
 
 使用：
 
 [[MagicLogManager shareManager] start];
 
 DDLogVerbose(@"Verbose");    // 详细日志
 
 DDLogDebug(@"Debug");        // 调试日志
 
 DDLogInfo(@"Info");          // 信息日志
 
 DDLogWarn(@"Warn");          // 警告日志
 
 DDLogError(@"Error");        // 错误日志
 
 NSLog(@"日志路径%@", [[MagicLogManager shareManager] getAllLogFilePath]);
 
 NSLog(@"日志内容%@", [[MagicLogManager shareManager] getAllLogFileContent]);
 */
@interface MagicLogManager : NSObject
@property(nonatomic, strong)DDFileLogger *fileLogger;
+ (MagicLogManager *)shareManager;
- (void)start;                              // 配置日志信息
- (NSArray *)getAllLogFilePath;             // 获取日志路径
- (NSArray *)getAllLogFileContent;          // 获取日志内容
@end

NS_ASSUME_NONNULL_END
