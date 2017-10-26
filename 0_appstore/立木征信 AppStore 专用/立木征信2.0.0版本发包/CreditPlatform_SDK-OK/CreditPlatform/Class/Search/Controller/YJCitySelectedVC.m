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

@interface YJCitySelectedVC ()
{
    NSIndexPath *_currentIndexPath;
    
    NSIndexPath *_scrollIndexPath;
    
    int _totalCities;
}

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@end

@implementation YJCitySelectedVC

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
            MYLog(@"%@",responseObj);
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

- (void)reloadDataAndScrollPosition {
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:_scrollIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexColor = RGB_navBar;
    self.tableView.sectionIndexBackgroundColor =[UIColor clearColor];
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
    
    YJCityModel *city = self.dataSource[indexPath.section];
    YJCitySelectCell *cell = [YJCitySelectCell citySelectCellWithTableView:tableView];
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
    
    self.selectedOneCity(currentModel);

    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:.25];

}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];

}


@end
