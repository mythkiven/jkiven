//
//  CommonSearchCell.h
//  CreditPlatform
//
//  Created by gyjrong on 16/8/17.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LMZXHomeSearchType.h"
@class LMZXSearchCellModel;

typedef enum : NSInteger {
    CommonSearchCellTypeAllow=1,
    CommonSearchCellTypeEye,
    CommonSearchCellTypeNone,
    CommonSearchCellTypeMailPromit,//下拉框
}LMZXCommonSearchCellType;




/** 运营商开始查询城市*/
typedef void(^ClickedSelectCity)(id);


@class LMZXCommonSearchCell;
@protocol LMZXCommonSearchCellDelegate <NSObject>

/**
 输入手机号满11位执行代理，验证城市

 */
@optional
- (void)commonSearchCell:(LMZXCommonSearchCell *)cell didCheckMobileFromCity:(NSString *)mobile;

@end





@interface LMZXCommonSearchCell : UITableViewCell





//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;


@property (nonatomic, weak) id delegate;

// 信用卡cell 类型
@property (nonatomic, strong) NSString * creditMail;


/** 查询手机号*/
@property (copy,nonatomic) ClickedSelectCity clickedSelectCity;
@property (strong,nonatomic) LMZXSearchCellModel      *model;

//cell的样式: 1 箭头 2 眼睛 3 无
@property (assign,nonatomic) LMZXCommonSearchCellType  type;

// cell的super的类型
@property (nonatomic, assign) LMZXSearchItemType  searchItemType;
@property (nonatomic, copy) NSArray  *mailData;

@property (strong,nonatomic) NSString      *city;
@property (strong, nonatomic)  UITextField *textField;

//@property (weak,nonatomic)  id<ClickeTextFiledDelegate> delegate;


+(instancetype)initCommonCellWith:(UITableView *)tableView;
@end
