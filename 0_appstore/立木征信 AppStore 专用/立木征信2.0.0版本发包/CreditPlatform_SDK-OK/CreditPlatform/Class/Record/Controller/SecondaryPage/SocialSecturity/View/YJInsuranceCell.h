//
//  YJInsuranceCell.h
//  CreditPlatform
//
//  Created by yj on 16/8/30.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSocialSecurityModel.h"

typedef void(^DetailBlock)(int tag);

@interface YJInsuranceCell : UITableViewCell
@property (nonatomic, copy) DetailBlock detailOption;

@property (nonatomic, strong) YJInsurances *insurances;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

+ (instancetype)insuranceCellWithTableView:(UITableView *)tableView;


@end
