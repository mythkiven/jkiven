//
//  JDReportModel.h
//  CreditPlatform
//
//  Created by ___蒋孝才___ on 16/8/6.
//  Copyright © 2016年 kangcheng. All rights reserved.
//
/*
 *
 *          ┌─┐       ┌─┐
 *       ┌──┘ ┴───────┘ ┴──┐
 *       │                 │
 *       │       ───       │
 *       │  ─┬┘       └┬─  │
 *       │                 │
 *       │       ─┴─       │
 *       │                 │
 *       └───┐         ┌───┘
 *           │         │
 *           │         │
 *           │         │
 *           │         └──────────────┐
 *           │                        │
 *           │                        ├─┐
 *           │                        ┌─┘
 *           │                        │
 *           └─┐  ┐  ┌───────┬──┐  ┌──┘
 *             │ ─┤ ─┤       │ ─┤ ─┤
 *             └──┴──┘       └──┴──┘
 *                 神兽保佑
 *                 代码无BUG!
 */


#import <Foundation/Foundation.h>
@class JDbasicInfoModel,JDbaiTiaoInfoModel,JDorderStatisticsModel,JDorderCostBarChartModel;
//总信息
@interface JDReportModel : NSObject
//基本信息
@property (strong,nonatomic) NSDictionary     *basicInfo;
@property (strong,nonatomic) JDbasicInfoModel      *basicInfoS;
//白条信息
@property (strong,nonatomic) NSDictionary      *baiTiaoInfo;
@property (strong,nonatomic) JDbaiTiaoInfoModel      *baiTiaoInfoS;

//银行卡信息
@property (strong,nonatomic) NSArray      *bankInfo;

//地址信息
@property (strong,nonatomic) NSArray      *addressInfo;
//订单信息
@property (strong,nonatomic) NSArray      *orderDetail;

//
//消费统计
@property (strong,nonatomic) JDorderStatisticsModel      *jdorderStatisticsModel;
//柱图
@property (strong,nonatomic) JDorderCostBarChartModel      *jdorderCostBarChartModel;

//
///** 近3年 累计消费*/
//@property (strong,nonatomic) NSString      *addSpend3Year;
///** 近3年 订单总数*/
//@property (strong,nonatomic) NSString      *totalOrderCount;
///** 单笔最高*/
//@property (strong,nonatomic) NSString      *singleHightSpend;
///** 平均消费消费*/
//@property (strong,nonatomic) NSString      *avgSpend;
///** 商品总数*/
//@property (strong,nonatomic) NSString      *totalGoodsCount;
//
//@property (strong,nonatomic) NSString      *spendOrder0To50Count;
//@property (strong,nonatomic) NSString      *spendOrder50To100Count;
//@property (strong,nonatomic) NSString      *spendOrder100To200Count;
//@property (strong,nonatomic) NSString      *spendOrder200To500Count;
//@property (strong,nonatomic) NSString      *spendOrder500To1000Count;
//@property (strong,nonatomic) NSString      *spendOrder1000To3000Count;
//@property (strong,nonatomic) NSString      *spendOrder5000UpCount;


@end

//基本信息
@interface JDbasicInfoModel : NSObject
/**昵称*/
@property (copy,nonatomic) NSString      *nickName ;
/**等级*/
@property (copy,nonatomic) NSString      *vipLevel ;
/**手机号*/
@property (copy,nonatomic) NSString      *mobileNo ;
/**邮箱*/
@property (copy,nonatomic) NSString      *email ;
/**真实NMAE*/
@property (copy,nonatomic) NSString      *realName ;
/**身份证*/
@property (copy,nonatomic) NSString      *idCard ;
/**成长等级*/
@property (copy,nonatomic) NSString      *growthValue ;
/**安全级别*/
@property (copy,nonatomic) NSString      *securityLevel ;
@end


//银行卡信息
@interface JDbankInfoModel : NSObject
/**姓名*/
@property (copy,nonatomic) NSString      *name ;
/**卡号*/
@property (copy,nonatomic) NSString      *bankCardID ;
/**银行卡类型*/
@property (copy,nonatomic) NSString      *cardType ;
/**电话*/
@property (copy,nonatomic) NSString      *tel ;


@end
//白条信息
@interface JDbaiTiaoInfoModel : NSObject
/** 限额*/
@property (copy,nonatomic) NSString      *creditlimit ;
/** */
@property (copy,nonatomic) NSString      *availablelimit ;
/**是否开通*/
@property (copy,nonatomic) NSString      *isOpen ;
/**月*/
@property (copy,nonatomic) NSString      *monthloan ;
/**白条金额*/
@property (copy,nonatomic) NSString      *biaoTiaoConSum ;
/**小白信用*/
@property (copy,nonatomic) NSString      *xiaoBaiCreditValue ;
@end


//地址信息
@interface JDaddressInfoModel : NSObject

/**地址*/
@property (copy,nonatomic) NSString      *address ;
/** 名*/
@property (copy,nonatomic) NSString      *linkman ;
/**电话*/
@property (copy,nonatomic) NSString      *tel ;

@end
//订单信息
@interface JDorderDetailModel : NSObject
/** */
@property (copy,nonatomic) NSString      *goodsName ;
/**  */
@property (copy,nonatomic) NSString      *consigneeAddr ;
/** */
@property (copy,nonatomic) NSString      *orderDate ;
/** */
@property (copy,nonatomic) NSString      *orderMoney ;
/**  */
@property (copy,nonatomic) NSString      *consigneePerson ;
/** */
@property (copy,nonatomic) NSString      *tel ;
/** */
@property (copy,nonatomic) NSString      *orderStatus ;
/** */
@property (copy,nonatomic) NSString      *payType ;


@end


// 消费统计
@interface JDorderStatisticsModel : NSObject
/** 近3年 累计消费*/
@property (strong,nonatomic) NSString      *addSpend3Year;
/** 近3年 订单总数*/
@property (strong,nonatomic) NSString      *totalOrderCount;
/** 单笔最高*/
@property (strong,nonatomic) NSString      *singleHightSpend;
/** 平均消费消费*/
@property (strong,nonatomic) NSString      *avgSpend;
/** 商品总数*/
@property (strong,nonatomic) NSString      *totalGoodsCount;


@end

//柱状图
@interface JDorderCostBarChartModel : NSObject
@property (strong,nonatomic) NSString      *spendOrder0To50Count;
@property (strong,nonatomic) NSString      *spendOrder50To100Count;
@property (strong,nonatomic) NSString      *spendOrder100To200Count;
@property (strong,nonatomic) NSString      *spendOrder200To500Count;
@property (strong,nonatomic) NSString      *spendOrder500To1000Count;
@property (strong,nonatomic) NSString      *spendOrder1000To3000Count;
@property (strong,nonatomic) NSString      *spendOrder3000To5000Count;
@property (strong,nonatomic) NSString      *spendOrder5000UpCount;


@end




