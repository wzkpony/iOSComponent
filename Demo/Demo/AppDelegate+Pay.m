//
//  AppDelegate+Pay.m
//  lockiOS
//
//  Created by wzk on 2019/10/28.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "AppDelegate+Pay.h"

@implementation AppDelegate (Pay)
- (void)registerApp{
    [WXApi registerApp:App_WX_AppKey];

}

/**
 这里处理微信/支付宝支付完成之后跳转回来
 NOTE:9.0以后使用新API接口
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return [self openUrlPay:url];
}

-(BOOL)openUrlPay:(NSURL*)url{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipaySDKResult" object:resultDic];
            BOOL isfinel =  [resultDic[@"resultStatus"] isEqualToString:@"9000"];
            if (isfinel) {
                
            }else{
                
            }
        }];
        
        //         授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    else if ([url.host isEqualToString:@"pay"]) {
        
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    }
    
    return YES;
}


@end
