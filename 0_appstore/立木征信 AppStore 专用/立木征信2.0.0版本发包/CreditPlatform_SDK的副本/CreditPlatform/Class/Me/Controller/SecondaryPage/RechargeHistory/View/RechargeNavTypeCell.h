//
//  RechargeNavTypeCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/8.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RechargeStatusTypeAll = 31,
    RechargeStatusTypeFaile,
    RechargeStatusTypeAllSuccess,
    RechargeStatusTypeAllWaitting,
} RechargeStatusType;


@class RechargeNavTypeModel;
@protocol RechargeNavTypeDelegate <NSObject>

- (void)didSelectedRechargeNavTypeDidSelected:(RechargeNavTypeModel *)model;

@end




@interface RechargeNavTypeCell : UITableViewCell

@property (nonatomic,assign) NSInteger rechargeStatusType;

@property (strong,nonatomic) RechargeNavTypeModel *model;
@property (nonatomic, weak) id<RechargeNavTypeDelegate> delegate;
+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;

@end
