//
//  ComboHistoryCell.m
//  CreditPlatform
//
//  Created by gyjrong on 16/10/25.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJChildAccountManagerCell.h"
#import "YJChildAccountListModel.h"
@interface YJChildAccountManagerCell ()




@property (weak, nonatomic) IBOutlet UILabel *titleLB;


@end

@implementation YJChildAccountManagerCell

+ (instancetype)childAccountManagerCellWithTableView:(UITableView *)tableView {
    
    YJChildAccountManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJChildAccountManagerCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJChildAccountManagerCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
    
    
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLB.text = title;
}



@end
