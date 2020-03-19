//
//  GPSearchView.m
//  Crmservice
//
//  Created by wzk on 2019/12/22.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "GPSearchView.h"

@implementation GPSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    self.searchView = [[UINib nibWithNibName:@"GPSearchView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    [self addSubview:self.searchView];
    self.searchView.backgroundColor = [UIColor clearColor];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}


@end
