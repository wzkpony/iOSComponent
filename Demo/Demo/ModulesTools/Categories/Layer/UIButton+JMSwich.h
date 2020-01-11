//
//  CALayer+JKBorderColor.h
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 100apps. All rights reserved.
//http://www.gfzj.us/tech/2015/06/18/set-uiview-bordercolor-and-backgroundimage-in-interface-builder.html
//http://stackoverflow.com/a/27986696/3825920

//#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIButton (UIButtonJMSwich)

//@property(nonatomic)

@property(nonatomic,retain)IBInspectable UIImage* selectedImg;
@property(nonatomic,retain)IBInspectable UIImage* noSelectedImg;

@property(nonatomic,retain)IBInspectable UIColor* selectedColor;
@property(nonatomic,retain)IBInspectable UIColor* noSelectedColor;
@property(nonatomic,assign)IBInspectable BOOL selectedState;
- (void)setSelectedState:(BOOL)selectedState;
@end
