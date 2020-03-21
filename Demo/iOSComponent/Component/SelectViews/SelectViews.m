//
//  SelectViews.m
//  Crmservice
//
//  Created by wzk on 2020/1/13.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "SelectViews.h"

@implementation SelectViews

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentViews = [[UINib nibWithNibName:@"SelectViews" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    [self addSubview:self.contentViews];
    self.contentViews.backgroundColor = [UIColor clearColor];
    [self.contentViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}
@end
