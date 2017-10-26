//
//  YJRechargeTypeVC.m
//  CreditPlatform
//
//  Created by yj on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJOnlineRechargeTypeVC.h"
#import "YJRechargeTypeCell.h"
#import "YJHomeItemModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "YJAlipayOrder.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "YJCommitTransferMsgVC.h"
#import "YJAlipayManager.h"

#import "WeChatPayManager.h"


@interface YJOnlineRechargeTypeVC ()
{
    NSIndexPath *_currentIndexPath;
    UIButton *gotoPayBtn_;
    PayReq*WXreq_;
    
    __block NSString *_orderNO;
}

/**
 *  充值金额
 */
@property (weak, nonatomic) IBOutlet UILabel *rechargeAmountLB;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *payTypeArray;

@end

@implementation YJOnlineRechargeTypeVC
- (NSArray *)payTypeArray {
    if (_payTypeArray == nil) {
        _payTypeArray = [NSArray array];
        
        _payTypeArray = [YJHomeItemModel mj_objectArrayWithFilename:@"onlinePayType.plist"];
    }
    return _payTypeArray;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    gotoPayBtn_.enabled = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBg"] forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付方式";
    self.tableView.rowHeight = 75;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB_pageBackground;
    
    [self setupRechargeAmount];
    

    [self setupFooterView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAppWillResignActiveJ:) name:appWillResignActiveJ object:nil];
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccesS) name:YJNotificationPaySuccessALi object:nil];
    }
    
    
    _orderNO = @"";
    
}

-(void)paySuccesS{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    self.tableView.userInteractionEnabled = YES;
    __block typeof(self) sself =self;
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"支付成功" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [sself.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    取消预支付订单
    
}
/**
 *  设置充值金额
 */
- (void)setupRechargeAmount {
    
    self.rechargeAmountLB.attributedText = [self getAttributedString:[NSString stringWithFormat:@"充值金额：%@元",self.amount] color:RGB_navBar];
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)str color:(UIColor *)color {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange amountRange = [str rangeOfString:self.amount];
    
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:22],
                            NSForegroundColorAttributeName : color} range:amountRange];
    
     NSRange amountRange1 = [str rangeOfString:@"元"];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                            NSForegroundColorAttributeName : color} range:amountRange1];
    return attStr;
}

- (void)setupFooterView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB_pageBackground;
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 65);
    
    gotoPayBtn_ = [UIButton buttonWithType:(UIButtonTypeCustom)];
    gotoPayBtn_.frame =CGRectMake(kMargin_15, 20, SCREEN_WIDTH - kMargin_15*2,45);
    [gotoPayBtn_ setTitle:@"确认支付" forState:(UIControlStateNormal)];
    gotoPayBtn_.layer.cornerRadius = 2;
    gotoPayBtn_.layer.masksToBounds = YES;
    [gotoPayBtn_ setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtn] forState:(UIControlStateNormal)];
    [gotoPayBtn_ setBackgroundImage:[UIImage resizedImageWithColor:RGB_greenBtnHeighLight] forState:(UIControlStateHighlighted)];
    [gotoPayBtn_ setTitleColor:RGB_white forState:UIControlStateNormal];
    [gotoPayBtn_ setTitleColor:RGB_white forState:UIControlStateHighlighted];
    [gotoPayBtn_ addTarget:self action:@selector(gotoPayBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bg addSubview:gotoPayBtn_];
    
    self.tableView.tableFooterView = bg;
    
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.payTypeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YJRechargeTypeCell *cell = [YJRechargeTypeCell rechargeTypeCellWithTableView:tableView];
    cell.payTypeModel = self.payTypeArray[indexPath.row];
//    if (indexPath.row == 0) {
//        _currentIndexPath = indexPath;
//        cell.selectedView.highlighted = YES;
//        
//    }
    
    if (indexPath.row == 0) {
        UIView *separateLineUp = [self separateLine];
        separateLineUp.frame= CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:separateLineUp];
        
        UIView *separateLineDown = [self separateLine];
        separateLineDown.frame= CGRectMake(15, 75-0.5, SCREEN_WIDTH-15, 0.5);
        [cell.contentView addSubview:separateLineDown];

    } else if (self.payTypeArray.count-1 == indexPath.row) {
        UIView *separateLineDown = [self separateLine];
        separateLineDown.frame= CGRectMake(0, 75-0.5, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:separateLineDown];
    }
    
    return cell;
}




- (UIView *)separateLine {
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = RGB_grayLine;
    return separateLine;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        NSInteger gg = [[WeChatPayManager shareWeChatPay] isInstallWeChat];
        if (gg == 1) {
            [self.tableView makeToast:@"尚未安装微信"];
            return;
        }else if (gg == 2) {
            [self.tableView makeToast:@"微信版本过低"];
            return;
        }
        
    }
        YJHomeItemModel *lastPayTypeModel = self.payTypeArray[_currentIndexPath.row];
        lastPayTypeModel.isSelected = NO;
        
        YJHomeItemModel *selectedPayTypeModel = self.payTypeArray[indexPath.row];
        selectedPayTypeModel.isSelected = YES;
        
        _currentIndexPath = indexPath;
        [self.tableView reloadData];
    
    
}


- (void)gotoPayBtnClick:(UIButton *)sender {
    YJHomeItemModel *model = self.payTypeArray[_currentIndexPath.row];
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]] && [model.type isEqualToString:@"alipay"]) {
        self.tableView.userInteractionEnabled = NO;
    }else{
        [YJShortLoadingView yj_makeToastActivityInView:self.view];
        self.tableView.userInteractionEnabled = NO;
    }
    
    
    
    
    
    if ([model.type isEqualToString:@"alipay"]) { // 支付宝
//        160923000103860088
//        [YJAlipayManager alipayWithTotalAmount:self.amount outTradeNo:_orderNO viewcontroller:self from:(YJAlipayFromBalance) creatAlipayOrder:^(NSString *out_trade_no) {
//            _orderNO = out_trade_no;
//        }];
 
//#ifdef DEBUG
//        [YJAlipayManager alipayWithTotalAmount:@"0.01" outTradeNo:_orderNO viewcontroller:self from:(YJAlipayFromBalance) creatAlipayOrder:^(NSString *out_trade_no) {
//            _orderNO = out_trade_no;
//        }];
//#else

//        self.amount = @"0.01";
        [YJAlipayManager alipayWithTotalAmount:self.amount outTradeNo:_orderNO viewcontroller:self from:(YJAlipayFromBalance) creatAlipayOrder:^(NSString *out_trade_no) {
            _orderNO = out_trade_no;
        }];
//#endif
        

    } else if ([model.type isEqualToString:@"wechat"]) { // 微信

        WeChatPayManager *wpay =[WeChatPayManager shareWeChatPay ];
//#ifdef DEBUG
//        [wpay weChatWithTotalAmount:@"0.01" outTradeNo:_orderNO viewcontroller:self from:YJAlipayFromBalance creatAlipayOrder:^(NSString *out_trade_no) {
//            _orderNO = out_trade_no;
//            
//        }];
//#else
        [wpay weChatWithTotalAmount:self.amount outTradeNo:_orderNO viewcontroller:self from:YJAlipayFromBalance creatAlipayOrder:^(NSString *out_trade_no) {
            _orderNO = out_trade_no;
            
        }];
//#endif
        
        
        wpay.wxPay=^(id obj){
            [YJShortLoadingView yj_hideToastActivityInView:self.view];
            self.tableView.userInteractionEnabled = YES;
        };

       
        
    }
    
}
-(void)receiveAppWillResignActiveJ:(NSNotification*)noti{
    [YJShortLoadingView yj_hideToastActivityInView:self.view];
    self.tableView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
