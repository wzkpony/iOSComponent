//
//  UIViewController+Share.h
//  IronFish
//
//  Created by wzk on 2019/1/11.
//  Copyright © 2019 wzk. All rights reserved.
//
/**
 配置和参考代码：https://developer.umeng.com/docs/66632/detail/66898
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Share)

- (void)configUSharePlatforms;

- (BOOL)application:(UIApplication *)application url:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


/**微信登录授权---授权并获取用户信息(获取uid、access token及用户名等)*/
- (void)getAuthWithUserInfoFromWechat:(void(^)(UMSocialUserInfoResponse *response))resultBlock;

/**QQ - 授权并获取用户信息(获取uid、access token及用户名等)*/
- (void)getAuthWithUserInfoFromQQ:(void(^)(UMSocialUserInfoResponse *response))resultBlock;

/**新浪微博 授权并获取用户信息(获取uid、access token及用户名等)*/
- (void)getAuthWithUserInfoFromSina:(void(^)(NSString *openid))resultBlock;

/**分享文本*/
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType;

/**分享图片*/
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType;

/**图文分享*/
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType;

/**分享网页*/
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType title:(NSString *)title discr:(NSString *)discr url:(NSString *)url image:(UIImage *)image;

/**分享音乐*/
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType;

/**分享视频*/
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType;

/**分享微信表情*/
- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType;

/**分享微信小程序*/
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType;
@end

NS_ASSUME_NONNULL_END

