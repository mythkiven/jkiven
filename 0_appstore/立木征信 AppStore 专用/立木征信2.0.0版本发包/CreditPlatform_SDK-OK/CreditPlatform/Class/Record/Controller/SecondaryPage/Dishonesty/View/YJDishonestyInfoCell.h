//
//  YJDishonestyInfoCell.h
//  CreditPlatform
//
//  Created by yj on 2016/11/15.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum {
//    YJDishonestyInfoTypeOrganization = 1111,  // 组织
//    YJDishonestyInfoTypePerson,  // 个人
//} YJDishonestyInfoType;


@class reportDishonestyModel;

@interface YJDishonestyInfoCell : UITableViewCell

//@property (nonatomic, assign) YJDishonestyInfoType infoType;

@property (nonatomic, strong) reportDishonestyModel *reportDishonestyModel;

@end
