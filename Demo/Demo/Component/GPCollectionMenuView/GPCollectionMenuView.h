//
//  GPCollectionMenuView.h
//  Crmservice
//
//  Created by wzk on 2019/12/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPCollectionMenuView : BaseView
@property (strong, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 NSDictionary 格式：@{@"name":@"xxxx",@"imageUrl":@"xxxx"}
 */
@property (nonatomic ,strong) NSArray<NSDictionary *> *dataSource;

@property (nonatomic ,strong) UIColor *itemBackgroundColor;
@property (nonatomic ,strong) UIColor *itemTextLabelColor;
@property (nonatomic ,copy)void (^selectItemForCollectionView)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
