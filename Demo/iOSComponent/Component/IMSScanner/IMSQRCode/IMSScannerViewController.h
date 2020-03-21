//
//  IMSScannerViewController.h
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/16.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSScannerViewController : UIViewController

- (instancetype)initWithCompletion:(void(^ __nullable)(NSString *result))completion;

- (instancetype)initWithCompletion:(void(^ __nullable)(NSString *result))completion
				   errorCompletion:(void(^ __nullable)(void))errorCompletion;

// 扫描有效区域
@property (assign, nonatomic) CGRect scanFrame;
// 完成扫描回调
@property (copy, nonatomic) void(^completion)(NSString *result);
// 权限错误提示回调
@property (copy, nonatomic) void(^errorCompletion)(void);


/**
 开始扫描
 */
- (void)startScan;

/**
 结束扫描
 */
- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
