//
//  AppDelegate+EaseMob.m
//  EasMobSample
//
//  Created by dujiepeng on 12/5/14.
//  Copyright (c) 2014 dujiepeng. All rights reserved.
//

#import "AppDelegate+HelpDesk.h"
//#import "LocalDefine.h"
#import <Bugly/Bugly.h>

/**
 *  本类中做了EaseMob初始化和推送等操作
 */

@implementation AppDelegate (HelpDesk)
- (void)easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Bugly startWithAppId:@"b336efe49a"];
    //ios8注册apns
//    [self registerRemoteNotification];
    //初始化环信客服sdk
    [self initializeCustomerServiceSdk];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    [audioSession setActive:YES error:nil];
    
    // 注册环信监听
    [self setupNotifiers];
    
    
    /*
     注册IM用户【注意:注册建议在服务端创建，而不要放到APP中，可以在登录自己APP时从返回的结果中获取环信账号再登录环信服务器。】
     */
    
    //添加自定义小表情
#pragma mark smallpngface
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapePattern:@"\\[[^\\[\\]]{1,3}\\]"];
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapeDictionary:[HDConvertToCommonEmoticonsHelper emotionsDictionary]];

}
- (void)configAccountManager{
    CSDemoAccountManager *lgM = [CSDemoAccountManager shareLoginManager];
    lgM.appkey = kDefaultAppKey;
    lgM.cname = kDefaultCustomerName;
    lgM.nickname = @"我";
    lgM.username = @"";
    lgM.password = hxPassWord;
    lgM.tenantId = kDefaultTenantId;
    lgM.projectId = kDefaultProjectId;

}
//初始化客服sdk
- (void)initializeCustomerServiceSdk {
    
    [self configAccountManager];
    CSDemoAccountManager *lgM = [CSDemoAccountManager shareLoginManager];
    HDOptions *option = [[HDOptions alloc] init];
    option.appkey = lgM.appkey;
    option.tenantId = lgM.tenantId;
    option.enableConsoleLog = YES; // 是否打开日志信息
    option.apnsCertName = APP_APNSCertName;
    option.visitorWaitCount = YES; // 打开待接入访客排队人数功能
    option.showAgentInputState = YES; // 是否显示坐席输入状态
    HDClient *client = [HDClient sharedClient];
    HDError *initError = [client initializeSDKWithOptions:option];
    if (initError) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"initialization_error", @"Initialization error!") message:initError.errorDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self registerEaseMobNotification];
    
}


//修改关联app后需要重新初始化
- (void)resetCustomerServiceSDK {
    //如果在登录状态,账号要退出
    HDClient *client = [HDClient sharedClient];
    HDError *error = [client logout:NO];
    if (error != nil) {
            NSLog(@"登出出错:%@",error.errorDescription);
    }
#warning "changeAppKey 为内部方法，不建议使用"
    HDError *er = [client changeAppKey:@"appkey"];
    if (er == nil) {
        NSLog(@"appkey 已更新");
    } else {
        NSLog(@"appkey 更新失败,请手动重启");
    }
}

// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)setupNotifiers{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}
/**ios 10以上*/
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
//    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//    completionHandler(UNNotificationPresentationOptionBadge|
//                      UNNotificationPresentationOptionSound|
//                      UNNotificationPresentationOptionAlert);
//}
///**处理通知*/
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
//    //处理推送过来的数据
////    [self handlePushMessage:response.notification.request.content.userInfo];
////    completionHandler();
//}
///**iOS10一下*/
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary * _Nonnull)userInfo fetchCompletionHandler:(void (^ _Nonnull)(UIBackgroundFetchResult))completionHandler{
//    NSLog(@"didReceiveRemoteNotification:%@",userInfo);
//    /*
//     UIApplicationStateActive 应用程序处于前台
//     UIApplicationStateBackground 应用程序在后台，用户从通知中心点击消息将程序从后台调至前台
//     UIApplicationStateInactive 用用程序处于关闭状态(不在前台也不在后台)，用户通过点击通知中心的消息将客户端从关闭状态调至前台
//     */
//    //应用程序在前台给一个提示特别消息
//    if (application.applicationState == UIApplicationStateActive) {
//        //应用程序在前台
////        [self createAlertViewControllerWithPushDict:userInfo];
//    }else{
//        //其他两种情况，一种在后台程序没有被杀死，另一种是在程序已经杀死。用户点击推送的消息进入app的情况处理。
////        [self handlePushMessage:userInfo];
//    }
//    completionHandler(UIBackgroundFetchResultNewData);
//}



#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    [[HDClient sharedClient] applicationDidEnterBackground:notif.object];
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[HDClient sharedClient] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
//    [[HDClient sharedClient] applicationdidfinishLounching];
 //   [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
  //  [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
 //   [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeRecording" object:nil];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
 //   [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
//    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
}


// 注册推送
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
//        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
//        [application registerUserNotificationSettings:settings];
        
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
            [center setDelegate:self];
            UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
            [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    NSLog(@"注册成功");
                }else{
                    NSLog(@"注册失败");
                }
            }];
        }else if (@available(iOS 8.0, *)){
            UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
            UIUserNotificationTypeSound |
            UIUserNotificationTypeAlert;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        
    }
    
#if !TARGET_IPHONE_SIMULATOR
    [application registerForRemoteNotifications];
#endif
}

#pragma mark - registerEaseMobNotification

- (void)registerEaseMobNotification
{
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[HDClient sharedClient] addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[HDClient sharedClient] removeDelegate:self];
}


#pragma mark - IChatManagerDelegate

- (void)connectionStateDidChange:(HConnectionState)aConnectionState {
    switch (aConnectionState) {
        case HConnectionConnected: {
            break;
        }
        case HConnectionDisconnected: {
            break;
        }
        default:
            break;
    }
}

- (void)userAccountDidRemoveFromServer {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your login account has been remove from server") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)userAccountDidLoginFromOtherDevice {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//    [alertView show];
}


- (void)userDidForbidByServer {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"userDidForbidByServer", @"your login account has been forbid by server") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)userAccountDidForcedToLogout:(HDError *)aError {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"userAccountDidForcedToLogout", @"your login account has been forced logout") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

//退出当前
- (void)userAccountLogout {
    [[HDClient sharedClient] logout:YES];
//    HDChatViewController *chat = [CSDemoAccountManager shareLoginManager].curChat;
//    if (chat) {
//        [chat backItemClicked];
//    }
}


@end
