//
//  PayReqModel.h
//  AAMClient
//
//  Created by Apple on 2018/3/7.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayReqModel : NSObject
//"appid": "wx8424ea6d1a2919d3",
//"partnerid": "1495992862",
//"prepayid": "wx20180305212555eb8cc4673f0668963629",
//"noncestr": "5a9d4563262bf",
//"timestamp": 1520256355,
//"sign": "5DA213093C2CC32BEA92DBB08C9D3E1F",
//"packageValue": "Sign=WXPay"
@property(nonatomic, copy)    NSString *appid;
@property(nonatomic, copy)    NSString *partnerid;
@property(nonatomic, copy)    NSString  *prepayid;
@property(nonatomic, copy)    NSString *noncestr;
@property(nonatomic, assign)  UInt32 timestamp;
@property(nonatomic, copy)    NSString *sign;
@property(nonatomic, copy)    NSString *package;
-(PayReq* )getPayReq;
@end
