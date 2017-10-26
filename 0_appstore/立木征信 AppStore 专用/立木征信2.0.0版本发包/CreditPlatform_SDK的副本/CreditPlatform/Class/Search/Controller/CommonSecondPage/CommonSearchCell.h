//
//  CommonSearchCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCityModel.h"
@class CommonSearchCellModel;

typedef enum : NSInteger {
    CommonSearchCellTypeAllow=1,
    CommonSearchCellTypeEye,
    CommonSearchCellTypeNone,
    CommonSearchCellTypeMailPromit,//下拉框
} CommonSearchCellType;

/** 运营商开始查询城市*/
typedef void(^ClickedSelectCity)(id);

@interface CommonSearchCell : UITableViewCell


// 

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;

/** 查询手机号*/
@property (strong,nonatomic) ClickedSelectCity clickedSelectCity;
@property (strong,nonatomic) CommonSearchCellModel      *model;

//cell的样式: 1 箭头 2 眼睛 3 无
@property (assign,nonatomic) CommonSearchCellType  type;

// cell的super的类型
@property (nonatomic, assign) SearchItemType  searchItemType;
@property (nonatomic, copy) NSArray  *mailData;

@property (strong,nonatomic) NSString      *city;
@property (weak, nonatomic) IBOutlet UITextField *textField;

//@property (weak,nonatomic)  id<ClickeTextFiledDelegate> delegate;


+(instancetype)initCommonCellWith:(UITableView *)tableView;
@end
