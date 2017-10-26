//
//  ComboHistoryCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountListCell.h"
#import "YJChildAccountListModel.h"
@interface YJChildAccountListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *disableIconView;

@property (weak, nonatomic) IBOutlet UILabel *accountNameLB;

@property (weak, nonatomic) IBOutlet UILabel *accountNumLB;


@end

@implementation YJChildAccountListCell

+ (instancetype)childAccountListCellWithTableView:(UITableView *)tableView {
    
    YJChildAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJChildAccountListCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJChildAccountListCell" owner:nil options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}


- (void)setListModel:(YJChildAccountListModel *)listModel {
    _listModel = listModel;
    
    int status = [listModel.operatorStatus intValue];
    
    if (status == 1) { //未禁用
        self.disableIconView.image = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

    }else if (status == 2) {  //禁用
        self.disableIconView.image = [UIImage imageNamed:@"icon_ChildAccount_disable"];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
    self.accountNameLB.text = listModel.name;
    
    
    self.accountNumLB.text = listModel.fullName;
    
    
    
}



@end
