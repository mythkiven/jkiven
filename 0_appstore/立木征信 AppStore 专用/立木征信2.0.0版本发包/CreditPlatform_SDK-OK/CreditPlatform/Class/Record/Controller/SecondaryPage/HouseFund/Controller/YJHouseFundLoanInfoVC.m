//
//  YJHouseFundLoanVC.m
//  CreditPlatform
//
//  Created by yj on 16/7/28.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHouseFundLoanInfoVC.h"
#import "YJHouseFundModel.h"
@interface YJHouseFundLoanInfoVC ()
/**
 *  贷款账号
 */
@property (weak, nonatomic) IBOutlet UILabel *loanAccountLB;
/**
 *  贷款期限
 */
@property (weak, nonatomic) IBOutlet UILabel *loanDeadlineLB;
/**
 *  贷款总额
 */
@property (weak, nonatomic) IBOutlet UILabel *loanTotalLB;

/**
 *  贷款余额
 */
@property (weak, nonatomic) IBOutlet UILabel *loanBalanceLB;
/**
 *  还款方式
 */
@property (weak, nonatomic) IBOutlet UILabel *loanWayLB;
/**
 *  末次还款年、月
 */
@property (weak, nonatomic) IBOutlet UILabel *lastRepayDateLB;
/**
 *  贷款状态
 */
@property (weak, nonatomic) IBOutlet UILabel *loanStateLB;
/**
 *  开户日期
 */
@property (weak, nonatomic) IBOutlet UILabel *openAccountDateLB;


@end

@implementation YJHouseFundLoanInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贷款明细";
    
//    if (self.loadInfo) {
//        [self.view addSubview:[YJNODataView NODataView]];
//    } else {
//        [self loadData];
//    }
    
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (!_loadInfo) {
        [self.view addSubview:[JFactoryView JGrayViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]];
        [self.view addSubview:[YJNODataView NODataView:NODataTypeRedNormal]];
    }else{
        [self.view removeSubView:[JFactoryView class]];
        [self.view removeSubView:[YJNODataView class]];
    }
}

- (void)loadData {
    if (_loadInfo.loadAccNo) {
        self.loanAccountLB.text = _loadInfo.loadAccNo;
    }
    if (_loadInfo.loadLimit) {
        self.loanDeadlineLB.text = [NSString stringWithFormat:@"%@个月",_loadInfo.loadLimit];
    }
    if (_loadInfo.loadAll) {
        self.loanTotalLB.text = [NSString stringWithFormat:@"%@元",_loadInfo.loadAll];
    }
    if (_loadInfo.loadBal) {
        self.loanBalanceLB.text = [NSString stringWithFormat:@"%@元", _loadInfo.loadBal];
    }
    if (_loadInfo.paymentMethod) {
        self.loanWayLB.text = _loadInfo.paymentMethod;
    }
    if (_loadInfo.lastPaymentDate) {
        self.lastRepayDateLB.text = _loadInfo.lastPaymentDate;
    }
    if (_loadInfo.loadStatus) {
        self.loanStateLB.text = _loadInfo.loadStatus;
    }
    if (_loadInfo.openDate) {
        self.openAccountDateLB.text = _loadInfo.openDate;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseFundLoanInfoCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"HouseFundLoanInfoCell"];
    }
    cell.textLabel.text = @"公积金贷款信息";
    
    return cell;
}

@end
