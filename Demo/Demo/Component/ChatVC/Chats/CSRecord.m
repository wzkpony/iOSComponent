//
//  CSRecord.m
//  Voice
//
//  Created by 123 on 2017/12/7.
//  Copyright © 2017年 123. All rights reserved.
//

#import "CSRecord.h"
#import <AVFoundation/AVFoundation.h>

@interface CSRecord()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    NSInteger audioDurationSeconds;//时长
}
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)AVAudioRecorder * audioRecorder;//音频录音机
//@property (nonatomic,strong)AVAudioPlayer   * audioPlayer;//音频播放器，用于播放录音
@property (nonatomic,copy)void(^endRecordBlock)(NSString *path,NSString *times);

@property (nonatomic,strong)AVPlayer *player;
@end
@implementation CSRecord
static CSRecord *record = nil;
static dispatch_once_t onceTokenRecord;

+ (instancetype)ShareCSRecord
{
    dispatch_once(&onceTokenRecord, ^{
        record = [[CSRecord alloc] init];
    });
    return record;
}
- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

}
- (NSInteger)audioDuration {
    
    return audioDurationSeconds;
}
//获得录音机对象
-(AVAudioRecorder * )audioRecorder
{
    
    //    if (!_audioRecorder) {
    if ([_audioRecorder isRecording]) {
        [_audioRecorder stop];
    }
    NSString *pathName = [NSString stringWithFormat:@"%@.caf",_name];
    //创建录音文件保存路径
    NSURL * url = [NSURL fileURLWithPath:[self getSavePath:pathName]];
    //创建录音格式设置
    NSDictionary * setting = [self getAudioSettion];
    //创建录音机
    NSError * error = nil;
    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
    [_audioRecorder prepareToRecord];
    _audioRecorder.delegate = self;
    if(error)
    {
        NSLog(@"创建录音机对象发生错误，错误信息是：%@",error.localizedDescription);
        return nil;
    }
    
    
    //    }
    return _audioRecorder;
    
}

//设置音频格式
-(NSDictionary *)getAudioSettion
{
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMedium] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    //。。。。是他设置
    return result;
}

/**开始录音，初始化名字*/
- (void)beginRecord:(void(^)(NSInteger statusCode))completionBlock
{
    /**录音前停止播放*/
    [self.player pause];

    /**开始录音时*/
    _name = [[NSDate date] jk_stringWithFormat:@"yyyyMMddHHmmss"];
    if (![self.audioRecorder isRecording])
    {
        NSLog(@"初始化名字:%@",_name);
       
        // 删掉录音文件
//        [_audioRecorder deleteRecording];
        //创建音频会话对象
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        //设置category
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            // 首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        [_audioRecorder record];
        completionBlock(1);
            
        
    }
}
/**
 结束录音，发送请求
 path :音频路径
 times ：音频的名字，用时间作为名字，不会重复
 */
- (void)endRecord:(void(^)(NSString *path,NSString *times))endBlock
{
    NSLog(@"录音结束Path");
    /**为了不影响门铃声音响*/
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDuckOthers error:nil];

    self.endRecordBlock = endBlock;
    [_audioRecorder stop];
}


#pragma mark -- 录音代理方法 AVAudioRecorderDelegate--
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSString *pathName = [NSString stringWithFormat:@"%@.caf",_name];

    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[self getSavePath:pathName]] options:nil];
    CMTime audioDuration = audioAsset.duration;
    audioDurationSeconds = [[NSString stringWithFormat:@"%ld",(long)CMTimeGetSeconds(audioDuration)] integerValue];
    NSLog(@"录音完成!-->%ld",audioDurationSeconds);
    NSString *pathMp3Name = [NSString stringWithFormat:@"%@.mp3",_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getSavePath:pathName]]) {
        NSLog(@"文件已存在");

           [self toMp3Name:pathMp3Name oldName:pathName];
    }
    else{
        NSLog(@"文件暂未生成");
      
    }
 
}
//转化成mp3
- (void)toMp3Name:(NSString *)mp3Name oldName:(NSString *)oldName{
    /**
     20191101183627.mp3
     20191101183627.caf
     */
    NSString *cafFilePath = [self getSavePath:oldName];
    NSString *mp3FilePath = [self getSavePath:mp3Name];
    @try {
        
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024,SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        
        int PCM_SIZE = 8192;
        int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        //这里的44100值和录音的字典中的AVSampleRateKey一样
        lame_set_in_samplerate(lame, 44100);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            fwrite(mp3_buffer, write, 1, mp3);
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新UI操作
        });
        
    }
    @finally {
        //GCD延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //更新UI操作
            if (self.endRecordBlock == nil) {
                return ;
            }
            else{
                self.endRecordBlock(mp3FilePath, mp3Name);
            }
            
            
        });
        
        
    }
    
    
}

//创建播放器
-(AVPlayer *)configAudioPlayer:(NSString *)nameName
{
    NSLog(@"播放文件名字:%@",nameName);
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.player = nil;

    NSURL * url = [NSURL fileURLWithPath:[self getSavePath:nameName]];
    self.player = [[AVPlayer alloc] initWithURL:url];
    
    

    return self.player;

}
- (void)playbackFinished{
    /**为了不影响门铃声音响*/
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDuckOthers error:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"audioPlayerDidFinishPlaying" object:nil];

}

- (void)playRecord:(NSString *)name
{
    
    self.player = [self configAudioPlayer:name];
    [self.player pause];
    
    [self.player play];
}
- (void)stopPlayRecord:(NSString *)name
{
    
    self.player = [self configAudioPlayer:name];
    [self.player pause];
}
/**释放单利*/
- (void)stopPlayAll{
    [self.player pause];
    onceTokenRecord = 0;
    record = nil;
}


//文件的路径
-(NSString *)getSavePath:(NSString *)name
{
        NSString * urlStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ) lastObject] stringByAppendingPathComponent:name];
//    NSString * urlStr = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    return urlStr;
    
}
@end

