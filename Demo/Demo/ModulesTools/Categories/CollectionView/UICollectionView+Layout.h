//
//  UICollectionView+Layout.h
//  Crmservice
//
//  Created by wzk on 2019/12/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Layout)
/**设置collectionview的layout
 itemWidth item的宽度
 itemHeight item的高度
 minimumInteritemSpacing  设置列间距
 minimumLineSpacing  设置行间距
 sectionInset 每个分区的四边间距UIEdgeInsetsMake
 
 */
- (void)configLayoutCollectionWithItemWidth:(CGFloat)itemWidth withHeight:(CGFloat)itemHeight minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInset:(UIEdgeInsets)sectionInset;
@end

NS_ASSUME_NONNULL_END
