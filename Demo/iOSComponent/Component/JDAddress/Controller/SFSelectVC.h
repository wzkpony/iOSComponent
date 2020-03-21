//
//  SFSelectVC.h
//  iseasoftCompany
//
//  Created by songfei on 2018/4/19.
//  Copyright © 2018年 hycrazyfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFSelectModel.h"
#import "SFSelectTableViewCell.h"
typedef void (^SoureBlock)(NSMutableArray<SFSelectModel*> *models);
@protocol SFSelectVCDataSource <NSObject>
- (void)sFSelectVCSourceBackWithDepth:(NSInteger)depth regionId:(NSString*)regionId block:(SoureBlock)block;
@end
@protocol SFSelectVCDelegate <NSObject>
- (void)sFSelectVCDidChange:(NSString*)adress firstRegionId:(NSString*)firstRegionId lastRegionId:(NSString*)lastRegionId;
@end
@interface SFSelectVC : UIViewController
@property (nonatomic ,weak) id<SFSelectVCDataSource> dataSource;
@property (nonatomic ,weak) id<SFSelectVCDelegate> delegate;
@property (nonatomic ,strong) NSMutableArray<NSMutableArray<SFSelectModel*>*> *allModelArray;//全部的数据
@property (nonatomic ,strong) NSMutableArray<SFSelectModel *> *midelModels;//中间分类
@property (nonatomic ,strong) SFSelectModel *lastSelctcModel;
@property (nonatomic ,strong) NSMutableArray<SFSelectModel*>* selectArr ;
- (instancetype)initWithFirstData:(NSMutableArray<SFSelectModel *>*)firstData;
@end
