//
//  YJCitySearchResultVC.m
//  CreditPlatform
//
//  Created by yj on 2016/12/14.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "LMZXCitySearchResultVC.h"
#import "LMZXCityListCell.h"
#import "UIImage+LMZXTint.h"
#import "LMZXSDK.h"
@interface LMZXCitySearchResultVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIImageView *noResultTip;
@end

static NSString *kCitySearchResultVCId = @"kCitySearchResultVCCell";
@implementation LMZXCitySearchResultVC

- (UIImageView *)noResultTip {
    if (!_noResultTip) {
        _noResultTip = [[UIImageView alloc] init];
        UIImage *img = [UIImage imageFromBundle:@"lmzxResource" name:@"lmzx_noResult"];
        _noResultTip.image = img;
        _noResultTip.contentMode = UIViewContentModeCenter;
        _noResultTip.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        UILabel *lb = [UILabel new];
        lb.text = @"无结果";
        lb.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textAlignment = NSTextAlignmentCenter;
        
        lb.frame = CGRectMake(0, img.size.height*0.5+105, self.view.bounds.size.width, 20);
        [_noResultTip addSubview:lb];
        
    }
    return _noResultTip;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,10, self.view.bounds.size.width, self.view.bounds.size.height-10) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[LMZXCityListCell class] forCellReuseIdentifier:kCitySearchResultVCId];
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
//    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    
    UIColor *pageColor = [LMZXSDK shared].lmzxPageBackgroundColor;
    if (pageColor) {
        self.view.backgroundColor = pageColor;
        self.tableView.backgroundColor = pageColor;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchList.count == 0) {
        [self.tableView addSubview:self.noResultTip];
    } else {
        [self.noResultTip removeFromSuperview];
    }
    return self.searchList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMZXCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCitySearchResultVCId forIndexPath:indexPath ];
    if (indexPath.row == 0) {
        cell.topLine.hidden = NO;
    } else {
        cell.topLine.hidden = YES;
    }
    
    if (self.searchList.count) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.searchList[indexPath.row] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
        
        
        if (self.inputValue && self.inputValue.length) {
            NSRange range = [self.searchList[indexPath.row] rangeOfString:self.inputValue];
            
            [attStr addAttributes:@{NSForegroundColorAttributeName : [self matchingStringColor]} range:range];
        } else if (self.matchValues&&self.matchValues.count) {
            for (NSString *match in self.matchValues) {
                NSRange range = [self.searchList[indexPath.row] rangeOfString:match];
                 [attStr addAttributes:@{NSForegroundColorAttributeName : [self matchingStringColor] } range:range];
            }
            
        }
       
        
        cell.textLB.attributedText = attStr;
    }
   
    
    return cell;
}

- (UIColor *)matchingStringColor {
    if ([LMZXSDK shared].lmzxProtocolTextColor) {
        return [LMZXSDK shared].lmzxProtocolTextColor;
    }
    return [UIColor colorWithRed:48/255.0 green:113/255.0 blue:242/255.0 alpha:1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(citySearchResultVC:didSelectCity:)]) {
        [self.delegate citySearchResultVC:self didSelectCity:self.searchList[indexPath.row]];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
    

}





- (void)dealloc {
//    MYLog(@"---------%@销毁了",self);
}


@end
