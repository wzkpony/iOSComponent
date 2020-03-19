//
//  NormalCell.h
//  Crmservice
//
//  Created by wzk on 2020/1/15.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

NS_ASSUME_NONNULL_END
