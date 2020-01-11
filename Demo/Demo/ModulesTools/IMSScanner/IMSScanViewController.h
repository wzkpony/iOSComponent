//
//  CALScan.h
//  CALScan
//
//  Created by Dong on 2017/11/2.
//  Copyright © 2017年 aliyun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IMSScanViewController : UIViewController
/**
 标题
 默认为‘扫描二维码’
 */
@property (nonatomic, copy) NSString *titleStr;

/**
 提示
 默认为‘请将设备二维码防止在识别框中’
 */
@property (nonatomic, copy) NSString *tipStr;

/**
 没开启相机权限时提示
 */
@property (nonatomic, copy) NSString *errorStr;

/**
 提示框按钮文字
 */
@property (nonatomic, copy) NSString *errorConfirm;
/**
 扫描结果回调
 value 扫码得出的string
 */
@property (nonatomic, copy) void(^resultBlock)(NSString *value);

@end


