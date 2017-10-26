//
//  LinkMMMainTopView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMMainModel.h"
#import "LinkedMainModel.h"
@interface LinkMMMainTopView : UIView
@property (nonatomic, assign) SearchItemType  searchType;
@property(nonatomic,strong) cardInfoMM *mmModel;
@property(nonatomic,strong) cardInfoLY *linkModel;

+ (id)linkMMMainTopViewView:(SearchItemType)type;




@end
