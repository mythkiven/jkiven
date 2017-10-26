//
//  House.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/23.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXCommonSearchCell.h"
#import "LMZXCityListBaseVC.h"
#import "LMZXCityListiOS7VC.h"
#import "LMZXCityListViewController.h"
#import "NSString+LMZXCommon.h"

#import "LMZXHouseFundSocialSecuritySearchVC.h"
#import <CoreLocation/CoreLocation.h>
#define iOS8Later_lmzx ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
@interface LMZXHouseFundSocialSecuritySearchVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    
    
    // 呼和浩特 特殊,这里用:
    BOOL isHHHT;  //呼和浩特
    BOOL isHHHTID;//呼和浩特 sfz
    NSMutableArray *HHHTDATA;// 呼和浩特的 数据源
    
    CLLocationManager *_locManager;//定位管理类
}


@property (nonatomic, strong) UIButton      *selectedBtn;
@property (nonatomic, strong) UIButton      *cityBtn;
@property (nonatomic, strong) NSArray       *cityList;
@property (nonatomic, strong) UIPickerView  *pickerView;


@end

@implementation LMZXHouseFundSocialSecuritySearchVC
/**
 定位授权
 */
- (void)locationAuthorization {
    _locManager = [[CLLocationManager alloc] init];
    if (iOS8Later_lmzx) {
        [_locManager requestWhenInUseAuthorization];
        
    }
    

}

#pragma mark - 生命周期

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationAuthorization];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingQ:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    
//    [self refreshUI];
    
    //事件添加
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    

    
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
//
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    LMLog(@"=========viewWillAppear");
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //    [self.view bringSubviewToFront:_textField];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
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
    
    LMZXCommonSearchCell *cell = [LMZXCommonSearchCell initCommonCellWith:tableView];
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
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    cell.textField.clearsOnBeginEditing = NO;
    return cell;
}
-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}

#pragma mark  通用 creat Model
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



#pragma mark 点击 查询报告
- (void)didClickedSearch{
    
    [self.view endEditing:YES];
    if (![self verificateData ]) {
        return;
    }
    // 呼和浩特
    if (isHHHTID&&isHHHT) {
        LMZXSearchCellModel *twoModel =  self.commonCellData[3];
        twoModel.Text=@"";
        
    } else {
        
    }
    
    [self scrollViewWillBeginDragging:self.tableView];
    
    // 查询条件的模型 ////////////// 注意 映射 关系的转变////////////
    
    self.lmQueryInfoModel.area = self.cityModel.areaCode;
    
    for (LMZXSearchCellModel *model in self.commonCellData) {
        if ([model.fundModel.name isEqualToString:@"username"]) {
            self.lmQueryInfoModel.username =  model.Text.length>=1? model.Text:@"" ;
        } else if ([model.fundModel.name isEqualToString:@"password"]) {
            self.lmQueryInfoModel.password = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.fundModel.name isEqualToString:@"realName"]) {
            self.lmQueryInfoModel.realname = model.Text.length>=1? model.Text:@"" ;
        }else if ([model.fundModel.name isEqualToString:@"otherInfo"]) {
            self.lmQueryInfoModel.otherInfo = model.Text.length>=1? model.Text:@"" ;
            
        }
    }
    
    
    LMZXLoadingReportBaseVC *loadingVc = [[LMZXLoadingReportBaseVC alloc] init];
    loadingVc.lmQueryInfoModel = self.lmQueryInfoModel;
    loadingVc.searchType = self.searchItemType;
    [self.navigationController pushViewController:loadingVc animated:YES];
    

}
#pragma mark -
#pragma mark 校验格式
-(BOOL)verificateData {
    
    //    [self.view makeToast:[NSString stringWithFormat:@"%@=%@=%@",self.firstTextField,self.twoTextField,self.threeTextField]];
    //
    //    sleep(1);
    
    LMZXSearchCellModel *model = self.commonCellData[0];
    if ([model.Text isEqualToString:@""]|!model.Text) {
        [self.view makeToast:@"请选择城市" ifSucess:NO];
        return NO;
    }
    
    
    for (int i=1; i<self.commonCellData.count; i++) {
        LMZXSearchCellModel *model = self.commonCellData[i];
//        MYLog(@"%@",model.Text);
        if ([model.fundModel.required isEqualToString:@"true"]) {
            
            
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
    if ((!self.btnSelected.selected) ) {
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
//    UITextField *tf = (UITextField *)noti.object;
//    LMZXCommonSearchCell  *editeCell  = (LMZXCommonSearchCell *)[[tf superview] superview];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:editeCell];
//    LMZXSearchCellModel *model =  self.commonCellData[indexPath.row];
   
//#warning  onHasKeyShowInfo什么意思
//    "onHasKeyShowInfo":"如已办理联名卡，则必须输入，否则无需输入。"
//    if (model.fundModel.onHasKeyShowInfo.length) {
//        self.markLabel.text =model.fundModel.onHasKeyShowInfo;
//
//        self.markLabel.alpha =1;
//        self.markLabel.hidden=NO;
//    }
    
    
    
    
}
#pragma  mark tf 结束编辑 子类通用的
- (void)textFieldTextDidEndEditingQ:(NSNotification *)noti {
    
    //    [super textFieldTextDidEndEditingSuper:noti];
    
    self.markLabel.alpha =0;
    self.markLabel.hidden=YES;
    
//    MYLog(@"%@",noti);
    
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
    
    LMZXSearchCellModel *CSModel = self.commonCellData[indexPath.row];
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

#pragma mark  - 公积金 社保 选择城市
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //清空数据
    //    self.firstTextField = nil;
    //    self.twoTextField = nil;
    //    self.threeTextField = nil;
    
    for (LMZXSearchCellModel *model in self.commonCellData) {
        if (model.location==1) { //  城市数据不清空.防止下一页面不选直接返回造成的 BUG
            continue;
        }
        model.Text= @"";
    }
    
    
    if (indexPath.row == 0) {
        if (self.searchItemType == LMZXSearchItemTypeHousingFund | self.searchItemType == LMZXSearchItemTypeSocialSecurity) {//公积金 社保
            
            float version = [[UIDevice currentDevice].systemVersion floatValue];

            LMZXCityListBaseVC *cityList;
            if (version >= 8.0) {
                cityList = [[LMZXCityListViewController alloc] init];
            } else {
                cityList = [[LMZXCityListiOS7VC alloc] init];
            }
            
            cityList.searchItemType = self.searchItemType;
            
            if (self.cityModel.areaName) {
                cityList.cityString = self.cityModel.areaName;
            }
            
            __weak typeof(self) weakSelf = self;
            
            cityList.selectedOneCity = ^(LMZXCityModel *cityInfo) {
                weakSelf.cityModel = cityInfo;
                NSArray *obj = weakSelf.cityModel.elements;
                
                if (obj.count) {
                    
                    for (LMZXSearchCellModel *model in self.commonCellData) {
                        model.Text = @"";
                    }
                    
                    
                    LMZXSearchCellModel *firstModel =  weakSelf.commonCellData[0];
                    firstModel.Text = weakSelf.cityModel.areaName;
                    [weakSelf.commonCellData removeAllObjects];
                    [weakSelf.commonCellData addObject:firstModel];
                    NSArray *dataArr =[LMZXSearchCellModel dataArrWithFundSocialModel:obj Withtype:weakSelf.searchItemType];
                    [weakSelf.commonCellData addObjectsFromArray:dataArr];
                    
                    
                    
                    //呼和浩特
                    isHHHT = NO;
                    LMZXSearchCellModel *twoModel =  weakSelf.commonCellData[1];
                    
                    if ([twoModel.Text isEqualToString:@"呼和浩特市"]|[weakSelf.cityModel.areaCode isEqualToString:@"1501"]) {
                        isHHHT =YES;
                        if (!HHHTDATA) {
                            HHHTDATA = [NSMutableArray arrayWithCapacity:0];
                        }
                        [HHHTDATA removeAllObjects];
                        HHHTDATA = [weakSelf.commonCellData mutableCopy];
                    }
                    
                    [weakSelf.tableView reloadData];
                    
                    
                }
                
                
            };
            
            [self.navigationController pushViewController:cityList animated:YES];
            
        }
        
    }


}




@end


