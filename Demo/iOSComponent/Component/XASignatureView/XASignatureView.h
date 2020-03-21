//
//  XASignatureView.h
//  Crmservice
//
//  Created by wzk on 2020/1/4.
//  Copyright © 2020 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface XASignatureView : UIView

/**
 *  画布
 */
{
    CGPoint _start;
    CGPoint _move;
    CGMutablePathRef _path;
    NSMutableArray *_pathArray;
    CGFloat _lineWidth;
    UIColor *_color;
}

@property (nonatomic,assign)CGFloat lineWidth;/**< 线宽 */

@property (nonatomic,strong)UIColor *color;/**< 线的颜色 */

@property (nonatomic,strong)NSMutableArray *pathArray;

@property (nonatomic,strong)UILabel *textLabel;/**< 文字提示 */

/**
 获取绘制的图片
 
 @return 绘制的图片
 */
-(UIImage*)getDrawingImg;

/**
 撤销
 */
-(void)undo;

/**
 清空
 */
-(void)clear;

@end

NS_ASSUME_NONNULL_END
