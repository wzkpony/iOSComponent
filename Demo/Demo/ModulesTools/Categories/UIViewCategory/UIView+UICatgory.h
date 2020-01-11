//
//  UIView+UICatgory.h
//  lockiOS
//
//  Created by wzk on 2019/10/14.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (UICatgory)
//配置button的样式:8厘米拐角半径。和字体颜色的边框
+ (void)viewBorderAndCornerConfig:(UIButton *)button;
//圆角 和边框
- (void)viewBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
//设置拐角半径
- (void)configCornerRadius:(CGFloat )cornerRadius;

- (void)configCornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**设置阴影*/
- (void)shadow;
@end

NS_ASSUME_NONNULL_END
