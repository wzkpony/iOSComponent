//
//  GPLocationBaidu.m
//  Crmservice
//
//  Created by wzk on 2019/12/30.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "GPLocationBaidu.h"

@implementation GPLocationBaidu
SINGLETON_FOR_CLASS(GPLocationBaidu)
- (id)init{
    if (self = [super init]) {
        [[BMKLocationAuth sharedInstance] checkPermisionWithKey:App_baidu_AppKey authDelegate:self];

        self.locationManager = [[BMKLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
//        self.locationManager.pausesLocationUpdatesAutomatically = NO;
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
        self.locationManager.locationTimeout = 10;
        self.locationManager.reGeocodeTimeout = 10;
    }
    return self;
}

- (void)startdLocation:(BMKLocatingCompletionBlock)completionBlock{
    WeakSelf;

   BOOL location = [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        //获取经纬度和该定位点对应的位置信息
        NSLog(@"location = %@",location.rgcData);
        weakSelf.location = location;
       completionBlock(location,state,error);
    }];
}
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager
{
    
    [locationManager requestAlwaysAuthorization];
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError
{
    NSLog(@"location auth onGetPermissionState %ld",(long)iError);
    
}
/**网络请求发生改变*/
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"%d",status);
    
}
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error{
    NSLog(@"%@",error);
}
@end
