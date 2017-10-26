//
//  ReportLinkedinBaseInfoView.h
//  CreditPlatform
//
//  Created by gyjrong on 16/9/29.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
#import "LinkMMreportBaseCellTableViewCell.h"
 

@interface ReportLinkedinBaseInfoView : LinkMMreportBaseCellTableViewCell
@property(nonatomic,strong) baseInfoMM *mmModel;
@property(nonatomic,strong) baseInfoLY *linkModel;

+ (id)reportLinkedinBaseInfoView:(SearchItemType)type;

+(CGFloat)cellHelight:(NSString*)str :(SearchItemType)type;
@end
