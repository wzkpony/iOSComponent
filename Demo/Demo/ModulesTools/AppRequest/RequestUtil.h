//
//  RequestUtil.h
//  JJShipping
//
//  Created by Mr.Han on 2017/4/25.
//  Copyright © 2017年 Adinnet_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestUtil : NSObject



+ (RequestUtil *)manager;

//普通POST请求json提交
+(void)requestPost:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//普通Patch请求
+(void)requestPatch:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
//普通elete请求
+ (void)requestDelete:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//多个上传文件
+(void)requestPostForFiles:(NSString *)action para:(id)params fileArray:(NSArray *)fileArray nameKeys:(NSArray <NSString *>*)names mimeTypes:(NSArray <NSString *>*)mimeTypes completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;
//普通Get请求
+(void)requestGet:(NSString *)action para:(id)params completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;

//下载文件
+ (void)requestDownLoadURL:(NSString *)urlString completionBlock:(void(^)(id errorString, id responseObject ))completionBlock;

//使用NSURLSession 发起一个get请求
+ (void)requestGetURLSession:(NSString *)urlString completionBlock:(void(^)(NSInteger statusCode,id errorString, id responseObject ))completionBlock;


/**获取web的cookie*/
+ (NSString *)getCookies;
/**图片压缩*/
+ (NSData *)configImageData:(UIImage *)image;
@end
