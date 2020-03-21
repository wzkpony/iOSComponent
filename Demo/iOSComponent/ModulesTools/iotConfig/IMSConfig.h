//
//  IMSConfig.h
//  lockiOS
//
//  Created by wzk on 2019/8/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入头文件
#import <ALBBOpenAccountCloud/ALBBOpenAccountSDK.h>
#import <ALBBOpenAccountCloud/ALBBOpenAccountUser.h>
/**BoneMobile 容器 SDK*/
#import <IMSRouter/IMSRouter.h>
/**身份认证*/
#import <IMSAuthentication/IMSIoTAuthentication.h>
#import <IMSApiClient/IMSApiClient.h>
/**绑定*/
#import <IMLDeviceCenter/IMLDeviceCenter.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IMSConfigDelegate <NSObject>
//身份认证完成
- (void)verifyAuthenticationSuccess;
//配网完成
- (void)linkNetworkProductKey:(NSString *)productKey deviceName:(NSString *)deviceName;
//绑定设备完成
- (void)bindDeviceProductKey:(NSString *)productKey deviceName:(NSString *)deviceName token:(NSString *)token iotId:(NSString *)iotId;

@end
@interface IMSConfig : NSObject

@property (nonatomic,copy) NSString *productKey;
@property (nonatomic,copy) NSString *deviceName;
@property (nonatomic,copy) NSString *token;

@property (nonatomic,assign) id<IMSConfigDelegate> delegate;


+ (instancetype)sharedInstance;
- (void)configDelegate:(id<IMSConfigDelegate>)delegate VC:(UIViewController *)vc;
- (BOOL)aliISLogin;//是否登录阿里
#pragma mark -- 登录阿里账号
- (void)aliLogin;
#pragma mark -- 身份认证
- (void)verifyAuthentication;
#pragma mark -- 配网
- (void)startProvisionControllerWithInfo:(NSDictionary *)info;
#pragma mark -- 获取token
- (void)configToken;
#pragma mark -- 绑定设备
- (void)bindDevice;

#pragma mark --获取当前用户的绑定的锁列表
- (void)listBindingByAccount;
#pragma  mark --解绑
- (void)unBingLock:(NSString *)iotId completionBlock:(nonnull void (^)(NSInteger, id _Nonnull))completionBlock;
@end

NS_ASSUME_NONNULL_END
