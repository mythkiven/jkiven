//
//  PurchaseHistoryTopPullView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum {
    /**
     *  今天
     */
    PurchaseHistoryTimeTypeToday = 90,
    /**
     *  最近一周
     */
    PurchaseHistoryTimeTypeWeek,
    /**
     *  最近一月
     */
    PurchaseHistoryTimeTypeMonth,
    /**
     *  最近三月
     */
    PurchaseHistoryTimeTypeThreeMonth ,
    /**
     *  自定义时间
     */
    PurchaseHistoryTimeTypeAuto,
    
    
}PurchaseHistoryTimeType;

@protocol PurchaseHistoryTopPullTimeDelegate <NSObject>
//回调操作。用于互斥
- (void)didSelectedPurchaseHistoryTimeType:(PurchaseHistoryTimeType)type;
//取消 确定 取消 31 确定 32。如果是四选一，带有type。没有则是自定义
-(void)didClickedCancelSureBtn:(UIButton*)btn TimeType:(PurchaseHistoryTimeType)type;
//开始结束时间 开始 21 结束 22 按钮
-(void)didClickeBeginEndTimeBtn:(UIButton *)btn ;
@end


@interface PurchaseHistoryTopPullTime : UIView
+(instancetype)initPurchaseHistoryTopPullTime;

@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak,nonatomic) id <PurchaseHistoryTopPullTimeDelegate> delegate;
@property (nonatomic, assign) PurchaseHistoryTimeType itemType;

 


@end








