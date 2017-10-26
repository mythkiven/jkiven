//
//  LMZXEBankBillVC.m
//  LMZX_SDK_Demo
//
//  Created by gyjrong on 17/3/8.
//  Copyright © 2017年 lmzx. All rights reserved.
//

#import "LMZXEBankBillVC.h"

#import "NSString+LMZXCommon.h"

#import "LMZXLoadingReportBaseVC.h"

#import "LMZXTool.h"

#import "LMZXHTTPTool.h"

#import "LMZXListHookVC.h"
#import "LMZXListHookCell.h"
#import "LMZXListHookModel.h"

#import "LMZXBankBillLoadingVC.h"

// 键盘延时弹出时间:有些特殊键盘加载时间较长,如果是页面没有完全弹出之前,加载键盘,会卡顿.
#define LM_TextfiledPopDelay 0.5

@interface LMZXEBankBillVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate,LMZXCommonSearchCellDelegate>
{
    
    // 网银选择银行所用的model
    LMZXListHookModel *_bankListModel;
    //
    LMZXListHookVC *_bankList;
    
}


@property (nonatomic, strong) UIButton      *selectedBtn;
@property (nonatomic, strong) UIButton      *cityBtn;
@property (nonatomic, strong) NSArray       *cityList;

@end

@implementation LMZXEBankBillVC


#pragma mark - 生命周期
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    LMLog(@"--------%@销毁了",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidEndEditingQ:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    
    
    //事件添加
    [self.btnSearch addTarget:self action:@selector(didClickedSearch) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}




#pragma mark - tableview代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commonCellData.count;
}

// 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LMZXCommonSearchCell *cell = [LMZXCommonSearchCell initCommonCellWith:tableView];
    
    cell.model = self.commonCellData[indexPath.row];
    
    //键盘响应
    if (!self.showAllowCell && indexPath.row == 0 && !cell.textField.text.length) {
//        [self performSelector:@selector(firstResponder:) withObject:cell.textField afterDelay:LM_TextfiledPopDelay];
        
       [cell.textField canBecomeFirstResponder];
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
    
    
    cell.textField.clearsOnBeginEditing = NO;
    return cell;
}

#pragma mark  网银流水选择银行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    __block typeof(self) sself =self;
    
    if (indexPath.row == 0) {
        if (self.searchItemType == SearchItemTypeNetBankBill) {// 网银
            if (_bankList) {
            } else {
                _bankList = [[LMZXListHookVC alloc] init];
            }
            
            _bankList.searchItemType = self.searchItemType;
            _bankList.title = @"网银流水";
            
            _bankList.selectedOneCity = ^(id obj){
                __block LMZXListHookModel *model = obj;
                
                _bankListModel = model;
                LMZXSearchCellModel *cmm = sself.commonCellData[0];
                cmm.Text = model.eBankListModel.name;
                
                [sself.tableView reloadData];
                
            };
            self.verifyNum = 2;
            self.showAllowCell =YES;
            [self.navigationController pushViewController:_bankList animated:YES];
            
        }
        
    }
    
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


#pragma mark - 点击 查询报告
- (void)didClickedSearch{
    
    [self.view endEditing:YES];
    
    if (![self verificateData ]) {
        return;
    }
    
    [self scrollViewWillBeginDragging:self.tableView];
    
    [self.lmQueryInfoModel setDataWangyinWithAccessType:@"sdk" identityCardNo:@"" identityName:@"" UserName:self.firstTextField password:self.twoTextField bankCode:_bankListModel.eBankListModel.code];
 
    LMZXBankBillLoadingVC  * loadingVC = [[LMZXBankBillLoadingVC alloc] init];
    loadingVC.lmQueryInfoModel = self.lmQueryInfoModel;
 
    [self.navigationController pushViewController:loadingVC animated:YES];
    
    
}
#pragma mark - 校验格式
-(BOOL)verificateData {
    //    LMLog(@"格式校验：first:%@-twO:%@-three:%@",self.firstTextField,self.twoTextField,self.threeTextField);
    
    
    if (!_bankListModel) {
        [self.view makeToast:@"请选择银行" ifSucess:NO];
        return NO;
    }
    
    
    //其他
    if (self.verifyNum == 2) {
        if (!self.firstTextField.length) {
            [self.view makeToast:@"请输入账号" ifSucess:NO];
            return NO;
        }else if (!self.twoTextField.length) {
            [self.view makeToast:@"请输入密码" ifSucess:NO];
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





#pragma  mark -   键盘

-(void)firstResponder:(UITextField*)textfiled{
    [textfiled becomeFirstResponder];
}


#pragma  mark textfiled 结束编辑
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
    
    if ((self.searchItemType == SearchItemTypeOperators)&&(indexPath.row == 0)) {
        return;
    }
    
    [editeCell endEditing:YES];
    
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



