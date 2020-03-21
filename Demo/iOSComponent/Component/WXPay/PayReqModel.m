//
//  PayReqModel.m
//  AAMClient
//
//  Created by Apple on 2018/3/7.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "PayReqModel.h"

@implementation PayReqModel
-(PayReq* )getPayReq{
    PayReq *request =   [PayReq new];
    request.partnerId = self.partnerid;
    
    request.prepayId=  self.prepayid ;
    
    request.package =self.package;
    
    request.nonceStr= self.noncestr ;
    //typedef unsigned int                    UInt32;
    request.timeStamp= self.timestamp;
    request.sign = self.sign;
    return request;
}

@end
