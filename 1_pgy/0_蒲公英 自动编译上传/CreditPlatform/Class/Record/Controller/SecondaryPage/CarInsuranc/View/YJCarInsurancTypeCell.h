//
//  YJFilingTimeCell.h
//  CreditPlatform
//
//  Created by yj on 2016/10/24.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJCarInsurancePolicyDetails;
@class YJEBankCards;
@interface YJCarInsurancTypeCell : UITableViewCell

/**
 车险
 */
@property (nonatomic, strong) YJCarInsurancePolicyDetails *policyDetail;
/**
 网银流水
 */
@property (nonatomic, strong) YJEBankCards *eBankCards;

//@property (nonatomic, strong) reportDishonestyModel *reportDishonestyModel;

+ (instancetype)carInsurancTypeCellWithTableView:(UITableView *)tableView ;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;

@end
