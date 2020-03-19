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
    self.contentsView = [[UINib nibWithNibName:@"GPCollectionMenuView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    [self addSubview:self.contentsView];
    self.contentsView.backgroundColor = [UIColor clearColor];
    [self.contentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.collectionView configLayoutCollectionWithItemWidth:105 withHeight:105 minimumInteritemSpacing:((App_WIDTH-40 - 4*105)/3) minimumLineSpacing:0 sectionInset:UIEdgeInsetsMake(20, 10, 0, 10)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GPItemCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
 
}
- (void)setDataSource:(NSArray<NSDictionary *> *)dataSource{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GPItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GPItemCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.item];
    cell.nameLabel.text = dict[@"name"];
    cell.nameLabel.textColor = self.itemTextLabelColor;
    cell.titleImageView.image = App_IMAGE(dict[@"imageUrl"]);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    if (self.selectItemForCollectionView != nil) {
        self.selectItemForCollectionView(indexPath);
    }
}
@end
