//
//  YJPhotoAlbumVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJPhotoAlbumVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
 #import <Photos/Photos.h>
#import "YJPhotoAlbumCell.h"
#import "YJPhotoItemModel.h"

@interface YJPhotoAlbumVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> //UICollectionViewDataSourcePrefetching
{
    UICollectionView *_collectionView;
    
    NSMutableArray *_AssetArray;
    
    NSMutableArray *_addImageArr; // 最多放8张图片
    NSMutableArray *_addImageBase64Arr; // 最多放8张图片

}

@property (nonatomic,strong) NSMutableArray *assetGroups;

@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic,strong) NSMutableArray *isSelectedList;


@property (nonatomic,strong) NSMutableArray *images;


@end

static NSString *collectionIdentifier = @"photoAlbumCell";

@implementation YJPhotoAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _addImageBase64Arr = [NSMutableArray arrayWithCapacity:0];
    _addImageArr = [NSMutableArray arrayWithCapacity:0];

    self.title = @"相机胶卷";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(okItemClcik)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancelItemClcik)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self load];
    [self creatCollectionView];
    
//    [self reloadImagesFromLibrary];
    
    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    
}

#pragma mark -- 点击返回
- (void)okItemClcik {
    if (_addImageBase64Arr.count==0) {
        
        [self.view makeToast:@"请选择图片"];
        return;
    }
    
    if (self.photosBlock) {
        self.photosBlock(_addImageBase64Arr);
    }
    
    [self cancelItemClcik];
    
}
- (void)cancelItemClcik {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)creatCollectionView {
    // (UICollectionViewLayout *)决定他的布局方式
    
    CGFloat margin = 5;
    int col = 4;
    
    CGFloat photoWH = (SCREEN_WIDTH -margin*2 - margin * 3) / col;
    
    //平铺方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(photoWH, photoWH); //设置cell的大小
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height-64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    _collectionView.prefetchDataSource = self;
    _collectionView.showsVerticalScrollIndicator = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[YJPhotoAlbumCell class] forCellWithReuseIdentifier:collectionIdentifier];
    _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    
    

    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    [self.view addSubview:_collectionView];
    
}



#pragma mark--UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MYLog(@"--------%ld---%ld",section,self.images.count);
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJPhotoAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];

        cell.itemModel = self.images[indexPath.row];


    return cell;
}
#pragma mark--UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YJPhotoItemModel *itemModel = self.images[indexPath.row];
//    MYLog(@"=====%@",itemModel.base64ImageStr);

    // 1.控制最多还能选择多少张
    if (_addImageBase64Arr.count == self.totalCount && !itemModel.isSelected) {
        NSString *msg = nil;
        if (self.totalCount == 8) {
            msg = [NSString stringWithFormat:@"最多能选择%d张照片",self.totalCount];
        } else {
            msg = [NSString stringWithFormat:@"只能选择%d张照片了",self.totalCount];
        }
        
        UIAlertController *AlertVC = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [AlertVC addAction:action];
        
        [self presentViewController:AlertVC animated:YES completion:^{
            
        }];
        
        return;
    }
    
    
    // 2.选择的图片base64放进数组
    if (!itemModel.isSelected) {
//        MYLog(@"=====%@",itemModel.base64ImageStr);
        if (itemModel.base64ImageStr == nil) {
            return;
        }
        
        [_addImageBase64Arr addObject:itemModel.base64ImageStr];
    } else {
        [_addImageBase64Arr removeObject:itemModel.base64ImageStr];

    }
    
    // 3.控制是否选中
    itemModel.isSelected = !itemModel.isSelected;
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    
    
}

#pragma mark--UICollectionViewDataSourcePrefetching
//- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//    
////    MYLog(@"prefetch--------%@",indexPaths);
//    
//    
//}
//- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
////    MYLog(@"cancelPrefetching--------%@",indexPaths);
//    
//}






- (void)load {
    
    self.images = [[NSMutableArray alloc] init];
    __weak typeof(self) weakSelf = self;


    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            // Group Enumerator Failure Block
            [YJShortLoadingView yj_makeToastActivityInView:self.view];
            
            void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
                    NSString *errorMessage = @"您未对相册授权，请在设置中打开权限设置。";
                    [[[UIAlertView alloc] initWithTitle:@"鉴权失败" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    
                } else {
                    NSString *errorMessage = [NSString stringWithFormat:@"相册错误: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]];
                    [[[UIAlertView alloc] initWithTitle:@"错误" message:errorMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                }
                
                [self.navigationItem setTitle:nil];
            };
            
            
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
            {
                if (group == nil) {
                    return;
                }
                
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    //index就是他的位置
                    //ALAsset 的这个result 就是我们要的图片
                    //两种情况
                    //单选的话，这个界面是自带的
                    //多选的话，没有提供界面，但是提供了照片的资源，我们可以创建一个tableview来弄
                    //这个地方我们一般是找一个model或者数组来接受
                    
                    //用数组保存起来
                
                    
                    if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                        
                        
                        YJPhotoItemModel *itemPhoto = [[YJPhotoItemModel alloc] init];
//                        itemPhoto.photo = [UIImage imageWithCGImage:result.thumbnail];
                        itemPhoto.asset = result;
                        
                        itemPhoto.isSelected = NO;
                        [self.images addObject:itemPhoto];
                    }
                    
                }];
                [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];

                
                // 刷新
                [_collectionView performSelectorOnMainThread:@selector(reloadData)
                 
                                                  withObject:nil waitUntilDone:YES];
                
                if (self.images.count) {
                    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count-1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
                }
                
                
            };
            
            
            // Enumerate Albums
            
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            self.library = library;
            [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                   usingBlock:assetGroupEnumerator
                                 failureBlock:assetGroupEnumberatorFailure];
           
            
            
        }
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//获取相册的所有图片
- (void)reloadImagesFromLibrary
{
    self.images = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        @autoreleasepool {

            ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
                MYLog(@"相册访问失败 =%@", [myerror localizedDescription]);
                if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                    MYLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
                }else{
                    MYLog(@"相册访问失败.");
                }
            };
            
            ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
                if (result!=NULL) {
                    
                    
                    if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                        
                        YJPhotoItemModel *itemPhoto = [[YJPhotoItemModel alloc] init];
                        itemPhoto.photo = [UIImage imageWithCGImage:result.thumbnail];
                        itemPhoto.isSelected = NO;
                        [self.images addObject:itemPhoto];
                        
//                        [_AssetArray addObject:result];
                        
                        //                        [self.images addObject:result];
                        //                        [result aspectRatioThumbnail];
                        //                        [self.images addObject:[UIImage imageWithCGImage:result.thumbnail]];
                        //                        [self.images addObject:[UIImage imageWithCGImage:result.defaultRepresentation.fullScreenImage]];
                        
                        
                    }
                } else {
                    

                    [_collectionView performSelectorOnMainThread:@selector(reloadData)
                     
                                                      withObject:nil waitUntilDone:YES];
                    
                    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.images.count-1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
                    

                    
                }
            };
            
            ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
                
                if (group == nil)
                {
                    
                }
                
                if (group!=nil) {
                    NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                    NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
                    
                    NSString *g1=[g substringFromIndex:16 ] ;
                    NSArray *arr=[[NSArray alloc] init];
                    arr=[g1 componentsSeparatedByString:@","];
                    NSString *g2=[[arr objectAtIndex:0] substringFromIndex:5];
                    if ([g2 isEqualToString:@"Camera Roll"]) {
                        g2=@"相机胶卷";
                    }
                    NSString *groupName=g2;//组的name
                    
                    [group enumerateAssetsUsingBlock:groupEnumerAtion];
                }
                
            };
            
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            self.library = library;
            [self.library  enumerateGroupsWithTypes:ALAssetsGroupAll
                                         usingBlock:libraryGroupsEnumeration
                                       failureBlock:failureblock];
            
            
        }
        
    });
    
    
    
}


@end
