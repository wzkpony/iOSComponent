//
//  MBProgressHUD+LL.m
//  LL
//
//  Created by LL on 2017/1/17.
//  Copyright © 2017年 Eve. All rights reserved.
//

#import "MBProgressHUD+LL.h"
#import "UIImage+GIF.h"

#define HUD_BG_COLOR [[UIColor blackColor] colorWithAlphaComponent:0.8]

static NSTimeInterval const hud_interval = 1.5;

@implementation MBProgressHUD (LL)

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    [self ll_dismiss];
    
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=message ? : @"";
    hud.label.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = HUD_BG_COLOR;
    hud.contentColor = [UIColor whiteColor];
    
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

+ (void)ll_showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:hud_interval];
}
+ (void)ll_showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:hud_interval];
}
+ (void)ll_showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)ll_showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    [self ll_dismiss];
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = HUD_BG_COLOR;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.label.font=[UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [hud hideAnimated:YES afterDelay:1];
}
#pragma mark-------------------- show Activity----------------------------
+ (void)ll_showActivity
{
    [self showActivityMessage:nil isWindow:true timer:0];
}
+ (void)ll_showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)ll_showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)ll_showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)ll_showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    /** 自定义动画
    hud.mode = MBProgressHUDModeCustomView;
    
    // 自定义加载动画
    NSString *gifImagPath = [[NSBundle mainBundle] pathForResource:@"白色loading" ofType:@"gif"];
    UIImage *image = [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:gifImagPath]];
    UIImageView *loadingView = [[UIImageView alloc] initWithImage:image];
//    loadingView.frame = CGRectMake(0, 0, 50, 50);
    hud.customView = loadingView;
     */
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

+ (void)ll_showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+LL.bundle/MBProgressHUD/MBHUD_Success";
    [self ll_showCustomIconInWindow:name message:Message];
}
+ (void)ll_showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+LL.bundle/MBProgressHUD/MBHUD_Error";
    [self ll_showCustomIconInWindow:name message:Message];
}
+ (void)ll_showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+LL.bundle/MBProgressHUD/MBHUD_Info";
    [self ll_showCustomIconInWindow:name message:Message];
}
+ (void)ll_showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+LL.bundle/MBProgressHUD/MBHUD_Warn";
    [self ll_showCustomIconInWindow:name message:Message];
}
+ (void)ll_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self ll_showCustomIcon:iconName message:message isWindow:true];
    
}
+ (void)ll_showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self ll_showCustomIcon:iconName message:message isWindow:false];
}
+ (void)ll_showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    [hud hideAnimated:YES afterDelay:hud_interval];
    
}
+ (void)ll_dismiss
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideAllHUDsForView:[self getCurrentUIVC].view animated:YES];
}
//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
    if ([superVC isKindOfClass:[UINavigationController class]]) {
        
        return ((UINavigationController*)superVC).viewControllers.lastObject;  
    }
    return superVC;
}

@end
