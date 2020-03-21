//
//  IFShareView.m
//  IronFish
//
//  Created by wzk on 2018/12/20.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "JMShareView.h"

@implementation JMShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)shareView {
    static JMShareView *shareView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[JMShareView alloc] init];
        
        UITapGestureRecognizer *tapWX = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(selectShareImage:)];
        UITapGestureRecognizer *tapPYQ = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(selectShareImage:)];
        UITapGestureRecognizer *tapQQ = [[UITapGestureRecognizer alloc] initWithTarget:shareView action:@selector(selectShareImage:)];
        
        [shareView.imageWX addGestureRecognizer:tapWX];
        [shareView.imagePYQ addGestureRecognizer:tapPYQ];
        [shareView.imageQQ addGestureRecognizer:tapQQ];
        
    });
    return shareView;
}

- (IBAction)selectCancleButton:(id)sender {
    [self dismissFromWindow];
   
}

- (void)selectShareImage:(UITapGestureRecognizer *)tap{

    if (self.selectShareButton != nil) {
        UIImageView *imageView = (UIImageView *)tap.view;
        self.selectShareButton(self, imageView.tag);
    }
}

@end
