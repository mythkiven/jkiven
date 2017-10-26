//
//  YJHouseFundPayCell.m
//  CreditPlatform
//
//  Created by yj on 16/7/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "YJHouseFundPayCell.h"
#import "YJHouseFundModel.h"
@interface YJHouseFundPayCell ()
/**
 *  业务描述
 */
@property (nonatomic, weak) IBOutlet UILabel *bizDescLB;
/**
 *  日期
 */
@property (nonatomic, weak) IBOutlet UILabel *accDateLB;

/**
 *  单位名称
 */
@property (nonatomic, weak) IBOutlet UILabel *corpNameLB;

/**
 *  金额
 */
@property (nonatomic, weak) IBOutlet UILabel *amtLB;



@end

@implementation YJHouseFundPayCell

+ (instancetype)houseFundPayCellWithTableView:(UITableView *)tableView {
    
    YJHouseFundPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"houseFundPayCell"];
    
    if (cell == nil) {
        cell= [[[NSBundle mainBundle] loadNibNamed:@"YJHouseFundPayCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
    
}


- (void)setDetail:(YJHouseFundDetails *)detail {
    _detail = detail;
    
    if (detail.accDate) {
        if (detail.accDate.length>0)
            self.accDateLB.text = detail.accDate;
    }
    if (detail.bizDesc) {
        if (detail.bizDesc.length>0)
            self.bizDescLB.text = detail.bizDesc;
    }

    if (detail.amt) {
        if (detail.amt.length>0)
            self.amtLB.text = [NSString stringWithFormat:@"%@元",detail.amt];
    }
    
    if (detail.corpName) {
        if (detail.corpName.length)
            self.corpNameLB.text = detail.corpName;
    }
    
    
    
    
    
   
    
    
    
}


- (void)setFrame:(CGRect)frame {
    //    frame.origin.x = kMargin;
    //    frame.size.width -= kMargin * 2;
    //
//    frame.origin.y += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
    
}

@end
