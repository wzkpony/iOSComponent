//
//  GPLocationBaidu.h
//  Crmservice
//
//  Created by wzk on 2019/12/30.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPLocationBaidu : NSObject<BMKLocationManagerDelegate>{
}
SINGLETON_FOR_HEADER(GPLocationBaidu);
@property (nonatomic,strong) BMKLocationManager *locationManager;

@property (nonatomic, strong) BMKLocation * location;
//@property (nonatomic, strong) BMKLocationNetworkState  state;


- (void)startdLocation:(BMKLocatingCompletionBlock)completionBlock;//开始单次定位
@end

NS_ASSUME_NONNULL_END
