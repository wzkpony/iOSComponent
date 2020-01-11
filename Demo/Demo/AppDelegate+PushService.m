//
//  AppDelegate+PushService.m
//  ChinaShippingDemo
//
//  Created by Eve on 2018/9/8.
//  Copyright © 2018年 Adinnt. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import <YYModel/YYModel.h>

@implementation AppDelegate (PushService)

- (void)registJPushWithOptions:(NSDictionary *)launchOptions {

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    BOOL isProduction;
#ifdef DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    //TODO:发布上线需要更改
    [JPUSHService setupWithOption:launchOptions
                           appKey:App_JiGuang_AppKey
                          channel:App_channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    

    /**放到登录之后，因为memberId 必填*/
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0){
//            NSLog(@"registrationID获取成功：%@",registrationID);
//            NSDictionary *dict = @{@"memberId":App_ShowString([JMMemberUserLoginModel user].usrId),@"iosCid":registrationID};
//            [RequestUtil requestGet:api_pushCid para:dict completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//                NSLog(@"%@",responseObject);
//            }];
//        }
//        else{
//            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];
        
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[HDClient sharedClient] bindDeviceToken:deviceToken];
//    });
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
//                                                    message:error.description
//                                                   delegate:nil
//                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                                          otherButtonTitles:nil];
//    [alert show];
}


#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            //程序运行时收到通知，先弹出消息框
            NSLog(@"程序在前台收到推送:%@",userInfo);
            [self gotoPage:userInfo];
        }
        
        else{
            //跳转到指定页面
            NSLog(@"程序在后台收到推送:%@",userInfo);
            [self gotoPage:userInfo];
        }
        
    }
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


// 基于 iOS 6 及以下的系统版本
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)gotoPage:(NSDictionary *)userinfo
{


}
- (void)setAlias:(NSString *)alias withTag:(NSString *)tag{
    if (App_IsEmpty(alias)) {
        [MBProgressHUD ll_showErrorMessage:@"用户ID为空，请重新登录"];
        return;
    }
    if (App_IsEmpty(tag)) {
           [MBProgressHUD ll_showErrorMessage:@"用户部门为空，请重新登录"];
           return;
       }
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:0];
    [JPUSHService setTags:[NSSet setWithObject:tag] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
}
/**清空角标数据*/
- (void) clearAllNotificationForNotificationBar{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
}





/**
 {
 aps = {
 alert = 尊敬的用户:
 您的如下订舱状态已更新
 提单号:5040070630
 最新状态:车辆指派
 动态时间:2016-06-15 16:53:00
 更完整的货物跟踪，请猛戳详情查看!。;
 badge = 1;
 sound = ;
 }
 ;
 busiId = 6103622780;
 _j_uid = 16668029285;
 _j_msgid = 67553997023084309;
 msgType = 2;
 _j_business = 1;
 }
 */


@end
