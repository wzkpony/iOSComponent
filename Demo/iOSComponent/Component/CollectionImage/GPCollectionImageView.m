//
//  GPCollectionImageView.m
//  Crmservice
//
//  Created by wzk on 2019/12/28.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "GPCollectionImageView.h"
#import "HLImagesCell.h"
#import "UICollectionView+Layout.h"

@interface GPCollectionImageView()<UICollectionViewDelegate,UICollectionViewDataSource,YBImageBrowserDataSource>


@end

@implementation GPCollectionImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
   
}
- (void)awakeFromNib{
    [super awakeFromNib];
    if (self.number == 0) {
        self.number = 1;
    }
    /**初始化数据*/
    if (_imageidsArray == nil) {
        _imageidsArray = [NSMutableArray new];
    }
    if (_imagePathsArray == nil) {
        _imagePathsArray = [NSMutableArray new];
    }
    [_imagePathsArray addObject:@"btn_addSend"];
    [_imageidsArray addObject:@"btn_addSend"];
    
    CGFloat itemWidth = 80*App_SCREEN_RATIO6;
    
    [self.collectionView configLayoutCollectionWithItemWidth:itemWidth withHeight:itemWidth minimumInteritemSpacing:5 minimumLineSpacing:1 sectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_collectionView registerNib:[UINib nibWithNibName:@"HLImagesCell" bundle:nil] forCellWithReuseIdentifier:@"HLImagesCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imagePathsArray.count > self.number) {
        return self.number;
    }
    return _imagePathsArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HLImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HLImagesCell" forIndexPath:indexPath];
    NSString *obj = _imagePathsArray[indexPath.row];

    cell.delButton.tag = indexPath.item;
    [cell.delButton addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.imageViews.contentMode = UIViewContentModeScaleAspectFill;
    if ([@"btn_addSend" isEqualToString:obj]) {
        cell.delButton.hidden = YES;
        cell.imageViews.image = App_IMAGE(obj);//+号
    }
    else{
        cell.delButton.hidden = NO;
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageFilePath = [path stringByAppendingPathComponent:obj];
        cell.imageViews.image = [UIImage imageWithContentsOfFile:imageFilePath];
//        [cell.imageViews sd_setImageWithURL:[NSURL fileURLWithPath:imageFilePath] placeholderImage:[UIImage imageNamed:@"btn_addSend"]];
//    [cell.imageViews sd_setImageWithURL:App_File_URL_String(@"", @"") placeholderImage:App_IMAGE(@"img_none2")];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *obj = _imagePathsArray[indexPath.row];
    
    if ([@"btn_addSend" isEqualToString:obj]) {
        [self selectImage];
        
    }
    else{
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSource = self;
        browser.currentPage = 0;
//        browser.enterTransitionType = YBImageBrowserTransitionTypeFade;
//        browser.outTransitionType = YBImageBrowserTransitionTypeFade;
        //展示
        [browser show];
    }
}
- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser{
    return _imagePathsArray.count;
}

- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index{
    NSString *obj = _imagePathsArray[index];
    YBIBImageData *data = [YBIBImageData new];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:obj];
    data.imagePath = imageFilePath;
    return data;
}

- (void)delImage:(UIButton *)button{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:_imagePathsArray.firstObject];
    
    
    BOOL isImage = [[NSFileManager defaultManager] fileExistsAtPath:imageFilePath];
    if (isImage) {
        
       BOOL success = [[NSFileManager defaultManager] removeItemAtPath:imageFilePath error:nil];
        NSLog(@"%ld",success);
    }
    [_imageidsArray removeObjectAtIndex:button.tag];
    [_imagePathsArray removeObjectAtIndex:button.tag];
    if (_imagePathsArray.count == 0) {
        [_imagePathsArray addObject:@"btn_addSend"];
    }
    if (_imageidsArray.count == 0) {
        [_imageidsArray addObject:@"btn_addSend"];
    }
  
    
    [self.collectionView reloadData];
}


- (void)selectImage{
    __weak typeof(self) weakSelf = self;
    if (self.isImageChannle == 1) {
        [self photoPic];

    }
    else if (self.isImageChannle == 2){
        [self imagePickerVC];

    }
    else{
        
        
        [LEEAlert actionsheet].config
        .LeeCornerRadius(5)
        .LeeAddAction(^(LEEAction *action) {
            // 自定义设置Block
            // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
            action.title = @"拍照";
            action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
            action.titleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
            action.clickBlock = ^{
                NSLog(@"拍照");
                [weakSelf photoPic];
            };
        })
        .LeeAddAction(^(LEEAction *action) {
            // 自定义设置Block
            // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
            action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
            action.title = @"手机相册";
            action.backgroundImage = [UIImage imageNamed:@"Rectangle27"];
            action.titleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
            action.clickBlock = ^{
                NSLog(@"手机相册");
                [weakSelf imagePickerVC];
            };
        })
        .LeeShow();
    }
    return;

}
/**从相册选择*/
- (void)imagePickerVC{
    __weak typeof(self) weakSelf = self;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.number delegate:self];
    // 是否允许显示视频
    imagePickerVc.allowPickingVideo =  NO;
    // 是否允许显示图片
    imagePickerVc.allowPickingImage = YES;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        for (NSInteger i = 0; i<photos.count; i++) {
            UIImage* img = photos[0];
            [weakSelf performSelectorOnMainThread:@selector(addImage:) withObject:img waitUntilDone:true];
        }
        
    }];
    [self.jk_viewController.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
}

/**从相册选择照片成功*/
-(void)addImage:(UIImage*)image{
    NSData *data = [RequestUtil configImageData:image];
    // 本地沙盒目录
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *fileName = @"MyImage.jpg";
    NSString *imageFilePath = [path stringByAppendingPathComponent:fileName];
    
    // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    
    BOOL success = [data writeToFile:imageFilePath atomically:YES];
    
    if (success){
        
        NSLog(@"写入本地成功");
        [self.imagePathsArray replaceObjectAtIndex:0 withObject:fileName];
        [self.collectionView reloadData];
    }

//    [self requestUpdateFiled:@[data] nameKeys:@[@"attach"] mimeTypes:@[@"image/jpg"]];
}

/**拍照*/
- (void)photoPic{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    //    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self.jk_viewController presentViewController:picker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
    
}
#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    
    NSLog(@"finish..");
    
    
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [self addImage:image];
        
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
