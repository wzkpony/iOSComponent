//
//  JMLocationInfo.m
//  JMProject
//
//  Created by wzk on 2019/4/4.
//  Copyright © 2019 JingMai. All rights reserved.
//

#import "JMLocationManager.h"

@implementation JMLocationManager
SINGLETON_FOR_CLASS(JMLocationManager)

- (void)setAppKey:(NSString *)appKey{
//    [AMapServices sharedServices].apiKey = appKey;//@"";
}
/*
- (void)startLocation:(void(^)(CLLocation *location,AMapLocationReGeocode *locationInfo)) resultInfo {
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager == nil) {
            _locationManager = [[AMapLocationManager alloc]init];
        }
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout = 20;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 20;
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        __weak typeof(self) weakSelf = self;
        [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            
            if (regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode);

                weakSelf.resultLocationInfo = regeocode;
                resultInfo(location,regeocode);
            }
        }];
    }
}
*/

@end
