//
//  LMZXAutoinsuranceVC.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/6.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXAutoinsuranceVC.h"
#import "LMZXSDKNavigationController.h"

#import "LMZXLevelSlideBar.h"
#import "LMZXListHookVC.h"
#import "LMZXListHookModel.h"
#import "LMZXCommonSearchCell.h"
#import "LMZXAutoInsuranceLoadingVC.h"
//#import "YJReportCarInsurancTypeVC.h"
//#import "CommonSearchSortModel.h"

@interface LMZXAutoinsuranceVC () <LMZXLevelSlideBarDelegate>

{
    // 车险的公司 model
    __block  LMZXCompanyCarInsurancModel *_companyCarInsurancModel;
    // 车险的公司 model
    __block  LMZXCompanyCarInsurancModel *_companyCarInsurancModelTwo;
    
    
     LMZXListHookVC *_companyList;
     LMZXListHookVC *_companyListAcc;
//    YJSearchConditionModel  *_searchConditionModel;
    // commonCellData 对应是  1 账号  下边是对应是  2 保单
    NSMutableArray * _dataTwo;
}


@property (nonatomic, strong) LMZXLevelSlideBar *topMenuView;

// 用于区分 账单还是保单  1 账号   2 保单
@property (nonatomic, assign)NSInteger currentIndex;



@end

@implementation LMZXAutoinsuranceVC


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
    _dataTwo = [NSMutableArray arrayWithCapacity:0];
    
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self jLevelSlideBar:nil didSelectedItemIndex:self.currentIndex-1];
    [self.tableView reloadData];
}


#pragma mark - view
-(void)configView{
    if (self.searchItemType != SearchItemTypeCarSafe) {
        return;
    }
    
    //设置能够滑动的listTabBar
    self.topMenuView = [[LMZXLevelSlideBar alloc] initWithFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH, lmzxkMenuHeight)];
    self.topMenuView.itemWidth = 70;
    self.topMenuView.delegate = self;
    self.currentIndex = 1 ;
    if (self.topMenuView.itemsTitle.count) {
        self.topMenuView.itemsTitle = nil;
    }
    // 11对应 不可修改
    self.topMenuView.itemsTitle = @[@"账号查询",@"保单查询"];
    
    [self.view addSubview: self.topMenuView];
    self.tableView.frame = CGRectMake(0, lmzxkMenuHeight+10, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT-lmzxkMenuHeight-10);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}


#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commonCellData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LMZXCommonSearchCell *cell = [LMZXCommonSearchCell initCommonCellWith:tableView];
    
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
#pragma mark 车险公司选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    __block typeof(self) sself =self;
    
    if (indexPath.row == 0) {
        if (self.searchItemType == SearchItemTypeCarSafe) {
            
            if (self.currentIndex == 1) { // 账号
                if (_companyListAcc) {
                    
                } else {
                    _companyListAcc = [[LMZXListHookVC alloc] init];
                }
                
                //处理选择
                LMZXCompanyCarInsurancModel *modelR = _companyCarInsurancModel;
                if (self.currentIndex == 2) {
                    modelR = _companyCarInsurancModelTwo;
                }
                
                for (LMZXListHookModel *mm in _companyList.listData) {
                    mm.selected =NO;
                    if ([mm.companyCarInsuranc.code isEqualToString: modelR.code] ) {
                        mm.selected =YES;
                    }
                }
                
                _companyListAcc.searchItemType = self.searchItemType;
                _companyListAcc.title = @"车险查询";
                
                _companyListAcc.selectedOneCity = ^(id obj){
                    __block LMZXListHookModel *model = obj;
                    
                    
                    if (self.currentIndex == 1) { // 账号
                        _companyCarInsurancModel = model.companyCarInsuranc;
                    } else if (self.currentIndex == 2) { // 保单
                        _companyCarInsurancModelTwo = model.companyCarInsuranc;
                        
                    }
                    [sself setModelm:indexPath.row];
                    
                };
                _companyListAcc.url = @"?bizType=autoinsurance_acct";
                [self.navigationController pushViewController:_companyListAcc animated:YES];
                
            } else if (self.currentIndex == 2) { // 保单
                if (_companyList) {
                    
                } else {
                    _companyList = [[LMZXListHookVC alloc] init];
                }
                
                
                
                //处理选择
                LMZXCompanyCarInsurancModel *modelR = _companyCarInsurancModel;
                if (self.currentIndex == 2) {
                    modelR = _companyCarInsurancModelTwo;
                }
                
                for (LMZXListHookModel *mm in _companyList.listData) {
                    mm.selected =NO;
                    if ([mm.companyCarInsuranc.code isEqualToString: modelR.code] ) {
                        mm.selected =YES;
                    }
                }
                
                _companyList.searchItemType = self.searchItemType;
                _companyList.title = @"车险查询";
                
                _companyList.selectedOneCity = ^(id obj){
                    __block LMZXListHookModel *model = obj;
                    
                    
                    if (self.currentIndex == 1) { // 账号
                        _companyCarInsurancModel = model.companyCarInsuranc;
                    } else if (self.currentIndex == 2) { // 保单
                        _companyCarInsurancModelTwo = model.companyCarInsuranc;
                        
                    }
                    [sself setModelm:indexPath.row];
                    
                };
                _companyList.url = nil;
                [self.navigationController pushViewController:_companyList animated:YES];
            }
            
            
            
        }
        
    }
}
#pragma mark 本页的重置 model
-(void)setModelm:(NSInteger)index{
    
    if (self.currentIndex == 1) {
        LMZXSearchCellModel *mm  = self.commonCellData[index];
        mm.Text = _companyCarInsurancModel.name;
    } else if (self.currentIndex == 2) {
        LMZXSearchCellModel *mm  = _dataTwo[index];
        mm.Text = _companyCarInsurancModelTwo.name;
    }
    
    [self.tableView reloadData];
    
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
//
            if (self.currentIndex ==1 ) { // 授权查询
//                self.lmQueryInfoModel.insuranceCompany = _companyCarInsurancModel.key;
//                self.lmQueryInfoModel.username = [(LMZXSearchCellModel*)self.commonCellData[1] Text];
//                self.lmQueryInfoModel.password = [(LMZXSearchCellModel*)self.commonCellData[2] Text];
//                self.lmQueryInfoModel.type = @"1";
                
                [self.lmQueryInfoModel setDataChexianWithAccessType:@"sdk" identityCardNo:@"" identityName:@"" UserName:[(LMZXSearchCellModel*)self.commonCellData[1] Text] password:[(LMZXSearchCellModel*)self.commonCellData[2] Text] policyNo:@"" identityNo:@"" type:@"1"  insuranceCompany:_companyCarInsurancModel.code];
                
            } else if (self.currentIndex ==2 ){// 保单查询
//                self.lmQueryInfoModel.insuranceCompany = _companyCarInsurancModelTwo.key;
//                self.lmQueryInfoModel.username = [(LMZXSearchCellModel*)_dataTwo[1] Text];
//                self.lmQueryInfoModel.password = [(LMZXSearchCellModel*)_dataTwo[2] Text];
//                self.lmQueryInfoModel.type = @"2";
                [self.lmQueryInfoModel setDataChexianWithAccessType:@"sdk" identityCardNo:@"" identityName:@"" UserName:@"" password:@"" policyNo:[(LMZXSearchCellModel*)_dataTwo[1] Text] identityNo:[(LMZXSearchCellModel*)_dataTwo[2] Text] type:@"2"  insuranceCompany:_companyCarInsurancModelTwo.code];
            }

            
            
            
            LMZXAutoInsuranceLoadingVC *loadingVc = [[LMZXAutoInsuranceLoadingVC alloc] init];
            loadingVc.lmQueryInfoModel = self.lmQueryInfoModel;
            [self.navigationController pushViewController:loadingVc animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}





#pragma mark - 校验格式
-(BOOL)verificateData {
    
    if (self.currentIndex == 1) {
        
        if (!_companyCarInsurancModel) {
            [self.view makeToast:@"请选择保险公司" ifSucess:NO];
            return NO;
        }
        LMZXSearchCellModel*mm= (LMZXSearchCellModel*)self.commonCellData[1];
        LMZXSearchCellModel*mm2= (LMZXSearchCellModel*)self.commonCellData[2];
//
//        if (!mm.Text.length|!mm2.Text.length) {
//            [self.view makeToast:@"请完善输入" ifSucess:NO];
//            return NO;
//        }
        
            if (!mm.Text.length) {
                [self.view makeToast:@"请输入账号" ifSucess:NO];
                return NO;
            }else if (!mm2.Text.length) {
                [self.view makeToast:@"请输入密码" ifSucess:NO];
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
        LMZXSearchCellModel*mm= (LMZXSearchCellModel*)_dataTwo[1];
        LMZXSearchCellModel*mm2= (LMZXSearchCellModel*)_dataTwo[2];
        
        
            if (!mm.Text.length) {
                [self.view makeToast:@"请输入保单号" ifSucess:NO];
                return NO;
            }else if (!mm2.Text.length) {
                [self.view makeToast:@"请输入证件号" ifSucess:NO];
                return NO;
            }
        
        
//        LMZXSearchCellModel*mm= (LMZXSearchCellModel*)_dataTwo[1];
//        LMZXSearchCellModel*mm2= (LMZXSearchCellModel*)_dataTwo[2];
//        if (!mm.Text.length|!mm2.Text.length) {
//            [self.view makeToast:@"请完善输入" ifSucess:NO];
//            return NO;
//        }
    }
    
    
    if (!self.btnSelected.selected) {
        [self.view makeToast:@"不同意协议无法进行下一步" ifSucess:NO];
        return NO;
    }
    
    
    
    return YES;
}


#pragma mark -  model 处理
#pragma mark  点击账号/保单
- (void)jLevelSlideBar:(LMZXLevelSlideBar *)topMenuView didSelectedItemIndex:(NSInteger)index {
    
    //    CommonSearchSortModel * commonSearchSortModel = [[CommonSearchSortModel alloc]init];
    //    commonSearchSortModel.titleWidth = self.titleWidth;
    //    commonSearchSortModel.searchItemType = self.searchItemType;
    
    CGFloat wide=65;
    if (index+1 == 1) {// 账号
        self.currentIndex = 1;
        self.topMenuView.currentItemIndex = 0;
        
        if (!_companyCarInsurancModel) {
            self.commonCellData = [self factoryArrWithIndex:1];
        }
        
        for (LMZXSearchCellModel *m in  self.commonCellData) {
            CGFloat width=[m.Name  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
            wide = (width>=wide ? width:wide);
        }
        
        for (LMZXSearchCellModel *m in self.commonCellData) {
            m.maxLength = wide;
        }
        
    }else if (index+1 == 2) {//保单
        if (!_dataTwo.count) {
            _dataTwo = [self factoryArrWithIndex:2];
        }
        
        self.currentIndex = 2;
        
        for (LMZXSearchCellModel *m in _dataTwo) {
            CGFloat width=[m.Name  boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
            wide = (width>=wide ? width:wide);
        }
        
        for (LMZXSearchCellModel *m in _dataTwo) {
            m.maxLength = wide;
        }
        
    }
    
    self.verifyNum = 2;
    
    [self.tableView reloadData];
    
    
}

/** 车险 */
-(NSMutableArray*)factoryArrWithIndex:(NSInteger)index{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    LMZXSearchCellModel*  modelF,*modelS,*modelT;
    if (index == 2) {//保单查询
        modelF = [self modelLocation:1 Name:@"保险公司" type:CommonSearchCellTypeAllow place:@"请选择保险公司"];
        modelS = [self modelLocation:2 Name:@"保单号" type:CommonSearchCellTypeNone place:@"请输入保单号"];
        modelT =  [self modelLocation:3 Name:@"投保人证件号" type:CommonSearchCellTypeNone place:@"请输入投保人身份证号码"];
        
        [arr addObject:modelF];
        [arr addObject:modelS];
        [arr addObject:modelT];
        
        return arr;
    } else if (index == 1){//账号查询
        modelF = [self modelLocation:1 Name:@"保险公司" type:CommonSearchCellTypeAllow place:@"请选择保险公司"];
        modelS = [self modelLocation:2 Name:@"账号" type:CommonSearchCellTypeNone place:@"请输入账户名"];
        modelT =  [self modelLocation:3 Name:@"密码" type:CommonSearchCellTypeEye place:@"请输入密码"];
        
        [arr addObject:modelF];
        [arr addObject:modelS];
        [arr addObject:modelT];
        
        return arr;
    }
    
    return arr;
    
}
-(LMZXSearchCellModel *)modelLocation:(NSInteger)location Name:(NSString*)name type:(LMZXCommonSearchCellType)type place:(NSString *)hold {
    LMZXSearchCellModel*  model = [[LMZXSearchCellModel alloc]init];
    model.location = location;
    model.Name = name;
    model.type = type;
    model.placeholdText = hold;
    model.Text =@"";
    model.searchItemType = self.searchItemType;
    CGFloat width=[model.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
    self.titleWidth = (width>=self.titleWidth ? width:self.titleWidth);
    model.maxLength = self.titleWidth;
    return model;
}



#pragma mark - 其他

-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}


@end






