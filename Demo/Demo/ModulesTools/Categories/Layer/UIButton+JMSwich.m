//
//  CALayer+JKBorderColor.m
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 Xidibuy. All rights reserved.
//

#import "CALayer+JKBorderColor.h"
//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
//https://www.jianshu.com/p/bc8a3a285be8
static const void * SelectedImgBy = &SelectedImgBy;
static const void * noSelectedImgBy = &noSelectedImgBy;

static const void * SelectedColorBy = &SelectedColorBy;
static const void * noSelectedColorBy = &noSelectedColorBy;


static const void * selectedStateBy = &selectedStateBy;
@implementation UIButton (UIButtonJMSwich)


-(void)touchSelectImg{
    self.selectedState = !self.selectedState;
}
-(void)touchSelectColor{
    self.selectedState = !self.selectedState;
}

-(void)setSelectedImg:(UIImage *)selectedImg {
    objc_setAssociatedObject(self, SelectedImgBy, selectedImg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(touchSelectImg) forControlEvents:(UIControlEventTouchUpInside)];
    [self setSelectedState:self.selectedState];
}
-(UIImage *)selectedImg {
    return objc_getAssociatedObject(self, SelectedImgBy);
}
-(void)setNoSelectedImg:(UIImage *)noSelectedImg {
    objc_setAssociatedObject(self, noSelectedImgBy, noSelectedImg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setSelectedState:self.selectedState];
}
-(UIImage *)noSelectedImg {
    return objc_getAssociatedObject(self, noSelectedImgBy);
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    objc_setAssociatedObject(self, SelectedColorBy, selectedColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   [self addTarget:self action:@selector(touchSelectColor) forControlEvents:(UIControlEventTouchUpInside)];
    [self setSelectedState:self.selectedState];
}
-(UIColor *)selectedColor {
    return objc_getAssociatedObject(self, SelectedColorBy);
}
-(void)setNoSelectedColor:(UIColor *)noSelectedColor{
    objc_setAssociatedObject(self, noSelectedColorBy, noSelectedColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setSelectedState:self.selectedState];
}
-(UIColor *)noSelectedColor {
    return objc_getAssociatedObject(self, noSelectedColorBy);
}


- (void)setSelectedState:(BOOL)selectedState{
    objc_setAssociatedObject(self, selectedStateBy, [NSNumber numberWithBool:selectedState], OBJC_ASSOCIATION_ASSIGN);
    if (selectedState) {
        if (self.selectedColor) {
            [self setTitleColor:self.selectedColor forState:UIControlStateNormal];
        }
        if (self.selectedImg) {
            [self setImage:self.selectedImg forState:(UIControlStateNormal)];
        } 
    }else{
        if (self.noSelectedColor) {
            [self setTitleColor:self.noSelectedColor forState:UIControlStateNormal];
        }
        
        if (self.noSelectedImg) {
            [self setImage:self.noSelectedImg forState:(UIControlStateNormal)];
        }
    
    }
}
-(BOOL)selectedState{
    return [objc_getAssociatedObject(self, selectedStateBy) boolValue];
}
@end
