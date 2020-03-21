//
//  GPItemCell.h
//  Crmservice
//
//  Created by wzk on 2019/12/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
