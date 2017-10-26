//
//  LMZXCityListiOS7VC.m
//  LMZX_SDK_Develop
//
//  Created by yj on 2017/5/12.
//  Copyright © 2017年 99baozi. All rights reserved.
//

#import "LMZXCityListiOS7VC.h"
#import "LMZXHTTPTool.h"
#import "LMZXCityModel.h"
#import "LMZXHouseFundSocialSecuritySearchVC.h"
#import "LMZXSDKNavigationController.h"
#import "LMZXCityListCell.h"
#import "LMZXDemoAPI.h"
#import <CoreLocation/CoreLocation.h>
#import "LMZXCityLocationView.h"
#import "UIBarButtonItem+LMZXExtension.h"

@interface LMZXCityListiOS7VC ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate,UISearchDisplayDelegate>
{
    NSMutableArray *_allCityModels;// 所以城市
    
    NSMutableArray *_cityGroups;// 城市分组
    
    NSMutableArray *_searchList;// 搜索城市名结果
    NSMutableArray *_totalList; // 城市汇总-供搜索
    
    NSMutableArray *_titlesArray;//组标题a/b/c
    
    NSMutableArray *_searchResultModel;//搜索结果Model
    
    NSMutableArray *_matchValues;
    NSString *_inputValue;
    
    int _refreshTime;
    UISearchBar *_searchBar;// 搜索bar
    
     NSIndexPath *_currentIndexPath;//当前城市的index
    
    UISearchDisplayController *_searchDisplayController;
    
    
    CGFloat _startOffSetY;
    CGFloat _endOffSetY;
    


}
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) LMZXCityLocationView *locationView; // 城市定位
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end


static NSString *LMZXCityListCellId = @"LMZXCityListCell";

@implementation LMZXCityListiOS7VC
#pragma mark--懒加载
- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        //        _refreshControl.attributedTitle =[[NSAttributedString alloc]initWithString:@"获取城市列表"];
        [_refreshControl addTarget:self action:@selector(loadCityListData) forControlEvents:(UIControlEventValueChanged)];
    }
    return _refreshControl;
}


- (LMZXCityLocationView *)locationView {
    if (!_locationView) {
        _locationView = [LMZXCityLocationView cityLocationView];
        _locationView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 73);
        __weak typeof(self) weakSelf = self;
        _locationView.selectedCurrentCity = ^(LMZXCityModel *city){
            
            [weakSelf loadCityElement:city];
            
        };
        
        _locationView.locationSettingBock = ^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        };
    }
    return _locationView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45.0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 45) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 45;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LMZXCityListCell class] forCellReuseIdentifier:LMZXCityListCellId];
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [self matchingStringColor];
        
        
    }
    return _tableView;
}

- (void)dealloc {
    //    LMLog(@"=========%@销毁了",self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _searchList = [NSMutableArray array];
    
    _totalList = [NSMutableArray array];
    
    _titlesArray = [NSMutableArray array];
    
    _cityGroups = [NSMutableArray array];
    
    _searchResultModel = [NSMutableArray array];
    
    _matchValues = [NSMutableArray array];
    
    
    if (self.searchItemType == LMZXSearchItemTypeHousingFund) { //公积金
        self.title = @"公积金查询";
    } else if (self.searchItemType == LMZXSearchItemTypeSocialSecurity) { // 社保
        self.title = @"社保查询";
    }
    
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 73)];
    [headerView addSubview:self.locationView];
    _tableView.tableHeaderView = headerView;
    
    
    [self.tableView addSubview:self.refreshControl];
    
    // 开始加载数据
    //    [self.refreshControl beginRefreshing];
    [self loadCityListData];
    
    
    //    [self.locationView startLocation];
    
    
    
    [self setupSearchViewController];
    
    
    [self setupLeftBtn];
    
    
    UIColor *pageColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    if (pageColor) {
        self.view.backgroundColor = pageColor;
        self.tableView.backgroundColor = pageColor;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
}
- (void)setupSearchViewController{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45.0)];
    _searchBar.placeholder = @"搜索";
    [self.view addSubview:_searchBar];
    

    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
//    _searchDisplayController.active = YES;
    _searchDisplayController.delegate = self;
    
    UITableView *searchResultsTableView = _searchDisplayController.searchResultsTableView;
    
    [searchResultsTableView registerClass:[LMZXCityListCell class] forCellReuseIdentifier:LMZXCityListCellId];
    
    searchResultsTableView.rowHeight = 45;
    searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    searchResultsTableView.tableFooterView = [[UIView alloc] init];
    
    UIColor *pageColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    if (pageColor) {
        searchResultsTableView.backgroundColor = pageColor;
    }

    _searchDisplayController.searchResultsDataSource = self;
    
    _searchDisplayController.searchResultsDelegate = self;
    
    
//    self.definesPresentationContext = YES;
}

#pragma mark - UISearchDisplayDelegate代理
//搜索状态改变事件处理方法
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
    //LMLog(@"=======searchDisplayControllerWillBeginSearch");
    
    // 设置光标颜色
    _searchBar.tintColor = [self matchingStringColor];
    _searchBar.frame = CGRectMake(0, 20, self.view.frame.size.width, 45.0);
   
    

    
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    for (UIView *sonV in _searchBar.subviews) {
//        NSLog(@"sonV-------%@",sonV);
        
        if (sonV.subviews.count) {
            for (UIView *vv in sonV.subviews) {
//                NSLog(@"vv-------%@",sonV.class);
                if ([vv isKindOfClass:[UIButton class]]) {
                    UIButton *cancleBtn = (UIButton *)vv;
                    [cancleBtn setTitleColor:[self matchingStringColor] forState:(UIControlStateNormal)];
                }
                
                if ([vv isKindOfClass:[UITextField class]]) {
                    UITextField *searchField = (UITextField*)vv;
                    
                    [searchField setBackground:nil];
                    [searchField setBorderStyle:UITextBorderStyleNone];
                    
                    searchField.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
                    
                    searchField.layer.cornerRadius = 4;
                    searchField.layer.masksToBounds = YES;
                    
                }
                if ([vv isKindOfClass:[UIImageView class]]) {
                    UIImageView *imgView = (UIImageView *)vv;
                    imgView.image = nil;
                    imgView.backgroundColor = [UIColor whiteColor];
                }
                
               
            }
        }
    }
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = _searchBar.frame;
        frame.origin.y = 0;
        _searchBar.frame = frame;
        
        
//        _searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 45.0);
    }];

}



// 显示和隐藏tableview事件处理方法:
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    _locationView.hidden = YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView {
    _locationView.hidden = NO;
}

// 搜索条件改变时响应事件处理方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
    //LMLog(@"=======shouldReloadTableForSearchString：%@",searchString);
    
    if (_searchList!= nil) {
        [_searchList removeAllObjects];
    }
    
    if (_searchResultModel) {
        [_searchResultModel removeAllObjects];
    }
    
    for (LMZXCityModel *city in _allCityModels) {
        city.isInSearchList = NO;
        
    }
    
    //    NSLog(@"updateSearchResultsForSearchController");
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    
    //判断是否为中文的正则表达式
    NSPredicate* predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[\u4e00-\u9fa5]"];
    //过滤数据
    if (searchString && searchString.length) {
        
        if ([predicate1 evaluateWithObject:[searchString substringToIndex:1]]) {// 首位为汉字

            _inputValue = searchString;
            NSArray *searchList = [NSMutableArray arrayWithArray:[_totalList filteredArrayUsingPredicate:preicate]];
            
            for (NSString *str in searchList) {
                
                for (LMZXCityModel *model in _allCityModels) {
                    if ([str isEqualToString:model.areaName]) {
                        [_searchResultModel addObject:model];
                        break;
                    }
                }
                
            }
            
            
        } else { // 非汉字
            NSMutableArray *temp = [NSMutableArray array];
            NSMutableArray *matches = [NSMutableArray array];
            
            // 1.先匹配简拼
            if (searchString.length >= 2) {
                for (LMZXCityModel *city in _allCityModels) {
                    
                    NSRange range = [city.spellShort rangeOfString:searchString  options:NSCaseInsensitiveSearch];
                    
                    if (range.location == 0 && range.length) {
                        [temp addObject:city.areaName];
                        city.isInSearchList = YES;
                        
                        [_searchResultModel addObject:city];
                        
                        [matches addObject:[city.areaName substringToIndex:range.length]];
                    }
                }
                
                
            }
            
            // 2.再匹配全拼
            for (LMZXCityModel *city in _allCityModels) {
                if (city.isInSearchList) {continue;}
                NSString *spellAll = [city.sortLetter substringToIndex:city.sortLetter.length - 3];
                //                NSLog(@"=====spellAll:%@",spellAll);
                NSRange range = [spellAll rangeOfString:searchString options:NSCaseInsensitiveSearch];
                
                // 模糊搜索
                if (range.length) {
                    if (range.location == 0) {
                        [temp insertObject:city.areaName atIndex:0 ];
                        
                        [_searchResultModel insertObject:city atIndex:0 ];
                        
                        //                        [matches addObject:[city.areaName substringToIndex:range.length]];
                    } else {
                        [temp addObject:city.areaName];
                        
                        [_searchResultModel addObject:city];
                    }
                }
                
            }
            
            _matchValues = matches;
            
            
        }
        
    }

    return YES;
    
}

#pragma mark-- 加载列表
- (void)loadCityListData {
    
    
    //    [self.refreshControl beginRefreshing];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys: [LMZXSDK shared].lmzxApiKey,@"apiKey" ,
                                 @"1.2.0",@"version", nil];
    
    if (self.searchItemType == LMZXSearchItemTypeHousingFund) { //公积金
        
        [dict setObject:@"api.housefund.getareas" forKey:@"method"];
    } else if (self.searchItemType == LMZXSearchItemTypeSocialSecurity) { // 社保
        [dict setObject:@"api.socialsecurity.getareas" forKey:@"method"];
    }
    
    [_cityGroups removeAllObjects];// 城市分组
    [_searchList removeAllObjects];// 搜索城市名结果
    [_totalList removeAllObjects]; // 城市汇总供搜索
    [_titlesArray removeAllObjects];//组标题a/b/c
    
    
    __weak typeof(self) weakSelf = self;
    //    LMLog(@"=====LMZXSDK_url:%@",LMZXSDK_url);
    [LMZXHTTPTool post:LMZXSDK_url params:dict success:^(id responseObj) {
        //LMLog(@"城市成功----%@",responseObj[@"msg"]);
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
            
            _refreshTime += 1;
            
            // 刷新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *regex = @"[A-Z]+";
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in responseObj[@"data"]) {
                    LMZXCityModel *city = [LMZXCityModel cityWithDict:dict];
                    
                    [tempArray addObject:city];
                    // 搜索的城市列表
                    [_totalList addObject:city.areaName];
                    
                    
                    
                    int len = (int)city.sortLetter.length;
                    // 截取城市简拼
                    NSMutableString *spellShort = [NSMutableString stringWithString:[city.sortLetter substringToIndex:1]];
                    for (int i = 1; i < len; i++) {
                        NSString *tempStr = [city.sortLetter substringWithRange:NSMakeRange(i, 1)];
                        if ([predicate evaluateWithObject:tempStr]) {
                            [spellShort appendString:tempStr];
                        }
                        
                    }
                    city.spellShort = spellShort;
                    
                    
                    
                }
                _allCityModels = tempArray;
                
                //            A = 65
                // 添加热门城市hot
                NSMutableArray *hotGroup = [NSMutableArray array];
                for (LMZXCityModel *city in tempArray) {
                    if ([city.areaName isEqualToString:@"北京市"] ||
                        [city.areaName isEqualToString:@"上海市"] ||
                        [city.areaName isEqualToString:@"深圳市"] ||
                        [city.areaName isEqualToString:@"广州市"]) {
                        
                        //                    LMZXCityModel *hotCity = [[LMZXCityModel alloc] init];
                        //                    hotCity.areaCode = city.areaCode;
                        //                    hotCity.areaName = city.areaName;
                        //                    hotCity.sortLetter = city.sortLetter;
                        //                    hotCity.status = city.status;
                        
                        [hotGroup addObject:city];
                        
                    }
                }
                [_titlesArray insertObject:@"热门城市" atIndex:0];
                [_cityGroups insertObject:hotGroup atIndex:0];
                
                // 城市分组A/B/C
                for (int i = 65; i <= 90; i++) {
                    
                    if (!tempArray.count) { break; }
                    NSMutableArray *group = [NSMutableArray array];
                    NSString *ascci = [NSString stringWithFormat:@"%c", i];
                    
                    
                    for (int j = 0; j < tempArray.count; j ++) {
                        LMZXCityModel *city = tempArray[j];
                        
                        
                        if ([ascci isEqualToString:[city.sortLetter substringToIndex:1] ]) {
                            [group addObject:city];
                            
                            // 城市选中
                            
                        }
                    }
                    
                    
                    if (!group.count) { continue; }
                    
                    //                for (LMZXCityModel *city in group) {
                    //                    [tempArray removeObject:city];
                    //                }
                    
                    // 组标题A/B/C
                    [_titlesArray addObject:ascci];
                    
                    [_cityGroups addObject:group];
                    
                }
                
                // 判断上次选中的城市
                BOOL isHotCity = NO;
                for (int i = 0; i < _cityGroups.count; i++) {
                    if (isHotCity) { break; }
                    NSArray *arr = _cityGroups[i];
                    
                    
                    for (int j = 0; j < arr.count ; j ++) {
                        LMZXCityModel *city = arr[j];
                        
                        if ([weakSelf.cityString isEqualToString:city.areaName]) {
                            city.isSelected = YES;
                            _currentIndexPath = [NSIndexPath indexPathForRow:j inSection: i];
                            
                            //                        LMLog(@"------_currentIndexPath%ld===%ld",_currentIndexPath.section, _currentIndexPath.row);
                            if ([weakSelf.cityString isEqualToString:@"北京市"] ||
                                [weakSelf.cityString isEqualToString:@"上海市"] ||
                                [weakSelf.cityString isEqualToString:@"深圳市"] ||
                                [weakSelf.cityString isEqualToString:@"广州市"]){
                                isHotCity = YES;
                                break;
                            }
                            
                        } else {
                            city.isSelected = NO;
                        }
                        
                    }
                    
                    
                }
                
                
                
                
                [weakSelf.locationView startLocation];
                
                
                // 城市定位成功回调
                weakSelf.locationView.locationSuccessBock = ^() {
                    if (weakSelf.locationView.currentCityName) {
                        
                        LMZXCityModel *supportedCity;
                        for (LMZXCityModel *city in tempArray) {
                            if ([weakSelf.locationView.currentCityName isEqualToString:city.areaName]) {
                                supportedCity = city;
                                break;
                            }
                        }
                        //                        LMLog(@"supportedCity=====%@",supportedCity);
                        
                        if (supportedCity) {
                            
                            weakSelf.locationView.cityModel = supportedCity;
                            // 设置选中效果
                            if ([supportedCity.areaName isEqualToString:weakSelf.cityString]) {
                                [weakSelf.locationView setupSelectedArea];
                            }
                            
                            //                        LMLog(@"---当前城市--%@",weakSelf.locationView.currentCityName);
                        } else {
                            // 设置不支持
                            [weakSelf.locationView setupUnsupportedArea];
                        }
                        
                    }
                };
                
                
                [weakSelf.refreshControl endRefreshing];
                [weakSelf reloadDataAndScrollPosition];
            });
            
        }
        
        
    } failure:^(NSString *error) {
        //        MYLog(@"城市失败----%@",error);
        [weakSelf.refreshControl endRefreshing];
        [weakSelf.view makeToast:@"获取城市列表失败，请检查网络"];
        
    }];
    
    
    
}





#pragma mark-- 上次选中城市滚动到顶部
- (void)reloadDataAndScrollPosition {
    
    [self.tableView reloadData];
    if (_currentIndexPath && _refreshTime == 1) {
        [self.tableView scrollToRowAtIndexPath:_currentIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:NO];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return _cityGroups.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return [_cityGroups[section] count];
    }
    return _searchResultModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LMZXCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:LMZXCityListCellId forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.topLine.hidden = YES;
    } else {
        cell.topLine.hidden = NO;
    }
    
    LMZXCityModel *cityModel;

    if (tableView == self.tableView) {
        if (_cityGroups.count) {
            //LMLog(@"_cityGroups:%d",_cityGroups.count);
            cityModel = _cityGroups[indexPath.section][indexPath.row];
            cell.cityModel = cityModel;
        };
    } else {
        
        if (_searchResultModel.count) {
            cityModel =  _searchResultModel[indexPath.row];
            cityModel.isSelected = NO;
//            cell.cityModel = cityModel;
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:cityModel.areaName attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
            
            
            if (_inputValue.length) {
                NSRange range = [cityModel.areaName rangeOfString:_inputValue];
                
                [attStr addAttributes:@{NSForegroundColorAttributeName : [self matchingStringColor]} range:range];
            } else if (_matchValues&&_matchValues.count) {
                for (NSString *match in _matchValues) {
                    NSRange range = [cityModel.areaName rangeOfString:match];
                    [attStr addAttributes:@{NSForegroundColorAttributeName : [self matchingStringColor] } range:range];
                }
                
            }
            
            
            cell.textLB.attributedText = attStr;
            
        }
        
    }
    
    

    if ([cityModel.status isEqualToString:@"0"]) { // 维护中
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (_titlesArray.count) {
            //LMLog(@"====_titlesArray.count:%d",_titlesArray.count);
            return _titlesArray[section];
        }
        return @" ";
    }
    
    return nil;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        NSMutableArray *sectionIndexTitles = [NSMutableArray arrayWithArray:_titlesArray];
        if (sectionIndexTitles.count) {
            [sectionIndexTitles replaceObjectAtIndex:0 withObject:@" "];
        }
        //LMLog(@"====%@",sectionIndexTitles);
        return sectionIndexTitles;
    }
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        //    btn.contentMode = UIViewContentModeLeft;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 16.5, 0, 0);
        btn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        if (_titlesArray.count) {
            [btn setTitle:_titlesArray[section] forState:(UIControlStateNormal)];
        }
        btn.userInteractionEnabled = NO;
        
        return btn;
    }
    
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    if (tableView == self.tableView) {
        return 28;
    }
    
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  {
    if (tableView == self.tableView) {
        if (section == _cityGroups.count - 1) {
            return 46;
        }
        return 0;
    }
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == _cityGroups.count - 1) {
            
            UILabel *lb = [UILabel new];
            lb.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
            lb.text = [NSString stringWithFormat:@"共%ld座城市",_totalList.count];
            lb.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.font = [UIFont systemFontOfSize:18];
            return lb;
        }
        return nil;
    }
    
    return nil;
    
    
}

#pragma mark--选择城市
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    LMZXCityModel *cityModel;
    if (tableView == self.tableView) {
        
        cityModel = _cityGroups[indexPath.section][indexPath.row];
        if (_currentIndexPath) {
            LMZXCityModel *selectedCity = _cityGroups[_currentIndexPath.section][_currentIndexPath.row];
            selectedCity.isSelected = NO;
            [tableView reloadRowsAtIndexPaths:@[_currentIndexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        _currentIndexPath = indexPath;
        
        cityModel.isSelected = YES;

        
    } else {
        cityModel = _searchResultModel[indexPath.row];
    }
    
    // 判断是否在维护中
    if ([cityModel.status isEqualToString:@"0"]) { // 维护中
        [self.view makeToast:[NSString stringWithFormat:@"%@维护中",cityModel.areaName]];
        return;
    }
    

    
    // 加载登录元素
    
    [self loadCityElement:cityModel];
    
}

#pragma 加载城市输入元素
- (void)loadCityElement:(LMZXCityModel*)cityModel {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys: [LMZXSDK shared].lmzxApiKey,@"apiKey" ,
                                 @"1.2.0",@"version",  cityModel.areaCode,@"areaCode", nil];
    
    if (self.searchItemType == LMZXSearchItemTypeHousingFund) { //公积金
        [dict setObject:@"api.housefund.getloginelements" forKey:@"method"];
    } else if (self.searchItemType == LMZXSearchItemTypeSocialSecurity) { // 社保
        [dict setObject:@"api.socialsecurity.getloginelements" forKey:@"method"];
    }
    __weak typeof(self) weakSelf = self;
    [self.activityIndicatorView startAnimating];
    [LMZXHTTPTool post:LMZXSDK_url params:dict success:^(id responseObj) {
        //        LMLog(@"城市输入元素成功----%@",responseObj);
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dict in responseObj[@"data"]) {
            [arr addObject:[LMZXCityLoginElement cityLoginElementWithDict:dict]];
        }
        cityModel.elements = arr;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.selectedOneCity(cityModel);
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf.activityIndicatorView stopAnimating];
            
        });
        
        
    } failure:^(NSString *error) {
        //        MYLog(@"城市失败----%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicatorView stopAnimating];
            [weakSelf.view makeToast:@"获取城市信息失败，请重试"];
            //            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        });
        
    }];
}


#pragma mark - searchbar随滚动变化
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
            _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height );
        }];
        
    }
    
    if (endOffSetY - startOffSetY < - scrollV) {
        [UIView animateWithDuration:0.25 animations:^{
            _searchBar.alpha = 1;
            _tableView.frame = CGRectMake(0, 45, self.view.bounds.size.width, self.view.bounds.size.height - 45.0);
        }];
    }
    
}


#pragma mark- 设置左侧返回按钮
- (void)setupLeftBtn {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemtarget:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
- (NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}
- (UIColor *)matchingStringColor {
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        return [LMZXSDK shared].lmzxProtocolTextColor;
    }
    return [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1];
}
@end
