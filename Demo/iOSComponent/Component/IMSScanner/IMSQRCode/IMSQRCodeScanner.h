//
//  IMSQRCodeScanner.h
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IMSQRCodeScanner : NSObject

/**
 扫描图像

 @param image 包含二维码的图像
 @param completion 完成回调
 @remark 目前只支持64位的iOS设备
 */
+ (void)scanImage:(UIImage *)image completion:(void(^)(NSArray *values))completion;


/**
 使用 string 异步生成二维码图像

 @param string 二维码图像的字符串
 @param completion 完成回调
 */
+ (void)qrImageWithString:(NSString *)string completion:(void(^)(UIImage *image))completion;

@end
