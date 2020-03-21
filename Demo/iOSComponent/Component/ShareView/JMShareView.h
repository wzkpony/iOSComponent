//
//  IFShareView.h
//  IronFish
//
//  Created by wzk on 2018/12/20.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMShareView : BaseView
+ (instancetype)shareView;

@property (weak, nonatomic) IBOutlet UIImageView *imageWX;
@property (weak, nonatomic) IBOutlet UIImageView *imagePYQ;
@property (weak, nonatomic) IBOutlet UIImageView *imageQQ;
@property (nonatomic, copy) void (^selectShareButton)(JMShareView *shareView,NSInteger index);
@end

NS_ASSUME_NONNULL_END
