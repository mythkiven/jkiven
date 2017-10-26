//
//  PurchaseHistoryTopPullTime.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOperatorBaseCell.h"
@class PurchaseHistoryTopPullTypeModel;
typedef  enum {
    /**  公积金 */
    PurchaseHistoryTTHousingFund,
    /**  社保 */
    PurchaseHistoryTTSocialSecurity,
    /**   运营商 */
    PurchaseHistoryTTOperators,
    /**  央行征信 */
    PurchaseHistoryTTCentralBank,
    /**  黑名单  */
    PurchaseHistoryTTBlackList,
    /** 京东 */
    PurchaseHistoryTTJD,
    /** 淘宝 */
    PurchaseHistoryTTTaoBao,
    /** 学历学籍 */
    PurchaseHistoryTTEducation,
    /** 脉脉 */
    PurchaseHistoryTTMaiMai,
    /** 领英 */
    PurchaseHistoryTTLinder,
    /** 其他 */
    PurchaseHistoryTTther,
    
    
}PurchaseHistoryTypeType;


@protocol PurchaseHistoryTypeDelegate <NSObject>

- (void)didSelectedPurchaseHistoryTypeDidSelected:(PurchaseHistoryTopPullTypeModel*)model;

@end


@interface PurchaseHistoryTopPullType : UITableViewCell

@property (nonatomic, assign) PurchaseHistoryTypeType itemType;

@property (nonatomic, weak) id<PurchaseHistoryTypeDelegate> delegate;

//@property (assign,nonatomic) BOOL  isSelected;

//@property (assign , nonatomic) BOOL showFirst;



@property (strong,nonatomic) PurchaseHistoryTopPullTypeModel      *model;

+ (instancetype)subjectCellWithTabelView:(UITableView *)tableview;


@end













