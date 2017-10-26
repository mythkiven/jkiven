//
//  House.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "JHousingFundSocialSecurityVC.h"


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


#import "JLoadingReportBaseVC.h"


@interface JHousingFundSocialSecurityVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    YJCityInfoModel *_selectCityInfoModel;
    
    YJSearchConditionModel *_searchConditionModel;
    
    BOOL isHHHT;//呼和浩特
    BOOL isHHHTID;//呼和浩特 sfz
    NSMutableArray *HHHTDATA;
}


@property (nonatomic, strong) UIButton      *selectedBtn;
@property (nonatomic, strong) UIButton      *cityBtn;
@property (nonatomic, strong) NSArray       *cityList;
@property (nonatomic, strong) UIPickerView  *pickerView;


@end

@implementation JHousingFundSocialSecurityVC


#pragma mark - 生命周期
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingQ:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    
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
    
//    [self.view bringSubviewToFront:_textField];
    
}

#pragma mark - tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isHHHT&&isHHHTID) {
        return HHHTDATA.count;
    }
    return self.commonCellData.count;
}

#pragma mark 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonSearchCell *cell = [CommonSearchCell initCommonCellWith:tableView];
    cell.model = self.commonCellData[indexPath.row];
    if (isHHHT&&isHHHTID) {
        cell.model = HHHTDATA[indexPath.row];
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

#pragma mark  - 公积金 社保 选择城市
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //清空数据
//    self.firstTextField = nil;
//    self.twoTextField = nil;
//    self.threeTextField = nil;
    
    
    if (indexPath.row == 0) {
        if (self.searchItemType == SearchItemTypeHousingFund | self.searchItemType == SearchItemTypeSocialSecurity) {//公积金 社保
            YJCitySelectedVC *cityVC = [[YJCitySelectedVC alloc] init];
            cityVC.searchItemType = self.searchItemType;
            if (self.searchItemType == SearchItemTypeHousingFund) {
                cityVC.title = @"公积金查询";
            }else if ( self.searchItemType == SearchItemTypeSocialSecurity){
                cityVC.title = @"社保查询";
            }
            
            if (_selectCityInfoModel.areaName) {
                cityVC.cityString = _selectCityInfoModel.areaName;
                
            }
            
            __block typeof(self.tableView) tV= self.tableView;
            
            NSMutableArray * fundSocialData = [NSMutableArray arrayWithCapacity:0];
            // 处理回调
            cityVC.selectedOneCity = ^(YJCityInfoModel *cityInfo) {
                
                NSArray * obj = cityInfo.fundSocialModel.elements;
                _selectCityInfoModel = cityInfo;
                if ( obj.count ) {
                    
                    // 只要选择了城市,默认清除 所有数据
                    for (CommonSearchCellModel *model in self.commonCellData) {
                        model.Text= @"";
                    }
//                    [self.tableView reloadData];
                    
                    
                    for ( id item  in obj) {
                        JFundSocialSearchCellModel *model = [JFundSocialSearchCellModel mj_objectWithKeyValues:item];
                        [fundSocialData addObject:model];
                     }
                    CommonSearchCellModel *firstModel =  self.commonCellData[0];
                    firstModel.Text = cityInfo.areaName;
                    [self.commonCellData removeAllObjects];
                    [self.commonCellData addObject:firstModel];
                    NSArray *dataArr =[CommonSearchCellModel dataArrWithFundSocialModel:fundSocialData Withtype:self.searchItemType];
                    [self.commonCellData addObjectsFromArray:dataArr];
                   
                    //呼和浩特
                    isHHHT = NO;
                    CommonSearchCellModel *twoModel =  self.commonCellData[1];
                    if ([twoModel.Text isEqualToString:@"呼和浩特市"]|[_selectCityInfoModel.areaCode isEqualToString:@"1501"]) {
                        isHHHT =YES;
                        if (!HHHTDATA) {
                            HHHTDATA = [NSMutableArray arrayWithCapacity:0];
                        }
                        [HHHTDATA removeAllObjects];
                        HHHTDATA = [self.commonCellData mutableCopy];
                    }
                    
                    
                }
                
                [tV reloadData];
                
            };
            [self.navigationController pushViewController:cityVC animated:YES];
            
        }
        
    }else{
        
    }
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



#pragma mark 点击 查询报告
- (void)didClickedSearch{
    
    [self.view endEditing:YES];
    if (![self verificateData ]) {
        return;
    }
    // 呼和浩特
    if (isHHHTID&&isHHHT) {
        CommonSearchCellModel *twoModel =  self.commonCellData[3];
        twoModel.Text=@"";
        
    } else {
        
    }
    
    [self scrollViewWillBeginDragging:self.tableView];
    
    // 查询条件的模型
    _searchConditionModel = [[YJSearchConditionModel alloc] init];
    _searchConditionModel.type = YJGoToSearchResultTypeFromHome;
    [_searchConditionModel setCityCode:_selectCityInfoModel.areaCode account:@"" passWord:@"" servicePass: @"" otherInfo:@""];
    for (CommonSearchCellModel *model in self.commonCellData) {
        if ([model.fundModel.name isEqualToString:@"username"]) {
            _searchConditionModel.account =  model.Text.length>=1? model.Text:@"" ;
        } else if ([model.fundModel.name isEqualToString:@"password"]) {
            _searchConditionModel.passWord = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.fundModel.name isEqualToString:@"realName"]) {
            _searchConditionModel.servicePass = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.fundModel.name isEqualToString:@"otherInfo"]) {
            
            _searchConditionModel.otherInfo = model.Text.length>=1? model.Text:@"" ;
            
        }
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
            
        default:
            break;
    }
}
#pragma mark -
#pragma mark 校验格式
-(BOOL)verificateData {
   
//    [self.view makeToast:[NSString stringWithFormat:@"%@=%@=%@",self.firstTextField,self.twoTextField,self.threeTextField]];
//    
//    sleep(1);
    
    CommonSearchCellModel *model = self.commonCellData[0];
    if ([model.Text isEqualToString:@""]|!model.Text) {
        [self.view makeToast:@"请选择城市" ifSucess:NO];
        return NO;
    }
    
    
    for (int i=1; i<self.commonCellData.count; i++) {
        CommonSearchCellModel *model = self.commonCellData[i];
        MYLog(@"%@",model.Text);
        if ([model.fundModel.checkEmpty isEqualToString:@"true"]) {
            
            
            if (!model.Text) {
                [self.view makeToast:[NSString stringWithFormat:@"%@尚未输入",model.Name] ifSucess:NO];
                return NO;
            }
            if (model.Text.length<1) {
                [self.view makeToast:[NSString stringWithFormat:@"%@尚未输入",model.Name]  ifSucess:NO];
                return NO;
            }
            
            
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
    CommonSearchCellModel *model =  self.commonCellData[indexPath.row];
    if (model.fundModel.onHasKeyShowInfo.length) {
        self.markLabel.text =model.fundModel.onHasKeyShowInfo;
        
        self.markLabel.alpha =1;
        self.markLabel.hidden=NO;
    }
    
    
    
    
}
#pragma  mark tf 结束编辑 子类通用的
- (void)textFieldTextDidEndEditingQ:(NSNotification *)noti {
    
//    [super textFieldTextDidEndEditingSuper:noti];
    
    self.markLabel.alpha =0;
    self.markLabel.hidden=YES;
    
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
    
    CommonSearchCellModel *CSModel = self.commonCellData[indexPath.row];
    CSModel.Text = tf.text;
    
    
    
    //呼和浩特
    if (isHHHT&&indexPath.row==1) {
        if ([tf.text isIdentityCard]) {
            isHHHTID =YES;
            HHHTDATA = [self.commonCellData mutableCopy];
            [HHHTDATA removeLastObject];
        } else{
            isHHHTID =NO;
            [self.tableView reloadData];
            return;
        }
        
        [self.tableView reloadData];
    }else{
        
    }
    
//    CommonSearchCellModel *mmm = self.commonCellData[indexPath.row];
//    [self.view makeToast:[NSString stringWithFormat: @"输入:%@ 写入:%@ 序号:%ld",tf.text,mmm.Text,indexPath.row ]  duration:2.0 position:@"top"];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag!=100) {
        return;
    }
    self.firstTextField = textField.text;
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


