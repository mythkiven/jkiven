//
//  YJStartSearchViewController.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/9.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJStartSearchViewController.h"
#import "YJProtocolVC.h"
#import "LMBaseReportViewController.h"
#import "LMZXQueryInfoModel.h"
@interface YJStartSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *positionTF;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation YJStartSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_type) {
        self.navigationItem.title = @"标准版报告";
    } else {
        self.navigationItem.title = @"基础版报告";
    }
    
    [self setupUI];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)setupUI{
    self.bgView.layer.borderWidth=0.5;
    self.bgView.layer.borderColor= RGB(224, 224, 224).CGColor;
    self.searchBtn.layer.cornerRadius = 5;
    self.searchBtn.layer.masksToBounds = YES;
    [self.searchBtn setBackgroundImage:[UIImage imageWithColor:RGB(57,179,27)] forState:(UIControlStateNormal)];
    [self.searchBtn setBackgroundImage:[UIImage imageWithColor:RGB(57,179,27)] forState:(UIControlStateHighlighted)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/**
 是否同意协议
 */
- (IBAction)agreeProtocolBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

/**
 查看协议
 */
- (IBAction)gotoProtocolBtnclcik:(UIButton *)sender {
    YJProtocolVC *protocolVc = [[YJProtocolVC alloc] init];
    
    [self.navigationController pushViewController:protocolVc animated:YES];
}


/**
 开始查询
 */
- (IBAction)startSearch:(UIButton *)sender {
    
    MYLog(@"===开始查询");
    LMBaseReportViewController *vc = [[LMBaseReportViewController alloc] init];
    if (_type) {
        vc.reportType = LMReportTypeStandardType;
    } else {
        vc.reportType = LMReportTypeBasicType;
    }
    LMZXQueryInfoModel *model = [[LMZXQueryInfoModel alloc] initWithName:_nameTF.text mobile:_mobileTF.text idNO:_idTF.text position:_positionTF.text];
    vc.queryInfoModel = model;
    [self.navigationController pushViewController:vc animated:YES];
 
    
    
}



-(IBAction)textFieldTextChange:(UITextField *)textField{
    if (_nameTF.text.length && _mobileTF.text.length && _idTF.text.length && _positionTF.text.length && _agreeBtn.isSelected) {
        _searchBtn.enabled = YES;

    } else {
        _searchBtn.enabled = NO;
    }
}





@end
