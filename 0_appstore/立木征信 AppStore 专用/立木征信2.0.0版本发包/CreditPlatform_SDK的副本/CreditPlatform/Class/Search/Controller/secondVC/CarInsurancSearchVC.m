//
//  CarInsurancSearchVC.m
//  CreditPlatform
//
//  Created by mythkiven on 16/11/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CarInsurancSearchVC.h"

#import "JLevelSlideBar.h"
#import "ListHookVC.h"
#import "YJCarInsuranceTool.h"
#import "YJReportCarInsurancTypeVC.h"



@interface CarInsurancSearchVC ()<JLevelSlideBarDelegate>

{
    // 车险的公司 model
  __block  CompanyCarInsurancModel *_companyCarInsurancModel;
    // 车险的公司 model
  __block  CompanyCarInsurancModel *_companyCarInsurancModelTwo;
    
    
    ListHookVC *_companyList;
    ListHookVC *_companyList2;
    YJSearchConditionModel  *_searchConditionModel;
    // commonCellData 对应是  1 账号  下边是对应是  2 保单
    NSMutableArray * _dataTwo;
}


@property (nonatomic, strong) JLevelSlideBar *topMenuView;
@property (nonatomic, assign)NSInteger currentIndex;



@end

@implementation CarInsurancSearchVC
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self configView];
    _dataTwo = [NSMutableArray arrayWithCapacity:0];
    
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)configView{
    if (self.searchItemType != SearchItemTypeCarSafe) {
        return;
    }
 
    //设置能够滑动的listTabBar
    self.topMenuView = [[JLevelSlideBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMenuHeight)];
    self.topMenuView.itemWidth = 70;
    self.topMenuView.delegate = self;
    self.currentIndex = 1 ;
    if (self.topMenuView.itemsTitle.count) {
        self.topMenuView.itemsTitle = nil;
    }
    // 11对应 不可修改
    self.topMenuView.itemsTitle = @[@"账号查询",@"保单查询"];
    
    [self.view addSubview: self.topMenuView];
    self.tableView.frame = CGRectMake(0, kMenuHeight+10, SCREEN_WIDTH, SCREEN_HEIGHT-kMenuHeight-10);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self jLevelSlideBar:nil didSelectedItemIndex:self.currentIndex-1];
    [self.tableView reloadData];
}

#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commonCellData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonSearchCell *cell = [CommonSearchCell initCommonCellWith:tableView];
    
    if (self.currentIndex == 1) {
        cell.model = self.commonCellData[indexPath.row];
    }else if (self.currentIndex == 2) {
        cell.model = _dataTwo[indexPath.row];
    }
    
    //键盘响应
    if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
        [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:0.6];
    }else{
        [cell.textField canBecomeFirstResponder];
    }
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    cell.textField.clearsOnBeginEditing = NO;
    return cell;
}
#pragma mark cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    __block typeof(self) sself =self;
    
    if (indexPath.row == 0) {
        if (self.searchItemType == SearchItemTypeCarSafe) {
            
            if (self.currentIndex == 1) {
                if (_companyList) {
                } else {
                    _companyList = [[ListHookVC alloc] init];
                }
                _companyList.loginType = @"02";
                //处理选择
                CompanyCarInsurancModel *modelR = _companyCarInsurancModel;
                for (ListHookModel *mm in _companyList.listData) {
                    mm.selected =NO;
                    if ([mm.companyCarInsuranc.key isEqualToString: modelR.key] ) {
                        mm.selected =YES;
                    }
                }
                _companyList.searchItemType = self.searchItemType;
                _companyList.title = @"车险查询";
                _companyList.selectedOneCity = ^(id obj){
                    __block ListHookModel *model = obj;
                    if (self.currentIndex == 1) {
                        _companyCarInsurancModel = model.companyCarInsuranc;
                    } else if (self.currentIndex == 2) {
                        _companyCarInsurancModelTwo = model.companyCarInsuranc;
                    }
                    [sself setModel:indexPath.row];
                };
                [self.navigationController pushViewController:_companyList animated:YES];
            }else if (self.currentIndex == 2) {
                if (_companyList2) {
                } else {
                    _companyList2 = [[ListHookVC alloc] init];
                }
                _companyList2.loginType  = @"01";
                //处理选择
                CompanyCarInsurancModel *modelR = _companyCarInsurancModel;
                if (self.currentIndex == 2) {
                    modelR = _companyCarInsurancModelTwo;
                }
                for (ListHookModel *mm in _companyList2.listData) {
                    mm.selected =NO;
                    if ([mm.companyCarInsuranc.key isEqualToString: modelR.key] ) {
                        mm.selected =YES;
                    }
                }
                _companyList2.searchItemType = self.searchItemType;
                _companyList2.title = @"车险查询";
                _companyList2.selectedOneCity = ^(id obj){
                    __block ListHookModel *model = obj;
                    
                    
                    if (self.currentIndex == 1) {
                        _companyCarInsurancModel = model.companyCarInsuranc;
                    } else if (self.currentIndex == 2) {
                        _companyCarInsurancModelTwo = model.companyCarInsuranc;
                    }
                    [sself setModel:indexPath.row];
                    
                };
                
                [self.navigationController pushViewController:_companyList2 animated:YES];
            }
            
            
            
            
            
        }
        
    }
}

-(void)setModel:(NSInteger)index{
    
    if (self.currentIndex == 1) {
        CommonSearchCellModel *mm  = self.commonCellData[index];
        mm.Text = _companyCarInsurancModel.val;
    } else if (self.currentIndex == 2) {
        CommonSearchCellModel *mm  = _dataTwo[index];
        mm.Text = _companyCarInsurancModelTwo.val;
    }
    
    [self.tableView reloadData];

}

-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}


#pragma mark - 查询报告
- (void)didClickedSearch{
    [self.view endEditing:YES];
    
    if (![self verificateData ]) {
        return;
    }
    
    
    switch (self.searchItemType) {
        
        case SearchItemTypeCarSafe: //车险
        {
            // 查询条件的模型
            _searchConditionModel = [[YJSearchConditionModel alloc] init];
            _searchConditionModel.type = YJGoToSearchResultTypeFromHome;
            _searchConditionModel.searchType = self.currentIndex;
            
            if (self.currentIndex ==1 ) {
                [_searchConditionModel setCityCode:_companyCarInsurancModel.key account:((CommonSearchCellModel*)self.commonCellData[1]).Text passWord:((CommonSearchCellModel*)self.commonCellData[2]).Text servicePass:(!self.threeTextField)? @"":self.threeTextField ];
            } else if (self.currentIndex ==2 ){
                [_searchConditionModel setCityCode:_companyCarInsurancModelTwo.key account:((CommonSearchCellModel*)_dataTwo[1]).Text passWord:((CommonSearchCellModel*)_dataTwo[2]).Text  servicePass:(!self.threeTextField)? @"":self.threeTextField ];
            }
            
            YJReportCarInsurancTypeVC *vc = [[YJReportCarInsurancTypeVC alloc]init];
            vc.searchType = self.searchItemType;
            vc.searchConditionModel = _searchConditionModel;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - 数据 处理  jLevelSlideBar的代理方法。
- (void)jLevelSlideBar:(JLevelSlideBar *)topMenuView didSelectedItemIndex:(NSInteger)index {
    
    CommonSearchSortModel * commonSearchSortModel = [[CommonSearchSortModel alloc]init];
    commonSearchSortModel.titleWidth = self.titleWidth;
    commonSearchSortModel.searchItemType = self.searchItemType;
    
    CGFloat wide=65;
     if (index+1 == 1) {// 账号
            self.currentIndex = 1;
            
            if (!_companyCarInsurancModel) {
                self.commonCellData = [commonSearchSortModel factoryArrWithIndex:1];
            }
            
            for (CommonSearchCellModel *m in  self.commonCellData) {
                CGFloat width=[m.Name  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
                wide = (width>=wide ? width:wide);
            }
            
            for (CommonSearchCellModel *m in self.commonCellData) {
                m.maxLength = wide;
            }
            
     }else if (index+1 == 2) {//保单
         if (!_dataTwo.count) {
             _dataTwo = [commonSearchSortModel factoryArrWithIndex:2];
         }
         
         self.currentIndex = 2;
         
         for (CommonSearchCellModel *m in _dataTwo) {
             CGFloat width=[m.Name  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
             wide = (width>=wide ? width:wide);
         }
         
         for (CommonSearchCellModel *m in _dataTwo) {
             m.maxLength = wide;
         }
         
     }
    
    self.verifyNum = 2;
    
    [self.tableView reloadData];
    
    
}



#pragma mark - 校验格式
-(BOOL)verificateData {
    
    if (self.currentIndex == 1) {
        
        if (!_companyCarInsurancModel) {
            [self.view makeToast:@"请选择保险公司" ifSucess:NO];
            return NO;
        }
        CommonSearchCellModel*mm= (CommonSearchCellModel*)self.commonCellData[1];
        CommonSearchCellModel*mm2= (CommonSearchCellModel*)self.commonCellData[2];
        
        if (!mm.Text.length|!mm2.Text.length) {
            [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
    } else if (self.currentIndex == 2){
        
        if (!_companyCarInsurancModelTwo) {
            [self.view makeToast:@"请选择保险公司" ifSucess:NO];
            return NO;
        }
        if (!_dataTwo.count) {
            [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
        CommonSearchCellModel*mm= (CommonSearchCellModel*)_dataTwo[1];
        CommonSearchCellModel*mm2= (CommonSearchCellModel*)_dataTwo[2];
        if (!mm.Text.length|!mm2.Text.length) {
            [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
    }
    
    
    if (!self.btnSelected.selected) {
        [self.view makeToast:@"不同意协议无法进行下一步" ifSucess:NO];
        return NO;
    }
    
    
    
    return YES;
}





@end





