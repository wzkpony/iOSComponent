//
//  JMLocationInfo.h
//  JMProject
//
//  Created by wzk on 2019/4/4.
//  Copyright © 2019 JingMai. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *LocationInfo = @"LocationInfo";
NS_ASSUME_NONNULL_BEGIN

@interface JMLocationManager : NSObject
SINGLETON_FOR_HEADER(JMLocationManager);
@property (nonatomic, copy) NSString *appKey;
//@property (nonatomic,strong ) AMapLocationManager *locationManager;//定位服务
//@property (nonatomic, strong) AMapLocationReGeocode *resultLocationInfo;//定位完成得到的结果
//- (void)startLocation:(void(^)(CLLocation *location,AMapLocationReGeocode *locationInfo)) resultInfo;
@end

NS_ASSUME_NONNULL_END
