//
//  SizeConst.h
//  DuoRongApp
//
//  Created by Panda on 16/9/28.
//  Copyright © 2016年 Panda. All rights reserved.
//

#ifndef SizeConst_h
#define SizeConst_h

//NavBar高度
#define App_NavigationBar_HEIGHT 44

#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


//获取屏幕 宽度、高度
#define App_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define App_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define App_NavHeight (App_Device_Is_iPhoneX ? 88 : 64)
#define App_StatusBarHeight (App_Device_Is_iPhoneX ? 44 : 20)
#define App_TabHeight (App_Device_Is_iPhoneX ? 70 : 49)
//#define App_Device_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define App_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define App_IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define App_IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
//判断iPhoneX所有系列
#define App_Device_Is_iPhoneX (App_Is_iPhoneX || App_IS_IPHONE_Xr || App_IS_IPHONE_Xs_Max)


//适配等比缩放大小
#define App_SCREEN_RATIO (App_WIDTH / 320.0f)
#define App_SCREEN_RATIO6 (App_WIDTH / 375.0f)

//基于iPhone6等比计算
#define App_Ratio(constant) (constant*(KWIDTH/375.0f))


#endif /* SizeConst_h */
