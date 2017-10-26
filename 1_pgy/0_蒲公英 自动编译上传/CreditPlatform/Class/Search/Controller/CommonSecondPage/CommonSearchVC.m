//
//  CommonSearchVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSearchVC.h"
#import "OperatorsReportMainVC.h"
#import "YJReportHoseFundDetailsVC.h"
#import "YJReportSocialSecurityDetailsVC.h"
#import "JmailTextField.h"

#import "WebViewController.h"

#import "ECommerceReportMainVC.h"

//#import "ForgetPassWordOperation.h"



#import "CommonSendMsgVC.h"
#import "OperatorsDataTool.h"
#import "OperationModel.h"
#import "YJSearchConditionModel.h"
#import "YJReportCentralBankDetailsVC.h"
#import "YJReportEducationDetailsVC.h"
#import "ReportLinkedinDetailsVC.h"
#import "YJReportTaoBaoDetailsVC.h"
#import "CommonSearchCellModel.h"
#import "CommonSearchCell.h"
#import "YJReportDishonestyDetailsVC.h"
#import "YJCitySelectedVC.h"
#import "YJCityModel.h"
#import "YJReportNetbankBillTypeVC.h"

#import "JLoadingReportBaseVC.h"


@interface CommonSearchVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    // 公积金社保 选择城市所用的model
    YJCityInfoModel *_selectCityInfoModel;
    // 网银选择银行所用的model
    ListHookModel *_bankListModel;
    
    OperatorsDataTool *_operatorsDataTool;
    BOOL showThreeTestfield_;//展示服务密码。
    
    YJSearchConditionModel *_searchConditionModel;

    
    //吉林电信 特殊 主动发信息
    BOOL isSCALJL;
    
    NSInteger addTime_;
    
    NSArray *_mailData;
    JmailTextField *_textField;
    
    //
     ListHookVC *_bankList;

}


@property (nonatomic, strong) UIButton      *selectedBtn;
@property (nonatomic, strong) UIButton      *cityBtn;
@property (nonatomic, strong) NSArray       *cityList;
@property (nonatomic, strong) UIPickerView  *pickerView;

/**展示联名卡*/
@property (nonatomic, assign) BOOL showLML;


@property (nonatomic, assign) BOOL  showLuoyangCity;//洛阳。rename是第三个。不能变

@property (nonatomic, assign) BOOL  showXiAn;//西安

@end

@implementation CommonSearchVC


#pragma mark - 生命周期
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    addTime_ = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingQ:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChangedQ:) name:UITextFieldTextDidChangeNotification object:nil];
   
    if (self.searchItemType == SearchItemTypeCreditCardBill) {
        [self LoadMailData];
    }
   
    //事件添加
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
   
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    NSArray *arr = [self cellsForTableView:self.tableView];
    for (UIView *cell in arr) {
        [cell endEditing:YES];
        [cell canBecomeFirstResponder];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_navBar] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.view bringSubviewToFront:_textField];
    
}

#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commonCellData.count;
}

#pragma mark 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonSearchCell *cell = [CommonSearchCell initCommonCellWith:tableView];
    cell.model = self.commonCellData[indexPath.row];
    __block typeof(self) ss = self;
    __block typeof(cell) cc = cell;
    
    if (indexPath.row == 0 && (self.searchItemType == SearchItemTypeOperators)) {
        cell.textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
        
        cell.clickedSelectCity= ^(id text){
            if (text) {
                [cc endEditing:YES];
                [cc canBecomeFirstResponder];
                self.firstTextField = (NSString*)text;
                [ss sendCityC];
            }
        };
    }
    if ((self.searchItemType == SearchItemTypeCreditCardBill)) {
        if (indexPath.row == 0 ) {
            if (self.searchItemType == SearchItemTypeCreditCardBill && _mailData.count) {
                
                JmailTextField *textField = [[JmailTextField alloc] initWithFrame:CGRectMake(65, 20, 239, 43.5) InView:self.view];
                
                [textField setTableViewSuffixArray:_mailData];
                textField.font = Font15;
                textField.placeholder = @"请输入邮箱";
                
                [self.view addSubview:textField];
                cell.textField.hidden = YES;
                cell.textField = nil;
                cell.textField = textField;
                _textField = textField;
                textField.tag = 100;
                _textField.delegate = self;
                
            }else{
//                cell.textField.hidden = NO;
//                [self removeSubView:[JmailTextField class]];
//                [self.contentView removeSubView:[JmailTextField class]];
            }
            
            cell.searchItemType = self.searchItemType;
            cell.mailData = _mailData;
        } else {
            cell.searchItemType = self.searchItemType;
            cell.mailData = nil;
        }
        
    }
    //键盘响应
    if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
        [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:0.6];
    }else{
        [cell.textField canBecomeFirstResponder];
    }
    
    if (self.isPhone &&indexPath.row == 0) {
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    cell.textField.clearsOnBeginEditing = NO;
    return cell;
}
-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}
#pragma mark  网银流水选择银行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    __block typeof(self) sself =self;
    
    if (indexPath.row == 0) {
        if (self.searchItemType == SearchItemTypeNetBankBill) {// 网银
            if (_bankList) {
            } else {
                _bankList = [[ListHookVC alloc] init];
            }
            
            _bankList.searchItemType = self.searchItemType;
            _bankList.title = @"网银查询";
            
            _bankList.selectedOneCity = ^(id obj){
                __block ListHookModel *model = obj;
                
                _bankListModel = model;
                CommonSearchCellModel *cmm = sself.commonCellData[0];
                cmm.Text = model.eBankListModel.val;
                
                [sself.tableView reloadData];
                
            };
            self.verifyNum = 2;
            self.showAllowCell =YES;
            [self.navigationController pushViewController:_bankList animated:YES];
            
        }
        
    }
    
}
#pragma mark   运营商 查手机号城市
- (void)sendCityC{
    
    if ((self.firstTextField == nil)|[self.firstTextField isEqualToString:@""])
    {
        [self.view makeToast:@"请输入手机号" ifSucess:NO];
        return;
    }
    if (![Tool validateMobile:self.firstTextField]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO];
        return;
    }
    
    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_queryMobileArea,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"mobileNo":self.firstTextField};
    
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_queryMobileArea] params:dicParams success:^(id responseObj) {
        MYLog(@"%@",responseObj);
        [YJShortLoadingView yj_hideToastActivityInView:self.view];

/*
 code = 0000;
 data =     
 {
    code = 0000;
    data =         {
        areaCode = 010;
        city = "\U5317\U4eac";
        province = "\U5317\U4eac";
        type = "\U8054\U901a";
    };
    msg = "\U6210\U529f";
 };
 list = "<null>";
 msg = "\U5904\U7406\U6210\U529f";
 success = 1;
 
 **/
        
        NSDictionary *list = [responseObj objectForKey:@"data"];
        NSString *code;
        if (list[@"code"]) {
            code =list[@"code"];
        }else if (responseObj[@"code"]) {
            code =responseObj[@"code"];
        }
        if (![list isKindOfClass:[NSNull class]]) {
            if ([code isEqualToString:@"0000"]) {//有数
                NSString *str,*type;
                if (list[@"data"]) {
                     str = list[@"data"][@"province"];
                     type = list[@"data"][@"type"];
                } else {
                    str = list[@"province"];
                    type = list[@"type" ];
                }
                
                str = [NSString TwoCharString:str];
                type = [NSString TwoCharString:type];
                
                self.threeTextField = nil;
                
                if ([str isEqualToString:@"北京"]&&[type isEqualToString:@"移动"]) {//+服务密码框
                    if (self.commonCellData.count == 2) {
                        CommonSearchCellModel*  model = self.commonCellData[1];
                        model.location=2;
                    }
                    if (self.commonCellData.count==3) {
                         [self.commonCellData removeLastObject];
                    }
                    
                    CommonSearchCellModel*  model = [self modelLocation:3 Name:@"客服密码" type:CommonSearchCellTypeEye place:@"客服密码"];
                    [self.commonCellData addObject:model];
                    
                }else if (([str isEqualToString:@"山西"]|[str isEqualToString:@"广西"])&&[type isEqualToString:@"电信"]){//显示身份证信息
                   
                    if (self.commonCellData.count == 2) {
                        CommonSearchCellModel*  model = self.commonCellData[1];
                        model.location=2;
                    }
                    if (self.commonCellData.count==3) {
                        [self.commonCellData removeLastObject];
                    }
                    
                    CommonSearchCellModel*  model = [self modelLocation:3 Name:@"身份证" type:CommonSearchCellTypeNone place:@"身份证"];
                    [self.commonCellData addObject:model];
                    
                }else {
                    if (self.commonCellData.count==3) {
                        [self.commonCellData removeLastObject];
                    }
                    
                }
                if (([str isEqualToString:@"吉林"])&&[type isEqualToString:@"电信"]) {
                    isSCALJL = YES;
                }else{
                    isSCALJL = NO;
                }
                
                self.verifyNum = self.commonCellData.count;
                [self.tableView reloadData];
                
                
                [self.view makeToast:[NSString stringWithFormat:@"%@%@",str,type]];
            }else{//无数据
                [self.view makeToast:[NSString stringWithFormat:@"%@",[responseObj[@"data"] objectForKey:@"msg"]]];
            }
        } else {//延时情况
            
            if (addTime_ > 2) {
                [self.view makeToast:responseObj[@"msg"]];
            }else{
                [sself sendCityC];
                addTime_ ++;
            }
            
        }
        
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [self.view makeToast:errorInfo];
    }];

    
}

#pragma mark  通用 creat Model
-(CommonSearchCellModel *)modelLocation:(NSInteger)location Name:(NSString*)name type:(CommonSearchCellType)type place:(NSString *)hold {
    CommonSearchCellModel*  model = [[CommonSearchCellModel alloc]init];
    model.location = location;
    model.Name = name;
    model.type = type;
    model.placeholdText = hold;
    model.searchItemType = self.searchItemType;
    CGFloat width=[model.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
    self.titleWidth = (width>=self.titleWidth ? width:self.titleWidth);
    model.maxLength = self.titleWidth;
    return model;
}

#pragma mark  信用卡 加载邮箱
-(void)LoadMailData {
   // __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : urlJK_creditEmailType,
                               @"mobile" : kUserManagerTool.mobile,
                               @"userPwd": kUserManagerTool.userPwd,
                               @"appVersion":VERSION_APP_1_4_0};
    
    
    [YJHTTPTool post:[SERVE_URL stringByAppendingString:urlJK_creditEmailType] params:dicParams success:^(id obj) {
        if ([obj[@"code"] isEqualToString:@"0000"]) {
            
            _mailData = obj[@"data"];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [self.view makeToast:errorInfo];
    }];

}
 

#pragma mark 点击 查询报告
- (void)didClickedSearch{
    
    
    [self.view endEditing:YES];

    
    
    if (![self verificateData ]) {
        return;
    }
    
    [self scrollViewWillBeginDragging:self.tableView];
    
    // 查询条件的模型
    _searchConditionModel = [[YJSearchConditionModel alloc] init];
    _searchConditionModel.type = YJGoToSearchResultTypeFromHome;
    MYLog(@"first:%@-two:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
    

    if (self.searchItemType == SearchItemTypeNetBankBill) {// 网银流水
        [_searchConditionModel setCityCode:_bankListModel.eBankListModel.key account:self.firstTextField passWord:self.twoTextField servicePass:(!self.threeTextField)? @"":self.threeTextField ];
    }
    else{//正常 是 1-账户 2- 密码 3- 其他信息
      [_searchConditionModel setCityCode:_selectCityInfoModel.areaCode account:self.firstTextField passWord:self.twoTextField servicePass:(!self.threeTextField)? @"":self.threeTextField ];
    }
    
    
    switch (self.searchItemType) {
        case SearchItemTypeHousingFund: // 公积金
        {
            YJReportHoseFundDetailsVC *reportHoseFundVC = [[YJReportHoseFundDetailsVC alloc] init];
            reportHoseFundVC.searchConditionModel = _searchConditionModel;
            reportHoseFundVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:reportHoseFundVC animated:YES];
            break;
        }
        case SearchItemTypeSocialSecurity: // 社保
        {
            YJReportSocialSecurityDetailsVC *socialSecurityVC = [[YJReportSocialSecurityDetailsVC alloc] init];
            socialSecurityVC.searchConditionModel =_searchConditionModel;
            socialSecurityVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:socialSecurityVC animated:YES];
            break;
        }
        case SearchItemTypeOperators: // 运营商
        {
            
            //母控制器：
            OperatorsReportMainVC * operationVC = [[OperatorsReportMainVC alloc] init];
            operationVC.searchConditionModel =_searchConditionModel;
            operationVC.searchType = self.searchItemType;
            if(isSCALJL){
                operationVC.isSCALJL = YES;
            }
////            [self.navigationController pushViewController:operationVC animated:YES];
            
            // 子控制器
            JLoadingReportBaseVC  * operationVC1 = [[JLoadingReportBaseVC alloc] init];
            operationVC1.searchConditionModel =_searchConditionModel;
            operationVC1.searchType = self.searchItemType;
            if(isSCALJL){
                operationVC1.isSCALJL = YES;
            }
            
            [operationVC addChildViewController:operationVC1];
            
            
            [self.navigationController pushViewController:operationVC animated:YES];
            
            
            
            break;
        }
        case SearchItemTypeCentralBank: // 央行征信
        {
            YJReportCentralBankDetailsVC *centralBankVC = [[YJReportCentralBankDetailsVC alloc] init];
            centralBankVC.searchConditionModel =_searchConditionModel;
            centralBankVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:centralBankVC animated:YES];
            break;
        }
        case SearchItemTypeE_Commerce: // 电商数据
        {
            ECommerceReportMainVC * operationVC = [[ECommerceReportMainVC alloc] init];
            operationVC.searchConditionModel =_searchConditionModel;
            operationVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:operationVC animated:YES];
            break;
        }
        case SearchItemTypeEducation: // 学历学籍
        {
            YJReportEducationDetailsVC *educationVC = [[YJReportEducationDetailsVC alloc] init];
            educationVC.searchConditionModel =_searchConditionModel;
            educationVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:educationVC animated:YES];
            break;
        }
            
        case SearchItemTypeTaoBao: // 淘宝
        {
            YJReportTaoBaoDetailsVC *educationVC = [[YJReportTaoBaoDetailsVC alloc] init];
            educationVC.searchConditionModel =_searchConditionModel;
            educationVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:educationVC animated:YES];
            break;
        }
        case SearchItemTypeMaimai:case SearchItemTypeLinkedin: // 脉脉- 领英
        {
            ReportLinkedinDetailsVC *educationVC = [[ReportLinkedinDetailsVC alloc] init];
            educationVC.searchConditionModel =_searchConditionModel;
            educationVC.searchType = self.searchItemType;
            [self.navigationController pushViewController:educationVC animated:YES];
            break;
        }

        case SearchItemTypeCreditCardBill:// 信用卡
        {
            ListHookVC *city = [[ListHookVC alloc]init];
            city.searchItemType = self.searchItemType;
            city.searchConditionModel = _searchConditionModel;
            city.searchItemType = self.searchItemType;
            [self.navigationController pushViewController:city animated:YES];
            
            break;
            
        }
        case SearchItemTypeLostCredit: //失信
            {
                YJReportDishonestyDetailsVC *dishonestyDetailsVC = [[YJReportDishonestyDetailsVC alloc] init];
                dishonestyDetailsVC.searchConditionModel =_searchConditionModel;
                dishonestyDetailsVC.searchType = self.searchItemType;
                [self.navigationController pushViewController:dishonestyDetailsVC animated:YES];
                
                break;
            }
        case SearchItemTypeNetBankBill: //网银流水
        {
            YJReportNetbankBillTypeVC *city = [[YJReportNetbankBillTypeVC alloc]init];
            city.searchConditionModel = _searchConditionModel;
            city.searchType = self.searchItemType;
            [self.navigationController pushViewController:city animated:YES];
            
            break;
        }
   
            
        default:
            break;
    }
}
#pragma mark -
#pragma mark 校验格式 分别配置的
-(BOOL)verificateData {
MYLog(@"格式校验：first:%@-twO:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
    
    
    if ( self.searchItemType == SearchItemTypeNetBankBill ) {// 银行 网银
        if (!_bankListModel.eBankListModel.val.length ){
            [self.view makeToast:@"请选择银行" ifSucess:NO];
            return NO;
        }
    } else {//城市：：公积金社保
        if (self.showAllowCell&&!_selectCityInfoModel.isSelected   ){
            [self.view makeToast:@"请选择城市" ifSucess:NO];
            return NO;
        }
    }
    
    
    
    //其他
    if (self.verifyNum == 2) {
        if (!self.firstTextField.length|!self.twoTextField.length) {
            [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
    } else if ( self.verifyNum == 3){
        if (!self.firstTextField.length|!self.twoTextField.length|!self.threeTextField.length) {
            [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
    }
    
    //协议
    if ((!self.btnSelected.selected) && ( self.searchItemType != SearchItemTypeLostCredit)) {
        [self.view makeToast:@"不同意协议无法进行下一步" ifSucess:NO];
        return NO;
    }
    
    
    return YES;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//     [super scrollViewWillBeginDragging:scrollView];
    [self.view endEditing:YES];
}


#pragma  mark -  tf 开始编辑

- (void)textFieldTextDidBeginEditingQ:(NSNotification *)noti {
    UITextField *tf = (UITextField *)noti.object;
    CommonSearchCell  *editeCell  = (CommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    if ((indexPath.row == 3)) {
//        if (self.showLML) {
//            self.LMlabel.alpha =1;
//            self.LMlabel.hidden=NO;
//            return;
//        }
 
    }
//        self.LMlabel.alpha =0;
//        self.LMlabel.hidden=YES;
    
    
    
}
#pragma  mark tf 结束编辑 子类通用的
- (void)textFieldTextDidEndEditingQ:(NSNotification *)noti {
    
    [super textFieldTextDidEndEditingSuper:noti];
//    if (self.showLML) {
//        self.LMlabel.alpha =0;
//        self.LMlabel.hidden=YES;
//    }
    
    MYLog(@"%@",noti);
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != TagCommonSearchCellTextfiled) {
        return;
    }
    
     CommonSearchCell  *editeCell  = (CommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    
    if ((self.searchItemType == SearchItemTypeOperators)&&(indexPath.row == 0)) {
        return;
    }
    
   [editeCell endEditing:YES];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag!=100) {
        return;
    }
    self.firstTextField = textField.text;
}

-(void)textFiledEditChangedQ:(NSNotification *)obj{
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

#pragma mark 获取cell
-(NSArray *)cellsForTableView:(UITableView *)tableView
{
    NSInteger sections = tableView.numberOfSections;
    NSMutableArray *cells = [[NSMutableArray alloc]  init];
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [cells addObject:[tableView cellForRowAtIndexPath:indexPath]];
        }
    }
    return cells;
}



@end

//    if (_showLuoyangCity) {// 洛阳  是 1-账户 2-真实姓名 3- 密码
//        [_searchConditionModel setCityCode:_selectCityInfoModel.areaCode account:self.firstTextField passWord:(!self.threeTextField)? @"":self.threeTextField servicePass: self.twoTextField ];
//    }else

//    if (_showLuoyangCity ) {// 洛阳  是 1-账户 2-真实姓名 3- 联名卡号
//        [_searchConditionModel setCityCode:_selectCityInfoModel.areaCode account:self.firstTextField passWord:(!self.threeTextField)? @"":self.threeTextField servicePass: self.twoTextField ];
//    }
//    else if (_showXiAn) {// 西安 社保  是 1-账户 2-真实姓名  3- 。。。
//        [_searchConditionModel setCityCode:_selectCityInfoModel.areaCode account:self.firstTextField passWord:(!self.threeTextField)? @"":self.threeTextField servicePass: self.twoTextField ];
//    }

