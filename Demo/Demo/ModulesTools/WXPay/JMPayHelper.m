//
//  JMPayHelper.m
//  JMProject
//
//  Created by Apple on 2019/4/23.
//  Copyright © 2019年 JingMai. All rights reserved.
//

#import "JMPayHelper.h"


@interface JMPayHelper()
@property (nonatomic, copy)void(^succeedBlock)(void);
@property (nonatomic, copy)NSString *moneyStr;
@property (nonatomic, copy)NSString *datesStr;

@property (nonatomic, copy)NSString *outTradeNo;
@end
@implementation JMPayHelper
static JMPayHelper* helper = NULL;
+(JMPayHelper*)shear{
    if (helper == NULL) {
        helper = [JMPayHelper new];
        [[NSNotificationCenter defaultCenter] addObserver:helper selector:@selector(paySuccessWeixin:) name:WXPaySuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:helper selector:@selector(paySuccessAli:) name:@"AlipaySDKResult" object:NULL];
    }
    return helper;
}
#pragma mark - 发起微信续费获取 tradeNo
- (void)sendWeiXinRenewPay:(NSString *)dates completionBlock:(void(^)(void))completionBlock{
    __weak typeof(self)weakSelf = self;
    self.datesStr = dates;
    self.succeedBlock = completionBlock;
    
    [weakSelf sendWeiXinRenewPayLast];

}


#pragma mark - 发起微信支付  tradeNo
- (void)sendWeiXinPay:(NSString *)money completionBlock:(void(^)(void))completionBlock{

    __weak typeof(self)weakSelf = self;
    self.moneyStr = money;
    self.succeedBlock = completionBlock;
  
//    [RequestUtil requestGet:Api_member_tradeNo para:@{} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        BaseResponseModel *model = [BaseResponseModel yy_modelWithJSON:responseObject];
//        if (model.code == 0) {
//            /**
//             {
//             code = 000000;
//             data = ba4f750d01fd48b18c36a44afd9487eb;
//             errMsg = "\U8bf7\U6c42\U6210\U529f";
//             }
//             */
//            weakSelf.outTradeNo = model.data;
//            [weakSelf sendWeiXinPayLast];
//        }
//    }];
   
}
//微信续费Request
- (void)sendWeiXinRenewPayLast{
    __weak typeof(self)weakSelf = self;

//    [RequestUtil requestPost:Api_member_renewWeixint para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"renewTime":App_ShowString(self.datesStr),@"outTradeNo":App_ShowString(self.outTradeNo)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        BaseResponseModel *model = [BaseResponseModel yy_modelWithJSON:responseObject];
//        PayReqModel* payModel = [PayReqModel yy_modelWithJSON:model.data[@"payInfo"]];
//        PayReq *request =   [payModel getPayReq];
//        BOOL isfinel =  [WXApi sendReq:request];
//        if (isfinel == NO) {
//            [MBProgressHUD ll_showWarnMessage:@"微信续费失败"];
//
//        }else{
//        }
//
//    }];
}
//微信支付Request
- (void)sendWeiXinPayLast{
    __weak typeof(self)weakSelf = self;
 
//    [RequestUtil requestPost:Api_member_weixin para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"amount":App_ShowString(self.moneyStr),@"outTradeNo":App_ShowString(self.outTradeNo)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        /**
//         {
//         code = 000000;
//         data =     {
//         payInfo = "{\"appid\":\"wx494f2c901f84c00f\",\"noncestr\":\"e2fdbbf69c154d13a562d1f55e933351\",\"package\":\"Sign=WXPay\",\"partnerid\":\"1520465491\",\"prepayid\":\"wx0515082109593536c9150f101013482200\",\"sign\":\"85822E81535AA9AC5074986A4451259928346ADC61F2B81DDE8CCB97DF368373\",\"timestamp\":\"1572937700\"}";
//         tradeNo = ef4222e36f134366aff66ddbf789447b;
//         };
//         errMsg = "\U8bf7\U6c42\U6210\U529f";
//         }
//
//         */
//        BaseResponseModel *model = [BaseResponseModel yy_modelWithJSON:responseObject];
//        PayReqModel* payModel = [PayReqModel yy_modelWithJSON:model.data[@"payInfo"]];
//        PayReq *request =   [payModel getPayReq];
//        BOOL isfinel =  [WXApi sendReq:request];
//        if (isfinel == NO) {
//            [MBProgressHUD ll_showWarnMessage:@"微信支付失败"];
//        }else{
//        }
//
//    }];
}


#pragma mark -发起支付宝续费Request
- (void)sendAliRenewpay:(NSString *)dates completionBlock:(void(^)(void))completionBlock{
    __weak typeof(self) weakSelf = self;
    self.datesStr = dates;
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"HLAlipay";
    
//    [RequestUtil requestPost:Api_member_renewalipay para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"renewTime":App_ShowString(dates)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        BaseResponseModel *model = [BaseResponseModel yy_modelWithJSON:responseObject];
//        weakSelf.succeedBlock = completionBlock;
//
//        [[AlipaySDK defaultService] payOrder:model.data[@"payInfo"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSNotification* not = [NSNotification notificationWithName:@"AlipaySDKResult" object:resultDic];
//            NSLog(@"网页会掉");
//            [weakSelf paySuccessAli:not];
//        }];
//    }];
}
#pragma mark - 发起支付宝支付Request
- (void)sendAlipay:(NSString *)money completionBlock:(void(^)(void))completionBlock{
    __weak typeof(self) weakSelf = self;
    self.moneyStr = money;
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"HLAlipay";
 
//    [RequestUtil requestPost:Api_member_alipay para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"amount":App_ShowString(money)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        BaseResponseModel *model = [BaseResponseModel yy_modelWithJSON:responseObject];
//        weakSelf.succeedBlock = completionBlock;
//
//        [[AlipaySDK defaultService] payOrder:model.data[@"payInfo"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            /**
//             {
//             memo = "";
//             result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2019082666476476\",\"auth_app_id\":\"2019082666476476\",\"charset\":\"UTF-8\",\"timestamp\":\"2019-11-05 14:58:58\",\"out_trade_no\":\"431168b7a9cc46e8aad071888d0287da\",\"total_amount\":\"0.01\",\"trade_no\":\"2019110522001430420505236445\",\"seller_id\":\"2088631077872496\"},\"sign\":\"Z1iap1rnnZV+8XRK9gUDKP/uLVjMM4P3wrFwnlfYcz4UHx+/yG3ce+LnrKkqiBaBP2VCwr5/8nkMwvwiDfdlmahDb4QmZWlTJoJW8LpQXlzLkZZIB3nZblzaxrCSWx+tyjRX5J4/0Qz0bzCiOhejroh/rxcG5KVjiTuI1dScsWFUC90GUa4pN3PZauGzSoyGAHtDrFAEMa3eX+obQzHAq6ER1VxxPQmG4Klu/qGS03/mfXLRlI8tFVcWFS9ci3Jlya2Xvwe8dwE7anYjcD1CLpZQx8+IxwHaoXSgWnj5pJ6pjaHdULY1nyrzVG4iJctKAPual3qNHKd/VPkACPdHsQ==\",\"sign_type\":\"RSA2\"}";
//             resultStatus = 9000;
//             }
//             */
//            NSNotification* not = [NSNotification notificationWithName:@"AlipaySDKResult" object:resultDic];
//            NSLog(@"网页会掉");
//            [weakSelf paySuccessAli:not];
//
//        }];
//    }];
}

#pragma mark - 微信支付完成回调 --
- (void)paySuccessWeixin:(NSNotification*)noti{
    __weak typeof(self) weakSelf = self;
    if (self.type == TopUp) {
//        [weakSelf payTradeQueryCallBack:Api_member_weixinQuery outTradeNo:self.outTradeNo];

    }
    else if (self.type == Renew){
//        [weakSelf payTradeQueryRenewCallBack:Api_member_renewWeixinQuery outTradeNo:self.outTradeNo];
    }

}
#pragma mark - 支付宝支付完成回调 --
-(void)paySuccessAli:(NSNotification*)noti{
    NSDictionary*resultDic =  noti.object;
    BOOL isfinel =  [resultDic[@"resultStatus"] isEqualToString:@"9000"];
    if (isfinel) {
//        [self payOK];
        NSData *data =[resultDic[@"result"] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (self.type == TopUp) {
//            [self payTradeQueryCallBack:Api_member_apipayQuery outTradeNo:dict[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
        }
        else if (self.type == Renew){
//            [self payTradeQueryRenewCallBack:Api_member_renewAlipayQuery outTradeNo:dict[@"alipay_trade_app_pay_response"][@"out_trade_no"]];
        }
        
    }else{
        [MBProgressHUD ll_showInfoMessage:@"充值失败"];
    }
}


//查询回调接口--充值校验 --
-(void)payTradeQueryCallBack:(NSString*)tradeQueryUrl outTradeNo:(NSString *)out_trade_no{
     __weak typeof(self) weakSelf = self;
//    [RequestUtil requestPost:tradeQueryUrl para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"amount":App_ShowString(self.moneyStr),@"outTradeNo":App_ShowString(out_trade_no)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        BaseResponseModel* response =  [BaseResponseModel yy_modelWithDictionary:responseObject];
//        if (response.code == 0) {
////            [weakSelf payOK];
//            if (weakSelf.succeedBlock != nil) {
//                weakSelf.succeedBlock();
//            }
//        }else{
//            [weakSelf payFail:@"充值失败"];
//        }
//    }];
}


//查询回调接口--续费校验
-(void)payTradeQueryRenewCallBack:(NSString*)tradeQueryUrl outTradeNo:(NSString *)out_trade_no{
    __weak typeof(self) weakSelf = self;
//    [RequestUtil requestPost:tradeQueryUrl para:@{@"memberId":App_ShowString([UserModel shareUser].userMoreInfo.ID),@"renewTime":App_ShowString(self.datesStr),@"outTradeNo":App_ShowString(out_trade_no)} completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
//        NSLog(@"%@",responseObject);
//        BaseResponseModel* response =  [BaseResponseModel yy_modelWithDictionary:responseObject];
//        if (response.code == 0) {
//            //            [weakSelf payOK];
//            if (weakSelf.succeedBlock != nil) {
//                weakSelf.succeedBlock();
//            }
//        }else{
//            [weakSelf payFail:@"续费失败"];
//        }
//    }];
}

-(void)payFail:(NSString*)msg{
    [MBProgressHUD ll_showSuccessMessage:msg];
    //    [self.navigationController popToRootViewControllerAnimated:true];
}


@end
