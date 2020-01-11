//
//  FontConfig.h
//  PodProduct
//
//  Created by wzk on 2018/1/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#ifndef FontConfig_h
#define FontConfig_h




#define App_SystemFont(font) [UIFont systemFontOfSize:font]

//默认字体:平方体
//苹方-简 常规体
#define App_PF_FONT(font) [UIFont fontWithName:@"PingFangSC-Regular" size:font]
//苹方-简 中黑体
#define App_PFM_FONT(font) [UIFont fontWithName:@"PingFangSC-Medium" size:font]
//苹方-简 细体
#define App_PFL_FONT(font) [UIFont fontWithName:@"PingFangSC-Light" size:font]
//苹方-简 粗体
#define App_PFB_FONT(font) [UIFont fontWithName:@"PingFangSC-Bold" size:font]
//苹方-简 中粗体
#define App_PFS_FONT(font) [UIFont fontWithName:@"PingFangSC-Semibold" size:font]

/*
 字体格式设置
 */
#define App_HelveticaBold @"Helvetica-Bold"
#define App_Neue @"HelveticaNeue"
#define App_ArialBoldMT @"Arial-BoldMT"
#define App_PingFangSCRegular @"PingFangSC-Regular"
#define App_PingFangSCSemibold @"PingFangSC-Semibold"
#define App_PingFangSCBold @"PingFangSC-Bold"


/*
 设置字体样式和大小
 type ：字体格式
 f： 字体大小
 scale： 适配设别比例
 */
#define App_FontTypeAndSize(type,f,scale) [UIFont fontWithName:type size:((f)* (scale))]


#endif
