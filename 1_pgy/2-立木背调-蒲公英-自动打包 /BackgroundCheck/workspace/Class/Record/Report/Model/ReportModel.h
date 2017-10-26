//
//  ReportModel.h
//  BackgroundCheck
//
//  Created by gyjrong on 2017/10/10.
//  Copyright © 2017年 limuzhengxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReportInfoModel,ReportBaseInfoModel,RiskTipsModel,PersionRecordModel,PersionRiskInfoModel;

@interface ReportModel : NSObject
// 1. 报告信息 reportMsg
@property (strong,nonatomic) ReportInfoModel *reportMsg;
// 2 基本信息 BasicMsg
@property (strong,nonatomic) ReportBaseInfoModel *BasicMsg;
// 3 风险提示
@property (strong,nonatomic) RiskTipsModel *riskMsg;
// 4 个人履历信息 BiographicalMsg
@property (strong,nonatomic) PersionRecordModel      *BiographicalMsg;
// 5 个人风险信息 PersonalRiskMsg
@property (strong,nonatomic) PersionRiskInfoModel      *PersonalRiskMsg;

@property (strong,nonatomic) NSString      *BasicTitle;
@property (strong,nonatomic) NSString      *PersonalRiskTitle;
@property (strong,nonatomic) NSString      *BiographicalTitle;
@property (strong,nonatomic) NSString      *reportTitle;
@property (strong,nonatomic) NSString      *riskTitle;
@end



//////// 1. 报告基本信息 reportMsg
@interface ReportInfoModel : NSObject
/**报告日期*/
@property (strong,nonatomic) NSString      *reportTime;
/**报告编号*/
@property (strong,nonatomic) NSString      *reportNo;
/**报告版本*/
@property (strong,nonatomic) NSString      *reportVersion;
@end



//////// 2. 基本信息 candidateMsg
@class ReportBaseInfoHouxuanModel,ReportBaseInfoTwoModel;
@interface ReportBaseInfoModel : NSObject
/** 2.1 候选人信息*/
@property (strong,nonatomic) ReportBaseInfoHouxuanModel  *candidateMsg;
/** 2.2 双方信息*/
@property (strong,nonatomic) ReportBaseInfoTwoModel      *twoMsg;

@end
// 2.1. 候选人信息
@interface ReportBaseInfoHouxuanModel : NSObject
/**是否一致*/
@property (strong,nonatomic) NSString      *resultMsg;
/**身份证*/
@property (strong,nonatomic) NSString      *identityNo;
/**年龄*/
@property (strong,nonatomic) NSString      *age;
/**性别*/
@property (strong,nonatomic) NSString      *gender;
/**姓名*/
@property (strong,nonatomic) NSString      *name;
/**归属地*/
@property (strong,nonatomic) NSString      *mobileNoTrack;
/**手机号*/
@property (strong,nonatomic) NSString      *mobile;
@end
// 2.2. 双方信息
@interface ReportBaseInfoTwoModel : NSObject
/**委托方*/
@property (strong,nonatomic) NSString      *principal;
/**候选人*/
@property (strong,nonatomic) NSString      *candidate;
/**职位*/
@property (strong,nonatomic) NSString      *position;
@end



//////// 3. 风险提示
@interface  RiskTipsModel : NSObject
/**法院诉讼 cligNum */
@property (strong,nonatomic) NSString      *cligNum;
/**失信被执行 dishNum*/
@property (strong,nonatomic) NSString      *dishNum;
/**贷款信息 linfNum*/
@property (strong,nonatomic) NSString      *linfNum;
@end



//////// 4. 个人履历信息
@interface PersionRecordModel : NSObject
/** 最高学历 */
@property (strong,nonatomic) NSArray  *acrdMsg;
/** 职业资格 */
@property (strong,nonatomic) NSArray  *vcqnMsg;
@property (assign,nonatomic) NSInteger      cellHeight;
@end
// 4.1. 最高学历
@interface PersionRecordHegihtEducationModel : NSObject
/** 毕业院校 */
@property (strong,nonatomic) NSString  *graduate;
/** 学校类型 */
@property (strong,nonatomic) NSString  *schoolCategory;
/** 入学年份 */
@property (strong,nonatomic) NSString  *enrolDate;
/** 毕业时间 */
@property (strong,nonatomic) NSString  *graduateTime;
/** 专业名称 */
@property (strong,nonatomic) NSString  *specialityName;
/** 学历 */
@property (strong,nonatomic) NSString  *educationDegree;
/** 学历类型 */
@property (strong,nonatomic) NSString  *studyStyle;
@property (strong,nonatomic) NSString  *id;
@property (strong,nonatomic) NSString  *uid;
@property (strong,nonatomic) NSString  *username;
@property (strong,nonatomic) NSString  *identity;
@property (strong,nonatomic) NSString  *mobile;
@end
// 4.2. 职业资格 vcqnMsg
@interface PersionRecordQualificationsModel : NSObject
/**证书名称*/
@property (strong,nonatomic) NSString      *occupation;
/**颁证日期*/
@property (strong,nonatomic) NSString      *banZhengRiQi;
/**证书级别*/
@property (strong,nonatomic) NSString      *level;
/**发证单位*/
@property (strong,nonatomic) NSString      *submitOrgName;
/**证书编号*/
@property (strong,nonatomic) NSString      *certificateid;
@property (strong,nonatomic) NSString      *id;
@property (strong,nonatomic) NSString      *uid;
@property (strong,nonatomic) NSString      *mobile;
@end



//////// 5 个人风险信息
@interface PersionRiskInfoModel : NSObject
/**贷款信息*/
@property (strong,nonatomic) NSArray      *linfMsg;
/**法院诉讼*/
@property (strong,nonatomic) NSArray      *cligMsg;
/**失信*/
@property (strong,nonatomic) NSArray      *dishMsg;
@property (assign,nonatomic) NSInteger      cellHeight;

@end
// 5.1 法院诉讼
@interface PersionRiskInfoFaYuanModel : NSObject
/**案件标题*/
@property (strong,nonatomic) NSString      *title;
/**案件类别*/
@property (strong,nonatomic) NSString      *jtype;
/**法院名称*/
@property (strong,nonatomic) NSString      *court;
/**案号*/
@property (strong,nonatomic) NSString      *jnum;
/**详情ID*/
@property (strong,nonatomic) NSString      *detailsid;
/**审结时间*/
@property (strong,nonatomic) NSString      *judgeDate;
/**审结程序*/
@property (strong,nonatomic) NSString      *jprocees;
/**当事人*/
@property (strong,nonatomic) NSString      *dangshiren;
/**上述人*/
@property (strong,nonatomic) NSString      *shangshuren;
/**被上述人*/
@property (strong,nonatomic) NSString      *beishangshuren;
/**案由*/
@property (strong,nonatomic) NSString      *jcase;
/**案件摘要*/
@property (strong,nonatomic) NSString      *jsummary;
/**判决结果*/
@property (strong,nonatomic) NSString      *resultStr;
@property (strong,nonatomic) NSString      *id;
@property (strong,nonatomic) NSString      *uid;
@end
// 5.2 失信被执行
@interface PersionRiskInfoShiXinModel : NSObject
/**立案时间*/
@property (strong,nonatomic) NSString      *filingTime;
/**省份*/
@property (strong,nonatomic) NSString      *province;
/**执行法院*/
@property (strong,nonatomic) NSString      *executiveCourt;
/**序号*/
@property (strong,nonatomic) NSString      *no;
/**执行依据文号*/
@property (strong,nonatomic) NSString      *executiveBaiscNo;
/**案号*/
@property (strong,nonatomic) NSString      *caseNo;
/**做出依据单位*/
@property (strong,nonatomic) NSString      *executiveArm;
/**生效法律确定的义务*/
@property (strong,nonatomic) NSString      *legalObligation;
///**审结时间*/
//@property (strong,nonatomic) NSString      *resultStr  ;
/**被执行人的履行情况*/
@property (strong,nonatomic) NSString      *executiveCase;
/**具体情形*/
@property (strong,nonatomic) NSString      *specificSituation;

@property (strong,nonatomic) NSString      *id;
@property (strong,nonatomic) NSString      *uid;
@end
// 5.3 贷款信息
@interface PersionRiskInfoDaiKuanModel : NSObject
/**借款类型*/
@property (strong,nonatomic) NSString      *borrowType;
/**个人信贷*/
@property (strong,nonatomic) NSString      *borrowState;
/**借款金额*/
@property (strong,nonatomic) NSString      *borrowAmount;
/**借款日期*/
@property (strong,nonatomic) NSString      *contractDate;
/**借款期数*/
@property (strong,nonatomic) NSString      *loanPeriod;
/**当前状态*/
@property (strong,nonatomic) NSString      *repayState;
/**欠款金额*/
@property (strong,nonatomic) NSString      *arrearsAmount;

@property (strong,nonatomic) NSString      *mobile;
@property (strong,nonatomic) NSString      *id;
@property (strong,nonatomic) NSString      *uid;

@end








