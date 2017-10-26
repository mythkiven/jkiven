//
//  LMBaseReportViewController.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/9/29.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

 

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LMReportType){
    LMReportTypeBasicType  = 0,//基础版
    LMReportTypeStandardType
};

typedef enum {
    LMReportDetailFromHome,
    LMReportDetailFromList
}LMReportDetailFrom;

@class LMZXQueryInfoModel;
@interface LMBaseReportViewController : UIViewController
@property (assign,nonatomic) LMReportType  reportType;
@property (strong,nonatomic) LMZXQueryInfoModel *queryInfoModel;

@property (copy,nonatomic) NSString *UID;

@property (nonatomic, assign) LMReportDetailFrom reportDetailFrom;

// 样例数据
@property (strong,nonatomic) NSString * samepleUrl ;
@end
