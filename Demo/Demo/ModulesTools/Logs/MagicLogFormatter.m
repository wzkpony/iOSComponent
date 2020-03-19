//
//  MagicLogFormatter.m
//  lockiOS
//
//  Created by wzk on 2020/3/17.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "MagicLogFormatter.h"
@implementation MagicLogFormatter
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    NSString *loglevel = nil;
    switch (logMessage.flag){
        case DDLogFlagError:
            loglevel = @"[ERROR]--->";
            break;
        case DDLogFlagWarning:
            loglevel = @"[WARN]--->";
            break;
        case DDLogFlagInfo:
            loglevel = @"[INFO]--->";
            break;
        case DDLogFlagDebug:
            loglevel = @"[DEBUG]--->";
            break;
        case DDLogFlagVerbose:
            loglevel = @"[VBOSE]--->";
            break;
        default:
            break;
    }
    NSString *resultString = [NSString stringWithFormat:@"%@ %@___line[%ld]__%@", loglevel, logMessage->_function, logMessage->_line, logMessage->_message];
    return resultString;
}
@end
/*
 DDLogMessage中返回信息
 
 NSString *_message;             // 具体logger内容
 DDLogLevel _level;              // 全局lever等级
 DDLogFlag _flag;                // log的flag等级
 NSInteger _context;             //
 NSString *_file;                // 文件
 NSString *_fileName;            // 文件名称
 NSString *_function;            // 函数名
 NSUInteger _line;               // 行号
 id _tag;                        //
 DDLogMessageOptions _options;   //
 NSDate *_timestamp;             // 时间
 NSString *_threadID;            // 线程id
 NSString *_threadName;          // 线程名称
 NSString *_queueLabel;          // gcd线程名称
 
 
 */
