//
//  IMSQRCodeViewController.h
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMSScannerViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface IMSQRCodeViewController : IMSScannerViewController

- (instancetype)initWithScanRectOffset:(CGFloat)scannerRectOffset
					      scannerColor:(UIColor * __nullable)scannerColor
					        completion:(void(^ __nullable)(NSString *result))completion
				       errorCompletion:(void(^ __nullable)(void))errorCompletion;
// 上提示label
@property (strong, nonatomic, readonly) UILabel *topTipLabel;
// 下提示label
@property (strong, nonatomic, readonly) UILabel *bottomTipLabel;
// 遮罩背景颜色 默认为黑色(alpha 0.4)
@property (strong, nonatomic) UIColor *maskViewBackgroundColor;
// 扫描区域的上下偏移度，默认为0.f，在正中间
@property (assign, nonatomic, readonly) CGFloat scannerRectOffset;
// 扫描器颜色 默认为#0B8EE9
@property (strong, nonatomic, readonly) UIColor *scannerColor;

// 顶部提示与扫描区域的间隔 默认为30.f
@property (assign, nonatomic) CGFloat topMargin;
// 底部提示与扫描区域的间隔 默认为30.f
@property (assign, nonatomic) CGFloat bottomMargin;
@end

NS_ASSUME_NONNULL_END
