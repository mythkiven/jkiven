//
//  CommonSearchSortModel.m
//  CreditPlatform
//
//  Created by gyjrong on 16/11/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#import "CommonSearchSortModel.h"


#import "CommonSearchVC.h"
#import "OperatorsReportMainVC.h"
#import "YJReportHoseFundDetailsVC.h"
#import "YJReportSocialSecurityDetailsVC.h"
#import "JmailTextField.h"

#import "WebViewController.h"
#import "ListHookVC.h"
#import "ECommerceReportMainVC.h"
#import "ListHookModel.h"
//#import "ForgetPassWordOperation.h"

#import "ListHookModel.h" 
#import "CommonSendMsgVC.h"
#import "OperatorsDataTool.h"
#import "OperationModel.h"
#import "YJSearchConditionModel.h"
#import "YJReportCentralBankDetailsVC.h"
#import "YJReportEducationDetailsVC.h"
#import "ReportLinkedinDetailsVC.h"
#import "YJReportTaoBaoDetailsVC.h"

#import "CommonSearchCell.h"
#import "YJReportDishonestyDetailsVC.h"
#import "YJCitySelectedVC.h"
#import "YJCityModel.h"


#import "CommonSearchCellModel.h"



@implementation CommonSearchSortModel


-(NSMutableArray*)factoryArr:(NSMutableArray *)marr city:(NSString *)city{
    
    if (!_titleWidth) {
        _titleWidth = 0;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
     
    
    if (self.searchItemType == SearchItemTypeHousingFund) {//公积金
        [arr addObject:marr[0]];
        
        if ([city isEqualToString:@"洛阳"]) {
            
            CommonSearchCellModel*  modelF = [self modelLocation:2 Name:@"身份证号" type:CommonSearchCellTypeNone place:@"身份证号"];
            CommonSearchCellModel*  modelS = [self modelLocation:2 Name:@"公积金账号/姓名" type:CommonSearchCellTypeNone place:@"公积金账号或姓名"];
            CommonSearchCellModel*  modelT =  [self modelLocation:3 Name:@"联名卡号" type:CommonSearchCellTypeNone place:@"联名卡号前6位或后6位"];
            [arr addObject:modelF];
            [arr addObject:modelS];
            [arr addObject:modelT];

        } else if ([city isEqualToString:@"西安"]|[city isEqualToString:@"郑州"]){
            CommonSearchCellModel*  modelF = [self modelLocation:2 Name:@"账号" type:CommonSearchCellTypeNone place:@"身份证号"];
            CommonSearchCellModel*  modelS = [self modelLocation:2 Name:@"密码" type:CommonSearchCellTypeEye place:@"密码"];
            CommonSearchCellModel*  modelT =  [self modelLocation:3 Name:@"真实姓名" type:CommonSearchCellTypeNone place:@"真实姓名"];
            
            [arr addObject:modelF];
            [arr addObject:modelS];
            [arr addObject:modelT];
        }else {//通用
            
            CommonSearchCellModel*  modelF = [self modelLocation:2 Name:@"账号" type:CommonSearchCellTypeNone place:_selectCityInfoModel.accountPlaceholder];
            CommonSearchCellModel*  modelS = [self modelLocation:3 Name:@"密码" type:CommonSearchCellTypeEye place:_selectCityInfoModel.passwordPlaceholder];
            
            [arr addObject:modelF];
            [arr addObject:modelS];
            
        }
        
    }else if (self.searchItemType == SearchItemTypeSocialSecurity){//社保
        
        [arr addObject:marr[0]];//箭头
        [arr addObject:marr[1]];//账号
        if ([city isEqualToString:@"合肥"]) {//合肥社保 增加 真实姓名
               
            CommonSearchCellModel*  modelF = [self modelLocation:2 Name:@"密码" type:CommonSearchCellTypeEye place:@"密码"];
            
            CommonSearchCellModel*  modelS = [self modelLocation:3 Name:@"真实姓名" type:CommonSearchCellTypeNone place:@"真实姓名"];
            
            [arr addObject:modelF];
            [arr addObject:modelS];
        
        }else if ([city isEqualToString:@"西安"]) {//更改显示 身份证+姓名  密码->姓名
        
           CommonSearchCellModel*  modelS = [self modelLocation:3 Name:@"真实姓名" type:CommonSearchCellTypeNone place:@"真实姓名"];
            
            [arr addObject:modelS];
        
        
        }else{
          //  CommonSearchCellModel*  modelF = [self modelLocation:2 Name:@"账号" type:CommonSearchCellTypeNone place:_selectCityInfoModel.accountPlaceholder];
            CommonSearchCellModel*  modelS = [self modelLocation:3 Name:@"密码" type:CommonSearchCellTypeEye place:_selectCityInfoModel.passwordPlaceholder];
            
            //[arr addObject:modelF];
            [arr addObject:modelS];
            
        }
    }
    
    
    return arr;
}

-(CommonSearchCellModel *)modelLocation:(NSInteger)location Name:(NSString*)name type:(CommonSearchCellType)type place:(NSString *)hold {
        CommonSearchCellModel*  model = [[CommonSearchCellModel alloc]init];
        model.location = location;
        model.Name = name;
        model.type = type;
        model.placeholdText = hold;
        model.searchItemType = self.searchItemType;
        CGFloat width=[model.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.width;
        _titleWidth = (width>=_titleWidth ? width:_titleWidth);
        model.maxLength = _titleWidth;
        return model;
}


/** 车险 */
-(NSMutableArray*)factoryArrWithIndex:(NSInteger)index{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    CommonSearchCellModel*  modelF,*modelS,*modelT;
    if (index == 2) {//保单查询
        modelF = [self modelLocation:1 Name:@"保险公司" type:CommonSearchCellTypeAllow place:@"请选择保险公司"];
        modelS = [self modelLocation:2 Name:@"保单号" type:CommonSearchCellTypeNone place:@"请输入保单号"];
        modelT =  [self modelLocation:3 Name:@"投保人证件号" type:CommonSearchCellTypeNone place:@"请输入投保人身份证号码"];
    } else if (index == 1){//账号查询
        modelF = [self modelLocation:1 Name:@"保险公司" type:CommonSearchCellTypeAllow place:@"请选择保险公司"];
        modelS = [self modelLocation:2 Name:@"账号" type:CommonSearchCellTypeNone place:@"请输入账户名"];
        modelT =  [self modelLocation:3 Name:@"密码" type:CommonSearchCellTypeEye place:@"请输入密码"];
    }
    
    [arr addObject:modelF];
    [arr addObject:modelS];
    [arr addObject:modelT];
    
    return arr;
}
@end
