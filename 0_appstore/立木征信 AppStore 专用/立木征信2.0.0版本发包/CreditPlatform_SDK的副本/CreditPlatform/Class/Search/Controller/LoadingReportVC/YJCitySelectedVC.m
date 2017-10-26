//
//  YJCitySelectedVC.m
//  CreditPlatform
//
//  Created by yj on 2016/11/2.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJCitySelectedVC.h"
#import "YJCityModel.h"
#import "YJCitySelectCell.h"
#import "YJCitySearchResultVC.h"

@interface YJCitySelectedVC ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSIndexPath *_currentIndexPath;
    
    NSIndexPath *_scrollIndexPath;
    
    int _totalCities;
    
    UISearchController *_searchController;
    
    UISearchBar *_searchBar;
    
    CGFloat _startOffSetY;
    CGFloat _endOffSetY;
    
}

@property (nonatomic,strong) NSArray *dataSource;// 模型数据
@property (strong,nonatomic) NSMutableArray *searchList;// 搜索城市名
@property (strong,nonatomic) NSMutableArray *totalList;// 城市名汇总

@property (nonatomic,strong) NSMutableArray *titlesArray;//组标题a/b/c
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation YJCitySelectedVC

/**
 城市名字汇总列表
 */
- (NSMutableArray *)totalList {
    if (_totalList == nil) {
        _totalList = [NSMutableArray arrayWithCapacity:10];
    }
    return _totalList;
}
/**
 搜索匹配城市名字列表
 */
- (NSMutableArray *)searchList {
    if (_searchList == nil) {
        _searchList = [NSMutableArray arrayWithCapacity:0];
    }
    return _searchList;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreenW, kScreenH-64 - 45) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = RGB_pageBackground;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 45;
//        _tableView.sectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.sectionIndexColor = RGB_navBar;
        _tableView.sectionIndexBackgroundColor =[UIColor clearColor];
    }
    
    return _tableView;
}


#pragma mark-- 数据源
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
        _titlesArray = [NSMutableArray array];

        __weak typeof(self) weakSelf = self;
        [YJShortLoadingView yj_makeToastActivityInView:self.view];
        __block NSString *type = [NSString new];
        if (self.searchItemType == SearchItemTypeHousingFund) {
            type = @"housefund";
        }else if (self.searchItemType == SearchItemTypeSocialSecurity){
            type = @"socialsecurity";
        }
        
        NSDictionary *dicParams =@{@"method" : urlJK_queryCities,
                                   @"mobile" : kUserManagerTool.mobile,
                                   @"userPwd": kUserManagerTool.userPwd,
                                   @"bizType":type,
                                   @"appVersion": VERSION_APP_1_4_0};
        
        _totalCities = 0;
        [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_queryCities] params:dicParams success:^(id responseObj) {
//            MYLog(@"%@",responseObj);
            dispatch_async(dispatch_get_main_queue(), ^{
                [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];
            });
            
            NSArray *list = [responseObj objectForKey:@"list"];
            if (![list isKindOfClass:[NSNull class]]&&([responseObj[@"code"] isEqualToString:@"0000"])) {//有数
                _dataSource = [YJCityModel mj_objectArrayWithKeyValuesArray:list];
                
                int i = 0;
                for (YJCityModel *model in _dataSource) {
                    [_titlesArray addObject:model.key]; //组标题a/b/c
                    _totalCities += (int)model.sortList.count;
                    int j = 0;
                    for (YJCityInfoModel *modelInfo in model.sortList) {
                        
                        [weakSelf.totalList addObject:modelInfo.areaName];
                        
                        
                        if ([modelInfo.areaName isEqualToString:_cityString]) {
                            modelInfo.isSelected = YES;
                            
                            _scrollIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                            _currentIndexPath = _scrollIndexPath;
                            
                        }else {
                            modelInfo.isSelected =NO;
                        }
                        
                        j ++;
                    }
                    
                    i ++;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf performSelector:@selector(reloadDataAndScrollPosition) withObject:nil afterDelay:0.2];
                    
                    
                });
            
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.view makeToast:[responseObj objectForKey:@"msg"]];
                    
                    
                });
            }
            
            
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [YJShortLoadingView yj_hideToastActivityInView:weakSelf.view];
                [weakSelf.view makeToast:errorInfo];
                
            });
            
        }];
        
    }
    return _dataSource;
}

#pragma mark-- 上次选中城市滚动到顶部
- (void)reloadDataAndScrollPosition {
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:_scrollIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupSearchViewController];

}
#pragma mark-- 设置搜索控制器
- (void)setupSearchViewController {
    
    YJCitySearchResultVC *resultVc = [[YJCitySearchResultVC alloc] init];
    __weak typeof(self) weakSelf = self;
    resultVc.selectCity = ^(NSString *cityName) {
        MYLog(@"----%@",cityName);
        int i = 0;
        for (YJCityModel *model in weakSelf.dataSource) {
            int j = 0;
            for (YJCityInfoModel *modelInfo in model.sortList) {
                if ([modelInfo.areaName isEqualToString:cityName]) {
                    weakSelf.selectedOneCity(modelInfo);
                    break;
                }
                j ++;
            }
            i ++;
        }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];

//        [weakSelf performSelector:@selector(dismiss) withObject:nil afterDelay:.25];
        
        
    };
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVc];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    //        _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    //        _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    //        _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchBar = _searchController.searchBar;
    _searchBar.frame = CGRectMake(0, 0, kScreenW, 45.0);
    [self.view addSubview:_searchBar];
    self.definesPresentationContext = YES;
    
    //    _searchBar.barTintColor = RGB_pageBackground;
    //    UIImageView *view = [[[_searchBar.subviews objectAtIndex:0] subviews] firstObject];
    //    view.layer.borderColor = RGB_pageBackground.CGColor;
    //    view.layer.borderWidth = 1;
    //
    //    for (UIView *sonV in _searchBar.subviews) {
    //        if (sonV.subviews.count) {
    //            for (UIView *vv in sonV.subviews) {
    //                if ([vv isKindOfClass:[UITextField class]]) {
    //                    UITextField *tf = (UITextField *)vv;
    //                    tf.layer.borderWidth = 0.5;
    //                    tf.layer.borderColor = RGB(221, 221, 221).CGColor;
    //                    tf.layer.cornerRadius = 3;
    //                    tf.clipsToBounds = YES;
    //                    break;
    //                }
    //            }
    //        }
    //    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

         return self.dataSource.count;

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

        YJCityModel *city = self.dataSource[section];
        
        return [city sortList].count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        YJCitySelectCell *cell = [YJCitySelectCell citySelectCellWithTableView:tableView];
    
        YJCityModel *city = self.dataSource[indexPath.section];
        cell.cityInfoModel = city.sortList[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.topLine.hidden = YES;
    } else {
        cell.topLine.hidden = NO;
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
     YJCityModel *city = self.dataSource[section];
    

        return city.key;
        
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.titlesArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    btn.contentMode = UIViewContentModeLeft;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 16.5, 0, 0);
    btn.backgroundColor = RGB_pageBackground;
    [btn setTitleColor:RGB_grayNormalText forState:(UIControlStateNormal)];
    btn.titleLabel.font = Font13;
    [btn setTitle:self.titlesArray[section] forState:(UIControlStateNormal)];
    btn.userInteractionEnabled = NO;
    
    return btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  {
    if (section == self.dataSource.count - 1) {
        return 45;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    if (section == self.dataSource.count - 1) {
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //    btn.contentMode = UIViewContentModeLeft;
       // btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //btn.contentEdgeInsets = UIEdgeInsetsMake(0, 16.5, 0, 0);
        btn.backgroundColor = RGB_pageBackground;
        [btn setTitleColor:RGB_grayNormalText forState:(UIControlStateNormal)];
        btn.titleLabel.font = Font18;
        [btn setTitle:[NSString stringWithFormat:@"共%d座城市",_totalCities] forState:(UIControlStateNormal)];
        btn.userInteractionEnabled = NO;
        
        return btn;
    }
    return nil;
}


#pragma mark - Table view data delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YJCityInfoModel *selectedModel = [self.dataSource[_currentIndexPath.section] sortList][_currentIndexPath.row];
    selectedModel.isSelected = NO;
    if (_currentIndexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[_currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];

    }

    
    
    YJCityInfoModel *currentModel = [self.dataSource[indexPath.section] sortList][indexPath.row];
    currentModel.isSelected = YES;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    
    _currentIndexPath = indexPath;
    
    self.tableView.userInteractionEnabled = NO;
    
    self.selectedOneCity(currentModel);

    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:.25];

}
#pragma mark - UIScrollView delegate代理

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 正在滚动时点击
    if (scrollView.decelerating) {
        [self refreshSearchBar:_startOffSetY endOffSetY:scrollView.contentOffset.y];
    }
    
    // 记录开始点
    _startOffSetY = scrollView.contentOffset.y;

    
    
//    MYLog(@"scrollViewWillBeginDragging---%d",scrollView.decelerating);
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    MYLog(@"scrollViewDidEndDragging---%d",scrollView.decelerating);

        _endOffSetY = scrollView.contentOffset.y;
        
        [self refreshSearchBar:_startOffSetY endOffSetY:_endOffSetY];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    MYLog(@"scrollViewDidEndDecelerating---%d",scrollView.decelerating);

    // 记录结束点
    _endOffSetY = scrollView.contentOffset.y;
    
    [self refreshSearchBar:_startOffSetY endOffSetY:_endOffSetY];
    
}

- (void)refreshSearchBar:(CGFloat)startOffSetY endOffSetY:(CGFloat)endOffSetY {
    CGFloat scrollV = 150;
    if (endOffSetY - startOffSetY > scrollV) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _searchBar.alpha = 0;
            _tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - 64.0);
        }];
    }
    
    if (endOffSetY - startOffSetY < - scrollV) {
        [UIView animateWithDuration:0.25 animations:^{
            _searchBar.alpha = 1;
            _tableView.frame = CGRectMake(0, 45, kScreenW, kScreenH - 64.0 - 45.0);
        }];
    }
    
}



#pragma mark - UISearchControllerDelegate代理
- (void)willPresentSearchController:(UISearchController *)searchController
{
    
    
}

- (void)didPresentSearchController:(UISearchController *)searchController
{

    for (UIView *sonV in _searchBar.subviews) {
        //        MYLog(@"sonV-------%@",sonV);
        if (sonV.subviews.count) {
            for (UIView *vv in sonV.subviews) {
                if ([vv isKindOfClass:[UIButton class]]) {
                    UIButton *cancleBtn = (UIButton *)vv;
                    [cancleBtn setTitleColor:RGB_navBar forState:(UIControlStateNormal)];
                }
            }
        }
    }
    
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    
}

- (void)presentSearchController:(UISearchController *)searchController
{
    
  
}


#pragma mark- UISearchResultsUpdating搜索协议
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    
    YJCitySearchResultVC *resultVc = (YJCitySearchResultVC *)searchController.searchResultsController;
    resultVc.searchList = [NSMutableArray arrayWithArray:[self.totalList filteredArrayUsingPredicate:preicate]];
    
    //刷新表格
    [resultVc.tableView reloadData];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)dealloc {
    MYLog(@"---------%@销毁了",self);
}

@end
