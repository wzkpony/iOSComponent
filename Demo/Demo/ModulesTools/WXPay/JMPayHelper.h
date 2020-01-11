//
//  JMPayHelper.h
//  JMProject
//
//  Created by Apple on 2019/4/23.
//  Copyright © 2019年 JingMai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum UseType {
    TopUp = 0,//充值
    Renew//续费
} UseType;
@interface JMPayHelper : NSObject
{

}
+(JMPayHelper*)shear;
@property (nonatomic,assign) UseType type;
- (void)sendWeiXinPay:(NSString *)money completionBlock:(void(^)(void))completionBlock;
- (void)sendAlipay:(NSString *)money completionBlock:(void(^)(void))completionBlock;

- (void)sendWeiXinRenewPay:(NSString *)dates completionBlock:(void(^)(void))completionBlock;
- (void)sendAliRenewpay:(NSString *)dates completionBlock:(void(^)(void))completionBlock;
@end

NS_ASSUME_NONNULL_END
