//
//  IMSConfig.m
//  lockiOS
//
//  Created by wzk on 2019/8/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "IMSConfig.h"
#import "IMSOpenAccount.h"

@interface IMSConfig()
@property (nonatomic, weak) UIViewController *viewController;
@end
@implementation IMSConfig

+ (instancetype)sharedInstance {
    static IMSConfig *config;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[[self class] alloc] init];
        
    });
    
    return config;
}
- (void)configDelegate:(id<IMSConfigDelegate>)delegate VC:(UIViewController *)vc{
    self.viewController = vc;
    self.delegate = delegate;
}
- (BOOL)aliISLogin{
    return [ALBBOpenAccountSession sharedInstance].isLogin;
}
#pragma mark -- 登录阿里账号

- (void)aliLogin{
    __weak typeof(self) weakSelf = self;

    // 获取账号UI服务
    id<ALBBOpenAccountUIService> uiService = ALBBService(ALBBOpenAccountUIService);
    // 显示登录窗口，presentingViewController将通过present方式展示登陆界面viewcontroller
    
    [uiService presentLoginViewController:self.viewController.navigationController success:^(ALBBOpenAccountSession *currentSession) {
        // 登录成功，currentSession为当前会话信息
        // 获取当前会话标识
        NSLog(@"sessionId:%@", currentSession);
        NSLog(@"sessionId:%@", currentSession.sessionID);
        // 获取当前用户信息
        ALBBOpenAccountUser *currentUser = [currentSession getUser];
        NSLog(@"mobile:%@", [currentUser mobile]);
        NSLog(@"avatarUrl:%@", [currentUser avatarUrl]);
        NSLog(@"accountId:%@", [currentUser accountId]);
        NSLog(@"displayName:%@", [currentUser displayName]);
        IMSCredential *credential = [IMSCredentialManager sharedManager].credential;
        NSString *identityId = credential.identityId;
        NSString *iotToken = credential.iotToken;
        NSLog(@"identityId:%@", identityId);
        NSLog(@"iotToken:%@", iotToken);


        [weakSelf verifyAuthentication];

        
        
    } failure:^(NSError *error) {
        // 登录失败对应的错误；取消登录同样会返回一个错误码
        NSLog(@"登录失败对应的错误；取消登录同样会返回一个错误码");
//        [MBProgressHUD ll_showErrorMessage:@"阿里服务登录失败"];
    }];
    
}
#pragma mark -- 身份认证
- (void)verifyAuthentication{
    __weak typeof(self) weakSelf = self;
    // 构建请求
    NSString *path = @"/uc/listByAccount";
    NSString *apiVer = @"1.0.0";
    NSDictionary *params = @{};
    IMSIoTRequestBuilder *builder = [[IMSIoTRequestBuilder alloc] initWithPath:path apiVersion:apiVer params:params];
    
    // 指定身份认证类型
    IMSRequest *request = [[builder setAuthenticationType:IMSAuthenticationTypeIoT] build];

    //通过 IMSRequestClient 发送请求
    [IMSRequestClient asyncSendRequest:request responseHandler:^(NSError * _Nullable error, IMSResponse * _Nullable response) {
        
        if (error) {
            //处理Error，非服务端返回的错误都通过该Error回调
            if ([weakSelf aliISLogin]) {//判断是否登录阿里账号
                [weakSelf loginOut];
            }
            [weakSelf aliLogin];
        } else {
            if (response.code == 200) {
                //成功，处理response.data
                if ([weakSelf.delegate respondsToSelector:@selector(verifyAuthenticationSuccess)]&&weakSelf.delegate != nil) {
                    [weakSelf.delegate verifyAuthenticationSuccess];
                }
            }
            else {
                //处理服务端错误
                if ([weakSelf aliISLogin]) {//判断是否登录阿里账号
                    [weakSelf loginOut];
                }

                [weakSelf aliLogin];

                
            }
        }
    }];
}


#pragma mark -- 配网
- (void)startProvisionControllerWithInfo:(NSDictionary *)info {
    NSMutableDictionary *options = [info mutableCopy];
    __weak typeof(self) weakSelf = self;
    IMSRouterCallback block = ^(NSError *error, NSDictionary *info) {
        // 配网成功后，需要后退到根页面，然后显示绑定页面
#pragma mark -- 配网完成回调
        NSLog(@"配网成功返回的数据 = %@",info);
        if (info[@"deviceName"] == nil) {
            return ;
        }
        weakSelf.deviceName = info[@"deviceName"];
        weakSelf.productKey = info[@"productKey"];
        if ([weakSelf.delegate respondsToSelector:@selector(linkNetworkProductKey:deviceName:)]&&weakSelf.delegate != nil) {
            [weakSelf.delegate linkNetworkProductKey:info[@"deviceName"] deviceName:info[@"productKey"]];
        }
        [weakSelf configToken];

    };
    options[AKRouterCompletionHandlerKey] = block;
    
    NSURL *url = [NSURL URLWithString:@"link://router/connectConfig"];
    [[IMSRouterService sharedService] openURL:url
                                      options:options
                            completionHandler:^(BOOL success) {
                                if (success) {
                                    NSLog(@"插件打开成功");
                                } else {
                                    NSLog(@"插件打开失败");
                                }
                            }];
    
    
    
}

- (void)configToken{
    // self.productKey 和 self.deviceName 是配网成功后返回的设备模型中的 productKey 和 deviceName
    __weak typeof(self) weakSelf = self;

    [[IMLLocalDeviceMgr sharedMgr] getDeviceToken:self.productKey deviceName:self.deviceName timeout:20 resultBlock:^(NSString *token, BOOL boolSuccess) {
        if(token){
            // 调用绑定接口进行设备绑定
            weakSelf.token = token;
            [weakSelf bindDevice];
        } else{
            [MBProgressHUD ll_showInfoMessage:@"锁具token获取失败"];
            //处理服务端错误
            [weakSelf.viewController.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
- (void)bindDevice{
    __weak typeof(self) weakSelf = self;
    // 构建请求
    NSString *path = @"/awss/token/user/bind";
    NSString *apiVer = @"1.0.3";
    NSDictionary *params = @{@"productKey":App_ShowString(self.productKey),
                             @"deviceName":App_ShowString(self.deviceName),
                             @"token":App_ShowString(self.token)
                             };
    IMSIoTRequestBuilder *builder = [[IMSIoTRequestBuilder alloc] initWithPath:path apiVersion:apiVer params:params];
    
    // 指定身份认证类型
//    [builder setScheme:@"https://"];
    IMSRequest *request = [[builder setAuthenticationType:IMSAuthenticationTypeIoT] build];
    //通过 IMSRequestClient 发送请求
    [IMSRequestClient asyncSendRequest:request responseHandler:^(NSError * _Nullable error, IMSResponse * _Nullable response) {
//        response[@"data"];//iotId在此处可以获取
        if (!App_IsEmpty(response.localizedMsg)) {
            [MBProgressHUD ll_showInfoMessage:App_ShowString(response.localizedMsg)];
        }
        if (error) {
            //处理Error，非服务端返回的错误都通过该Error回调
        } else {
            if (response.code == 200) {
                //成功，处理response.data
                NSString *iot = (NSString *)response.data;
                if ([weakSelf.delegate respondsToSelector:@selector(bindDeviceProductKey:deviceName:token:iotId:)]&&weakSelf.delegate != nil) {
                    [weakSelf.delegate bindDeviceProductKey:weakSelf.productKey deviceName:weakSelf.deviceName token:weakSelf.token iotId:iot];
                }
            }
            else {
                //处理服务端错误
                [weakSelf.viewController.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}



#pragma  mark --
- (void)listBindingByAccount{
    __weak typeof(self) weakSelf = self;
    // 构建请求
    NSString *path = @"/uc/listBindingByAccount";
    NSString *apiVer = @"1.0.2";
    NSDictionary *params = @{@"pageSize":@1000
                             };
    IMSIoTRequestBuilder *builder = [[IMSIoTRequestBuilder alloc] initWithPath:path apiVersion:apiVer params:params];
    
    // 指定身份认证类型
    //    [builder setScheme:@"https://"];
    IMSRequest *request = [[builder setAuthenticationType:IMSAuthenticationTypeIoT] build];
    //通过 IMSRequestClient 发送请求
    [IMSRequestClient asyncSendRequest:request responseHandler:^(NSError * _Nullable error, IMSResponse * _Nullable response) {
        //
        if (error) {
            //处理Error，非服务端返回的错误都通过该Error回调
        } else {
            if (response.code == 200) {
                
            }
            else {
                //处理服务端错误
            }
        }
    }];
}
#pragma  mark --解绑
- (void)unBingLock:(NSString *)iotId completionBlock:(nonnull void (^)(NSInteger, id _Nonnull))completionBlock{
//    __weak typeof(self) weakSelf = self;
    // 构建请求
    NSString *path = @"/uc/unbindAccountAndDev";
    NSString *apiVer = @"1.0.2";
    NSDictionary *params = @{
                             @"iotId":iotId
                             };
    IMSIoTRequestBuilder *builder = [[IMSIoTRequestBuilder alloc] initWithPath:path apiVersion:apiVer params:params];
    
    // 指定身份认证类型
    //    [builder setScheme:@"https://"];
    IMSRequest *request = [[builder setAuthenticationType:IMSAuthenticationTypeIoT] build];
    //通过 IMSRequestClient 发送请求
    [IMSRequestClient asyncSendRequest:request responseHandler:^(NSError * _Nullable error, IMSResponse * _Nullable response) {
        //i1nFryaeVuvaUPjVSuiS000100
        [MBProgressHUD ll_showInfoMessage:response.localizedMsg];
        if (error) {
            //处理Error，非服务端返回的错误都通过该Error回调
        } else {
            if (response.code == 200) {
                
                if (completionBlock != nil) {
                    completionBlock(response.code,response.data);
                }
            }
            else {
                //处理服务端错误
                
            }
        }
    }];
}

- (void)loginOut{

    [[IMSOpenAccount sharedInstance] logout];
}
@end
