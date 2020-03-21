//
//  HLImagesCell.h
//  lockiOS
//
//  Created by wzk on 2019/10/22.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLImagesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViews;
@property (weak, nonatomic) IBOutlet UIButton *delButton;

@end

NS_ASSUME_NONNULL_END
