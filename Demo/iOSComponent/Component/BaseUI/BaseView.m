//
//  BaseView.m
//  IronFish
//
//  Created by wzk on 2018/12/17.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)setupView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (instancetype)init {
    if (self = [super init]) {
        @try {
            self = [self setupView];
        } @catch (NSException *exception) {
            NSLog(@"%@的xib没找到",[self class]);
            self = [super init];
            
        } @finally {
            return self;
        }
        
      
    }
    return self;
}



/**将View加到keyWindow 上*/
- (void)showToWindow{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *viewBg = [[UIView alloc] init];
    viewBg.frame = window.bounds;
    viewBg.tag = 1001;
    viewBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    viewBg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePOP)];
    [viewBg addGestureRecognizer:tap];
    
    [window addSubview:viewBg];
    self.frame = CGRectMake(0, App_HEIGHT, self.jk_width, self.jk_height);
    [window addSubview:self];
    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT - self.jk_height, self.jk_width, self.jk_height);
    }];
}

/**将View加到Controller 上*/
- (void)showToViewController:(UIViewController *)VC{
    UIView *viewBg = [[UIView alloc] init];
    viewBg.frame = VC.view.bounds;
    viewBg.tag = 1001;
    viewBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    viewBg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePOPVC:)];
//    [viewBg addGestureRecognizer:tap];
    [VC.view addSubview:viewBg];
    self.frame = CGRectMake(0, App_HEIGHT, self.jk_width, self.jk_height);
    [VC.view addSubview:self];
    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT - self.jk_height, self.jk_width, self.jk_height);
    }];
    
}


- (void)showToWindowToCenter{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *viewBg = [[UIView alloc] init];
    viewBg.frame = window.bounds;
    viewBg.tag = 1001;
    viewBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    viewBg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFromWindowToCenter)];
    [viewBg addGestureRecognizer:tap];
    viewBg.alpha = 0.0;

    [window addSubview:viewBg];
    self.clipsToBounds = YES;
    self.bounds = CGRectMake(0, 0, self.jk_width, self.jk_height);
    self.center = App_KeyWindow.center;
    self.alpha = 0.0;
    [window addSubview:self];
    [UIView animateWithDuration:0.33 animations:^{
        self.alpha = 1.0;
        viewBg.alpha = 1.0;
    }];
}
- (void)closePOP{
    [self dismissFromWindow];
}
- (void)closePOPVC:(id)obj{
    UIView *view = [UIView new];
    if ([obj isKindOfClass:[UIView class]]) {
        view = obj;
    }
    else if ([obj isKindOfClass:[UITapGestureRecognizer class]]){
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)obj;
        view = [tap.view superview];
    }
    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT, self.jk_width, self.jk_height);
    } completion:^(BOOL finished) {
        UIView *viewBg = [view viewWithTag:1001];
        [viewBg removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}


/***/
- (void)dismissFromWindow{
    
    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT, self.jk_width, self.jk_height);
    } completion:^(BOOL finished) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *viewBg = [window viewWithTag:1001];
        [viewBg removeFromSuperview];
        [self removeFromSuperview];
    }];
  
}

- (void)dismissFromWindowToCenter{
    
    [UIView animateWithDuration:0.33 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *viewBg = [window viewWithTag:1001];
        [viewBg removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}



@end
