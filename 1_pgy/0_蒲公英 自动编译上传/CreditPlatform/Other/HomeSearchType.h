//
//  HomeSearchType.h
//  CreditPlatform
//
//  Created by yj on 16/9/7.
//  Copyright © 2016年 kangcheng. All rights reserved.
//

#ifndef HomeSearchType_h
#define HomeSearchType_h
typedef  enum { // 请不要更改顺序（0开始），此顺序与homeSearchItem.plist文件类型一致
    /** 公积金
     */
    SearchItemTypeHousingFund = 20 ,
    /**社保 21
     */
    SearchItemTypeSocialSecurity,
    /**央行征信22
     */
    SearchItemTypeCentralBank,

    /**运营商23
     */
    SearchItemTypeOperators,
    
    /**京东24
     */
    SearchItemTypeE_Commerce,

    /**淘宝25
     */
    SearchItemTypeTaoBao,
    
    /**脉脉26
     */
    SearchItemTypeMaimai,
    /**领英27
     */
    SearchItemTypeLinkedin,
    /**学历学籍28
     */
    SearchItemTypeEducation,
    
    
    // 以下同plist
    
    /**信用卡账单 29
     */
    SearchItemTypeCreditCardBill,
    
    /**失信人 30
     */
    SearchItemTypeLostCredit,
    
    /**车险 31
     */
    SearchItemTypeCarSafe,
    /**网银流水 32
     */
    SearchItemTypeNetBankBill,
    
    /**携程 33
     */
    SearchItemTypeCtrip,
    /**网银流水 34
     */
    SearchItemTypeDidiTaxi,
    
//    
//   //  工商信息 33
//    SearchItemTypeCompanyBusiness,
    /**更多，请关注 35
     */
    SearchItemTypeMore
    
    
}SearchItemType;


/**公积金*/
#define kBizType_housefund          @"housefund"

/**社保*/
#define kBizType_socialsecurity     @"socialsecurity"

/**运营商*/
#define kBizType_mobile             @"mobile"

/**京东*/
#define kBizType_jd                 @"jd"

/**淘宝*/
#define kBizType_taobao             @"taobao"

/**学信*/
#define kBizType_education          @"education"

/**央行*/
#define kBizType_credit             @"credit"

/**领英*/
#define kBizType_linkedin           @"linkedin"

/**脉脉*/
#define kBizType_maimai             @"maimai"

/**信用卡账单*/
#define kBizType_bill               @"bill"

/**失信*/
#define kBizType_shixin             @"shixin"

/**车险*/
#define kBizType_autoinsurance             @"autoinsurance"

/**网银流水*/
#define kBizType_ebank             @"ebank"


/**携程*/
#define kBizType_ctrip           @"ctrip"

/**滴滴打车*/
#define kBizType_diditaxi             @"diditaxi"

/**身份证实名检验*/
#define kBizType_idcheck               @"idcheck"

/**手机号实名检验*/
#define kBizType_mobilecheck             @"mobilecheck"

/**银行三要素检验*/
#define kBizType_bankcard3check      @"bankcard3check"

/**银行四要素检验*/
#define kBizType_bankcard4check              @"bankcard4check"

/**运营商信用报告*/
#define kBizType_mobile_report             @"mobile_report"



//#define kBizType_ebank   @"netbankBill"



#endif /* HomeSearchType_h */
