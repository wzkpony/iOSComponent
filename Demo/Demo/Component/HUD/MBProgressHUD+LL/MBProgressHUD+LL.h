//
//  MBProgressHUD+LL.m
//  LL
//
//  Created by LL on 2017/1/17.
//  Copyright © 2017年 Eve. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LL)



+ (void)ll_showTipMessageInWindow:(NSString*)message;
+ (void)ll_showTipMessageInView:(NSString*)message;
+ (void)ll_showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)ll_showTipMessageInView:(NSString*)message timer:(int)aTimer;

/**
 默认显示在window上,无文字
 */
+ (void)ll_showActivity;
+ (void)ll_showActivityMessageInWindow:(NSString*)message;
+ (void)ll_showActivityMessageInView:(NSString*)message;
+ (void)ll_showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)ll_showActivityMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)ll_showSuccessMessage:(NSString *)Message;
+ (void)ll_showErrorMessage:(NSString *)Message;
+ (void)ll_showInfoMessage:(NSString *)Message;
+ (void)ll_showWarnMessage:(NSString *)Message;


+ (void)ll_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)ll_showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)ll_dismiss;

@end
