//
//  IMSScannerBorder.h
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMSScannerBorder : UIView
// 边直角的长度 默认为23.f
@property (assign, nonatomic, readonly) CGFloat lineLength;
// 边直角的宽度 默认为4.f
@property (assign, nonatomic, readonly) CGFloat lineWidth;
// 边直角的颜色 默认为#0B8EE9
@property (strong, nonatomic, readonly) UIColor *lineColor;
// 冲击波图像渲染颜色 默认为#0B8EE9
@property (strong, nonatomic) UIColor *scannerLineColor;

/**
 初始化扫描border视图

 @param frame 视图的frame
 @param lineLength 边直角的长度
 @param lineWidth 边直角的宽度
 @param lineColor 边直角的颜色
 @return 扫描border视图
 */
- (instancetype)initWithFrame:(CGRect)frame
				   lineLength:(CGFloat)lineLength
					lineWidth:(CGFloat)lineWidth
				    lineColor:(UIColor * __nullable)lineColor;

/// 开始扫描动画
- (void)startScannerAnimating;
/// 停止扫描动画
- (void)stopScannerAnimating;

@end

NS_ASSUME_NONNULL_END
