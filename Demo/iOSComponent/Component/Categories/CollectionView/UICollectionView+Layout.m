//
//  UICollectionView+Layout.m
//  Crmservice
//
//  Created by wzk on 2019/12/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "UICollectionView+Layout.h"

@implementation UICollectionView (Layout)
- (void)configLayoutCollectionWithItemWidth:(CGFloat)itemWidth withHeight:(CGFloat)itemHeight minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing minimumLineSpacing:(CGFloat)minimumLineSpacing sectionInset:(UIEdgeInsets)sectionInset {
    /**
     创建layout(布局)
     UICollectionViewFlowLayout 继承与UICollectionLayout
     对比其父类 好处是 可以设置每个item的边距 大小 头部和尾部的大小
     */
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    itemWidth = (itemWidth== 0)?((self.jk_width - 40) / 3):itemWidth;
    
    // 设置每个item的大小 100:83比例
    itemHeight = (itemHeight == 0)?(itemWidth*83/100.0):itemHeight;
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // 设置列间距
    layout.minimumInteritemSpacing = (minimumInteritemSpacing == 0)?5:minimumInteritemSpacing;
    
    // 设置行间距
    layout.minimumLineSpacing = minimumLineSpacing;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = sectionInset;
    //
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //layout.estimatedItemSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置布局方向(滚动方向)
    //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置头视图尺寸大小
    //layout.headerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置尾视图尺寸大小
    //layout.footerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    //
    // 设置分区(组)的EdgeInset（四边距）
    //layout.sectionInset = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    //
    // 设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
    //        layout.sectionFootersPinToVisibleBounds = YES;
    //        layout.sectionHeadersPinToVisibleBounds = YES;
    
    /**
     初始化mainCollectionView
     设置collectionView的位置
     */
    
    /** mainCollectionView 的布局(必须实现的) */
    self.collectionViewLayout = layout;
}
@end
