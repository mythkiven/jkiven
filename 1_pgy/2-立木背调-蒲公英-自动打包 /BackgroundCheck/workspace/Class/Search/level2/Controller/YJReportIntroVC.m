//
//  YJReportIntroVC.m
//  BackgroundCheck
//
//  Created by yj on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import "YJReportIntroVC.h"
#import "YJIntroHeaderView.h"
#import "YJIntroContentView.h"
#import "YJHomeItemModel.h"

@interface YJReportIntroVC ()
{
    YJIntroHeaderView *_headerView;
    YJIntroContentView *_contentView;
    UIScrollView *_scrollView;
}
@end

@implementation YJReportIntroVC


- (void)viewDidLoad {
	[super viewDidLoad]; 
    [self setupUI];
}
- (void)setupUI {
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor =RGB(233, 234, 237);
    [self.view addSubview:_scrollView];
    
    // 顶部
    _headerView = [YJIntroHeaderView introHeaderView];
    _headerView.introModel = _introModel;
    _headerView.frame = CGRectMake(0, 0, kScreenW, 303);
    [_scrollView addSubview:_headerView];
    
    // 价格
    UILabel *priceLB = [UILabel new];
    priceLB.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), kScreenW, 22);
    //    priceLB.text = self.introModel.price;
    //    priceLB.font = Font13;
    priceLB.textAlignment = NSTextAlignmentCenter;
    //    priceLB.textColor = RGB(153,153,153);
    
    NSString *priceStr = [NSString stringWithFormat:@"价格：%@元/次",self.introModel.price];
    NSRange range = [priceStr rangeOfString:self.introModel.price];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:priceStr attributes:@{NSForegroundColorAttributeName:RGB(153,153,153),NSFontAttributeName:Font13}];
    [attrStr setAttributes:@{NSForegroundColorAttributeName:RGB_black,NSFontAttributeName:Font18} range:range];
    priceLB.attributedText = attrStr;
    
    [_scrollView addSubview:priceLB];
    
    // 查询的内容
    _contentView = [YJIntroContentView introContentView];
    _contentView.type = _introModel.title;
    _contentView.frame = CGRectMake(15, CGRectGetMaxY(priceLB.frame)+20, kScreenW-30, 175);
    [_scrollView addSubview:_contentView];
    
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_contentView.frame)+64+60);
    
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
