//
//  YJChildAccountListMenuView.m
//  CreditPlatform
//
//  Created by yj on 2016/11/11.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountListMenuView.h"
#import "YJChildAccountListModel.h"
#import "YJTypeMenuButton.h"

@interface YJChildAccountListMenuView ()
{
    NSMutableArray *_btnArr;
    
    CGFloat _menuH;
    
}
@property (nonatomic, weak) UIButton *currentBtn;


/**
 套餐消费
 */
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableDictionary *menuBizTypeDict;

@end
@implementation YJChildAccountListMenuView
- (NSMutableArray *)titlesArray {
    
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray arrayWithObjects:@"全部", nil];
    }
    return _titlesArray;
}

- (NSMutableDictionary *)menuBizTypeDict {
    if (!_menuBizTypeDict) {
        _menuBizTypeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"全部", nil];
    }
    return _menuBizTypeDict;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _btnArr = [NSMutableArray arrayWithCapacity:2];
        
        //        [self setupSubviews];
        
        _contentView.frame =  CGRectMake(0, 0, self.frame.size.width, 265);
        
        [self setupSubviewsWithMenuTypeComboPurchase];// 子账号列表

        
    }
    return self;
}


/**
 子账号列表
 */
- (void)setupSubviewsWithMenuTypeComboPurchase {
    
    [self loadComboPurchaseData];
    
}

#pragma mark   加载用户套餐信息
- (void)loadComboPurchaseData {
    
    NSDictionary *dict = @{@"method" :      urlJK_queryUserOperatorNames,
                           @"mobile" :      kUserManagerTool.mobile,
                           @"userPwd" :     kUserManagerTool.userPwd,
                           @"appVersion":   VERSION_APP_1_4_1,
                           };


    
    __weak typeof(self) weakSelf = self;

    [YJHTTPTool post:[NSString stringWithFormat:@"%@%@",SERVE_URL,urlJK_queryUserOperatorNames] params:dict success:^(id obj) {
        MYLog(@"子账号列表%@",obj);
        
        if (![obj[@"data"] isKindOfClass:[NSNull class]]) {
            
//            weakSelf.titlesArray = obj[@"data"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.titlesArray addObjectsFromArray: obj[@"data"]];


                NSArray *titles = obj[@"data"];
                int count = (int)titles.count;
                for (int i = 0; i < count ; i ++) {
                    [weakSelf.menuBizTypeDict setObject:titles[i] forKey:titles[i]];
                }
                
                

                for (int i = 0; i < weakSelf.titlesArray.count ; i ++) {

                    YJTypeMenuButton *btn = [weakSelf menuBtnWithTitle:weakSelf.titlesArray[i]];
                    if (i == 0) {
                        weakSelf.currentBtn.selected = NO;
                        btn.selected = YES;
                        weakSelf.currentBtn = btn;
                    }
                    [_btnArr addObject:btn];
                    [weakSelf setNeedsLayout];

                }
                
            });
            
            
        }
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
        
    }];
}




- (YJTypeMenuButton *)menuBtnWithTitle:(NSString *)title {
    YJTypeMenuButton *btn = [[YJTypeMenuButton alloc] init];
    [btn setTitle:title forState:(UIControlStateNormal)];
    
    [_scrollView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClcik:) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}


- (void)btnClcik:(YJTypeMenuButton *) item {
    
    [self hide];
    
    
    // 1.控制选中状态
    self.currentBtn.selected = NO;
    item.selected = YES;
    self.currentBtn = item;
    
    
    NSString *type = @"userOperatorName";
    [[NSNotificationCenter defaultCenter] postNotificationName:YJUserOperatorIdDidChangeNotification object:nil userInfo:@{type:self.menuBizTypeDict[item.titleLabel.text]}];
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 25;
    
    CGFloat btnH = 40;
    int count = (int)_btnArr.count;
    
    
    CGFloat btnW = SCREEN_WIDTH - margin;
    for (int i = 0; i < count; i ++) {
        
        UIButton *btn = _btnArr[i];
        CGFloat btnX = margin;
        CGFloat btnY = i * btnH;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        if (i == count - 1) {
            _menuH = CGRectGetMaxY(btn.frame) +15;
        }
        
    }
    
    if (_menuH >= 265) {
        _scrollView.contentSize = CGSizeMake(0, _menuH+15);
        _scrollView.frame =  CGRectMake(0, 0, self.frame.size.width, 265);
    } else {
        _scrollView.contentSize = CGSizeMake(0, _menuH);
        _scrollView.frame =  CGRectMake(0, 0, self.frame.size.width, _menuH);
    }
    
    
}

@end
