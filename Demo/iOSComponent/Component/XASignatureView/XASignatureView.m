//
//  XASignatureView.m
//  Crmservice
//
//  Created by wzk on 2020/1/4.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "XASignatureView.h"
@implementation XASignatureView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.textColor = App_UICOLOR_HEX(@"#B2B2B2");
        _textLabel.font = [UIFont systemFontOfSize:17];
    }
    return _textLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _move = CGPointMake(0, 0);
        _start = CGPointMake(0, 0);
        _lineWidth = 2;
        _color = [UIColor redColor];
        _pathArray = [NSMutableArray array];
        [self configCornerRadius:8 borderWidth:1 borderColor:App_UICOLOR_HEX(@"#B2B2B2")];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPicture:context]; //画图
}

- (void)drawPicture:(CGContextRef)context {
    if (_pathArray.count == 0) {
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(@16.0);
        }];
    }
    else{
        [self.textLabel removeFromSuperview];
    }
    for (NSArray * attribute in _pathArray) {
        //将路径添加到上下文中
        CGPathRef pathRef = (__bridge CGPathRef)(attribute[0]);
        CGContextAddPath(context, pathRef);
        //设置上下文属性
        [attribute[1] setStroke];
        CGContextSetLineWidth(context, [attribute[2] floatValue]);
        //绘制线条
        CGContextDrawPath(context, kCGPathStroke);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //创建路径
    _path = CGPathCreateMutable();
    NSArray *attributeArry = @[(__bridge id)(_path),_color,[NSNumber numberWithFloat:_lineWidth]];
    //路径及属性数组数组
    [_pathArray addObject:attributeArry];
    //起始点
    _start = [touch locationInView:self];
    CGPathMoveToPoint(_path, NULL,_start.x, _start.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //释放路径
    CGPathRelease(_path);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _move = [touch locationInView:self];
    //将点添加到路径上
    CGPathAddLineToPoint(_path, NULL, _move.x, _move.y);
    [self setNeedsDisplay];
}

/**
 获取签名图片
 
 @return image
 */
-(UIImage *)getDrawingImg{
    
    if (_pathArray.count) {
        UIGraphicsBeginImageContext(self.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIRectClip(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
        [self.layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        return image;
    }
    return nil;
}

/**
 撤销
 */
-(void)undo
{
    [_pathArray removeLastObject];
    [self setNeedsDisplay];
}

/**
 清空
 */
-(void)clear
{
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
}

@end
