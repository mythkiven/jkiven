//
//  YJTaoBaoAlipayInfoVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJTaoBaoAlipayInfoVC.h"

@interface YJTaoBaoAlipayInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
@property (weak, nonatomic) IBOutlet UILabel *emailLB;
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;
@property (weak, nonatomic) IBOutlet UILabel *realNameLB;
@property (weak, nonatomic) IBOutlet UILabel *idLB;
@property (weak, nonatomic) IBOutlet UILabel *identityStatusLB;
@property (weak, nonatomic) IBOutlet UILabel *accBalLB;

@property (weak, nonatomic) IBOutlet UILabel *yueBaoBalLB;
@property (weak, nonatomic) IBOutlet UILabel *hisIncomLB;

@property (weak, nonatomic) IBOutlet UILabel *huaBeiLimitLB;
@property (weak, nonatomic) IBOutlet UILabel *huaBeiAvailableLimitLB;


@end

@implementation YJTaoBaoAlipayInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定支付宝信息";
    
    if (![self.taoBaoAlipayInfo.username isEqualToString:@""]) {
        self.userNameLB.text = self.taoBaoAlipayInfo.username;
    }
    
    if (![self.taoBaoAlipayInfo.email isEqualToString:@""]) {
        self.emailLB.text = self.taoBaoAlipayInfo.email;
    }
    
    if (![self.taoBaoAlipayInfo.mobile isEqualToString:@""]) {
        self.mobileLB.text = self.taoBaoAlipayInfo.mobile;
    }
    
    if (![self.taoBaoAlipayInfo.realName isEqualToString:@""]) {
        self.realNameLB.text = self.taoBaoAlipayInfo.realName;
    }
    
    if (![self.taoBaoAlipayInfo.identityNo isEqualToString:@""]) {
        self.idLB.text = self.taoBaoAlipayInfo.identityNo;
    }
    
    if (![self.taoBaoAlipayInfo.identityStatus isEqualToString:@""]) {
        self.identityStatusLB.text = self.taoBaoAlipayInfo.identityStatus;
    }
    
    if (![self.taoBaoAlipayInfo.accBal isEqualToString:@""]) {
        self.accBalLB.text = self.taoBaoAlipayInfo.accBal;
    }
    
    if (![self.taoBaoAlipayInfo.yuebaoBal isEqualToString:@""]) {
        self.yueBaoBalLB.text = self.taoBaoAlipayInfo.yuebaoBal;
    }
    
    if (![self.taoBaoAlipayInfo.yuebaoHisIncome isEqualToString:@""]) {
        self.hisIncomLB.text = self.taoBaoAlipayInfo.yuebaoHisIncome;
    }
    
    if (![self.taoBaoAlipayInfo.huabeiAvailableLimit isEqualToString:@""]) {
        self.huaBeiLimitLB.text = self.taoBaoAlipayInfo.huabeiAvailableLimit;
    }
    
    if (![self.taoBaoAlipayInfo.huabeiLimit isEqualToString:@""]) {
        self. huaBeiAvailableLimitLB.text = self.taoBaoAlipayInfo.huabeiLimit;
    }
    

    
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
