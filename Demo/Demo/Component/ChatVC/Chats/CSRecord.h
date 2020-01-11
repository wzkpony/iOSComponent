//
//  CSRecord.h
//  Voice
//
//  Created by 123 on 2017/12/7.
//  Copyright © 2017年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSRecord : NSObject
- (NSInteger)audioDuration;

+ (instancetype)ShareCSRecord;
- (void)beginRecord:(void(^)(NSInteger statusCode))completionBlock;
- (void)endRecord:(void(^)(NSString *path,NSString *times))endBlock;
//- (void)getVoicePath;
//- (void)getVoiceFile;
- (void)playRecord:(NSString *)name;
- (void)stopPlayRecord:(NSString *)name;
- (void)stopPlayAll;//关闭所有的播放/**释放单利*/
-(NSString *)getSavePath:(NSString *)name;

- (void)toMp3Name:(NSString *)mp3Name oldName:(NSString *)oldName;
@end
