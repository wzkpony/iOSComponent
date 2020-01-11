//
//  IMSScannerMaskView.h
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/11.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 扫描遮罩视图
@interface IMSScannerMaskView : UIView

/**
 使用裁切区域实例化遮罩视图

 @param frame 视图区域
 @param cropRect 裁切区域
 @return 遮罩视图
 */
+ (instancetype)maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropRect;

// 裁切区域
@property (assign, nonatomic) CGRect cropRect;
// 遮罩背景颜色 默认为黑色(alpha 0.4)
@property (strong, nonatomic) UIColor *maskViewBackgroundColor;
// 边框颜色 默认为#0B8EE9
@property (strong ,nonatomic) UIColor *borderColor;
// 边框宽度 默认为1.f
@property (assign, nonatomic) CGFloat borderWidth;

@end
