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
/**设置collectionview的layout*/
- (void)configLayoutCollectionWithItemWidth:(CGFloat)itemWidth withHeight:(CGFloat)itemHeight minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing;
@end

NS_ASSUME_NONNULL_END
