//
//  SelectViews.h
//  Crmservice
//
//  Created by wzk on 2020/1/13.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectViews : BaseView
@property (strong, nonatomic) IBOutlet UIView *contentViews;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
//@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END
