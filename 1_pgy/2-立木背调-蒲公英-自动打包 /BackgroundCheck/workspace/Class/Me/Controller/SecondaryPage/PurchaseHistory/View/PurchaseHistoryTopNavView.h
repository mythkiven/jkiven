//
//  PurchaseHistoryTopNavView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol PurchaseHistoryTopNavViewDelegate <NSObject>
//
//-(void)didclicked;
//
//@end
@class LeftImgBtn;
typedef void(^ClickedPurchaseHistoryTopNavBtn)(UIButton*);

@interface PurchaseHistoryTopNavView : UIView
//@property (strong, nonatomic) LeftImgBtn *btnType;
@property (copy, nonatomic) NSString*titlebtn;
@property(strong,nonatomic) ClickedPurchaseHistoryTopNavBtn clickedTopNavBtn;
-(id)initPurchaseHistoryTopNavViewWithframe:(CGRect)frame;
-(void)cancelSelected;
@end
