//
//  CommonSearchVC.m
//  CreditPlatform
//
//  Created by gyjrong on 16/7/22.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXMobileCarrieSearchVC.h"

#import "NSString+LMZXCommon.h"

#import "LMZXLoadingReportBaseVC.h"
#import "LMZXTool.h"


#import "LMZXHTTPTool.h"

#define LMZX_CarrieSearchtx1 @"请输入身份证"
// 键盘延时弹出时间:有些特殊键盘加载时间较长,如果是页面没有完全弹出之前,加载键盘,会卡顿.
#define LM_TextfiledPopDelay 0.5
//#define LMZX_UITextFieldTextShouldClear @"LMZX_UITextFieldTextShouldClear"
@interface LMZXMobileCarrieSearchVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate,LMZXCommonSearchCellDelegate>
{
    BOOL showThreeTestfield_; //展示服务密码。
    
//    YJSearchConditionModel *_searchConditionModel;

    //吉林电信 特殊 主动发信息
    BOOL isSCALJL;
    
    // 手机号是否正确 防止网络问题而造成的网络校验延迟导致的不正确,采取方案:默认正确.仅仅当网络校验错误,判断错误.
    BOOL  isRightPhone;
    
    NSArray *_mailData;

    NSInteger addTime_;
}


@property (nonatomic, strong) UIButton      *selectedBtn;
@property (nonatomic, strong) UIButton      *cityBtn;
@property (nonatomic, strong) NSArray       *cityList;

@end

@implementation LMZXMobileCarrieSearchVC


#pragma mark - 生命周期
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    LMLog(@"--------%@销毁了",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isRightPhone = YES;
    self.isVCOut = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
 
//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChangedQ:) name:UITextFieldTextDidChangeNotification object:nil];
   
    //事件添加
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([LMZXSDK shared].lmzxPreMobileNum) {
        if ([LMZXSDK shared].lmzxPreMobileNum.length>1) { // 启动网络服务
            self.firstTextField = [LMZXSDK shared].lmzxPreMobileNum;
            [self sendCityC];
        }else{
            [LMZXSDK shared].lmzxPreMobileNum =nil;
        }
    }
   
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isVCOut = YES;
    
//    [self.view endEditing:YES];
    
//    NSArray *arr = [self cellsForTableView:self.tableView];
//    for (UIView *cell in arr) {
//        [cell endEditing:YES];
//        [cell canBecomeFirstResponder];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isVCOut = NO;
    
}




#pragma mark - tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commonCellData.count;
}

// 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LMZXCommonSearchCell *cell = [LMZXCommonSearchCell initCommonCellWith:tableView];
    
    cell.searchItemType = self.searchItemType;
    cell.model = self.commonCellData[indexPath.row];

    if ([LMZXSDK shared].lmzxPreMobileNum) { /////////预传了手机号
        
        cell.textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
        cell.delegate = self;
        
        if (indexPath.row == 0 && (self.searchItemType == LMZXSearchItemTypeOperators) ) { // 手机号写入
            cell.textField.text = self.firstTextField;
            
        }
        
        if ([LMZXSDK shared].lmzxAbleEditPreMobileNum && (self.searchItemType == LMZXSearchItemTypeOperators)) { ////////////// 第二行可以修改
            //键盘响应
            if (!self.showAllowCell && indexPath.row == 1 && !cell.textField.text.length) {
                [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:LM_TextfiledPopDelay];
            }else{
                [cell.textField canBecomeFirstResponder];
            }
        }else{ //////// 不能修改手机号
            if (indexPath.row == 0) {
                cell.userInteractionEnabled =NO;
            }
        }
        
        
        
        if (indexPath.row == 0 ) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
                cell.textField.keyboardType = UIKeyboardTypePhonePad;
            }else{
                cell.textField.keyboardType = UIKeyboardTypeDefault;
            }
            
        }
        
        if ([LMZXSDK shared].lmzxAbleEditPreMobileNum ) { // 能修改手机号
            //键盘响应
            if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
                [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:LM_TextfiledPopDelay];
            }else{
                [cell.textField canBecomeFirstResponder];
            }
        }else{ // 不能修改手机号
            
        }
        
        
    } else {// 没有预传手机号
        if (indexPath.row == 0 && (self.searchItemType == LMZXSearchItemTypeOperators) ) {
            cell.textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
            cell.delegate = self;
            //        cell.clickedSelectCity= ^(id text){
            //            if (text) {
            ////                [cc endEditing:YES];
            ////                [cc canBecomeFirstResponder];
            ////                ss.firstTextField = (NSString*)text;
            ////                [ss sendCityC];
            //
            //
            //                [ss chuliMobileCity:indexPath text:text];
            //            }
            //        };
        }
        
        //键盘响应
        if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
            [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:LM_TextfiledPopDelay];
        }else{
            [cell.textField canBecomeFirstResponder];
        }
        if (indexPath.row == 0 ) {
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
                cell.textField.keyboardType = UIKeyboardTypePhonePad;
            }else{
                cell.textField.keyboardType = UIKeyboardTypeDefault;
            }
            
        }
    }
    
   
    
    
    cell.textField.clearsOnBeginEditing = NO;
    return cell;
}

#pragma LMZXCommonSearchCellDelegate号码归属地查询
- (void)commonSearchCell:(LMZXCommonSearchCell *)cell didCheckMobileFromCity:(NSString *)mobile {
    
//    LMZXCommonSearchCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
   
    
    [cell endEditing:YES];
    [cell canBecomeFirstResponder];
    self.firstTextField = (NSString*)mobile;
    [self sendCityC];
    
}

- (void)chuliMobileCity:(NSIndexPath *)indexPath text:(NSString *)text {
    
    LMZXCommonSearchCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell endEditing:YES];
    [cell canBecomeFirstResponder];
    self.firstTextField = (NSString*)text;
    [self sendCityC];
}


// 选中 cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark   运营商 查手机号城市
- (void)sendCityC{
    
    if ((self.firstTextField == nil)|[self.firstTextField isEqualToString:@""])
    {
        [self.view makeToast:@"请输入手机号" ifSucess:NO];// 旧:无
        return;
    }
    if (![LMZXTool validateMobile:self.firstTextField]) {
        [self.view makeToast:@"请输入正确的手机号" ifSucess:NO]; // 旧:无
        isRightPhone = NO;
        return;
    }
    
//    [YJShortLoadingView yj_makeToastActivityInView:self.view];
    
    isSCALJL = NO;
    
    __block typeof(self) sself = self;
    NSDictionary *dicParams =@{@"method" : @"api.mobile.getloginelements",//@"api.mobile.area",
                               @"apiKey" : [LMZXSDK shared].lmzxApiKey,
                               @"version": LMZX_Api_Version_1_2_0,
                               @"sign"   : @"sign",
                               @"mobileNo":self.firstTextField};
    [LMZXHTTPTool post:LMZXSDK_url params:dicParams success:^(id obj) {
//        LMLog(@"%@",obj);
        
//        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        
        
        BOOL obj4 =[obj isKindOfClass:[NSDictionary class]];
        if (!obj | !obj4) {
            [sself.view makeToast:@"网络请求失败"];
        }else {
            NSArray *list = [obj objectForKey:@"data"];
            NSString *code;
            
            if (obj[@"code"]) {
                code =obj[@"code"];
            }
            
            if (list && ![list isKindOfClass:[NSNull class]]) {
                if ([code isEqualToString:@"0000"]) {//有数
                    isRightPhone = YES;
                    
                    // 清空除手机号之外的数据
                    for (LMZXSearchCellModel *model in self.commonCellData) {
                        if (model.location != 1)
                            model.Text = @"";
                    }
                    
                    // 数据重载
                    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
                    for (NSDictionary *DD in list) {
                        [marr addObject: [LMZXMobileLoginElement mobileLoginElementWithDict:DD]];
                    }
                    
                    LMZXSearchCellModel *firstModel =  sself.commonCellData[0];
                    firstModel.Text = firstModel.Text ? firstModel.Text:self.firstTextField; // 预传手机号的载入
                    firstModel.mobileModel = marr.firstObject;
                    [sself.commonCellData removeAllObjects];
                    [sself.commonCellData addObject:firstModel];
                    
                    NSArray *dataArr =[LMZXSearchCellModel dataArrWithMobileModel:marr Withtype:sself.searchItemType];
                    [sself.commonCellData addObjectsFromArray:dataArr];
                    
                    self.lmQueryInfoModel.mobileSmsMsg = obj[@"verificationCode"];
                    
                    // 12223模式
                    
//                    NSString *str,*type;
//                    if (list[@"data"]) {
//                        str = list[@"data"][@"province"];
//                        type = list[@"data"][@"type"];
//                    } else {
//                        str = list[@"province"];
//                        type = list[@"type" ];
//                    }
//                    
//                    str = [NSString TwoCharString:str];
//                    type = [NSString TwoCharString:type];
//                    
//                    sself.threeTextField = nil;
//                    
//                    if ([str isEqualToString:@"北京"]&&[type isEqualToString:@"移动"]) {//+服务密码框
//                        if (sself.commonCellData.count == 2) {
//                            LMZXSearchCellModel*  model = self.commonCellData[1];
//                            model.location=2;
//                        }
//                        if (sself.commonCellData.count==3) {
//                            [sself.commonCellData removeLastObject];
//                        }
//                        
//                        LMZXSearchCellModel*  model = [sself modelLocation:3 Name:@"客服密码" type:CommonSearchCellTypeEye place:@"请输入客服密码" hint:@"请输入客服密码"];
//                        [sself.commonCellData addObject:model];
//                        
//                    }else if (([str isEqualToString:@"山西"]|[str isEqualToString:@"广西"])&&[type isEqualToString:@"电信"]){//显示身份证信息
//                        
//                        if (sself.commonCellData.count == 2) {
//                            LMZXSearchCellModel*  model = self.commonCellData[1];
//                            model.location=2;
//                        }
//                        if (sself.commonCellData.count==3) {
//                            [sself.commonCellData removeLastObject];
//                        }
//                        
//                        LMZXSearchCellModel*  model = [sself modelLocation:3 Name:@"身份证" type:CommonSearchCellTypeNone place:@"请输入身份证号" hint:LMZX_CarrieSearchtx1];
//                        
//                        [sself.commonCellData addObject:model];
//                        
//                    }else {
//                        if (sself.commonCellData.count==3) {
//                            [sself.commonCellData removeLastObject];
//                        }
//                        
//                    }
                    
//                    
//                    if (([obj[@"elements"] isEqualToString:@"吉林"])) {
//                        isSCALJL = YES;
//                    }else{
//                        isSCALJL = NO;
//                    }
//                    
                    
                    
                    
                    
                    
                    sself.verifyNum = sself.commonCellData.count;
                    
                    [sself.tableView reloadData];
                    
                    
//                    [sself.view makeToast:[NSString stringWithFormat:@"%@%@",str,type]];
                }
                else{//无数据
                    if ([code isEqualToString:@"1013"]) {
                        isRightPhone = NO;
                        [sself.view makeToast:@"请输入正确的手机号"]; // 旧:无
                    }else{
                        [sself.view makeToast:obj[@"msg"]];
                    }
                    
                }
            }
            else {//延时情况
                isRightPhone = NO;
                if (addTime_ > 2) {
                    if ([code isEqualToString:@"1013"]) {
                        [sself.view makeToast:@"请输入正确的手机号"]; // 旧:无
                    }else{
                        [sself.view makeToast:obj[@"msg"]];
                    }
                    
                }else{
                    [sself sendCityC];
                    addTime_ ++;
                }
                
            }
        }
        
    } failure:^(NSString *error) {
//        [YJShortLoadingView yj_hideToastActivityInView:self.view];
        [self.view makeToast:@"数据请求失败"];
    }];

    
}

#pragma mark  通用 creat Model 用于重置页面的 cell 数
-(LMZXSearchCellModel *)modelLocation:(NSInteger)location Name:(NSString*)name type:(LMZXCommonSearchCellType)type place:(NSString *)hold {
    LMZXSearchCellModel*  model = [[LMZXSearchCellModel alloc]init];
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

#pragma mark  通用 creat Model 用于重置页面的 cell 数
-(LMZXSearchCellModel *)modelLocation:(NSInteger)location Name:(NSString*)name type:(LMZXCommonSearchCellType)type place:(NSString *)hold hint:(NSString*)hint {
    LMZXSearchCellModel*  model = [[LMZXSearchCellModel alloc]init];
    model.location = location;
    model.Name = name;
    model.type = type;
    model.hint = hint;
    model.placeholdText = hold;
    model.searchItemType = self.searchItemType;
    CGFloat width=[model.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
    self.titleWidth = (width>=self.titleWidth ? width:self.titleWidth);
    model.maxLength = self.titleWidth;
    return model;
}



#pragma mark - 点击 查询报告
- (void)didClickedSearch{
    
    [self.view endEditing:YES];

    if (![self verificateData]) {
        return;
    }
    
    [self scrollViewWillBeginDragging:self.tableView];
    
    // 查询条件的模型
    
    
    
    
    
    
    for (LMZXSearchCellModel *model in self.commonCellData) {
        if ([model.mobileModel.name isEqualToString:@"username"]) {
            self.lmQueryInfoModel.username =  model.Text.length>=1? model.Text:@"" ;
        } else if ([model.mobileModel.name isEqualToString:@"password"]) {
            self.lmQueryInfoModel.password = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.mobileModel.name isEqualToString:@"otherInfo"]) {
            self.lmQueryInfoModel.otherInfo = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.mobileModel.name isEqualToString:@"identityName"]) {
            self.lmQueryInfoModel.identityName = model.Text.length>=1? model.Text:@"" ;
        }
    }
    
    self.lmQueryInfoModel.checkTypeForSMS = LMZXCommonSendMsgTypePhone;
    
    
    
//    
//    
//    [self.lmQueryInfoModel setDataMobileWithUserName:self.firstTextField password:self.twoTextField contentType:@"all" otherInfo:(!self.threeTextField)? @"":self.threeTextField idNO:@"" idName:@"" isJLDX:isSCALJL];
//
    
//    _searchConditionModel = [[YJSearchConditionModel alloc] init];
//    _searchConditionModel.type = YJGoToSearchResultTypeFromHome;
//    LMLog(@"first:%@-two:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
//    
//    //  1-账户 2- 密码 3- 其他信息
//    
//    [_searchConditionModel setCityCode:@"" account:self.firstTextField passWord:self.twoTextField servicePass:(!self.threeTextField)? @"":self.threeTextField ];
    
    
//    __block typeof(self) sself = self;
    
    
    
    
    // 自定一个
  LMZXLoadingReportBaseVC * loadingVC = [[LMZXLoadingReportBaseVC alloc] init];
    loadingVC.lmQueryInfoModel = self.lmQueryInfoModel;
    loadingVC.searchType = self.searchItemType;
//    if(isSCALJL){
//        loadingVC.isSCALJL = YES;
//    }
//    loadingVC.lmSearchResultBlock = ^(int status,LMZXSDKFunction type,id obj){
//        sself.lmSearchResultBlock(status,type,obj);
//    };
    
    [self.navigationController pushViewController:loadingVC animated:YES];
    

}
#pragma mark - 校验格式
-(BOOL)verificateData
  {
//    LMLog(@"格式校验：first:%@-twO:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
    
    
    if (self.verifyNum == 2) {
        if (!self.firstTextField.length) {
            [self.view makeToast:@"请输入手机号码" ifSucess:NO]; //旧:无
            return NO;
        }else if (!self.twoTextField.length) {
            [self.view makeToast:@"请输入服务密码" ifSucess:NO];
            return NO;
        }
    } else if ( self.verifyNum == 3){
        if (!self.firstTextField.length) {
            [self.view makeToast:@"请输入手机号码" ifSucess:NO];//旧:请输入手机号
            return NO;
        }else if (!self.twoTextField.length) {
            [self.view makeToast:@"请输入服务密码" ifSucess:NO];
            return NO;
        }else if (!self.threeTextField.length ) {
            LMZXSearchCellModel *model = self.commonCellData[2];
            if(model.hint) [self.view makeToast:model.hint ifSucess:NO];
            else [self.view makeToast:@"请完善输入" ifSucess:NO];
            return NO;
        }
        
        // 身份证格式校验
        LMZXSearchCellModel *model = self.commonCellData[2];
        if (self.threeTextField.length && [model.hint isEqualToString:LMZX_CarrieSearchtx1]) {
            if(![self.threeTextField isIdentityCard]){
                [self.view makeToast:@"请输入正确的身份证号码" ifSucess:NO];
                return NO;
            }
        }
        
    }
    
    // 手机号格式校验
    if (self.firstTextField.length) {
        if(![NSString isMobileNumber:self.firstTextField]){
            [self.view makeToast:@"请输入正确的手机号码" ifSucess:NO];// 旧 无
            return NO;
        }
        
    }
    
    
    //协议
    if ((!self.btnSelected.selected) ) {
        [self.view makeToast:@"不同意协议无法进行下一步" ifSucess:NO];
        return NO;
    }
    
    if (isRightPhone == NO) {
        [self.view makeToast:@"请输入正确的手机号码"]; //旧: 请输入正确的手机号
        return NO;
    }
    
    return YES;
}





#pragma  mark -   键盘

-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}


#pragma  mark textfiled 结束编辑
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    return YES;
}
- (void)textFieldTextDidEndEditingQ:(NSNotification *)noti {
    if (self.isVCOut) {
        return;
    }
    [super textFieldTextDidEndEditingSuper:noti];

    
//    LMLog(@"%@",noti);
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != LM_TagCommonSearchCellTextfiled) {
        return;
    }
    
    LMZXCommonSearchCell  *editeCell  = (LMZXCommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
    
    if ((self.searchItemType == LMZXSearchItemTypeOperators)&&(indexPath.row == 0)) {
        return;
    }
    
   [editeCell endEditing:YES];

}

//#pragma  mark textfiled 清除
-(void)textFiledEditChangedQ:(NSNotification *)noti{
    
    UITextField *tf = (UITextField *)noti.object;
    if (tf.tag != LM_TagCommonSearchCellTextfiled) {
        return;
    }
    
    LMZXCommonSearchCell  *editeCell  = (LMZXCommonSearchCell *)[[tf superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
//    NSString *result = tf.text;
    
    if (indexPath.row!=0) {
        return;
    }
    if (!self.firstTextField) {
        return;
    }
    if (!self.firstTextField.length) {
        return;
    }
    if (self.firstTextField.length<10) {
        return;
    }
    if ((self.firstTextField.length<10)&&(indexPath.row != 0)) {
        return;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        
    }else{
        self.firstTextField = @"";
    }
    
    
    
}


#pragma mark - 其他通用

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //     [super scrollViewWillBeginDragging:scrollView];
    [self.view endEditing:YES];
}


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

