//
//  UIView+UICatgory.m
//  lockiOS
//
//  Created by wzk on 2019/10/14.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "UIView+UICatgory.h"

@implementation UIView (UICatgory)
//配置button的样式:8厘米拐角半径。和字体颜色的边框
+ (void)viewBorderAndCornerConfig:(UIButton *)button{
    button.clipsToBounds = YES;
    button.layer.borderColor = button.currentTitleColor.CGColor;
    button.layer.cornerRadius = 8;
    button.layer.borderWidth = 1;
}

//圆形 和边框
- (void)viewBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.clipsToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.cornerRadius = (self.jk_width/2.0);
    self.layer.borderWidth = borderWidth;
}

//配置拐角半径
- (void)configCornerRadius:(CGFloat )cornerRadius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
//配置拐角半径和边框
- (void)configCornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}
/**设置阴影*/
- (void)shadow{
    self.layer.shadowOffset = CGSizeMake(0, -1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = App_UICOLOR_HEX(@"#999999").CGColor;
}
@end
