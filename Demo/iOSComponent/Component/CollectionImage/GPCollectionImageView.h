//
//  GPCollectionImageView.h
//  Crmservice
//
//  Created by wzk on 2019/12/28.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPCollectionImageView : BaseView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger number;/**上传图片的个数*/

@property (nonatomic, strong) NSMutableArray<NSString *> *imagePathsArray;/**用来记录上传的图片路径，用来显示使用*/
@property (nonatomic, strong) NSMutableArray<NSString *> *imageidsArray;/**用来记录上传的额图片ID，用来提交使用*/

@property (nonatomic, assign) NSInteger isImageChannle;//0.默认是是0，代表相机和相册，1，代表只有相机，2，代表只有相册
@end

NS_ASSUME_NONNULL_END
