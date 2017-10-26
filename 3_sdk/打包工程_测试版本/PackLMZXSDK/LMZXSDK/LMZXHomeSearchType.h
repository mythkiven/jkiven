//
//  HomeSearchType.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#ifndef LMZXHomeSearchType_h
#define LMZXHomeSearchType_h


static NSInteger  const lmSearchSuccess = 0;
static NSInteger  const lmSearching     = 1;

////////// 和 plist 一一对应
////////// 和 SDK 对外功能的 code 一一对应,方便回调当前查询的模块
typedef  enum {
    
///////////////////////// 1期 //////////////////////////
    
    /** 公积金0
     */
    LMZXSearchItemTypeHousingFund = 0 ,
    
    /**运营商1
     */
    LMZXSearchItemTypeOperators,
    
    /**京东2
     */
    LMZXSearchItemTypeE_Commerce,

    /**淘宝3
     */
    LMZXSearchItemTypeTaoBao,
    /**学历学籍4
     */
    LMZXSearchItemTypeEducation,
    
    
///////////////////////// 2期 //////////////////////////
    
    /**社保5 ---
     */
    LMZXSearchItemTypeSocialSecurity,
    
    /**车险6
     */
    LMZXSearchItemTypeCarSafe,
    
    /**网银流水7
     */
    LMZXSearchItemTypeNetBankBill,
    
    /**央行征信8
     */
    LMZXSearchItemTypeCentralBank,
    /**信用卡账单9
     */
    LMZXSearchItemTypeCreditCardBill,
    
///////////////////////// 以下暂未开发 //////////////////////////
    
    /**脉脉 11
     */
    LMZXSearchItemTypeMaimai,
    
    /**领英 12
     */
    LMZXSearchItemTypeLinkedin,
    
    
    /** 携程查询13 */
    LMZXSearchItemTypeCtrip,
    /** 滴滴查询14 */
    LMZXSearchItemTypeDiDiTaxi,
//    /** 身份验证:身份证实名 15*/
//    SearchItemTypeCheckIDCard,
//    /** 身份验证:手机号实名 16*/
//    SearchItemTypeCheckMobile,
//    /** 身份验证:银行卡3要素 17*/
//    SearchItemTypeCheckBankCard3,
//    /** 身份验证:银行卡4要素 18*/
//    SearchItemTypeCheckBankCard4,
//
//    /**失信人 10
//     */
//    SearchItemTypeLostCredit,
    /**更多，请关注 33
     */
    LMZXSearchItemTypeMore
    
    
}LMZXSearchItemType;


// 信用卡账单类型
typedef  enum {
    // 顺序不能调,已经和列表配死.
    LMZXCreditCardBillMailType163 = 0,
    LMZXCreditCardBillMailType126 , //1
    LMZXCreditCardBillMailType139,//2
    LMZXCreditCardBillMailTypesina,//3
    LMZXCreditCardBillMailTypeQQ  ,//4
    LMZXCreditCardBillMailTypealiyun,
    
}LMZXCreditCardBillMailType;


// 验证码类型
typedef enum : NSInteger {
    LMZXCommonSendMsgTypeNormal = 11,// 默认:信用卡账单邮箱验证码,京东,淘宝验证码(未单独列出)
    LMZXCommonSendMsgTypePhone,// 运营商 验证码(已单独列出)
    LMZXCommonSendMsgTypeJLDX,//吉林电信专用  验证码(已单独列出)
    LMZXCommonSendMsgTypeQQCredit,//信用卡邮箱:QQ独立密码(已单独列出)
}LMZXCommonSendMsgType;

/**公积金*/
#define lmzx_kBizType_housefund          @"housefund"

/**社保*/
#define lmzx_kBizType_socialsecurity     @"socialsecurity"

/**运营商*/
#define lmzx_kBizType_mobile             @"mobile"

/**京东*/
#define lmzx_kBizType_jd                 @"jd"

/**淘宝*/
#define lmzx_kBizType_taobao             @"taobao"

/**学信*/
#define lmzx_kBizType_education          @"education"

/**央行*/
#define lmzx_kBizType_credit             @"credit"


/**信用卡账单*/
#define lmzx_kBizType_bill               @"bill"

/**车险*/
#define lmzx_kBizType_autoinsurance             @"autoinsurance"

/**网银流水*/
#define lmzx_kBizType_ebank             @"ebank"

/**领英*/
#define lmzx_kBizType_linkedin           @"linkedin"

/**脉脉*/
#define lmzx_kBizType_maimai             @"maimai"

/**失信*/
#define lmzx_kBizType_shixin             @"shixin"

/**携程*/
#define lmzx_kBizType_ctrip             @"ctrip"

/**滴滴出行*/
#define lmzx_kBizType_diditaxi             @"diditaxi"



#endif


/* LMZXHomeSearchType_h */
