;//
//  YJSearchViewController.m
//  CreditPlatform
//
//  Created by yj on 16/7/20.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJSearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LoginVC.h"
#import "YJCycleModel.h"

#import "YJHomeItemModel.h"
#import "YJAlertView.h"
#import "YJHomeCollectionViewCell.h"

#import <CommonCrypto/CommonDigest.h>
#import "YJAuthorizationViewController.h"
#import "YJAuthTipModalView.h"
#import "YJHomeReusableFooterView.h"
#import "YJHomeGuideContentVC.h"
#import "YJStartSearchViewController.h"
@interface YJSearchViewController ()
{
    
    

    
}





@property (nonatomic, strong) NSArray *homeSearchItems;

@property (nonatomic, strong) YJAuthTipModalView *authTipModalView;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

static NSString *collectionIdentifier = @"homeCollectionViewCell";
static NSString *footerCollectionIdentifier = @"footerCollectionIdentifier";

@implementation YJSearchViewController
{
}




- (NSArray *)homeSearchItems {
    if (_homeSearchItems == nil) {
        _homeSearchItems = [NSArray array];
        
//        _homeSearchItems = [YJHomeItemModel mj_objectArrayWithFilename:@"homeSearchItem.plist"];
        
        _homeSearchItems = [YJHomeItemModel mj_objectArrayWithKeyValuesArray:[self homeItems]];
        
        
        
    }
    return _homeSearchItems;
}


- (NSArray *)homeItems {
    return @[
    @{
        @"searchItemType":@0,
        @"icon":@"home_icon_basic",
        @"title":@"基础版报告",
        @"subTitle":@"适用于蓝领、初级岗位",
        @"des":@"Basic Edition",
        @"price":@"28",
        @"intro":@{
                @"searchItemType":@0,
                @"introBgImg":@"home_introBasic_bg",
                @"icon":@"home_icon_introBasic",
                @"title":@"基础版报告",
                @"subTitle":@"适用于蓝领、企业初级岗位",
                @"des":@"Basic Edition",
                @"content":@"身份验证 + 风险黑名单检测，\n4项权威数据多维度验证求职者（候选人）背景，\n为企业规避用人风险 。",
                @"price":@"28"
                }
    },
    @{
        @"searchItemType":@1,
        @"icon":@"home_icon_standard",
        @"title":@"标准版报告",
        @"subTitle":@"适用于企业中、高级白领",
        @"des":@"Standard Edition",
        @"price":@"38",
        @"intro":@{
                @"searchItemType":@1,
                @"introBgImg":@"home_introStandard_bg",
                @"icon":@"home_icon_introStandard",
                @"title":@"标准版报告",
                @"subTitle":@"适用于企业中、高级白领职工",
                @"des":@"Standard Edition",
                @"content":@"教育背景 + 身份验证 + 风险黑名单检测三大维度，\n7项权威数据全面核查候选人身份，\n拒绝虚假信息 。",
                @"price":@"38"
                }
    }];
}



- (YJAuthTipModalView *)authTipModalView {
    if (_authTipModalView == nil) {
        _authTipModalView = [[YJAuthTipModalView alloc] init];
    }
    return _authTipModalView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.navigationItem.title = @"立木背调";
    
    [self setupCollectionView];
    
    
    if ([kUserManagerTool isLogin]) {
        
    } else {
        LoginVC *ll = [[LoginVC alloc]init];
        JENavigationController *nav = [[JENavigationController alloc] initWithRootViewController:ll];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    

    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];

}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat margin = 15;
    flowLayout.itemSize = CGSizeMake(kScreenW, 150);
    [flowLayout setFooterReferenceSize:(CGSizeMake(kScreenW, 45))];
//    flowLayout.minimumInteritemSpacing = 10;
//    flowLayout.minimumLineSpacing = 10;
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.alwaysBounceVertical = YES;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YJHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionIdentifier];
    _collectionView.contentInset = UIEdgeInsetsMake(184, 0, 0, 0);
    
//    MYLog(@"----%ld",self.homeSearchItems.count);
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YJHomeReusableFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier];
    
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MYLog(@"----%ld",self.homeSearchItems.count);
    return self.homeSearchItems.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    cell.homeItemModel = self.homeSearchItems[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    // 进入引导页
    cell.guideBlock = ^{
        
        YJHomeGuideContentVC *introVc = [[YJHomeGuideContentVC alloc] init];
        introVc.introModel = [weakSelf.homeSearchItems[indexPath.row] introModel];
        
        [weakSelf.navigationController pushViewController:introVc animated:YES];
        
        
    };
    // 快速查询
    cell.quickSearchBlock = ^{
        YJStartSearchViewController *startVc = [[YJStartSearchViewController alloc] init];
        startVc.type = [[weakSelf.homeSearchItems[indexPath.row] introModel] searchItemType];
        
        [weakSelf.navigationController pushViewController:startVc animated:YES];
        
    };

    return cell;
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter) {
        
       YJHomeReusableFooterView *reuseableFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
        
        return reuseableFooter;
    }
    return nil;
    
}



@end
