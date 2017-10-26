//
//  YJTopMenuPullView.m
//  CreditPlatform
//
//  Created by yj on 2017/6/30.
//  Copyright © 2017年 kangcheng. All rights reserved.
//

#import "YJTopMenuPullView.h"
#import "YJMenuModel.h"
#import "YJTopMenuPullCell.h"
#import "YJTabBarController.h"
@interface YJTopMenuPullView ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *_dataSource;
    NSIndexPath *_currentIndexPath;
}
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *cellId = @"TopMenuPullViewCellID";
@implementation YJTopMenuPullView


+ (instancetype)topMenuPullView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YJTopMenuPullView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerClass:[YJTopMenuPullCell class] forCellWithReuseIdentifier:cellId];
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    fl.itemSize = CGSizeMake((kScreenW-30 - 20*2)/3, 35);
    _collectionView.collectionViewLayout = fl;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _collectionView.alwaysBounceVertical = YES;
    _dataSource = @[
                    [YJMenuModel menuModelWith:@"运营商"],
                    [YJMenuModel menuModelWith:@"京东"],
                    [YJMenuModel menuModelWith:@"淘宝"],
                    [YJMenuModel menuModelWith:@"失信被执行"],
                    [YJMenuModel menuModelWith:@"学历学籍"],
                    [YJMenuModel menuModelWith:@"公积金"],
                    [YJMenuModel menuModelWith:@"央行征信"],
                    [YJMenuModel menuModelWith:@"社保"],
                    [YJMenuModel menuModelWith:@"信用卡账单"],
                    [YJMenuModel menuModelWith:@"车险"],
                    [YJMenuModel menuModelWith:@"领英"],
                    [YJMenuModel menuModelWith:@"网银流水"],
                    [YJMenuModel menuModelWith:@"滴滴"],
                    [YJMenuModel menuModelWith:@"携程"]
                    ];

    
    
}

- (void)setSelectedIndex:(int)selectedIndex {
    _selectedIndex = selectedIndex;
    
    _currentIndexPath = [NSIndexPath indexPathForItem:_selectedIndex inSection:0];
    [_dataSource[_selectedIndex] setIsSelected:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJTopMenuPullCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.menuModel = _dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock((int)indexPath.row);
    }
//    UITableViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    YJMenuModel *oldModel =  _dataSource[_currentIndexPath.row];
    oldModel.isSelected = NO;
    [collectionView reloadItemsAtIndexPaths:@[_currentIndexPath]];

    YJMenuModel *newModel =  _dataSource[indexPath.row];
    newModel.isSelected = YES;
    _currentIndexPath = indexPath;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
   
    
    [self hideBtnClick:nil];
    
}



- (IBAction)hideBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        // 1.scrollView从下面 -> 上面
        //        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height);
        
        
        self.alpha = 0;
        // 隐藏tabbar
        YJTabBarController *tabBarVc = [YJTabBarController shareTabBarVC];
        tabBarVc.tabBar.alpha = 1;
        
 
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        
        // 恢复属性
        self.transform = CGAffineTransformIdentity;
//        self.alpha  = 1;
    }];
    
}


@end
