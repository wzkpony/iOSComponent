//
//  IMSOpenAccount.h
//  IMSAccount
//
//  Created by Hager Hu on 01/11/2017.
//账户的锁SDK的model

#import <Foundation/Foundation.h>

#import <IMSAccount/IMSAccountUIProtocol.h>
#import <IMSAccount/IMSAccountProtocol.h>

@interface IMSOpenAccount : NSObject <IMSAccountProtocol, IMSAccountUIProtocol>

+ (instancetype)sharedInstance;
- (void)logout;
@end
