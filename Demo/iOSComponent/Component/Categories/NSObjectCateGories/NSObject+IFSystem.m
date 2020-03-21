//
//  NSObject+IFSystem.m
//  IronFish
//
//  Created by wzk on 2018/12/25.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "NSObject+IFSystem.h"

@implementation NSObject (IFSystem)
#pragma mark - 使用系统邮件客户端发送邮件
/**
 recipients:收件人
 subject :主题
 messageBody :内容
 */
+ (MFMailComposeViewController *)launchMailAppDelegateRecipients:(NSArray<NSString *> *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody delegate:(id<MFMailComposeViewControllerDelegate>)obj
{
    MFMailComposeViewController *picker = nil;
    if([MFMailComposeViewController canSendMail]) {// 判断设备是否支持发送邮件
        // 创建对象
        picker = [[MFMailComposeViewController alloc]init];
        // 设置代理
        picker.mailComposeDelegate = obj;
        picker.navigationBar.tintColor= [UIColor blackColor];
        // 设置收件人
        [picker setToRecipients:recipients];
        // 设置主题
        [picker setSubject:subject];
        // 设置邮件内容
        [picker setMessageBody:messageBody isHTML:NO];
       
    }
    else{
        [MBProgressHUD ll_showErrorMessage:@"请先设置登录邮箱号"];
    }
  
    return picker;
}
@end
