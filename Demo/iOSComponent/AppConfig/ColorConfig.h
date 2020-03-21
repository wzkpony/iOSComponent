//
//  ColorConfig.h
//  PodProduct
//
//  Created by wzk on 2018/1/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#ifndef ColorConfig_h
#define ColorConfig_h
// rgb颜色转换（16进制->10进制）
#define App_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define App_UIColorFromRGBAlpha(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

//RGB的设置颜色
#define App_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define App_FontGray UIColorFromRGB(0x8E8E93)

#define App_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define App_RGB(r,g,b) App_RGBA(r,g,b,1.0f)


//十六进制
#define App_UICOLOR_HEX(string) [UIColor jk_colorWithHexString:(string)]



//主题颜色
#define App_ThemeColor App_UICOLOR_HEX(@"#2F7CFE")
#define App_GrayColor  App_RGBA(102, 102, 102, 1)
#define App_51Color  App_RGBA(51, 51, 51, 1)
#define App_153Color  App_RGBA(153, 153, 153, 1)
#define App_153Color  App_RGBA(153, 153, 153, 1)
#define App_102Color  App_RGBA(102, 102, 102, 1)
#define App_102Color  App_RGBA(102, 102, 102, 1)
#define App_221Color  App_RGBA(221, 221, 221, 1)

//

//系统导航栏颜色
#define App_NavBarColor App_RGBA(255,255,255,1)


#endif



