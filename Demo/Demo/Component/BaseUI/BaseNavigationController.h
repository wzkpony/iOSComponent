//
//  BaseNavigationController.h
//  TodayGo
//
//  Created by Felix on 2017/7/16.
//
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

#pragma mark -- 系统的navBar --
/**设置bar的背景颜色和透明度和字体颜色*/
- (void)settingNavBarColor:(UIColor *)barColor titleColor:(UIColor *)titleColor alpha:(CGFloat)alpha;
- (void)showNavBar;//显示Bar
- (void)hiddenNavBar;//隐藏Bar
@end
