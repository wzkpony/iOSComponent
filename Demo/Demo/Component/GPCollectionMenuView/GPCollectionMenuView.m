//
//  GPCollectionMenuView.m
//  Crmservice
//
//  Created by wzk on 2019/12/21.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "GPCollectionMenuView.h"
#import "GPItemCell.h"

@interface GPCollectionMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation GPCollectionMenuView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.collectionView configLayoutCollectionWithItemWidth:135 withHeight:135 minimumInteritemSpacing:((App_WIDTH - 4*135)/3) minimumLineSpacing:0];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GPItemCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
 
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GPItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPItemCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.item];
    cell.nameLabel.text = dict[@"name"];
    return cell;
}
@end
